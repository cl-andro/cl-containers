#!/bin/sh
set -e
echo "=== hugo-builder Sandbox Setup ==="
mkdir -p /opt/hugo
cd /opt/hugo
if command -v wget >/dev/null 2>&1; then
    wget -O hugo.tar.gz https://github.com/gohugoio/hugo/releases/download/v0.115.1/hugo_extended_0.115.1_linux-amd64.tar.gz
else
    curl -L -o hugo.tar.gz https://github.com/gohugoio/hugo/releases/download/v0.115.1/hugo_extended_0.115.1_linux-amd64.tar.gz
fi
tar -xzf hugo.tar.gz
rm -f hugo.tar.gz

echo "=== hugo-builder Sandbox Forged ==="
