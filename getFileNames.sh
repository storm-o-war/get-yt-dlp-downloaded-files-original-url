#!/bin/bash
#
# extract_brackets.sh
# Scans a directory for filenames containing [text] blocks.
# For each file that has one:
#   - prints the full filename, with the [text] part highlighted in green
#   - prints  -> N characters inside '[]'
#   - appends the extracted text (one per line) to extracted_texts.txt
#
# Usage: ./extract_brackets.sh [directory]

set -u

DIR="${1:-.}"
OUTPUT="extracted_texts.txt"
: > "$OUTPUT"          # truncate / create output file

ESC=$(printf '\033')   # escape char for ANSI colors

for file in "$DIR"/*; do
    [ -f "$file" ] || continue
    name=$(basename "$file")

    # Extract every [text] block from the filename (brackets stripped)
    mapfile -t texts < <(
        printf '%s\n' "$name" \
        | grep -o '\[[^]]*\]' \
        | sed 's/^\[//; s/\]$//'
    )

    # Skip files that don't contain any [text]
    [ "${#texts[@]}" -eq 0 ] && continue

    # Print the full filename with each [text] highlighted in green
    printf '%s\n' "$name" \
      | sed "s/\[\([^]]*\)\]/\[${ESC}[0;32m\1${ESC}[0m\]/g"

    # Print the character count and store the text
    for text in "${texts[@]}"; do
        printf -- "-> %d characters inside '[]'\n" "${#text}"
        printf '%s\n' "$text" >> "$OUTPUT"
    done

    printf '\n'
done

printf 'Done. Extracted texts saved to: %s\n' "$OUTPUT"
