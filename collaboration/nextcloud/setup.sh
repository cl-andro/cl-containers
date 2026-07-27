#!/bin/sh
set -e
echo "=== Nextcloud Sandbox Provisioning ==="
mkdir -p /opt/nextcloud
cd /opt/nextcloud
if command -v wget >/dev/null 2>&1; then
    wget -O nextcloud.zip https://download.nextcloud.com/server/releases/latest.zip
else
    curl -L -o nextcloud.zip https://download.nextcloud.com/server/releases/latest.zip
fi
unzip nextcloud.zip
mv nextcloud/* .
rm -rf nextcloud nextcloud.zip
echo "=== Nextcloud Sandbox Forged ==="
