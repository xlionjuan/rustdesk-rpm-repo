#!/bin/bash

set -euo pipefail

export GPG_TTY=""

REPO_DIRS=(
  "wwwroot/latest"
  "wwwroot/latest-suse"
  "wwwroot/nightly"
  "wwwroot/nightly-suse"
)

for d in "${REPO_DIRS[@]}"; do
    xml="$d/repodata/repomd.xml"
    echo "Signing metadata: $xml"
    gpg --detach-sign --armor "$xml" &
done

wait
