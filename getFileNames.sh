#!/bin/bash
set -u
DIR="${1:-.}"
OUTPUT="extracted_texts.txt"
: > "$OUTPUT"
ESC=$(printf '\033')
i=0
for file in "$DIR"/*; do
    [ -f "$file" ] || continue
    name=$(basename "$file")
    mapfile -t texts < <(printf '%s\n' "$name" | grep -o '\[[^]]*\]' | sed 's/^\[//; s/\]$//')
    [ "${#texts[@]}" -eq 0 ] && continue
    i=$((i+1))
    printf '%d. ' "$i"
    printf '%s\n' "$name" | sed "s/\[\([^]]*\)\]/\[${ESC}[0;32m\1${ESC}[0m\]/g"
    for text in "${texts[@]}"; do
        printf -- "-> %d characters inside '[]'\n" "${#text}"
        printf '%s\n' "$text" >> "$OUTPUT"
    done
    printf '\n'
done
printf 'Done. Extracted texts saved to: %s\n' "$OUTPUT"