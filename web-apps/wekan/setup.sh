#!/bin/sh
set -e
echo "=== wekan-app Sandbox Setup ==="

# Clean and create directories
rm -rf /opt/node /opt/wekan
mkdir -p /opt/node
mkdir -p /opt/wekan

# 1. Download and extract Node.js v24.15.0
echo "Downloading Node.js v24.15.0..."
curl -L -o /tmp/node.tar.xz https://nodejs.org/dist/v24.15.0/node-v24.15.0-linux-x64.tar.xz
echo "Extracting Node.js..."
tar -C /opt/node --strip-components=1 -xJf /tmp/node.tar.xz
rm -f /tmp/node.tar.xz

# 2. Download and extract Wekan v10.53 zip
echo "Downloading Wekan v10.53..."
curl -L -o /tmp/wekan.zip https://github.com/wekan/wekan/releases/download/v10.53/wekan-10.53-amd64.zip
echo "Extracting Wekan..."
python3 -c "import zipfile; zipfile.ZipFile('/tmp/wekan.zip').extractall('/tmp/wekan-extracted')"
mv /tmp/wekan-extracted/bundle/* /opt/wekan/
rm -rf /tmp/wekan-extracted /tmp/wekan.zip

# 3. Build/install Wekan server dependencies
echo "Installing/building Wekan server dependencies..."
cd /opt/wekan/programs/server
/opt/node/bin/npm install

# Setup proper permissions
echo "Setting permissions..."
chmod -R 777 /opt/node
chmod -R 777 /opt/wekan

if [ -n "$SUDO_UID" ] && [ -n "$SUDO_GID" ]; then
    chown -R "$SUDO_UID:$SUDO_GID" /opt/node
    chown -R "$SUDO_UID:$SUDO_GID" /opt/wekan
fi

echo "=== wekan-app Sandbox Forged ==="
