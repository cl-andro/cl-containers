#!/bin/sh
set -e
echo "=== ClickHouse Sandbox Provisioning (Self-Contained) ==="

# 1. Create directory structure
mkdir -p /opt/clickhouse/bin
mkdir -p /opt/clickhouse/etc/clickhouse-server
mkdir -p /var/lib/clickhouse
mkdir -p /var/log/clickhouse-server

# 2. Download ClickHouse standalone binary
cd /opt/clickhouse/bin
echo "Downloading ClickHouse binary..."
if command -v wget >/dev/null 2>&1; then
    wget https://builds.clickhouse.com/master/amd64/clickhouse
else
    curl -O https://builds.clickhouse.com/master/amd64/clickhouse
fi
chmod +x clickhouse

# 3. Create clickhouse-server symlink
ln -sf clickhouse clickhouse-server

# 4. Download default configuration files
cd /opt/clickhouse/etc/clickhouse-server
echo "Downloading default ClickHouse configurations..."
if command -v wget >/dev/null 2>&1; then
    wget https://raw.githubusercontent.com/ClickHouse/ClickHouse/master/programs/server/config.xml
    wget https://raw.githubusercontent.com/ClickHouse/ClickHouse/master/programs/server/users.xml
else
    curl -O https://raw.githubusercontent.com/ClickHouse/ClickHouse/master/programs/server/config.xml
    curl -O https://raw.githubusercontent.com/ClickHouse/ClickHouse/master/programs/server/users.xml
fi

# 5. Enable listening on all interfaces (0.0.0.0 / ::)
sed -i 's|<!-- <listen_host>::</listen_host> -->|<listen_host>::</listen_host>|' config.xml

# 6. Apply ownership permissions for unprivileged execution
if [ -n "$INVOKING_USER" ] && [ "$INVOKING_USER" != "root" ]; then
    chown -R "$INVOKING_USER" /var/lib/clickhouse
    chown -R "$INVOKING_USER" /var/log/clickhouse-server
fi

echo "=== clickhouse-db Sandbox Forged ==="
