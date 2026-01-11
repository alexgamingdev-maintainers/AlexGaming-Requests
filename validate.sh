#!/bin/bash

echo "🔍 Starting local validation..."

# 1. Check if we are in the PR directory
if [ ! -d "PR" ]; then
  echo "❌ Error: Directory 'PR/' not found."
  exit 1
fi

# 2. Check JSON files
for file in $(find PR/ -name "*.json"); do
  jq . "$file" > /dev/null 2>&1
  if [ $? -ne 0 ]; then
    echo "❌ Invalid JSON syntax in: $file"
    exit 1
  fi
done

# 3. Check HTML files
for file in $(find PR/ -name "*.html"); do
  # Einfacher Check auf Tags
  if [[ ! $(cat "$file") == *"<html"* ]]; then
    echo "⚠️  Warning: $file might be missing HTML tags."
  fi
done

echo "✅ Local check passed! You can now submit your Pull Request."
