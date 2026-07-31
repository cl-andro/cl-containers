#!/bin/sh
set -e
echo "=== WordPress Sandbox Provisioning ==="
mkdir -p /opt/php
mkdir -p /opt/wordpress

echo "Downloading PHP packages and dependencies..."
curl -L -o /tmp/php-cli.deb https://deb.debian.org/debian/pool/main/p/php8.4/php8.4-cli_8.4.23-1~deb13u1_amd64.deb
curl -L -o /tmp/php-common.deb https://deb.debian.org/debian/pool/main/p/php8.4/php8.4-common_8.4.23-1~deb13u1_amd64.deb
curl -L -o /tmp/php-mysql.deb https://deb.debian.org/debian/pool/main/p/php8.4/php8.4-mysql_8.4.23-1~deb13u1_amd64.deb

echo "Extracting PHP packages..."
dpkg-deb -x /tmp/php-cli.deb /opt/php/
dpkg-deb -x /tmp/php-common.deb /opt/php/
dpkg-deb -x /tmp/php-mysql.deb /opt/php/
rm -f /tmp/php-cli.deb /tmp/php-common.deb /tmp/php-mysql.deb

echo "Downloading WordPress..."
cd /opt/wordpress
if command -v wget >/dev/null 2>&1; then
    wget -O wordpress.tar.gz https://wordpress.org/latest.tar.gz
else
    curl -L -o wordpress.tar.gz https://wordpress.org/latest.tar.gz
fi
tar -xzf wordpress.tar.gz --strip-components=1
rm -f wordpress.tar.gz

echo "Setting permissions..."
if [ -n "$SUDO_UID" ] && [ -n "$SUDO_GID" ]; then
    chown -R "$SUDO_UID:$SUDO_GID" /opt/php /opt/wordpress
else
    chmod -R 777 /opt/php /opt/wordpress
fi

echo "=== WordPress Sandbox Forged ==="
