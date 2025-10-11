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
TIMESTAMP=$(date +%H%M%S)
FILENAME="content/posts/${DATE}-${TIMESTAMP}-$(echo "$THEME" | sed 's/[^a-zA-Z0-9]/-/g' | tr '[:upper:]' '[:lower:]').md"

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

Output format (please output EXACTLY in this format):
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
    echo "success: blog post created at ${FILENAME}."
else
    echo "error: failed to generate blog post with llm command."
    exit 1
fi
