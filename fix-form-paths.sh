#!/bin/bash

# Fix form JavaScript paths in all HTML files
echo "Fixing form JavaScript paths in all HTML files..."

# Find all HTML files and fix the TSIFormsRenderer.js path
find . -name "*.html" -type f | while read file; do
    # Fix the encoded %3F to ? in the TSIFormsRenderer.js path
    sed -i '' 's|TSIFormsRenderer.js%3Fver=1724879172|TSIFormsRenderer.js?ver=1724879172|g' "$file"
done

echo "Form paths fixed!"