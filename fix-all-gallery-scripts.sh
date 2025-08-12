#!/bin/bash

# Fix jQuery loading order in all gallery pages
echo "Fixing jQuery loading order in all gallery pages..."

# List of gallery subdirectories
galleries=(
    "2014-2"
    "allison-and-will"
    "casey-garret"
    "dave-kayla"
    "emily-and-barron-nixon"
    "engagement"
    "erin-kate"
    "james-and-denise-allen"
    "jenna-and-steven-tschirgi"
    "joshua-and-teri"
    "kage"
    "kerry-dominic"
    "kristine-leuze-rum-river"
    "kyle-carrie"
    "loria-and-jason-rolstad-agape"
    "mattea-courtney-photo-gallery"
    "nick-and-kayla"
    "rachel-and-vince"
    "reins-wedding"
    "senior"
    "wedding"
)

for gallery in "${galleries[@]}"; do
    file="$gallery/index.html"
    
    if [ -f "$file" ]; then
        echo "Processing: $file"
        
        # Check if already has jQuery in head
        if grep -q '<script type="text/javascript" src="../cms_websites/js/dist/shared/external/scripts.min.js"></script>' "$file" && grep -n '<script type="text/javascript" src="../cms_websites/js/dist/shared/external/scripts.min.js"></script>' "$file" | head -1 | cut -d: -f1 | xargs test 50 -gt 2>/dev/null; then
            echo "  ✓ Already has jQuery in head section"
            continue
        fi
        
        # Step 1: Add jQuery to head section (after line containing "Scripts loaded at bottom" comment or similar)
        if grep -q "<!-- Scripts loaded at bottom for better performance -->" "$file"; then
            sed -i '' 's|<!-- Scripts loaded at bottom for better performance -->|<!-- Load jQuery and required scripts in head to fix execution order -->\
    <script type="text/javascript" src="../cms_websites/js/dist/shared/external/scripts.min.js"></script>|' "$file"
            echo "  + Added jQuery to head section"
        elif ! grep -q '<script type="text/javascript" src="../cms_websites/js/dist/shared/external/scripts.min.js"></script>' "$file"; then
            # If no jQuery at all, add it before </head>
            sed -i '' 's|</head>|    <!-- Load jQuery and required scripts in head to fix execution order -->\
    <script type="text/javascript" src="../cms_websites/js/dist/shared/external/scripts.min.js"></script>\
</head>|' "$file"
            echo "  + Added jQuery before </head>"
        fi
        
        # Step 2: Remove duplicate jQuery loading from bottom (if exists)
        # Look for the pattern at the bottom of the file
        if grep -q '<!-- Load main scripts bundle first (includes jQuery, underscore, etc) -->' "$file"; then
            # Remove the duplicate jQuery script line and update comment
            sed -i '' 's|<!-- Load main scripts bundle first (includes jQuery, underscore, etc) -->|<!-- Additional theme scripts (jQuery already loaded in head) -->|' "$file"
            sed -i '' '/<!\-\- Additional theme scripts (jQuery already loaded in head) \-\->/,+1 s|<script type="text/javascript" src="../cms_websites/js/dist/shared/external/scripts.min.js"></script>||' "$file"
            echo "  - Removed duplicate jQuery from bottom"
        fi
        
        # Also check for pattern without comment
        temp_file="${file}.tmp"
        awk '
            /<script type="text\/javascript" src="\.\.\/cms_websites\/js\/dist\/shared\/external\/scripts\.min\.js"><\/script>/ {
                if (NR > 1000) {
                    # Skip this line if it appears after line 1000 (likely at bottom)
                    next
                }
            }
            {print}
        ' "$file" > "$temp_file"
        
        # Only replace if file changed
        if ! cmp -s "$file" "$temp_file"; then
            mv "$temp_file" "$file"
            echo "  - Cleaned up duplicate script tags"
        else
            rm "$temp_file"
        fi
        
        echo "  ✓ Fixed: $gallery"
    else
        echo "  ⚠ File not found: $file"
    fi
done

echo ""
echo "✅ All gallery pages have been fixed!"
echo "Run 'git status' to see the changes"