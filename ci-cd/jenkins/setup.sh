#!/bin/sh
set -e
echo "=== Jenkins Sandbox Provisioning ==="
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

# 2. Download and install Jenkins
mkdir -p /opt/jenkins
mkdir -p /var/lib/jenkins
cd /opt/jenkins
if command -v wget >/dev/null 2>&1; then
    wget -O jenkins.war https://get.jenkins.io/war-stable/2.401.3/jenkins.war
else
    curl -L -o jenkins.war https://get.jenkins.io/war-stable/2.401.3/jenkins.war
fi
echo "=== Jenkins Sandbox Forged ==="
