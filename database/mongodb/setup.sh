#!/bin/sh
set -e
echo "=== MongoDB Sandbox Provisioning (Self-Contained) ==="

mkdir -p /opt/mongodb
cd /opt/mongodb

if command -v wget >/dev/null 2>&1; then
    wget -O mongo.tgz https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-debian12-7.0.5.tgz
else
    curl -L -o mongo.tgz https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-debian12-7.0.5.tgz
fi

tar -xzf mongo.tgz --strip-components=1
rm -f mongo.tgz

# Download and install the mongosh client shell (which is distributed separately starting in MongoDB 6.0+)
mkdir -p /tmp/mongosh-build
cd /tmp/mongosh-build
if command -v wget >/dev/null 2>&1; then
    wget -O mongosh.tgz https://fastdl.mongodb.org/mongocli/mongosh-1.10.1-linux-x64.tgz
else
    curl -L -o mongosh.tgz https://fastdl.mongodb.org/mongocli/mongosh-1.10.1-linux-x64.tgz
fi
tar -xzf mongosh.tgz --strip-components=1
cp bin/mongosh /opt/mongodb/bin/
cd /
rm -rf /tmp/mongosh-build

mkdir -p /opt/mongodb/data

echo "=== MongoDB Sandbox Forged ==="
