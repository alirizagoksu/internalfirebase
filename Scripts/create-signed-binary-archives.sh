#!/bin/bash

# Script to create zip archives with code signature preservation
# Usage: ./Scripts/create-signed-binary-archives.sh

set -e

FRAMEWORKS_DIR="Frameworks"
OUTPUT_DIR="BinaryArchives"
CHECKSUMS_FILE="checksums.txt"

# Create output directory
mkdir -p "$OUTPUT_DIR"
rm -f "$OUTPUT_DIR/$CHECKSUMS_FILE"

echo "Creating zip archives with ditto (preserves code signatures)..."
echo ""

# Find all .xcframework directories
find "$FRAMEWORKS_DIR" -maxdepth 1 -name "*.xcframework" -type d | while read -r framework; do
    # Get framework name without path
    framework_name=$(basename "$framework")
    zip_name="${framework_name%.xcframework}.xcframework.zip"
    
    echo "Processing: $framework_name"
    
    # Create zip using ditto (preserves resource forks and code signatures)
    cd "$FRAMEWORKS_DIR"
    ditto -c -k --sequesterRsrc --keepParent --norsrc "$framework_name" "../$OUTPUT_DIR/$zip_name"
    cd ..
    
    # Calculate checksum
    checksum=$(swift package compute-checksum "$OUTPUT_DIR/$zip_name")
    
    echo "  ✓ Created: $zip_name"
    echo "  ✓ Checksum: $checksum"
    echo ""
    
    # Save to checksums file
    echo "$zip_name|$checksum" >> "$OUTPUT_DIR/$CHECKSUMS_FILE"
done

echo "✓ All archives created successfully with code signatures preserved!"
echo ""
echo "Next steps:"
echo "1. Delete all .zip files from GitHub Release 12.6.1"
echo "2. Upload new .zip files from $OUTPUT_DIR/"
echo "3. Update Package.swift checksums if needed"
