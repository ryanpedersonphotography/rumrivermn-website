#!/bin/bash

# Fix JavaScript references in all HTML files
echo "Updating JavaScript references in all HTML files..."

# Find all HTML files and update JS references
find . -name "*.html" -type f | while read file; do
    echo "Processing: $file"
    
    # Replace the removed JS comment with actual local script reference
    sed -i '' 's|<!-- External JS removed - not available locally -->|<script type="text/javascript" src="cms_websites/js/dist/shared/external/scripts.min.js"></script>|g' "$file"
    
    # Keep the tracking one removed as it's not critical
done

echo "JavaScript references updated in all HTML files!"