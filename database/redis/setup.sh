#!/bin/sh
set -e
echo "=== Redis Sandbox Provisioning (Self-Contained Build) ==="

mkdir -p /tmp/redis-build
cd /tmp/redis-build

if command -v wget >/dev/null 2>&1; then
    wget -O redis.tar.gz https://download.redis.io/releases/redis-7.0.11.tar.gz
else
    curl -L -o redis.tar.gz https://download.redis.io/releases/redis-7.0.11.tar.gz
fi

tar -xzf redis.tar.gz --strip-components=1

CC=gcc make MALLOC=libc -j2
make MALLOC=libc PREFIX=/opt/redis install

cd /
rm -rf /tmp/redis-build

echo "=== Redis Sandbox Forged ==="
