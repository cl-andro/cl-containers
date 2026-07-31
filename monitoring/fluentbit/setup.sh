#!/bin/sh
set -e
echo "=== fluentbit-agent Sandbox Setup ==="
mkdir -p /opt/fluentbit

echo "Downloading Fluent Bit package..."
curl -L -o /tmp/fluent-bit.deb https://packages.fluentbit.io/debian/bookworm/pool/main/f/fluent-bit/fluent-bit_5.0.9_amd64.deb

echo "Extracting package..."
dpkg-deb -x /tmp/fluent-bit.deb /opt/fluentbit/
rm -f /tmp/fluent-bit.deb

echo "Setting permissions..."
if [ -n "$SUDO_UID" ] && [ -n "$SUDO_GID" ]; then
    chown -R "$SUDO_UID:$SUDO_GID" /opt/fluentbit
else
    chmod -R 777 /opt/fluentbit
fi

echo "=== fluentbit-agent Sandbox Forged ==="
