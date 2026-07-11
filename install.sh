#!/usr/bin/env bash
# Installa (via symlink) tutti i comandi e le skill del repo in ~/.claude/.
# I symlink puntano ai file del repo: un git pull aggiorna tutto senza reinstallare.
set -euo pipefail

CLAUDE_DIR="${CLAUDE_DIR:-$HOME/.claude}"
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

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
