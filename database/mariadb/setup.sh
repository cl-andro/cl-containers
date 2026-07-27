#!/bin/sh
set -e
echo "=== MariaDB Sandbox Provisioning ==="
mkdir -p /var/lib/mysql
mkdir -p /var/run/mysqld
chown -R mysql:mysql /var/lib/mysql /var/run/mysqld || true
echo "=== MariaDB Sandbox Forged ==="
