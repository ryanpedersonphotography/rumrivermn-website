#!/bin/bash

# Fix Rental Information links in all HTML files
echo "Fixing Rental Information dropdown links..."

# For root level pages
find . -maxdepth 1 -name "*.html" -type f | while read file; do
    # Replace href="[page]#">Rental Information with href="rental-info/index.html">Rental Information
    sed -i '' 's|href="[^"]*#">Rental Information|href="rental-info/index.html">Rental Information|g' "$file"
    echo "Fixed: $file"
done

# For subdirectory pages
find . -mindepth 2 -name "*.html" -type f | while read file; do
    # Replace href="index.html#">Rental Information with href="../rental-info/index.html">Rental Information
    sed -i '' 's|href="index.html#">Rental Information|href="../rental-info/index.html">Rental Information|g' "$file"
    echo "Fixed: $file"
done

# Also fix Testimonials dropdown links which have the same issue
echo "Fixing Testimonials dropdown links..."

# For root level pages
find . -maxdepth 1 -name "*.html" -type f | while read file; do
    sed -i '' 's|href="[^"]*#">Testimonials|href="testimonials/index.html">Testimonials|g' "$file"
done

# For subdirectory pages
find . -mindepth 2 -name "*.html" -type f | while read file; do
    sed -i '' 's|href="index.html#">Testimonials|href="../testimonials/index.html">Testimonials|g' "$file"
done

echo "All dropdown links fixed!"