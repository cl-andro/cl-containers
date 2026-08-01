#!/bin/sh
set -e
echo "=== PHP Sandbox Setup ==="
mkdir -p /opt/php

echo "Downloading PHP CLI packages..."
curl -L -o /tmp/php-cli.deb https://deb.debian.org/debian/pool/main/p/php8.4/php8.4-cli_8.4.23-1~deb13u1_amd64.deb
curl -L -o /tmp/php-common.deb https://deb.debian.org/debian/pool/main/p/php8.4/php8.4-common_8.4.23-1~deb13u1_amd64.deb

echo "Extracting PHP packages..."
dpkg-deb -x /tmp/php-cli.deb /opt/php/
dpkg-deb -x /tmp/php-common.deb /opt/php/
rm -f /tmp/php-cli.deb /tmp/php-common.deb

echo "Setting permissions..."
if [ -n "$SUDO_UID" ] && [ -n "$SUDO_GID" ]; then
    chown -R "$SUDO_UID:$SUDO_GID" /opt/php
else
    chmod -R 777 /opt/php
fi

echo "=== PHP Sandbox Forged ==="
