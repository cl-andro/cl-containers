#!/bin/sh
set -e
echo "=== kafka-stream Sandbox Setup ==="
mkdir -p /opt/kafka
cd /opt/kafka
if command -v wget >/dev/null 2>&1; then
    wget -O kafka.tgz https://archive.apache.org/dist/kafka/3.4.0/kafka_2.13-3.4.0.tgz
else
    curl -L -o kafka.tgz https://archive.apache.org/dist/kafka/3.4.0/kafka_2.13-3.4.0.tgz
fi
tar -xzf kafka.tgz --strip-components=1
rm -f kafka.tgz

echo "=== kafka-stream Sandbox Forged ==="
