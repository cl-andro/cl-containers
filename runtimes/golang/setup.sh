#!/bin/sh
set -e
echo "=== Golang Sandbox Provisioning ==="
mkdir -p /opt/go
cd /opt/go
if command -v wget >/dev/null 2>&1; then
    wget -O go.tar.gz https://go.dev/dl/go1.20.6.linux-amd64.tar.gz
else
    curl -L -o go.tar.gz https://go.dev/dl/go1.20.6.linux-amd64.tar.gz
fi
tar -xzf go.tar.gz --strip-components=1
rm -f go.tar.gz
ln -sf /opt/go/bin/go /usr/local/bin/go
echo "=== Golang Sandbox Forged ==="
