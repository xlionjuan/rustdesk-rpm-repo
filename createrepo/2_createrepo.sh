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
    echo "Running createrepo_c on: $d"
    createrepo_c "$d" &
done


wait
