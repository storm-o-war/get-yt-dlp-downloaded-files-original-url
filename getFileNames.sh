#!/bin/bash
set -u
DIR="${1:-.}"
ALL_OUT="extracted_texts.txt"      # all extracted texts
LEN11_OUT="matched_11.txt"         # only 11-char texts
: > "$ALL_OUT"
: > "$LEN11_OUT"
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
        printf '%s\n' "$text" >> "$ALL_OUT"
        if [ "${#text}" -eq 11 ]; then
            printf '%s\n' "$text" >> "$LEN11_OUT"
        fi
    done
    printf '\n'
done
printf 'All texts        -> %s\n' "$ALL_OUT"
printf '11-char texts    -> %s\n' "$LEN11_OUT"