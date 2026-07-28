#!/bin/sh
set -e
echo "=== etcd-store Sandbox Setup ==="
mkdir -p /opt/etcd
cd /opt/etcd
if command -v wget >/dev/null 2>&1; then
    wget -O etcd.tar.gz https://github.com/etcd-io/etcd/releases/download/v3.5.9/etcd-v3.5.9-linux-amd64.tar.gz
else
    curl -L -o etcd.tar.gz https://github.com/etcd-io/etcd/releases/download/v3.5.9/etcd-v3.5.9-linux-amd64.tar.gz
fi
tar -xzf etcd.tar.gz --strip-components=1
rm -f etcd.tar.gz

# 2. Create dedicated data directory
mkdir -p /var/lib/etcd

echo "=== etcd-store Sandbox Forged ==="
