#!/bin/sh
set -e
echo "=== zookeeper-node Sandbox Setup ==="
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

# 2. Download and install ZooKeeper
mkdir -p /opt/zookeeper
cd /opt/zookeeper
if command -v wget >/dev/null 2>&1; then
    wget -O zk.tar.gz https://archive.apache.org/dist/zookeeper/zookeeper-3.8.1/apache-zookeeper-3.8.1-bin.tar.gz
else
    curl -L -o zk.tar.gz https://archive.apache.org/dist/zookeeper/zookeeper-3.8.1/apache-zookeeper-3.8.1-bin.tar.gz
fi
tar -xzf zk.tar.gz --strip-components=1
rm -f zk.tar.gz

# 2. Configure directories
mkdir -p /var/run /var/lib/zookeeper/data /var/lib/zookeeper/log

# 3. Create clean zoo.cfg
cat <<EOF > conf/zoo.cfg
tickTime=2000
dataDir=/var/lib/zookeeper/data
dataLogDir=/var/lib/zookeeper/log
clientPort=2181
initLimit=5
syncLimit=2
EOF

echo "=== zookeeper-node Sandbox Forged ==="
