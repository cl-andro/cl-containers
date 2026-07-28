#!/bin/sh
set -e
echo "=== haproxy-loadbalancer Sandbox Provisioning ==="
mkdir -p /opt/haproxy
cd /opt/haproxy

# 1. Download HAProxy source
if command -v wget >/dev/null 2>&1; then
    wget -O haproxy.tar.gz "https://www.haproxy.org/download/2.8/src/haproxy-2.8.5.tar.gz"
else
    curl -L -o haproxy.tar.gz "https://www.haproxy.org/download/2.8/src/haproxy-2.8.5.tar.gz"
fi

# 2. Extract and compile
tar -xzf haproxy.tar.gz
cd haproxy-2.8.5
make -j$(nproc) TARGET=linux-glibc
cp haproxy /opt/haproxy/

# 3. Clean up source files
cd /opt/haproxy
rm -rf haproxy-2.8.5 haproxy.tar.gz

# 4. Create standard configuration
mkdir -p /etc/haproxy
cat <<EOF > /etc/haproxy/haproxy.cfg
global
    maxconn 256

defaults
    mode http
    timeout connect 5000ms
    timeout client 50000ms
    timeout server 50000ms

frontend http_in
    bind *:9000
    default_backend servers

backend servers
    server server1 127.0.0.1:8080 maxconn 32
EOF

echo "=== haproxy-loadbalancer Sandbox Forged ==="
