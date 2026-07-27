#!/bin/sh
set -e
echo "=== traefik-proxy Sandbox Setup ==="
mkdir -p /opt/traefik
cd /opt/traefik
if command -v wget >/dev/null 2>&1; then
    wget -O traefik.tar.gz https://github.com/traefik/traefik/releases/download/v2.10.1/traefik_v2.10.1_linux_amd64.tar.gz
else
    curl -L -o traefik.tar.gz https://github.com/traefik/traefik/releases/download/v2.10.1/traefik_v2.10.1_linux_amd64.tar.gz
fi
tar -xzf traefik.tar.gz
rm -f traefik.tar.gz

echo "=== traefik-proxy Sandbox Forged ==="
