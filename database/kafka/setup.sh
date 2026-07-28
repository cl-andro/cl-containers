#!/bin/sh
set -e
echo "=== Apache Kafka Sandbox Provisioning (Self-Contained KRaft Mode) ==="

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

# 2. Download and install Kafka
mkdir -p /opt/kafka
cd /opt/kafka
echo "Downloading Apache Kafka..."
if command -v wget >/dev/null 2>&1; then
    wget -O kafka.tgz https://archive.apache.org/dist/kafka/3.4.0/kafka_2.13-3.4.0.tgz
else
    curl -L -o kafka.tgz https://archive.apache.org/dist/kafka/3.4.0/kafka_2.13-3.4.0.tgz
fi
tar -xzf kafka.tgz --strip-components=1
rm -f kafka.tgz

# 3. Configure storage and log directories in KRaft config
mkdir -p /var/lib/kafka
sed -i 's|log.dirs=/tmp/kraft-combined-logs|log.dirs=/var/lib/kafka/kraft-combined-logs|' /opt/kafka/config/kraft/server.properties

# 4. Format storage using KRaft mode
echo "Formatting KRaft storage metadata..."
export JAVA_HOME=/opt/jre
export PATH=/opt/jre/bin:$PATH
CLUSTER_ID=$(/opt/kafka/bin/kafka-storage.sh random-uuid)
/opt/kafka/bin/kafka-storage.sh format -t "$CLUSTER_ID" -c /opt/kafka/config/kraft/server.properties

echo "=== kafka-stream Sandbox Forged ==="
