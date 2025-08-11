#!/bin/bash

# List of gallery directories
GALLERIES=(
    "allison-and-will"
    "anthony-and-linnea"
    "casey-garret"
    "dave-kayla"
    "emily-and-barron-nixon"
    "erin-kate"
    "james-and-denise-allen"
    "jenna-and-steven-tschirgi"
    "kage"
    "kerry-dominic"
    "kristine-leuze-rum-river"
    "kyle-carrie"
    "loria-and-jason-rolstad-agape"
    "mitch-jodi"
    "nick-and-kristen-helget"
    "rebecca-steve"
    "reins-wedding"
    "taylor-and-wes-sickmann-venue"
    "travis-and-alisa-swanson"
    "wendy-and-steve"
)

# Get the styles and scripts from joshua-and-teri
STYLE_START='<style>'
STYLE_END='</style>'
SCRIPT_START='<script>'
SCRIPT_END='</script>'

# Extract the complete style and script blocks from joshua-and-teri
STYLE_CONTENT=$(sed -n '/<style>/,/<\/style>/p' joshua-and-teri/index.html | head -n 152)
SCRIPT_CONTENT=$(sed -n '/\/\/ Immediately load all lazy images and setup lightbox/,/});/p' joshua-and-teri/index.html | head -n 62)

echo "Applying gallery fixes to all subdirectories..."

for gallery in "${GALLERIES[@]}"; do
    if [ -f "$gallery/index.html" ]; then
        echo "Processing $gallery/index.html..."
        
        # 1. Fix mismatched quotes in data-lazy-load-img-src
        sed -i '' "s/data-lazy-load-img-src=\"\([^']*\)'/data-lazy-load-img-src=\"\1\"/g" "$gallery/index.html"
        
        # 2. Convert relative paths to absolute paths
        sed -i '' 's|data-lazy-load-img-src="../files/|data-lazy-load-img-src="/files/|g' "$gallery/index.html"
        sed -i '' 's|src="../cms_websites/|src="/cms_websites/|g' "$gallery/index.html"
        sed -i '' 's|href="../files/|href="/files/|g' "$gallery/index.html"
        sed -i '' 's|src="../files/|src="/files/|g' "$gallery/index.html"
        
        # 3. Fix JavaScript sources
        sed -i '' 's|src="../cms_websites/js/|src="/cms_websites/js/|g' "$gallery/index.html"
        
        # 4. Remove problematic block_link overlays from hero images
        sed -i '' '/<a class=.block_link.*data-title=....><\/a>/d' "$gallery/index.html"
        
        echo "  - Fixed paths and quotes for $gallery"
    else
        echo "  - Skipping $gallery (no index.html found)"
    fi
done

echo "All galleries have been updated!"