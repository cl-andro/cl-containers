#!/bin/sh
set -e
echo "=== kubectl Sandbox Setup ==="
rm -rf /opt/kubectl
mkdir -p /opt/kubectl/bin

echo "Downloading kubectl stable standalone binary..."
curl -L -o /opt/kubectl/bin/kubectl https://dl.k8s.io/release/v1.36.3/bin/linux/amd64/kubectl

echo "Making binary executable..."
chmod +x /opt/kubectl/bin/kubectl

echo "Setting permissions..."
if [ -n "$SUDO_UID" ] && [ -n "$SUDO_GID" ]; then
    chown -R "$SUDO_UID:$SUDO_GID" /opt/kubectl
else
    chmod -R 777 /opt/kubectl
fi

echo "=== kubectl Sandbox Forged ==="
