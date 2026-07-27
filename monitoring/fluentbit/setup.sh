#!/bin/sh
set -e
echo "=== fluentbit-agent Sandbox Setup ==="
mkdir -p /opt/fluentbit
cd /opt/fluentbit
if command -v wget >/dev/null 2>&1; then
    wget -O fb.tar.gz https://releases.fluentbit.io/fluent-bit-2.1.4.tar.gz
else
    curl -L -o fb.tar.gz https://releases.fluentbit.io/fluent-bit-2.1.4.tar.gz
fi
tar -xzf fb.tar.gz --strip-components=1
rm -f fb.tar.gz

echo "=== fluentbit-agent Sandbox Forged ==="
