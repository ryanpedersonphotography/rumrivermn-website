#\!/bin/bash

echo "Checking and downloading ALL missing images from all gallery pages..."

# List of all gallery pages
galleries=(
"kristine-leuze-rum-river"
"kyle-carrie"
"mattea-courtney-photo-gallery"
"senior"
"engagement"
"loria-and-jason-rolstad-agape"
"kage"
"jenna-and-steven-tschirgi"
"emily-and-barron-nixon"
"nick-and-kayla"
"reins-wedding"
"anthony-and-linnea"
"joshua-and-teri"
)

missing_count=0
downloaded_count=0

for gallery in "${galleries[@]}"; do
  if [ -f "$gallery/index.html" ]; then
    echo "Checking $gallery..."
    
    # Extract all image URLs from the gallery
    grep -o "data-lazy-load-img-src=\"[^\"]*\"" "$gallery/index.html" | \
    sed 's/data-lazy-load-img-src="//g' | sed 's/"//g' | sed 's/^..//' | \
    while read img_path; do
      if [ \! -f "$img_path" ]; then
        ((missing_count++))
        echo "  Missing: $img_path"
        
        # Create directory if needed
        dir=$(dirname "$img_path")
        mkdir -p "$dir"
        
        # Download the image
        if curl -s -L -f "https://rumrivermn.com/$img_path" -o "$img_path" 2>/dev/null; then
          echo "    ✓ Downloaded"
          ((downloaded_count++))
        else
          echo "    ✗ Failed to download"
          rm -f "$img_path" 2>/dev/null
        fi
      fi
    done
  fi
done

echo ""
echo "Download complete\!"
echo "Found $missing_count missing images"
