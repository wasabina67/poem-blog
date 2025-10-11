#!/bin/bash

THEMES=(
    "School Life" "Daily Work" "Family Time" "Friendship"
    "Playing Sports" "Listening to Music" "Cooking Food" "Weekend Travel"
    "Staying Healthy" "Using Technology" "Enjoying Hobbies" "Four Seasons"
    "Pet Care" "Going Shopping" "Home Sweet Home" "Learning English"
)

LEVELS=("beginner" "intermediate" "advanced")

THEME="${THEMES[$RANDOM % ${#THEMES[@]}]}"
LEVEL="${LEVELS[$RANDOM % ${#LEVELS[@]}]}"
ISO_DATE=$(date +%Y-%m-%dT%H:%M:%S%z | sed 's/\(..\)$/:\1/')

DATE=$(date +%Y-%m-%d)
FILENAME="content/posts/${DATE}-$(echo "$THEME" | sed 's/[^a-zA-Z0-9]/-/g' | tr '[:upper:]' '[:lower:]').md"

PROMPT="

THEME: ${THEME}
LEVEL: ${LEVEL}

Output format (please output in this format):
+++
date = '${ISO_DATE}'
draft = false
title = 'title'
tags = []
categories = []
+++

"

llm "$PROMPT" > "$FILENAME"

if [ $? -eq 0 ]; then
    echo ""
else
    echo ""
    exit 1
fi
