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

PROMPT="You are a creative writer for an English learning blog.

Write a short blog about the following theme: ${THEME}

The difficulty level should be: ${LEVEL}
- beginner: Simple vocabulary, short sentences, present tense
- intermediate: Some varied vocabulary, mix of tenses, simple metaphors
- advanced: Rich vocabulary, complex sentences, figurative language

Requirements:
1. Write 150-200 words
2. Include practical examples
3. Use natural, conversational tone
4. IMPORTANT: Add a line break after every period (.) to make each sentence appear on a new line

Output format (you MUST follow this EXACTLY, including the +++ delimiters):
+++
date = '${ISO_DATE}'
draft = false
title = '[Create an attractive title for the blog]'
tags = []
categories = []
+++

[Blog content here]"

llm "$PROMPT" > "$FILENAME"

if [ $? -eq 0 ]; then
    echo "Success: blog post created at ${FILENAME}."
else
    echo "Error: failed to generate blog post with llm command."
    exit 1
fi
