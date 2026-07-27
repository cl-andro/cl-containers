#!/bin/sh
set -e
echo "=== typesense-search Sandbox Setup ==="
mkdir -p /opt/typesense/data
cd /opt/typesense
if command -v wget >/dev/null 2>&1; then
    wget -O typesense.tar.gz https://dl.typesense.org/releases/0.24.1/typesense-server-0.24.1-amd64.tar.gz
else
    curl -L -o typesense.tar.gz https://dl.typesense.org/releases/0.24.1/typesense-server-0.24.1-amd64.tar.gz
fi
tar -xzf typesense.tar.gz
rm -f typesense.tar.gz

echo "=== typesense-search Sandbox Forged ==="
