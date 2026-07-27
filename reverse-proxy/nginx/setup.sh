#!/bin/sh
set -e
echo "=== Nginx Sandbox Provisioning ==="
mkdir -p /etc/nginx
mkdir -p /var/log/nginx
mkdir -p /var/lib/nginx
if [ -d /etc/nginx ]; then
    cp -a /etc/nginx/* /etc/nginx/ || true
fi
echo "=== Nginx Sandbox Forged ==="
