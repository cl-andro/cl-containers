#!/bin/sh
set -e
echo "=== uptime-kuma Sandbox Setup ==="
# 1. Download and install a self-contained Node.js 18
mkdir -p /opt/node
cd /opt/node
echo "Downloading Node.js..."
if command -v wget >/dev/null 2>&1; then
    wget -O node.tar.xz https://nodejs.org/dist/v18.16.0/node-v18.16.0-linux-x64.tar.xz
else
    curl -L -o node.tar.xz https://nodejs.org/dist/v18.16.0/node-v18.16.0-linux-x64.tar.xz
fi
tar -xf node.tar.xz --strip-components=1
rm -f node.tar.xz

# 2. Download and install Uptime Kuma
mkdir -p /opt/uptime-kuma
cd /opt/uptime-kuma
echo "Downloading Uptime Kuma..."
if command -v wget >/dev/null 2>&1; then
    wget -O uptime.tar.gz https://github.com/louislam/uptime-kuma/archive/refs/tags/1.22.1.tar.gz
else
    curl -L -o uptime.tar.gz https://github.com/louislam/uptime-kuma/archive/refs/tags/1.22.1.tar.gz
fi
tar -xzf uptime.tar.gz --strip-components=1
rm -f uptime.tar.gz

# 3. Install production dependencies
export PATH=/opt/node/bin:$PATH
echo "Installing production node modules..."
npm install --production

# 4. Create data directory
mkdir -p data

echo "=== uptime-kuma Sandbox Forged ==="
