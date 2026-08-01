#!/bin/sh
set -e
echo "=== freshrss-app Sandbox Setup ==="

# Clean and create directories
rm -rf /opt/frankenphp /opt/freshrss
mkdir -p /opt/frankenphp
mkdir -p /opt/freshrss

# 1. Download and configure FrankenPHP binary
echo "Downloading FrankenPHP binary..."
curl -L -o /opt/frankenphp/frankenphp https://github.com/php/frankenphp/releases/download/v1.12.6/frankenphp-linux-x86_64
chmod +x /opt/frankenphp/frankenphp

# 2. Download and extract FreshRSS release tarball
echo "Downloading FreshRSS tarball..."
curl -L -o /tmp/fresh.tar.gz https://github.com/FreshRSS/FreshRSS/archive/refs/tags/1.21.0.tar.gz
echo "Extracting FreshRSS..."
tar -C /opt/freshrss --strip-components=1 -xzf /tmp/fresh.tar.gz
rm -f /tmp/fresh.tar.gz

# Setup proper permissions
echo "Setting permissions..."
chmod -R 777 /opt/frankenphp
chmod -R 777 /opt/freshrss

if [ -n "$SUDO_UID" ] && [ -n "$SUDO_GID" ]; then
    chown -R "$SUDO_UID:$SUDO_GID" /opt/frankenphp
    chown -R "$SUDO_UID:$SUDO_GID" /opt/freshrss
fi

echo "=== freshrss-app Sandbox Forged ==="
