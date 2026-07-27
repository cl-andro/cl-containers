#!/bin/sh
set -e
echo "=== MySQL Sandbox Provisioning (Self-Contained) ==="

mkdir -p /opt/mysql
cd /opt/mysql

echo "Downloading MySQL binary tarball..."
if command -v wget >/dev/null 2>&1; then
    wget -O mysql.tar.xz https://dev.mysql.com/get/Downloads/MySQL-8.0/mysql-8.0.33-linux-glibc2.17-x86_64.tar.xz
else
    curl -L -o mysql.tar.xz https://dev.mysql.com/get/Downloads/MySQL-8.0/mysql-8.0.33-linux-glibc2.17-x86_64.tar.xz
fi

tar -xf mysql.tar.xz --strip-components=1
rm -f mysql.tar.xz

mkdir -p /opt/mysql/data
mkdir -p /opt/mysql/run
mkdir -p /opt/mysql/log

echo "=== MySQL Sandbox Forged ==="
