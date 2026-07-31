#!/bin/sh
set -e
echo "=== netdata-monitor Sandbox Setup ==="
mkdir -p /opt/netdata

echo "Downloading Netdata static binary package..."
curl -L -o /tmp/netdata-static.gz.run https://github.com/netdata/netdata/releases/download/v1.46.3/netdata-x86_64-v1.46.3.gz.run

echo "Installing Netdata..."
sh /tmp/netdata-static.gz.run --accept -- --dont-start-it

echo "Setting permissions..."
if [ -n "$SUDO_UID" ] && [ -n "$SUDO_GID" ]; then
    chown -R "$SUDO_UID:$SUDO_GID" /opt/netdata
else
    chmod -R 777 /opt/netdata
fi

echo "Cleaning up..."
rm -f /tmp/netdata-static.gz.run

echo "=== netdata-monitor Sandbox Forged ==="
