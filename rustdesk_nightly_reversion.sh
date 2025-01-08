#!/bin/bash

set -oue pipefail

SOURCE_DIR="$1" # Directory containing the original .rpm files
IS_NIGHTLY_ARG="$2" # Input arg that determine whether needs reversion or not
TARGET_DIR=$(dirname "$SOURCE_DIR") # Target directory is the parent directory of SOURCE_DIR
DATE=$(date +%Y%m%d) # Current date in YYYYMMDD format

# Ensure the target directory exists
mkdir -p "$TARGET_DIR"

# Use $IS_NIGHTLY_ARG to determine it needs reversion or not
if [[ "$IS_NIGHTLY_ARG" == "IS_NIGHTLY" ]]; then
    echo "IS_NIGHTLY passed in, will reversion."
    IS_REVERSION=true
elif [[ -z "$IS_NIGHTLY_ARG" ]]; then
    echo "IS_NIGHTLY IS NOT passed in, will repackage (recompression) only."
    IS_REVERSION=false
else
    echo "Unexpected input, exit."
    exit 1
fi

# Iterate over all .rpm files in the source directory
for rpm_file in "$SOURCE_DIR"/*.rpm; do
    if [ -f "$rpm_file" ]; then
        (
            echo "Processing: $rpm_file"
            # Extract the original version
            ORIGINAL_VERSION=$(rpm -qp --qf '%{VERSION}' "$rpm_file")
            NEW_VERSION="${ORIGINAL_VERSION}+$DATE"
            # Arg determine by $IS_REVERSION
            if [[ "$IS_REVERSION" == true ]]; then
                FPM_RPM_VERSION_ARG="--version $NEW_VERSION"
            else
                FPM_RPM_VERSION_ARG=""
            fi
            # Rebuild the RPM using fpm
            fpm -t rpm -s rpm \
                $FPM_RPM_VERSION_ARG --rpm-compression xz\
                -p "$TARGET_DIR/$(basename "$rpm_file")" \
                "$rpm_file"
            echo "Processed and moved to: $TARGET_DIR/$(basename "$rpm_file")"
        ) &
    else
        echo "Skipping: $rpm_file"
    fi
done
wait

echo "Done, all modified files moved to: $TARGET_DIR"
echo "Cleanup....."
rm -rf "$SOURCE_DIR"
