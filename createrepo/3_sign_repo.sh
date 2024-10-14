#!/bin/bash

set -oue pipefail

gpg --detach-sign --armor wwwroot/latest/repodata/repomd.xml & \
gpg --detach-sign --armor wwwroot/latest-suse/repodata/repomd.xml & \
gpg --detach-sign --armor wwwroot/nightly/repodata/repomd.xml & \
gpg --detach-sign --armor wwwroot/nightly-suse/repodata/repomd.xml
