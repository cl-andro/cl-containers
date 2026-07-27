#!/bin/sh
set -e
echo "=== PostgreSQL Sandbox Provisioning ==="
mkdir -p /var/lib/postgresql/data
mkdir -p /var/run/postgresql
mkdir -p /opt/postgres/bin

if [ -x /usr/lib/postgresql/*/bin/initdb ]; then
    INITDB=$(ls /usr/lib/postgresql/*/bin/initdb | head -n 1)
    POSTGRES=$(ls /usr/lib/postgresql/*/bin/postgres | head -n 1)
    $INITDB -D /var/lib/postgresql/data --nosync || true
    ln -sf "$POSTGRES" /opt/postgres/bin/postgres
else
    echo "Error: PostgreSQL is not installed on the host. Run: apt-get install postgresql"
    exit 1
fi
echo "=== PostgreSQL Sandbox Forged ==="
