#!/bin/bash

# Fix JavaScript paths in subdirectory pages
echo "Fixing JavaScript paths in subdirectory pages..."

find . -mindepth 2 -name "*.html" -type f | while read file; do
    # Fix the missing ../ prefix for scripts.min.js
    if grep -q 'src="cms_websites/js/dist/shared/external/scripts.min.js"' "$file"; then
        sed -i '' 's|src="cms_websites/js/dist/shared/external/scripts.min.js"|src="../cms_websites/js/dist/shared/external/scripts.min.js"|g' "$file"
        echo "Fixed: $file"
    fi
done

echo "All JavaScript paths fixed!"