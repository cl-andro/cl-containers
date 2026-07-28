#!/bin/sh
set -e
echo "=== Prometheus Sandbox Provisioning ==="
mkdir -p /opt/prometheus
cd /opt/prometheus
if command -v wget >/dev/null 2>&1; then
    wget -O prometheus.tar.gz https://github.com/prometheus/prometheus/releases/download/v2.45.0/prometheus-2.45.0.linux-amd64.tar.gz
else
    curl -L -o prometheus.tar.gz https://github.com/prometheus/prometheus/releases/download/v2.45.0/prometheus-2.45.0.linux-amd64.tar.gz
fi
tar -xzf prometheus.tar.gz --strip-components=1
rm -f prometheus.tar.gz

# Create TSDB storage directory
mkdir -p /var/lib/prometheus

# Apply ownership permissions for unprivileged execution
if [ -n "$INVOKING_USER" ] && [ "$INVOKING_USER" != "root" ]; then
    chown -R "$INVOKING_USER" /var/lib/prometheus
fi

echo "=== Prometheus Sandbox Forged ==="
