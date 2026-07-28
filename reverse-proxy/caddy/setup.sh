#!/bin/sh
set -e
echo "=== Caddy Sandbox Provisioning ==="
mkdir -p /opt/caddy
cd /opt/caddy
# 1. Download Caddy release tarball from GitHub
if command -v wget >/dev/null 2>&1; then
    wget -O caddy.tar.gz "https://github.com/caddyserver/caddy/releases/download/v2.7.6/caddy_2.7.6_linux_amd64.tar.gz"
else
    curl -L -o caddy.tar.gz "https://github.com/caddyserver/caddy/releases/download/v2.7.6/caddy_2.7.6_linux_amd64.tar.gz"
fi
tar -xzf caddy.tar.gz caddy
rm -f caddy.tar.gz
chmod +x caddy

# 2. Create state directories
mkdir -p /var/lib/caddy/data
mkdir -p /var/lib/caddy/config

# 3. Create Caddyfile
echo 'localhost:8080 { respond "Hello from Caddy!" }' > Caddyfile

echo "=== Caddy Sandbox Forged ==="
