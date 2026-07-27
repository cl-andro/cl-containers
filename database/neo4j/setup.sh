#!/bin/sh
set -e
echo "=== Neo4j Sandbox Provisioning (Self-Contained) ==="

# 1. Download and install Neo4j
mkdir -p /opt/neo4j
cd /opt/neo4j
echo "Downloading Neo4j..."
if command -v wget >/dev/null 2>&1; then
    wget -O neo4j.tar.gz https://dist.neo4j.org/neo4j-community-5.9.0-unix.tar.gz
else
    curl -L -o neo4j.tar.gz https://dist.neo4j.org/neo4j-community-5.9.0-unix.tar.gz
fi
tar -xzf neo4j.tar.gz --strip-components=1
rm -f neo4j.tar.gz

# 2. Download and install a self-contained JRE 17
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

# Configure default listen address to bind to all interfaces
echo "server.default_listen_address=0.0.0.0" >> /opt/neo4j/conf/neo4j.conf

echo "=== Neo4j Sandbox Forged ==="
