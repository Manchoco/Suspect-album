#!/usr/bin/env bash
# Coupe les 18 extraits de 60 s à partir des masters.
# Usage : ./make_clips.sh dossier_des_masters
#   Les masters doivent s'appeler 01.wav, 02.wav … 18.wav (ou .mp3 / .flac).
#   clips.csv donne, pour chaque titre, la seconde où commence l'extrait (choisis le refrain / la meilleure punchline).
# Résultat : audio/01.mp3 … audio/18.mp3 (60 s, fondu 0,5 s à l'entrée et 3 s à la sortie, 160 kb/s)
set -euo pipefail
SRC="${1:?dossier des masters manquant}"
OUT="$(dirname "$0")/audio"; mkdir -p "$OUT"
LEN=60
tail -n +2 "$(dirname "$0")/clips.csv" | while IFS=, read -r num start _title; do
  in=$(ls "$SRC"/"$num".* 2>/dev/null | head -n1 || true)
  [ -z "$in" ] && { echo "⚠ master $num introuvable, ignoré"; continue; }
  ffmpeg -v error -y -ss "$start" -t "$LEN" -i "$in" \
    -af "afade=t=in:st=0:d=0.5,afade=t=out:st=$((LEN-3)):d=3" \
    -ac 2 -b:a 160k "$OUT/$num.mp3"
  echo "✓ $num ($_title) à partir de ${start}s"
done
