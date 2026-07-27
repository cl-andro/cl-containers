#!/bin/sh
set -e
echo "=== freshrss-app Sandbox Setup ==="
mkdir -p /opt/freshrss
cd /opt/freshrss
if command -v wget >/dev/null 2>&1; then
    wget -O fresh.tar.gz https://github.com/FreshRSS/FreshRSS/archive/refs/tags/1.21.0.tar.gz
else
    curl -L -o fresh.tar.gz https://github.com/FreshRSS/FreshRSS/archive/refs/tags/1.21.0.tar.gz
fi
tar -xzf fresh.tar.gz --strip-components=1
rm -f fresh.tar.gz

echo "=== freshrss-app Sandbox Forged ==="
