#!/bin/bash

# Fix CSS paths in all HTML files
echo "Updating CSS paths in all HTML files..."

# Find all HTML files and update CSS paths
find . -name "*.html" -type f | while read file; do
    echo "Processing: $file"
    
    # Update beacon theme CSS path
    sed -i '' 's|https://rumrivermn.com/cms_websites/css/dist/beacon-theme_easton/theme.css[^"]*|cms_websites/beacon-theme.css|g' "$file"
    
    # Update custom theme CSS path
    sed -i '' 's|https://rumrivermn.com/cms_websites/cms_theme_custom_css.php[^"]*|cms_websites/cms_theme_custom_css.css|g' "$file"
    
    # Update custom CSS path
    sed -i '' 's|https://rumrivermn.com/cms_websites/cms_custom_css.php[^"]*|cms_websites/cms_custom_css.css|g' "$file"
    
    # Remove external JS references that aren't available locally
    sed -i '' 's|<script type="text/javascript" src="https://rumrivermn.com/cms_websites/js/dist/shared/external/scripts.min.js"></script>|<!-- External JS removed - not available locally -->|g' "$file"
    sed -i '' 's|<script type="text/javascript" src="https://rumrivermn.com/cms_websites/tools/AdminBarAnalytics/js/external-tracking.min.js"></script>|<!-- External tracking removed - not available locally -->|g' "$file"
done

echo "CSS paths updated in all HTML files!"