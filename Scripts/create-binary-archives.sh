#!/bin/bash

# Script to create zip archives and checksums for all XCFrameworks
# Usage: ./Scripts/create-binary-archives.sh

set -e

FRAMEWORKS_DIR="Frameworks"
OUTPUT_DIR="BinaryArchives"
CHECKSUMS_FILE="checksums.txt"

# Create output directory
mkdir -p "$OUTPUT_DIR"
rm -f "$OUTPUT_DIR/$CHECKSUMS_FILE"

echo "Creating zip archives for XCFrameworks..."
echo ""

# Find all .xcframework directories
find "$FRAMEWORKS_DIR" -maxdepth 1 -name "*.xcframework" -type d | while read -r framework; do
    # Get framework name without path
    framework_name=$(basename "$framework")
    zip_name="${framework_name%.xcframework}.xcframework.zip"
    
    echo "Processing: $framework_name"
    
    # Create zip (excluding .DS_Store files)
    cd "$FRAMEWORKS_DIR"
    zip -r -q "../$OUTPUT_DIR/$zip_name" "$framework_name" -x "*.DS_Store"
    cd ..
    
    # Calculate checksum
    checksum=$(swift package compute-checksum "$OUTPUT_DIR/$zip_name")
    
    echo "  ✓ Created: $zip_name"
    echo "  ✓ Checksum: $checksum"
    echo ""
    
    # Save to checksums file
    echo "$zip_name|$checksum" >> "$OUTPUT_DIR/$CHECKSUMS_FILE"
done

echo "✓ All archives created successfully!"
echo ""
echo "Next steps:"
echo "1. Create a GitHub Release (e.g., 12.6.1)"
echo "2. Upload all .zip files from $OUTPUT_DIR/"
echo "3. Run: ./Scripts/generate-package-swift.sh"
