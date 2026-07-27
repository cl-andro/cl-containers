#!/bin/sh
set -e
echo "=== Caddy Sandbox Provisioning ==="
mkdir -p /opt/caddy
cd /opt/caddy
if command -v wget >/dev/null 2>&1; then
    wget -O caddy.tar.gz "https://caddyserver.com/api/download?os=linux&arch=amd64"
else
    curl -L -o caddy.tar.gz "https://caddyserver.com/api/download?os=linux&arch=amd64"
fi
tar -xzf caddy.tar.gz
rm -f caddy.tar.gz
echo 'localhost:8080 { respond "Hello from Caddy!" }' > Caddyfile
echo "=== Caddy Sandbox Forged ==="
