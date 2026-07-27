#!/bin/sh
set -e
echo "=== Cassandra Sandbox Provisioning (Self-Contained) ==="

# 1. Download and install Cassandra
mkdir -p /opt/cassandra
cd /opt/cassandra
echo "Downloading Cassandra..."
if command -v wget >/dev/null 2>&1; then
    wget -O cassandra.tar.gz https://archive.apache.org/dist/cassandra/4.1.2/apache-cassandra-4.1.2-bin.tar.gz
else
    curl -L -o cassandra.tar.gz https://archive.apache.org/dist/cassandra/4.1.2/apache-cassandra-4.1.2-bin.tar.gz
fi
tar -xzf cassandra.tar.gz --strip-components=1
rm -f cassandra.tar.gz

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

# Convert JVM options from removed CMS GC to modern G1 GC (since Java 17 removed CMS)
sed -i 's/^-XX:+UseConcMarkSweepGC/# -XX:+UseConcMarkSweepGC/' /opt/cassandra/conf/jvm11-server.options
sed -i 's/^-XX:+CMS/# -XX:+CMS/' /opt/cassandra/conf/jvm11-server.options
sed -i 's/^-XX:SurvivorRatio/# -XX:SurvivorRatio/' /opt/cassandra/conf/jvm11-server.options
sed -i 's/^-XX:MaxTenuringThreshold/# -XX:MaxTenuringThreshold/' /opt/cassandra/conf/jvm11-server.options
sed -i 's/#-XX:+UseG1GC/-XX:+UseG1GC/' /opt/cassandra/conf/jvm11-server.options
sed -i 's/#-XX:+ParallelRefProcEnabled/-XX:+ParallelRefProcEnabled/' /opt/cassandra/conf/jvm11-server.options
sed -i 's/#-XX:G1HeapRegionSize=16m/-XX:G1HeapRegionSize=16m/' /opt/cassandra/conf/jvm11-server.options

# Create required runtime directories inside guest
mkdir -p /var/lib/cassandra
mkdir -p /var/log/cassandra

echo "=== Cassandra Sandbox Forged ==="
