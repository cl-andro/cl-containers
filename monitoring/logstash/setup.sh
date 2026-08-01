#!/bin/sh
set -e
echo "=== logstash-pipeline Sandbox Setup ==="

# Clean and create directories
rm -rf /opt/logstash
mkdir -p /opt/logstash

# 1. Download and extract Logstash with bundled JDK
echo "Downloading Logstash with bundled JDK..."
curl -L -o /tmp/logstash.tar.gz https://artifacts.elastic.co/downloads/logstash/logstash-8.13.4-linux-x86_64.tar.gz
echo "Extracting Logstash..."
tar -C /opt/logstash --strip-components=1 -xzf /tmp/logstash.tar.gz
rm -f /tmp/logstash.tar.gz

# Setup proper permissions
echo "Setting permissions..."
chmod -R 777 /opt/logstash

if [ -n "$SUDO_UID" ] && [ -n "$SUDO_GID" ]; then
    chown -R "$SUDO_UID:$SUDO_GID" /opt/logstash
fi

echo "=== logstash-pipeline Sandbox Forged ==="
