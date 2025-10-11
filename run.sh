#!/bin/bash
set -euo pipefail

THEMES=(
    "School Life" "Daily Work" "Family Time" "Friendship"
    "Playing Sports" "Listening to Music" "Cooking Food" "Weekend Travel"
    "Staying Healthy" "Using Technology" "Enjoying Hobbies" "Four Seasons"
    "Pet Care" "Going Shopping" "Home Sweet Home" "Learning English"
)

LEVELS=("beginner" "intermediate" "advanced")

THEME="${THEMES[$RANDOM % ${#THEMES[@]}]}"
LEVEL="${LEVELS[$RANDOM % ${#LEVELS[@]}]}"
ISO_DATE=$(date +%Y-%m-%dT%H:%M:%S%:z)

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
