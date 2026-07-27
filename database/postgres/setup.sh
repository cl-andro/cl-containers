#!/bin/sh
set -e
echo "=== PostgreSQL Sandbox Provisioning ==="
mkdir -p /var/lib/postgresql/data
mkdir -p /var/run/postgresql
if [ -x /usr/lib/postgresql/*/bin/initdb ]; then
    INITDB=$(ls /usr/lib/postgresql/*/bin/initdb | head -n 1)
    $INITDB -D /var/lib/postgresql/data --nosync || true
fi
echo "=== PostgreSQL Sandbox Forged ==="
