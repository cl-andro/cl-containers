#!/bin/sh
set -e
echo "=== consul-store Sandbox Setup ==="
mkdir -p /opt/consul
cd /opt/consul
if command -v wget >/dev/null 2>&1; then
    wget -O consul.zip https://releases.hashicorp.com/consul/1.15.4/consul_1.15.4_linux_amd64.zip
else
    curl -L -o consul.zip https://releases.hashicorp.com/consul/1.15.4/consul_1.15.4_linux_amd64.zip
fi
unzip consul.zip
rm -f consul.zip

echo "=== consul-store Sandbox Forged ==="
