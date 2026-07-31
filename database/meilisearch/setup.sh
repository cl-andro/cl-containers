#!/bin/sh
set -e
echo "=== meilisearch Sandbox Setup ==="
mkdir -p /opt/meilisearch
cd /opt/meilisearch
if command -v wget >/dev/null 2>&1; then
    wget -O meilisearch https://github.com/meilisearch/meilisearch/releases/download/v1.2.0/meilisearch-linux-amd64
else
    curl -L -o meilisearch https://github.com/meilisearch/meilisearch/releases/download/v1.2.0/meilisearch-linux-amd64
fi
chmod +x meilisearch

# Ensure directory is world-writable so Meilisearch can write database files without permission conflicts
chmod 777 /opt/meilisearch

echo "=== meilisearch Sandbox Forged ==="
