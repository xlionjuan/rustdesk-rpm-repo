#!/bin/bash

set -euo pipefail

# Folder list
RPM_DIRS=(
  "wwwroot/latest"
  "wwwroot/latest-suse"
  "wwwroot/nightly"
  "wwwroot/nightly-suse"
)

MAX_RETRY=3
RETRY_SLEEP=2

# Return 0 = success
has_signature() {
  rpm -K "$1" | grep -q "signatures OK"
}

echo "Signing..."
for d in "${RPM_DIRS[@]}"; do
  for f in "$d"/*.rpm; do
    echo "Signing: $f"
    rpm --addsign "$f"
  done
done
echo ""

echo "Validate..."

for d in "${RPM_DIRS[@]}"; do
  for f in "$d"/*.rpm; do
    echo "Checking: $f"

    if has_signature "$f"; then
      echo "  ✔ OK: $f"
      continue
    fi

    echo "  ⚠ Signature missing or invalid, start retry: $f"

    attempt=1
    while (( attempt <= MAX_RETRY )); do
      echo "  → Retry $attempt/$MAX_RETRY: $f"
      # Ignore exit code for rpm-sign
      if ! rpm --addsign "$f"; then
        echo "    (rpm --addsign returned non-zero, ignore and re-check)"
      fi

      if has_signature "$f"; then
        echo "  ✔ OK after retry: $f"
        break
      fi

      (( attempt++ ))
      sleep "$RETRY_SLEEP"
    done

    # Failed completely when still not success
    if ! has_signature "$f"; then
      echo "  ❌ Signature invalid or missing after ${MAX_RETRY} retries: $f"
      exit 1
    fi
  done
done
