#!/bin/sh
set -e
echo "=== MySQL Sandbox Provisioning ==="
mkdir -p /var/lib/mysql
mkdir -p /var/run/mysqld
chown -R mysql:mysql /var/lib/mysql /var/run/mysqld || true
echo "=== MySQL Sandbox Forged ==="
