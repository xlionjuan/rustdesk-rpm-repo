#!/bin/bash

set -oue pipefail

SOURCE_DIR="$1" # Directory containing the original .rpm files
TARGET_DIR=$(dirname "$SOURCE_DIR") # Target directory is the parent directory of SOURCE_DIR
DATE=$(date +%Y%m%d) # Current date in YYYYMMDD format

# Ensure the target directory exists
mkdir -p "$TARGET_DIR"

# Iterate over all .rpm files in the source directory
for rpm_file in "$SOURCE_DIR"/*.rpm; do
    if [ -f "$rpm_file" ]; then
        echo "Processing: $rpm_file"

        # Extract the original version
        ORIGINAL_VERSION=$(rpm -qp --qf '%{VERSION}' "$rpm_file")
        NEW_VERSION="${ORIGINAL_VERSION}+$DATE"

        # Rebuild the RPM using fpm
        fpm -t rpm -s rpm \
            --version "$NEW_VERSION" \
            -p "$TARGET_DIR/$(basename "$rpm_file")" \
            "$rpm_file"

        echo "Processed and moved to: "$TARGET_DIR"/$(basename "$rpm_file")"
    else
        echo "Skipping: $rpm_file"
    fi
done

echo "Done, all modified files moved to: $TARGET_DIR"
echo "Cleanup....."
rm -rf "$SOURCE_DIR"