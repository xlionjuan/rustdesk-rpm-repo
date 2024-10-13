#!/bin/bash

set -oue pipefail

# Sign RPM
rpm --addsign wwwroot/latest/*.rpm
rpm --addsign wwwroot/latest-suse/*.rpm

# Create repo
createrepo_c wwwroot/latest
createrepo_c wwwroot/latest-suse

# Sign Repo
gpg --detach-sign --armor wwwroot/latest/repodata/repomd.xml
gpg --detach-sign --armor wwwroot/latest-suse/repodata/repomd.xml
