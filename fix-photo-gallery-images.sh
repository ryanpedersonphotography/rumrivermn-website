#!/bin/bash

echo "Fixing photo gallery image lazy-load attributes..."

# Fix all lazy-load image attributes that end with single quote
sed -i '' "s/data-lazy-load-img-src=\"\([^\"]*\)'/data-lazy-load-img-src=\"\1\"/g" photo-gallery/index.html

echo "Photo gallery images fixed!"