#!/bin/sh
set -e
echo "=== telegraf-agent Sandbox Setup ==="
mkdir -p /opt/telegraf
cd /opt/telegraf
if command -v wget >/dev/null 2>&1; then
    wget -O telegraf.tar.gz https://dl.influxdata.com/telegraf/releases/telegraf-1.27.0_linux_amd64.tar.gz
else
    curl -L -o telegraf.tar.gz https://dl.influxdata.com/telegraf/releases/telegraf-1.27.0_linux_amd64.tar.gz
fi
tar -xzf telegraf.tar.gz --strip-components=2
rm -f telegraf.tar.gz

echo "=== telegraf-agent Sandbox Forged ==="
