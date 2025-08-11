#!/bin/bash

echo "🔧 Fixing CSS paths in subdirectory index.html files..."
echo "======================================================="
echo ""

# Find all index.html files in subdirectories
for file in */index.html; do
    if [ -f "$file" ]; then
        echo "Processing: $file"
        
        # Fix CSS paths - add ../ prefix where missing
        # Fix beacon-theme.css path
        sed -i '' 's|href="cms_websites/beacon-theme.css"|href="../cms_websites/beacon-theme.css"|g' "$file"
        
        # Fix cms_theme_custom_css.css path
        sed -i '' 's|href="cms_websites/cms_theme_custom_css.css"|href="../cms_websites/cms_theme_custom_css.css"|g' "$file"
        
        # Fix cms_custom_css.css path
        sed -i '' 's|href="cms_websites/cms_custom_css.css"|href="../cms_websites/cms_custom_css.css"|g' "$file"
        
        # Fix theme.css if it exists
        sed -i '' 's|href="cms_websites/theme.css"|href="../cms_websites/theme.css"|g' "$file"
        
        # Count fixes
        fixes=$(grep -c 'href="../cms_websites' "$file" 2>/dev/null || echo 0)
        echo "  ✓ Fixed $fixes CSS references"
    fi
done

echo ""
echo "✅ CSS paths fixed in all subdirectory pages!"
echo ""
echo "Files that were updated:"
find . -name "index.html" -path "*/index.html" -exec echo "  - {}" \;