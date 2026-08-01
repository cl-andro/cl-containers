#!/bin/sh
set -e
echo "=== scala-compiler Sandbox Setup ==="
mkdir -p /opt/scala
mkdir -p /opt/scala/jre

echo "Downloading Scala 3 Compiler..."
curl -L -o /tmp/scala.tar.gz https://github.com/scala/scala3/releases/download/3.5.2/scala3-3.5.2.tar.gz

echo "Downloading OpenJDK JRE 17..."
curl -L -o /tmp/jre.tar.gz https://github.com/adoptium/temurin17-binaries/releases/download/jdk-17.0.7%2B7/OpenJDK17U-jre_x64_linux_hotspot_17.0.7_7.tar.gz

echo "Extracting Scala compiler..."
tar -xzf /tmp/scala.tar.gz -C /opt/scala --strip-components=1
rm -f /tmp/scala.tar.gz

echo "Extracting JRE 17..."
tar -xzf /tmp/jre.tar.gz -C /opt/scala/jre --strip-components=1
rm -f /tmp/jre.tar.gz

echo "Setting permissions..."
chmod -R +x /opt/scala/bin/
chmod -R +x /opt/scala/jre/bin/
if [ -n "$SUDO_UID" ] && [ -n "$SUDO_GID" ]; then
    chown -R "$SUDO_UID:$SUDO_GID" /opt/scala
else
    chmod -R 777 /opt/scala
fi

echo "=== scala-compiler Sandbox Forged ==="
