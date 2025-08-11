#!/bin/bash

# Fix external JavaScript references to use local paths
echo "Fixing external JavaScript references..."

# For root level pages
find . -maxdepth 1 -name "*.html" -type f | while read file; do
    # Replace https://rumrivermn.com references with local paths
    sed -i '' 's|src="https://rumrivermn.com/cms_websites/|src="cms_websites/|g' "$file"
    sed -i '' 's|src="https://rumrivermn.com/wp-content/|src="wp-content/|g' "$file"
    echo "Fixed root: $file"
done

# For subdirectory pages
find . -mindepth 2 -name "*.html" -type f | while read file; do
    # Replace https://rumrivermn.com references with local paths
    sed -i '' 's|src="https://rumrivermn.com/cms_websites/|src="../cms_websites/|g' "$file"
    sed -i '' 's|src="https://rumrivermn.com/wp-content/|src="../wp-content/|g' "$file"
    echo "Fixed subdir: $file"
done

echo "All external JavaScript references fixed!"