#!/bin/sh
set -e
echo "=== privoxy-proxy Sandbox Setup ==="
mkdir -p /opt/privoxy
mkdir -p /tmp/privoxy_extract
cd /tmp/privoxy_extract

echo "Downloading Privoxy package..."
curl -L -o privoxy.deb https://deb.debian.org/debian/pool/main/p/privoxy/privoxy_4.0.0-2_amd64.deb

echo "Extracting package..."
dpkg-deb -x privoxy.deb /opt/privoxy/
rm -f privoxy.deb

# Clean up temp folder
cd /
rm -rf /tmp/privoxy_extract

mkdir -p /etc/privoxy
echo "=== privoxy-proxy Sandbox Forged ==="
