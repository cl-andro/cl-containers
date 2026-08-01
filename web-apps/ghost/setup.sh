#!/bin/sh
set -e
echo "=== ghost-blog Sandbox Setup ==="

# 1. Download and extract NodeJS standalone v22.23.2
rm -rf /opt/node
mkdir -p /opt/node
mkdir -p /tmp/node_extract
cd /tmp/node_extract

echo "Downloading NodeJS standalone v22.23.2..."
if command -v wget >/dev/null 2>&1; then
    wget -O node.tar.xz https://nodejs.org/dist/v22.23.2/node-v22.23.2-linux-x64.tar.xz
else
    curl -L -o node.tar.xz https://nodejs.org/dist/v22.23.2/node-v22.23.2-linux-x64.tar.xz
fi

echo "Extracting NodeJS..."
tar -xJf node.tar.xz --strip-components=1 -C /opt/node
rm -f node.tar.xz

# Clean up temp folder
cd /
rm -rf /tmp/node_extract

# 2. Install ghost-cli locally
mkdir -p /opt/ghost-cli
cd /opt/ghost-cli
echo "Installing ghost-cli..."
PATH=/opt/node/bin:$PATH /opt/node/bin/npm install --unsafe-perm ghost-cli@1.29.1

# 3. Install Ghost locally using ghost-cli
mkdir -p /opt/ghost
cd /opt/ghost
echo "Creating mock setuptools module..."
mkdir -p /tmp/mock_python/setuptools
touch /tmp/mock_python/setuptools/__init__.py
echo "Installing Ghost via ghost-cli..."
PYTHONPATH=/tmp/mock_python GHOST_NODE_VERSION_CHECK=false PATH=/opt/node/bin:$PATH /opt/ghost-cli/node_modules/.bin/ghost install local --allow-root --no-start --dir /opt/ghost
rm -rf /tmp/mock_python

echo "Setting permissions..."
if [ -n "$SUDO_UID" ] && [ -n "$SUDO_GID" ]; then
    chown -R "$SUDO_UID:$SUDO_GID" /opt/node
    chown -R "$SUDO_UID:$SUDO_GID" /opt/ghost-cli
    chown -R "$SUDO_UID:$SUDO_GID" /opt/ghost
else
    chmod -R 777 /opt/node
    chmod -R 777 /opt/ghost-cli
    chmod -R 777 /opt/ghost
fi

echo "=== ghost-blog Sandbox Forged ==="
