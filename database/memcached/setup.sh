#!/bin/sh
set -e
echo "=== Memcached Sandbox Provisioning (Self-Contained Build) ==="

# 1. Compile libevent statically
mkdir -p /tmp/libevent-build
cd /tmp/libevent-build
if command -v wget >/dev/null 2>&1; then
    wget -O libevent.tar.gz https://github.com/libevent/libevent/releases/download/release-2.1.12-stable/libevent-2.1.12-stable.tar.gz
else
    curl -L -o libevent.tar.gz https://github.com/libevent/libevent/releases/download/release-2.1.12-stable/libevent-2.1.12-stable.tar.gz
fi
tar -xzf libevent.tar.gz --strip-components=1
CC=gcc ./configure --prefix=/opt/memcached --disable-shared
make -j2
make install
cd /
rm -rf /tmp/libevent-build

# 2. Compile memcached statically linking libevent
mkdir -p /tmp/memcached-build
cd /tmp/memcached-build
if command -v wget >/dev/null 2>&1; then
    wget -O memcached.tar.gz https://memcached.org/files/memcached-1.6.21.tar.gz
else
    curl -L -o memcached.tar.gz https://memcached.org/files/memcached-1.6.21.tar.gz
fi
tar -xzf memcached.tar.gz --strip-components=1
CC=gcc ./configure --prefix=/opt/memcached --with-libevent=/opt/memcached
make -j2
make install
cd /
rm -rf /tmp/memcached-build

echo "=== Memcached Sandbox Forged ==="
