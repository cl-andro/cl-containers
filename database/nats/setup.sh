#!/bin/sh
set -e
echo "=== nats-broker Sandbox Setup ==="
mkdir -p /opt/nats
cd /opt/nats
if command -v wget >/dev/null 2>&1; then
    wget -O nats.tar.gz https://github.com/nats-io/nats-server/releases/download/v2.9.19/nats-server-v2.9.19-linux-amd64.tar.gz
else
    curl -L -o nats.tar.gz https://github.com/nats-io/nats-server/releases/download/v2.9.19/nats-server-v2.9.19-linux-amd64.tar.gz
fi
tar -xzf nats.tar.gz --strip-components=1
rm -f nats.tar.gz

echo "=== nats-broker Sandbox Forged ==="
