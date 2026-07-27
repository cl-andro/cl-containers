#!/bin/sh
set -e
echo "=== kanboard-app Sandbox Setup ==="
mkdir -p /opt/kanboard
cd /opt/kanboard
if command -v wget >/dev/null 2>&1; then
    wget -O kanboard.zip https://kanboard.org/kanboard-latest.zip
else
    curl -L -o kanboard.zip https://kanboard.org/kanboard-latest.zip
fi
unzip kanboard.zip
mv kanboard/* .
rm -rf kanboard kanboard.zip

echo "=== kanboard-app Sandbox Forged ==="
