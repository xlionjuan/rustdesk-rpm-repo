#!/bin/bash

set -oue pipefail

echo "Signing..."
rpm --addsign wwwroot/latest/*.rpm
rpm --addsign wwwroot/latest-suse/*.rpm
rpm --addsign wwwroot/nightly/*.rpm
rpm --addsign wwwroot/nightly-suse/*.rpm
echo ""

echo "Validate..."

set -ouex pipefail

for f in wwwroot/{latest,latest-suse,nightly,nightly-suse}/*.rpm; do
    echo "Checking: $f"
    if rpm -K "$f" | grep -q "signatures OK"; then
        echo "  ✔ OK: $f"
    else
        echo "  ❌ Signature invalid or missing: $f"
        exit 1
    fi
done
