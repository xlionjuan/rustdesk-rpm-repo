#!/bin/bash

set -oue pipefail

# Sign RPM
rpm --addsign wwwroot/nightly/*.rpm
rpm --addsign wwwroot/nightly-suse/*.rpm

# Create repo
createrepo_c wwwroot/nightly
createrepo_c wwwroot/nightly-suse

# Sign Repo
gpg --detach-sign --armor wwwroot/nightly/repodata/repomd.xml
gpg --detach-sign --armor wwwroot/nightly-suse/repodata/repomd.xml
