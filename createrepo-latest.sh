#!/bin/bash

# Sign RPM
rpm --addsign wwwroot/latest/*.rpm

# Create repo
createrepo_c wwwroot/latest

# Sign Repo
gpg --detach-sign --armor wwwroot/latest/repodata/repomd.xml
