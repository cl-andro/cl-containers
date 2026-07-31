#!/bin/sh
set -e
echo "=== keydb-db Sandbox Setup ==="
mkdir -p /var/lib/keydb
mkdir -p /tmp/keydb-build

echo "Downloading KeyDB packages..."
curl -L -o /tmp/keydb-tools.deb https://download.keydb.dev/open-source-dist/pool/bookworm/main/k/keydb/keydb-tools_6.3.4-1+deb12u1_amd64.deb
curl -L -o /tmp/keydb-server.deb https://download.keydb.dev/open-source-dist/pool/bookworm/main/k/keydb/keydb-server_6.3.4-1+deb12u1_amd64.deb

echo "Extracting packages..."
mkdir -p /tmp/keydb-extract
dpkg-deb -x /tmp/keydb-tools.deb /tmp/keydb-extract
dpkg-deb -x /tmp/keydb-server.deb /tmp/keydb-extract

echo "Installing KeyDB..."
mkdir -p /opt/keydb/bin
cp /tmp/keydb-extract/usr/bin/keydb-server /opt/keydb/bin/
cp /tmp/keydb-extract/usr/bin/keydb-cli /opt/keydb/bin/
cp /tmp/keydb-extract/usr/bin/keydb-benchmark /opt/keydb/bin/ || true
cp /tmp/keydb-extract/usr/bin/keydb-check-aof /opt/keydb/bin/ || true
cp /tmp/keydb-extract/usr/bin/keydb-check-rdb /opt/keydb/bin/ || true

echo "Cleaning up..."
rm -rf /tmp/keydb-build /tmp/keydb-extract /tmp/keydb-tools.deb /tmp/keydb-server.deb

echo "=== keydb-db Sandbox Forged ==="
