#!/bin/sh
set -e
echo "=== influxdb-db Sandbox Setup ==="
mkdir -p /opt/influxdb
cd /opt/influxdb
if command -v wget >/dev/null 2>&1; then
    wget -O influx.tar.gz https://dl.influxdata.com/influxdb/releases/influxdb-1.8.10_linux_amd64.tar.gz
else
    curl -L -o influx.tar.gz https://dl.influxdata.com/influxdb/releases/influxdb-1.8.10_linux_amd64.tar.gz
fi
tar -xzf influx.tar.gz
mv influxdb-*/* .
rm -rf influxdb-* influx.tar.gz

mkdir -p /var/lib/influxdb
mkdir -p /etc/influxdb

echo "=== influxdb-db Sandbox Forged ==="
