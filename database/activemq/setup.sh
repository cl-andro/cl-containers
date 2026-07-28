#!/bin/sh
set -e
echo "=== Apache ActiveMQ Sandbox Provisioning (Self-Contained) ==="

# 1. Download and install a self-contained JRE 17
mkdir -p /opt/jre
cd /opt/jre
echo "Downloading JRE 17..."
if command -v wget >/dev/null 2>&1; then
    wget -O jre.tar.gz https://github.com/adoptium/temurin17-binaries/releases/download/jdk-17.0.7%2B7/OpenJDK17U-jre_x64_linux_hotspot_17.0.7_7.tar.gz
else
    curl -L -o jre.tar.gz https://github.com/adoptium/temurin17-binaries/releases/download/jdk-17.0.7%2B7/OpenJDK17U-jre_x64_linux_hotspot_17.0.7_7.tar.gz
fi
tar -xzf jre.tar.gz --strip-components=1
rm -f jre.tar.gz

# 2. Download and install ActiveMQ
mkdir -p /opt/activemq
cd /opt/activemq
echo "Downloading ActiveMQ..."
if command -v wget >/dev/null 2>&1; then
    wget -O activemq.tar.gz https://archive.apache.org/dist/activemq/5.18.1/apache-activemq-5.18.1-bin.tar.gz
else
    curl -L -o activemq.tar.gz https://archive.apache.org/dist/activemq/5.18.1/apache-activemq-5.18.1-bin.tar.gz
fi
tar -xzf activemq.tar.gz --strip-components=1
rm -f activemq.tar.gz

echo "=== activemq-broker Sandbox Forged ==="
