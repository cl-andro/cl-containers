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

echo "=== meilisearch Sandbox Forged ==="
