#!/bin/sh
set -e
echo "=== activemq-broker Sandbox Setup ==="
mkdir -p /opt/activemq
cd /opt/activemq
if command -v wget >/dev/null 2>&1; then
    wget -O activemq.tar.gz https://archive.apache.org/dist/activemq/5.18.1/apache-activemq-5.18.1-bin.tar.gz
else
    curl -L -o activemq.tar.gz https://archive.apache.org/dist/activemq/5.18.1/apache-activemq-5.18.1-bin.tar.gz
fi
tar -xzf activemq.tar.gz --strip-components=1
rm -f activemq.tar.gz

echo "=== activemq-broker Sandbox Forged ==="
