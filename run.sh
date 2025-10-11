#!/bin/bash
set -euo pipefail

mapfile -t THEMES < THEMES.txt
LEVELS=("beginner" "intermediate" "advanced")

export THEME="${THEMES[$RANDOM % ${#THEMES[@]}]}"
export LEVEL="${LEVELS[$RANDOM % ${#LEVELS[@]}]}"
export ISO_DATE=$(date +%Y-%m-%dT%H:%M:%S%:z)

DATE=$(date +%Y-%m-%d)
TIMESTAMP=$(date +%H%M%S)
THEME_SLUG=$(echo "$THEME" | tr '[:upper:]' '[:lower:]' | tr -s ' ' '-')
FILENAME="content/posts/${DATE}-${TIMESTAMP}-${THEME_SLUG}.md"

PROMPT=$(envsubst < PROMPT.txt)

llm "$PROMPT" > "$FILENAME"

if [ $? -eq 0 ]; then
    echo "Success: blog post created at ${FILENAME}."
else
    echo "Error: failed to generate blog post with llm command."
    exit 1
fi
