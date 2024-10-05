#!/bin/bash

# Sign RPM
rpm --addsign wwwroot/nightly/*.rpm

# Create repo
createrepo_c wwwroot/nightly

# Sign Repo
gpg --detach-sign --armor wwwroot/nightly/repodata/repomd.xml
