#!/bin/sh
set -e
echo "=== loki-collector Sandbox Setup ==="
mkdir -p /opt/loki
cd /opt/loki
if command -v wget >/dev/null 2>&1; then
    wget -O loki.zip https://github.com/grafana/loki/releases/download/v2.8.2/loki-linux-amd64.zip
    wget https://raw.githubusercontent.com/grafana/loki/main/cmd/loki/loki-local-config.yaml
else
    curl -L -o loki.zip https://github.com/grafana/loki/releases/download/v2.8.2/loki-linux-amd64.zip
    curl -O https://raw.githubusercontent.com/grafana/loki/main/cmd/loki/loki-local-config.yaml
fi
unzip loki.zip
mv loki-linux-amd64 loki
chmod +x loki
rm -f loki.zip

echo "=== loki-collector Sandbox Forged ==="
