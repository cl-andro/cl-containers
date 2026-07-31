#!/bin/sh
set -e
echo "=== keydb-db Sandbox Setup ==="
mkdir -p /var/lib/keydb
mkdir -p /tmp/keydb-build

echo "Downloading KeyDB source..."
curl -L -o /tmp/keydb.tar.gz https://github.com/Snapchat/KeyDB/archive/refs/tags/v6.3.4.tar.gz
tar -xzf /tmp/keydb.tar.gz -C /tmp/keydb-build --strip-components=1

echo "Compiling KeyDB..."
cd /tmp/keydb-build
make -j2

echo "Installing KeyDB..."
mkdir -p /usr/local/bin
cp src/keydb-server src/keydb-cli src/keydb-benchmark src/keydb-check-aof src/keydb-check-rdb /usr/local/bin/

echo "Cleaning up..."
rm -rf /tmp/keydb-build /tmp/keydb.tar.gz

echo "=== keydb-db Sandbox Forged ==="
