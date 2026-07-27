#!/bin/sh
set -e
echo "=== PostgreSQL Sandbox Provisioning (Self-Contained Build) ==="

mkdir -p /tmp/postgres-build
cd /tmp/postgres-build

if command -v wget >/dev/null 2>&1; then
    wget -O postgres.tar.gz https://ftp.postgresql.org/pub/source/v15.3/postgresql-15.3.tar.gz
else
    curl -L -o postgres.tar.gz https://ftp.postgresql.org/pub/source/v15.3/postgresql-15.3.tar.gz
fi

tar -xzf postgres.tar.gz --strip-components=1

CC=gcc ./configure --prefix=/opt/postgres --without-readline --without-zlib

make -j$(nproc)
make install

# Clean up build files
cd /
rm -rf /tmp/postgres-build

# Initialize data and run directories
mkdir -p /opt/postgres/data
mkdir -p /opt/postgres/run

/opt/postgres/bin/initdb -D /opt/postgres/data --nosync || true

echo "=== PostgreSQL Sandbox Forged ==="
