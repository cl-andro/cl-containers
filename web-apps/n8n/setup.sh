#!/bin/sh
set -e
echo "=== n8n-workflow Sandbox Setup ==="

# Clean and create directories
rm -rf /opt/node /opt/n8n
mkdir -p /opt/node
mkdir -p /opt/n8n

# 1. Download and extract Node.js v20.11.0
echo "Downloading Node.js v20.11.0..."
curl -L -o /tmp/node.tar.xz https://nodejs.org/dist/v20.11.0/node-v20.11.0-linux-x64.tar.xz
echo "Extracting Node.js..."
tar -C /opt/node --strip-components=1 -xJf /tmp/node.tar.xz
rm -f /tmp/node.tar.xz

# 2. Install n8n globally using local Node toolchain
echo "Installing n8n globally..."
PATH="/opt/node/bin:$PATH" /opt/node/bin/npm install -g n8n

# Setup proper permissions
echo "Setting permissions..."
chmod -R 755 /opt/node
chmod -R 777 /opt/n8n

if [ -n "$SUDO_UID" ] && [ -n "$SUDO_GID" ]; then
    chown -R "$SUDO_UID:$SUDO_GID" /opt/node
    chown -R "$SUDO_UID:$SUDO_GID" /opt/n8n
fi

echo "=== n8n-workflow Sandbox Forged ==="
