#!/bin/sh
set -e
echo "=== WordPress Sandbox Provisioning ==="
mkdir -p /opt/wordpress
cd /opt/wordpress
if command -v wget >/dev/null 2>&1; then
    wget -O wordpress.tar.gz https://wordpress.org/latest.tar.gz
else
    curl -L -o wordpress.tar.gz https://wordpress.org/latest.tar.gz
fi
tar -xzf wordpress.tar.gz --strip-components=1
rm -f wordpress.tar.gz
echo "=== WordPress Sandbox Forged ==="
