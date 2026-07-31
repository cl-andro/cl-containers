#!/bin/sh
set -e
echo "=== node-red-flow Sandbox Setup ==="
mkdir -p /opt/node
mkdir -p /opt/node-red
mkdir -p /var/lib/node-red

echo "Downloading and extracting Node.js..."
curl -L https://nodejs.org/dist/v22.11.0/node-v22.11.0-linux-x64.tar.xz | tar -xJ --strip-components=1 -C /opt/node

echo "Installing Node-RED via npm..."
export PATH="/opt/node/bin:$PATH"
npm install -g --prefix /opt/node-red node-red

echo "Setting permissions..."
if [ -n "$SUDO_UID" ] && [ -n "$SUDO_GID" ]; then
    chown -R "$SUDO_UID:$SUDO_GID" /opt/node /opt/node-red /var/lib/node-red
else
    chmod -R 777 /opt/node /opt/node-red /var/lib/node-red
fi

echo "=== node-red-flow Sandbox Forged ==="
