#!/bin/sh
set -e
echo "=== mediawiki-app Sandbox Setup ==="

# Clean and create directories
rm -rf /opt/frankenphp /opt/mediawiki
mkdir -p /opt/frankenphp
mkdir -p /opt/mediawiki

# 1. Download and configure FrankenPHP binary
echo "Downloading FrankenPHP binary..."
curl --http1.1 -L -o /opt/frankenphp/frankenphp https://github.com/php/frankenphp/releases/download/v1.12.6/frankenphp-linux-x86_64
chmod +x /opt/frankenphp/frankenphp

# 2. Download and extract MediaWiki release tarball
if [ -f /tmp/mediawiki.tar.gz ]; then
    echo "Found pre-downloaded MediaWiki package, skipping download."
else
    echo "Downloading MediaWiki..."
    curl --http1.1 -L -o /tmp/mediawiki.tar.gz https://releases.wikimedia.org/mediawiki/1.42/mediawiki-1.42.1.tar.gz
fi
echo "Extracting MediaWiki..."
tar -C /opt/mediawiki --strip-components=1 -xzf /tmp/mediawiki.tar.gz
rm -f /tmp/mediawiki.tar.gz

# Setup proper permissions (especially for images directory)
echo "Setting permissions..."
chmod -R 777 /opt/frankenphp
chmod -R 777 /opt/mediawiki

if [ -n "$SUDO_UID" ] && [ -n "$SUDO_GID" ]; then
    chown -R "$SUDO_UID:$SUDO_GID" /opt/frankenphp
    chown -R "$SUDO_UID:$SUDO_GID" /opt/mediawiki
fi

echo "=== mediawiki-app Sandbox Forged ==="
