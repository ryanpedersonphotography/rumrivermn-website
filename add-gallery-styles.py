#!/usr/bin/env python3
import os
import re

# List of actual gallery directories (excluding non-gallery pages)
GALLERIES = [
    "allison-and-will",
    "anthony-and-linnea",
    "casey-garret",
    "dave-kayla",
    "emily-and-barron-nixon",
    "erin-kate",
    "james-and-denise-allen",
    "jenna-and-steven-tschirgi",
    "kage",
    "kerry-dominic",
    "kristine-leuze-rum-river",
    "kyle-carrie",
    "loria-and-jason-rolstad-agape",
    "nick-and-kayla",
    "rachel-and-vince",
    "reins-wedding",
    "mattea-courtney-photo-gallery",
    "2014-2",
    "engagement",
    "senior",
    "wedding"
]

# Read the complete styles and script from joshua-and-teri
with open('joshua-and-teri/index.html', 'r') as f:
    joshua_content = f.read()

# Extract the style block
style_match = re.search(r'<style>\s*\/\* Gallery grid fix \*\/.*?</style>', joshua_content, re.DOTALL)
if style_match:
    style_block = style_match.group(0)
else:
    print("Could not find style block in joshua-and-teri/index.html")
    exit(1)

# Extract the script block
script_match = re.search(r'<script>\s*\/\/ Immediately load all lazy images and setup lightbox.*?</script>', joshua_content, re.DOTALL)
if script_match:
    script_block = script_match.group(0)
else:
    print("Could not find script block in joshua-and-teri/index.html")
    exit(1)

print(f"Found style block ({len(style_block)} chars) and script block ({len(script_block)} chars)")

for gallery in GALLERIES:
    filepath = f"{gallery}/index.html"
    if os.path.exists(filepath):
        print(f"Processing {gallery}/index.html...")
        
        with open(filepath, 'r') as f:
            content = f.read()
        
        # Check if styles already exist
        if '/* Gallery grid fix */' in content:
            print(f"  - Styles already exist in {gallery}, updating...")
            # Remove old style block
            content = re.sub(r'<style>\s*\/\* Gallery grid fix \*\/.*?</style>', '', content, flags=re.DOTALL)
        
        # Check if script already exists
        if '// Immediately load all lazy images' in content:
            print(f"  - Script already exists in {gallery}, updating...")
            # Remove old script block
            content = re.sub(r'<script>\s*\/\/ Immediately load all lazy images.*?</script>', '', content, flags=re.DOTALL)
        
        # Add new style block before </head> or before first <script>
        if '</head>' in content:
            content = content.replace('</head>', f'{style_block}\n{script_block}\n</head>')
        elif '<div id="fb-root">' in content:
            content = content.replace('<div id="fb-root">', f'{style_block}\n{script_block}\n<div id="fb-root">')
        else:
            # Find a good place to insert
            match = re.search(r'(<link[^>]*custom-css[^>]*>)', content)
            if match:
                content = content.replace(match.group(1), f'{match.group(1)}\n{style_block}\n{script_block}')
        
        with open(filepath, 'w') as f:
            f.write(content)
        
        print(f"  - Added styles and scripts to {gallery}")
    else:
        print(f"  - Skipping {gallery} (no index.html found)")

print("\nAll gallery pages have been updated with masonry layout and lightbox!")