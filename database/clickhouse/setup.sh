#!/bin/sh
set -e
echo "=== clickhouse-db Sandbox Setup ==="
mkdir -p /opt/clickhouse/bin
cd /opt/clickhouse/bin
if command -v wget >/dev/null 2>&1; then
    wget https://builds.clickhouse.com/master/amd64/clickhouse
else
    curl -O https://builds.clickhouse.com/master/amd64/clickhouse
fi
chmod +x clickhouse

echo "=== clickhouse-db Sandbox Forged ==="
