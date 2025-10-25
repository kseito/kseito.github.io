#!/bin/bash

# Check if title is provided
if [ -z "$1" ]; then
    echo "Usage: ./new_post.sh <post-title>"
    echo "Example: ./new_post.sh my-new-post"
    exit 1
fi

# Get the title from argument
TITLE_SLUG="$1"

# Get current date
DATE=$(date +%Y-%m-%d)
DATETIME=$(date +"%Y-%m-%d %H:%M:%S %z")

# Create filename
FILENAME="_posts/${DATE}-${TITLE_SLUG}.md"

# Check if file already exists
if [ -f "$FILENAME" ]; then
    echo "Error: File $FILENAME already exists!"
    exit 1
fi

# Create the post file with front matter
cat > "$FILENAME" << EOF
---
layout: single
title: "Your Post Title"
date: $DATETIME
categories: []
tags: []
---

Write your content here.
EOF

echo "✓ Created new post: $FILENAME"
echo "  You can now edit the file and update the title, categories, and tags."
