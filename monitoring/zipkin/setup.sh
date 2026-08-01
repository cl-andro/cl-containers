#!/bin/sh
set -e
echo "=== zipkin-tracer Sandbox Setup ==="

# Clean and create directories
rm -rf /opt/java /opt/zipkin
mkdir -p /opt/java
mkdir -p /opt/zipkin

# 1. Download and extract OpenJDK JRE 17
echo "Downloading OpenJDK JRE 17..."
curl -L -o /tmp/jre.tar.gz "https://api.adoptium.net/v3/binary/latest/17/ga/linux/x64/jre/hotspot/normal/eclipse"
echo "Extracting JRE..."
tar -C /opt/java --strip-components=1 -xzf /tmp/jre.tar.gz
rm -f /tmp/jre.tar.gz

# 2. Run Zipkin quickstart script to fetch the latest stable executable jar
echo "Running Zipkin quickstart script..."
cd /opt/zipkin
curl -sSL https://zipkin.io/quickstart.sh | bash -s

# Setup proper permissions
echo "Setting permissions..."
chmod -R 777 /opt/java
chmod -R 777 /opt/zipkin

if [ -n "$SUDO_UID" ] && [ -n "$SUDO_GID" ]; then
    chown -R "$SUDO_UID:$SUDO_GID" /opt/java
    chown -R "$SUDO_UID:$SUDO_GID" /opt/zipkin
fi

echo "=== zipkin-tracer Sandbox Forged ==="
