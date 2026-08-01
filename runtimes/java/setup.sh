#!/bin/sh
set -e
echo "=== java-runtime Sandbox Setup ==="
mkdir -p /opt/java
cd /opt/java

echo "Downloading OpenJDK 17..."
if command -v wget >/dev/null 2>&1; then
    wget -O jdk.tar.gz https://github.com/adoptium/temurin17-binaries/releases/download/jdk-17.0.7%2B7/OpenJDK17U-jdk_x64_linux_hotspot_17.0.7_7.tar.gz
else
    curl -L -o jdk.tar.gz https://github.com/adoptium/temurin17-binaries/releases/download/jdk-17.0.7%2B7/OpenJDK17U-jdk_x64_linux_hotspot_17.0.7_7.tar.gz
fi

echo "Extracting package..."
tar -xzf jdk.tar.gz --strip-components=1
rm -f jdk.tar.gz

echo "Setting permissions..."
if [ -n "$SUDO_UID" ] && [ -n "$SUDO_GID" ]; then
    chown -R "$SUDO_UID:$SUDO_GID" /opt/java
else
    chmod -R 777 /opt/java
fi

echo "=== java-runtime Sandbox Forged ==="
