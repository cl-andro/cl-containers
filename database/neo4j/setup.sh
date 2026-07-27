#!/bin/sh
set -e
echo "=== neo4j-db Sandbox Setup ==="
mkdir -p /opt/neo4j
cd /opt/neo4j
if command -v wget >/dev/null 2>&1; then
    wget -O neo4j.tar.gz https://dist.neo4j.org/neo4j-community-5.9.0-unix.tar.gz
else
    curl -L -o neo4j.tar.gz https://dist.neo4j.org/neo4j-community-5.9.0-unix.tar.gz
fi
tar -xzf neo4j.tar.gz --strip-components=1
rm -f neo4j.tar.gz

echo "=== neo4j-db Sandbox Forged ==="
