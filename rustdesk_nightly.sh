#!/bin/bash

set -oue pipefail

# Define the repository and the tag you want to fetch
REPO="rustdesk/rustdesk"
TAG="nightly"  # Change this to any tag you want
API_URL="https://api.github.com/repos/$REPO/releases/tags/$TAG"
#API_URL="https://api.github.com/repos/$REPO/releases/latest"
# Fetch the release data for the specified tag using curl
RELEASE_DATA=$(curl --retry 3 -s "$API_URL")

# Check if RELEASE_DATA is not empty
if [ -z "$RELEASE_DATA" ]; then
    echo "Failed to fetch release data. Please check your internet connection or the repository/tag name."
    exit 1
fi

# Use jq to parse JSON data and find the asset URL
RUSTDESK_URL_AMD64=$(echo "$RELEASE_DATA" | jq -r '.assets[] | select(.name | contains("x86_64") and endswith(".rpm") and (contains("suse") | not)) | .browser_download_url' | head -n 1)
RUSTDESK_URL_ARM64=$(echo "$RELEASE_DATA" | jq -r '.assets[] | select(.name | contains("aarch64") and endswith(".rpm") and (contains("suse") | not)) | .browser_download_url' | head -n 1)
RUSTDESK_URL_AMD64_SUSE=$(echo "$RELEASE_DATA" | jq -r '.assets[] | select(.name | contains("x86_64") and endswith(".rpm") and contains("suse")) | .browser_download_url' | head -n 1)
RUSTDESK_URL_ARM64_SUSE=$(echo "$RELEASE_DATA" | jq -r '.assets[] | select(.name | contains("aarch64") and endswith(".rpm") and contains("suse")) | .browser_download_url' | head -n 1)

echo "--------------------RESULT--------------------"
echo "RUSTDESK_URL_AMD64=\"$RUSTDESK_URL_AMD64\""
echo "RUSTDESK_URL_ARM64=\"$RUSTDESK_URL_ARM64\""
echo "RUSTDESK_URL_AMD64=\"$RUSTDESK_URL_AMD64_SUSE\""
echo "RUSTDESK_URL_ARM64=\"$RUSTDESK_URL_ARM64_SUSE\""
echo ""
echo "------------------DOWNLOADING-----------------"
wget -P wwwroot/nightly $RUSTDESK_URL_AMD64
wget -P wwwroot/nightly $RUSTDESK_URL_ARM64
wget -P wwwroot/latest-suse $RUSTDESK_URL_AMD64_SUSE
wget -P wwwroot/latest-suse $RUSTDESK_URL_ARM64_SUSE
