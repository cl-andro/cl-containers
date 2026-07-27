#!/bin/sh
set -e
echo "=== cassandra-db Sandbox Setup ==="
mkdir -p /opt/cassandra
cd /opt/cassandra
if command -v wget >/dev/null 2>&1; then
    wget -O cassandra.tar.gz https://archive.apache.org/dist/cassandra/4.1.2/apache-cassandra-4.1.2-bin.tar.gz
else
    curl -L -o cassandra.tar.gz https://archive.apache.org/dist/cassandra/4.1.2/apache-cassandra-4.1.2-bin.tar.gz
fi
tar -xzf cassandra.tar.gz --strip-components=1
rm -f cassandra.tar.gz

echo "=== cassandra-db Sandbox Forged ==="
