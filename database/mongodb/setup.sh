#!/bin/sh
set -e
echo "=== MongoDB Sandbox Provisioning (Self-Contained) ==="

mkdir -p /opt/mongodb
cd /opt/mongodb

if command -v wget >/dev/null 2>&1; then
    wget -O mongo.tgz https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-debian11-6.0.8.tgz
else
    curl -L -o mongo.tgz https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-debian11-6.0.8.tgz
fi

tar -xzf mongo.tgz --strip-components=1
rm -f mongo.tgz

mkdir -p /opt/mongodb/data

echo "=== MongoDB Sandbox Forged ==="
