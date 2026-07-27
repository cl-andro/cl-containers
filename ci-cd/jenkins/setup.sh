#!/bin/sh
set -e
echo "=== Jenkins Sandbox Provisioning ==="
mkdir -p /opt/jenkins
mkdir -p /var/lib/jenkins
cd /opt/jenkins
if command -v wget >/dev/null 2>&1; then
    wget -O jenkins.war https://get.jenkins.io/war-stable/2.401.3/jenkins.war
else
    curl -L -o jenkins.war https://get.jenkins.io/war-stable/2.401.3/jenkins.war
fi
echo "=== Jenkins Sandbox Forged ==="
