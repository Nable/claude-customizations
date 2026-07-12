#!/usr/bin/env bash
# Installa i comandi e le skill del repo.
#
# Due modalità:
#   ./install.sh
#       Symlink in ~/.claude/ (CLI locale): un git pull aggiorna tutto.
#   ./install.sh --project <path>
#       COPIA i comandi in <path>/.claude/commands/ del progetto indicato,
#       da committare nel repo del progetto. Necessario per Claude Code web
#       (l'ambiente cloud vede solo i file del repository; i symlink verso
#       questo repo risulterebbero rotti). Rilanciare dopo un git pull per
#       riallineare le copie.
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ---------- Modalità --project: copia nel repo di un progetto ----------
if [ "${1:-}" = "--project" ]; then
  TARGET="${2:-}"
  if [ -z "$TARGET" ] || [ ! -d "$TARGET" ]; then
    echo "Uso: ./install.sh --project <path-progetto>" >&2
    echo "Errore: '$TARGET' non è una directory valida." >&2
    exit 1
  fi
  TARGET="$(cd "$TARGET" && pwd)"
  [ -d "$TARGET/.git" ] || echo "Attenzione: $TARGET non sembra un repo git — le copie vanno committate per funzionare su Claude Code web."

  mkdir -p "$TARGET/.claude/commands"
  echo "Copia dei comandi in $TARGET/.claude/commands/"
  echo

  for f in "$REPO_DIR"/commands/*/*.md; do
    name="$(basename "$f")"
    case "$name" in README-*) continue ;; esac
    cp "$f" "$TARGET/.claude/commands/$name"
    echo "  comando → /${name%.md}"
  done

  # Skill: copiate come cartelle in .claude/skills/
  for d in "$REPO_DIR"/skills/*/; do
    [ -d "$d" ] || continue
    name="$(basename "$d")"
    mkdir -p "$TARGET/.claude/skills"
    rm -rf "$TARGET/.claude/skills/$name"
    cp -R "${d%/}" "$TARGET/.claude/skills/$name"
    echo "  skill   → $name"
  done

  # Marker di provenienza per sapere a quale versione sono allineate le copie
  rev="$(git -C "$REPO_DIR" rev-parse --short HEAD 2>/dev/null || echo sconosciuta)"
  printf 'source: claude-customizations\nrevision: %s\ncopied: %s\n' \
    "$rev" "$(date +%Y-%m-%d)" > "$TARGET/.claude/commands/.customizations-rev"

  echo
  echo "Fatto (revisione $rev). Committa .claude/ nel repo del progetto per usarli da Claude Code web."
  exit 0
fi

# ---------- Modalità default: symlink in ~/.claude ----------
CLAUDE_DIR="${CLAUDE_DIR:-$HOME/.claude}"

mkdir -p "$CLAUDE_DIR/commands" "$CLAUDE_DIR/skills"

echo "Installazione in $CLAUDE_DIR"
echo

# Comandi: un symlink per ogni file comando (i README sono esclusi)
for f in "$REPO_DIR"/commands/*/*.md; do
  name="$(basename "$f")"
  case "$name" in README-*) continue ;; esac
  ln -sfn "$f" "$CLAUDE_DIR/commands/$name"
  echo "  comando → /${name%.md}"
done

# Skill: un symlink per ogni cartella skill.
# Se la destinazione è una directory reale (installazione precedente via copia),
# ln -sfn creerebbe il link DENTRO di essa: va rimossa prima.
for d in "$REPO_DIR"/skills/*/; do
  [ -d "$d" ] || continue   # nessuna skill presente: glob non espanso
  name="$(basename "$d")"
  dest="$CLAUDE_DIR/skills/$name"
  if [ -d "$dest" ] && [ ! -L "$dest" ]; then
    echo "  skill   → $name (rimossa installazione precedente non-symlink)"
    rm -rf "$dest"
  else
    echo "  skill   → $name"
  fi
  ln -sfn "${d%/}" "$dest"
done

echo
echo "Fatto. Riavvia la sessione di Claude Code per vedere i nuovi comandi."
