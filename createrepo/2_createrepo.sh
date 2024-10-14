#!/bin/bash

set -oue pipefail

createrepo_c wwwroot/latest & \
createrepo_c wwwroot/latest-suse & \
createrepo_c wwwroot/nightly & \
createrepo_c wwwroot/nightly-suse
