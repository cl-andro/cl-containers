#!/bin/sh
set -e
echo "=== typesense-search Sandbox Setup ==="
mkdir -p /opt/typesense/data
cd /opt/typesense
if command -v wget >/dev/null 2>&1; then
    wget -O typesense.tar.gz https://dl.typesense.org/releases/0.24.1/typesense-server-0.24.1-linux-amd64.tar.gz
else
    curl -L -o typesense.tar.gz https://dl.typesense.org/releases/0.24.1/typesense-server-0.24.1-linux-amd64.tar.gz
fi
tar -xzf typesense.tar.gz
rm -f typesense.tar.gz

echo "Setting permissions..."
if [ -n "$SUDO_UID" ] && [ -n "$SUDO_GID" ]; then
    chown -R "$SUDO_UID:$SUDO_GID" /opt/typesense
else
    chmod -R 777 /opt/typesense
fi

echo "=== typesense-search Sandbox Forged ==="
