#!/bin/sh
set -e
echo "=== MySQL Sandbox Provisioning (Self-Contained) ==="

mkdir -p /opt/mysql
cd /opt/mysql

echo "Downloading MySQL binary tarball..."
if command -v wget >/dev/null 2>&1; then
    wget -O mysql.tar.xz https://dev.mysql.com/get/Downloads/MySQL-8.4/mysql-8.4.10-linux-glibc2.28-x86_64-minimal.tar.xz
else
    curl -L -o mysql.tar.xz https://dev.mysql.com/get/Downloads/MySQL-8.4/mysql-8.4.10-linux-glibc2.28-x86_64-minimal.tar.xz
fi

tar -xf mysql.tar.xz --strip-components=1
rm -f mysql.tar.xz

# Download and extract libaio1 (required by InnoDB) to /opt/mysql/lib
mkdir -p /tmp/libaio-build
cd /tmp/libaio-build
if command -v wget >/dev/null 2>&1; then
    wget -O libaio.deb http://ftp.de.debian.org/debian/pool/main/liba/libaio/libaio1t64_0.3.113-8_amd64.deb
else
    curl -L -o libaio.deb http://ftp.de.debian.org/debian/pool/main/liba/libaio/libaio1t64_0.3.113-8_amd64.deb
fi
dpkg-deb -x libaio.deb .
cp usr/lib/x86_64-linux-gnu/libaio.so.1* /opt/mysql/lib/
# Ensure proper symlinks
cd /opt/mysql/lib
ln -sf libaio.so.1.0.2 libaio.so.1 || true
cd /opt/mysql

mkdir -p /opt/mysql/data
mkdir -p /opt/mysql/run
mkdir -p /opt/mysql/log

echo "=== MySQL Sandbox Forged ==="
