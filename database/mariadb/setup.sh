#!/bin/sh
set -e
echo "=== MariaDB Sandbox Provisioning (Self-Contained) ==="

mkdir -p /opt/mariadb
cd /opt/mariadb

echo "Downloading MariaDB binary tarball..."
if command -v wget >/dev/null 2>&1; then
    wget -O mariadb.tar.gz https://archive.mariadb.org/mariadb-10.11.10/bintar-linux-systemd-x86_64/mariadb-10.11.10-linux-systemd-x86_64.tar.gz
else
    curl -L -o mariadb.tar.gz https://archive.mariadb.org/mariadb-10.11.10/bintar-linux-systemd-x86_64/mariadb-10.11.10-linux-systemd-x86_64.tar.gz
fi

tar -xzf mariadb.tar.gz --strip-components=1
rm -f mariadb.tar.gz

mkdir -p /opt/mariadb/data
mkdir -p /opt/mariadb/run
mkdir -p /opt/mariadb/log

echo "=== MariaDB Sandbox Forged ==="
