#!/bin/bash

set -oue pipefail

rpm --addsign wwwroot/latest/*.rpm & \
rpm --addsign wwwroot/latest-suse/*.rpm & \
rpm --addsign wwwroot/nightly/*.rpm & \
rpm --addsign wwwroot/nightly-suse/*.rpm
