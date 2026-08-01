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

# 2. Download and extract MediaWiki source tag archive from GitHub (extremely fast and stable CDN)
echo "Downloading MediaWiki source..."
curl -L -o /tmp/mediawiki.tar.gz https://github.com/wikimedia/mediawiki/archive/refs/tags/1.42.1.tar.gz
echo "Extracting MediaWiki..."
tar -C /opt/mediawiki --strip-components=1 -xzf /tmp/mediawiki.tar.gz
rm -f /tmp/mediawiki.tar.gz

# 3. Download Composer
echo "Downloading Composer..."
curl -L -o /tmp/composer.phar https://getcomposer.org/composer.phar

# 4. Install MediaWiki dependencies via Composer using FrankenPHP SAPI CLI
echo "Installing MediaWiki composer dependencies..."
COMPOSER_ALLOW_SUPERUSER=1 /opt/frankenphp/frankenphp php-cli /tmp/composer.phar install --no-dev --no-interaction --working-dir=/opt/mediawiki
rm -f /tmp/composer.phar

# Setup proper permissions (especially for images and cache directories)
echo "Setting permissions..."
chmod -R 777 /opt/frankenphp
chmod -R 777 /opt/mediawiki

if [ -n "$SUDO_UID" ] && [ -n "$SUDO_GID" ]; then
    chown -R "$SUDO_UID:$SUDO_GID" /opt/frankenphp
    chown -R "$SUDO_UID:$SUDO_GID" /opt/mediawiki
fi

echo "=== mediawiki-app Sandbox Forged ==="
