#!/usr/bin/env bash
# ============================================================
#  Fiches PSE1 — Bilan complémentaire · v0.2
#  Fichier : _dump/dump_pse_latex_files.sh
#  Rôle    : Concatène tous les fichiers source du projet
#            (.tex, .md, Makefile, .latexmkrc, .vscode/settings.json)
#            dans un unique .txt. Pratique pour partager un snapshot
#            complet du projet à une IA ou à un relecteur.
# ============================================================
set -euo pipefail

# Détermine la racine du projet (parent du dossier _dump)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

OUT_DIR="$SCRIPT_DIR"
OUT="$OUT_DIR/dump_pse_latex_files.txt"
EXTENSIONS=("tex" "cls" "sty" "md" "txt")

cd "$PROJECT_ROOT"

shopt -s globstar nullglob

FILES=()

# Fichiers LaTeX racine
for ext in tex cls sty; do
  for f in ./*."$ext"; do
    FILES+=("$f")
  done
done

# Fichiers texte/markdown racine
for ext in md txt; do
  for f in ./*."$ext"; do
    FILES+=("$f")
  done
done

# Tous les .tex en profondeur dans inc/, src/, fiches_tex/, fiches/
for f in inc/**/*.tex src/**/*.tex fiches_tex/**/*.tex fiches/**/*.tex; do
  FILES+=("$f")
done

# Makefile, .latexmkrc, .vscode/settings.json
for f in ./Makefile ./.latexmkrc ./.vscode/settings.json; do
  if [[ -f "$f" ]]; then
    FILES+=("$f")
  fi
done

shopt -u globstar nullglob

# Exclure les dossiers de build et d'archive
FILTERED=()
for f in "${FILES[@]}"; do
  case "$f" in
    ./_dump/*|./output/*|./build/*|./doc/*) continue ;;
    *) FILTERED+=("$f") ;;
  esac
done

# Dédoublonnage + tri stable
IFS=$'\n' FILES_SORTED=($(printf "%s\n" "${FILTERED[@]}" | sort -u))
unset IFS

echo "[dump_pse_latex_files] Racine projet     : $PROJECT_ROOT"
echo "[dump_pse_latex_files] Extensions ciblées : ${EXTENSIONS[*]} + Makefile"
echo "[dump_pse_latex_files] Fichiers trouvés   : ${#FILES_SORTED[@]}"

if (( ${#FILES_SORTED[@]} == 0 )); then
  echo "[dump_pse_latex_files] ERROR: Aucun fichier trouvé."
  exit 1
fi

mkdir -p "$OUT_DIR"
: > "$OUT"

for f in "${FILES_SORTED[@]}"; do
  echo "[dump_pse_latex_files] + $f"
  {
    echo "================================================================"
    echo "FILE: $f"
    echo "================================================================"
    cat "$f"
    echo
  } >> "$OUT"
done

echo "[dump_pse_latex_files] Done. Fichiers concaténés : ${#FILES_SORTED[@]}"
echo "[dump_pse_latex_files] Sortie : $OUT"
