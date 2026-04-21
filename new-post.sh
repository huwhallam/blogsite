#!/usr/bin/env bash
# Usage: ./new-post.sh <blog> <slug> [title]
#
# Examples:
#   ./new-post.sh commons 002-the-technical-landscape
#   ./new-post.sh abundance 002-alignment-and-incentives "Alignment and incentives"
#
# <blog>  : commons | abundance
# <slug>  : filename without .md, becomes the URL path
# [title] : optional — if omitted, the slug is used (you can edit frontmatter after)

set -e

BLOG="${1:-}"
SLUG="${2:-}"
TITLE="${3:-$SLUG}"
DATE="$(date +%Y-%m-%d)"

if [[ -z "$BLOG" || -z "$SLUG" ]]; then
  echo "Usage: ./new-post.sh <blog> <slug> [\"title\"]"
  echo "  blog  : commons | abundance"
  echo "  slug  : e.g. 002-my-new-post"
  exit 1
fi

if [[ "$BLOG" != "commons" && "$BLOG" != "abundance" ]]; then
  echo "Error: blog must be 'commons' or 'abundance'"
  exit 1
fi

DIR="src/content/$BLOG"
FILE="$DIR/$SLUG.md"

if [[ -f "$FILE" ]]; then
  echo "Error: $FILE already exists"
  exit 1
fi

cat > "$FILE" <<EOF
---
title: "$TITLE"
date: $DATE
description: ""
tags: []
---

Write your post here.
EOF

echo "Created: $FILE"

# Open in editor if one is set
if [[ -n "$EDITOR" ]]; then
  "$EDITOR" "$FILE"
elif command -v code &>/dev/null; then
  code "$FILE"
fi
