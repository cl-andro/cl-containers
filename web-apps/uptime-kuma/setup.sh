#!/bin/sh
set -e
echo "=== uptime-kuma Sandbox Setup ==="
mkdir -p /opt/uptime-kuma
cd /opt/uptime-kuma
if command -v wget >/dev/null 2>&1; then
    wget -O uptime.tar.gz https://github.com/louislam/uptime-kuma/archive/refs/tags/1.22.1.tar.gz
else
    curl -L -o uptime.tar.gz https://github.com/louislam/uptime-kuma/archive/refs/tags/1.22.1.tar.gz
fi
tar -xzf uptime.tar.gz --strip-components=1
rm -f uptime.tar.gz

echo "=== uptime-kuma Sandbox Forged ==="
