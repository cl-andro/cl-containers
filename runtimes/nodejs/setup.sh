#!/bin/sh
set -e
echo "=== Node.js Sandbox Provisioning ==="
mkdir -p /opt/node
cd /opt/node
if command -v wget >/dev/null 2>&1; then
    wget -O node.tar.xz https://nodejs.org/dist/v18.16.1/node-v18.16.1-linux-x64.tar.xz
else
    curl -L -o node.tar.xz https://nodejs.org/dist/v18.16.1/node-v18.16.1-linux-x64.tar.xz
fi
tar -xf node.tar.xz --strip-components=1
rm -f node.tar.xz
ln -sf /opt/node/bin/node /usr/local/bin/node
ln -sf /opt/node/bin/npm /usr/local/bin/npm
echo "=== Node.js Sandbox Forged ==="
