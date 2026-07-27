#!/bin/sh
set -e
echo "=== Nginx Sandbox Provisioning (Self-Contained Build) ==="

mkdir -p /tmp/nginx-build
cd /tmp/nginx-build

if command -v wget >/dev/null 2>&1; then
    wget -O nginx.tar.gz https://nginx.org/download/nginx-1.24.0.tar.gz
else
    curl -L -o nginx.tar.gz https://nginx.org/download/nginx-1.24.0.tar.gz
fi

tar -xzf nginx.tar.gz --strip-components=1

./configure --prefix=/opt/nginx \
            --without-http_rewrite_module \
            --without-http_gzip_module

make -j$(nproc)
make install

# Clean up build files
cd /
rm -rf /tmp/nginx-build

# Adjust default nginx configuration to run as unprivileged user on port 8080
if [ -f /opt/nginx/conf/nginx.conf ]; then
    sed -i 's/listen       80;/listen       8080;/g' /opt/nginx/conf/nginx.conf
    sed -i 's/#user  nobody;/user nobody;/g' /opt/nginx/conf/nginx.conf
fi

echo "=== Nginx Sandbox Forged ==="
