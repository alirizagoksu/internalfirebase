#!/bin/bash

# Script to update Package.swift checksums from checksums.txt
# Usage: ./Scripts/update-package-checksums.sh

CHECKSUMS_FILE="BinaryArchives/checksums.txt"
PACKAGE_FILE="Package.swift"
PACKAGE_BACKUP="Package.swift.backup"

# Backup Package.swift
cp "$PACKAGE_FILE" "$PACKAGE_BACKUP"

echo "Updating checksums in Package.swift..."
echo ""

# Read checksums and update Package.swift
while IFS='|' read -r zipname checksum; do
    # Extract framework name (remove .xcframework.zip)
    framework=$(echo "$zipname" | sed 's/.xcframework.zip//')
    
    echo "Updating: $framework"
    echo "  New checksum: $checksum"
    
    # Use sed to find and replace the checksum for this framework
    # Pattern: finds the binaryTarget with matching URL and updates its checksum
    sed -i '' -E "/download\/[0-9.]+\/${framework}.xcframework.zip/,/checksum:/ s/checksum: \"[^\"]+\"/checksum: \"${checksum}\"/" "$PACKAGE_FILE"
    
done < "$CHECKSUMS_FILE"

echo ""
echo "✓ All checksums updated in Package.swift"
echo "✓ Backup saved to $PACKAGE_BACKUP"
