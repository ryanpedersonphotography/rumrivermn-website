#!/bin/bash

echo "Fixing lazy-load image attributes in all gallery pages..."

# Find all index.html files with the broken pattern
for file in */index.html; do
    if grep -q 'data-lazy-load-img-src="[^"]*'"'" "$file" 2>/dev/null; then
        echo "Fixing: $file"
        # Fix all lazy-load image attributes that end with single quote
        sed -i '' "s/data-lazy-load-img-src=\"\([^\"]*\)'/data-lazy-load-img-src=\"\1\"/g" "$file"
    fi
done

echo "All gallery images fixed!"