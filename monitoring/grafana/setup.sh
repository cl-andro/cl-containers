#!/bin/sh
set -e
echo "=== Grafana Sandbox Provisioning ==="
mkdir -p /opt/grafana
cd /opt/grafana
if command -v wget >/dev/null 2>&1; then
    wget -O grafana.tar.gz https://dl.grafana.com/oss/release/grafana-10.0.3.linux-amd64.tar.gz
else
    curl -L -o grafana.tar.gz https://dl.grafana.com/oss/release/grafana-10.0.3.linux-amd64.tar.gz
fi
tar -xzf grafana.tar.gz --strip-components=1
rm -f grafana.tar.gz

# Apply ownership permissions for unprivileged execution
if [ -n "$INVOKING_USER" ] && [ "$INVOKING_USER" != "root" ]; then
    chown -R "$INVOKING_USER" /opt/grafana
fi

echo "=== Grafana Sandbox Forged ==="
