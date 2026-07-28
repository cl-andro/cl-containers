#!/bin/sh
set -e
echo "=== Caddy Sandbox Provisioning ==="
mkdir -p /opt/caddy
cd /opt/caddy
# 1. Download Caddy raw binary directly
if command -v wget >/dev/null 2>&1; then
    wget -O caddy "https://caddyserver.com/api/download?os=linux&arch=amd64"
else
    curl -L -o caddy "https://caddyserver.com/api/download?os=linux&arch=amd64"
fi
chmod +x caddy

# 2. Create state directories
mkdir -p /var/lib/caddy/data
mkdir -p /var/lib/caddy/config

# 3. Create Caddyfile
echo 'localhost:8080 { respond "Hello from Caddy!" }' > Caddyfile

# 4. Apply permissions for unprivileged execution
if [ -n "$INVOKING_USER" ] && [ "$INVOKING_USER" != "root" ]; then
    chown -R "$INVOKING_USER" /var/lib/caddy
fi

echo "=== Caddy Sandbox Forged ==="
