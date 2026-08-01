#!/bin/sh
set -e
echo "=== gatsby-builder Sandbox Setup ==="

# 1. Download and extract NodeJS standalone
mkdir -p /opt/node
mkdir -p /tmp/node_extract
cd /tmp/node_extract

echo "Downloading NodeJS standalone v22.5.1..."
if command -v wget >/dev/null 2>&1; then
    wget -O node.tar.xz https://nodejs.org/dist/v22.5.1/node-v22.5.1-linux-x64.tar.xz
else
    curl -L -o node.tar.xz https://nodejs.org/dist/v22.5.1/node-v22.5.1-linux-x64.tar.xz
fi

echo "Extracting NodeJS..."
tar -xJf node.tar.xz --strip-components=1 -C /opt/node
rm -f node.tar.xz

# Clean up temp folder
cd /
rm -rf /tmp/node_extract

# 2. Install gatsby-cli using local node/npm
mkdir -p /opt/gatsby
cd /opt/gatsby

echo "Installing gatsby-cli locally..."
PATH=/opt/node/bin:$PATH /opt/node/bin/npm install --unsafe-perm gatsby-cli

echo "Setting permissions..."
if [ -n "$SUDO_UID" ] && [ -n "$SUDO_GID" ]; then
    chown -R "$SUDO_UID:$SUDO_GID" /opt/node
    chown -R "$SUDO_UID:$SUDO_GID" /opt/gatsby
else
    chmod -R 777 /opt/node
    chmod -R 777 /opt/gatsby
fi

echo "=== gatsby-builder Sandbox Forged ==="
