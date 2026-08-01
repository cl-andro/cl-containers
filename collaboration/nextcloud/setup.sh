#!/bin/sh
set -e
echo "=== Nextcloud & PHP Sandbox Setup ==="

# 1. Download and Extract Nextcloud
mkdir -p /opt/nextcloud
mkdir -p /tmp/nextcloud_extract
cd /tmp/nextcloud_extract

echo "Downloading Nextcloud..."
if command -v wget >/dev/null 2>&1; then
    wget -O nextcloud.zip https://download.nextcloud.com/server/releases/latest.zip
else
    curl -L -o nextcloud.zip https://download.nextcloud.com/server/releases/latest.zip
fi

echo "Extracting Nextcloud..."
python3 -c "import zipfile; zipfile.ZipFile('nextcloud.zip').extractall('.')"
cp -r nextcloud/* /opt/nextcloud/
rm -rf nextcloud*

# 2. Download and Extract PHP 8.4 + Extensions + Required Libraries
mkdir -p /opt/php
mkdir -p /tmp/php_extract
cd /tmp/php_extract

BASE_URL="https://deb.debian.org/debian/pool/main/p/php8.4"
PHP_VER="8.4.23-1~deb13u1"

echo "Downloading PHP 8.4 packages..."
curl -L -o php-cli.deb "$BASE_URL/php8.4-cli_${PHP_VER}_amd64.deb"
curl -L -o php-common.deb "$BASE_URL/php8.4-common_${PHP_VER}_amd64.deb"
curl -L -o php-sqlite3.deb "$BASE_URL/php8.4-sqlite3_${PHP_VER}_amd64.deb"
curl -L -o php-gd.deb "$BASE_URL/php8.4-gd_${PHP_VER}_amd64.deb"
curl -L -o php-zip.deb "$BASE_URL/php8.4-zip_${PHP_VER}_amd64.deb"
curl -L -o php-xml.deb "$BASE_URL/php8.4-xml_${PHP_VER}_amd64.deb"
curl -L -o php-mbstring.deb "$BASE_URL/php8.4-mbstring_${PHP_VER}_amd64.deb"
curl -L -o php-curl.deb "$BASE_URL/php8.4-curl_${PHP_VER}_amd64.deb"

echo "Downloading shared library dependencies..."
# libonig5
curl -L -o libonig5.deb https://deb.debian.org/debian/pool/main/libo/libonig/libonig5_6.9.9-1%2Bb1_amd64.deb
# libzip5
curl -L -o libzip5.deb https://deb.debian.org/debian/pool/main/libz/libzip/libzip5_1.11.3-2_amd64.deb

echo "Extracting packages..."
for deb in *.deb; do
    dpkg-deb -x "$deb" /opt/php/
done

# Clean up temp folder
cd /
rm -rf /tmp/php_extract

# Write custom php.ini
echo "Writing custom php.ini..."
cat << 'EOF' > /opt/php/php.ini
[PHP]
extension_dir = "/opt/php/usr/lib/php/20240924"
extension=pdo.so
extension=pdo_sqlite.so
extension=sqlite3.so
extension=xml.so
extension=dom.so
extension=simplexml.so
extension=xmlreader.so
extension=xmlwriter.so
extension=mbstring.so
extension=gd.so
extension=zip.so
extension=curl.so
extension=ctype.so
extension=iconv.so
extension=fileinfo.so
extension=posix.so

memory_limit = 512M
upload_max_filesize = 512M
post_max_size = 512M
date.timezone = UTC
EOF

echo "Setting permissions..."
if [ -n "$SUDO_UID" ] && [ -n "$SUDO_GID" ]; then
    chown -R "$SUDO_UID:$SUDO_GID" /opt/nextcloud
    chown -R "$SUDO_UID:$SUDO_GID" /opt/php
else
    chmod -R 777 /opt/nextcloud
    chmod -R 777 /opt/php
fi

echo "=== Nextcloud Sandbox Forged ==="
