#!/bin/sh
set -e
echo "=== wireguard-vpn Sandbox Setup ==="
mkdir -p /opt/wireguard
mkdir -p /tmp/wg_extract
cd /tmp/wg_extract

echo "Downloading wireguard-tools package..."
curl -L -o wg.deb https://deb.debian.org/debian/pool/main/w/wireguard/wireguard-tools_1.0.20210914-3_amd64.deb

echo "Extracting package..."
dpkg-deb -x wg.deb /opt/wireguard/
rm -f wg.deb

# Clean up temp folder
cd /
rm -rf /tmp/wg_extract

mkdir -p /etc/wireguard
echo "=== wireguard-vpn Sandbox Forged ==="
