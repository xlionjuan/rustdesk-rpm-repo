#!/bin/bash

set -oue pipefail

echo "Signing..."
rpm --addsign wwwroot/latest/*.rpm & \
rpm --addsign wwwroot/latest-suse/*.rpm & \
rpm --addsign wwwroot/nightly/*.rpm & \
rpm --addsign wwwroot/nightly-suse/*.rpm
echo ""

echo "Validate..."

set -ouex pipefail

rpm -K wwwroot/latest/*.rpm | grep -q "signatures OK"
rpm -K wwwroot/latest-suse/*.rpm | grep -q "signatures OK"
rpm -K wwwroot/nightly/*.rpm | grep -q "signatures OK"
rpm -K wwwroot/nightly-suse/*.rpm | grep -q "signatures OK"