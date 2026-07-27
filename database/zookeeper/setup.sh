#!/bin/sh
set -e
echo "=== zookeeper-node Sandbox Setup ==="
mkdir -p /opt/zookeeper
cd /opt/zookeeper
if command -v wget >/dev/null 2>&1; then
    wget -O zk.tar.gz https://archive.apache.org/dist/zookeeper/zookeeper-3.8.1/apache-zookeeper-3.8.1-bin.tar.gz
else
    curl -L -o zk.tar.gz https://archive.apache.org/dist/zookeeper/zookeeper-3.8.1/apache-zookeeper-3.8.1-bin.tar.gz
fi
tar -xzf zk.tar.gz --strip-components=1
rm -f zk.tar.gz
cp conf/zoo_sample.cfg conf/zoo.cfg

echo "=== zookeeper-node Sandbox Forged ==="
