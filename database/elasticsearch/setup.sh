#!/bin/sh
set -e
echo "=== Elasticsearch Sandbox Provisioning ==="
mkdir -p /opt/elasticsearch
cd /opt/elasticsearch
if command -v wget >/dev/null 2>&1; then
    wget -O elastic.tar.gz https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.17.10-linux-x86_64.tar.gz
else
    curl -L -o elastic.tar.gz https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.17.10-linux-x86_64.tar.gz
fi
tar -xzf elastic.tar.gz --strip-components=1
rm -f elastic.tar.gz
echo "=== Elasticsearch Sandbox Forged ==="
