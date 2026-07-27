#!/bin/sh
set -e
echo "=== SQLite Sandbox Provisioning (Self-Contained Build) ==="

mkdir -p /opt/sqlite
mkdir -p /tmp/sqlite-build
cd /tmp/sqlite-build

if command -v wget >/dev/null 2>&1; then
    wget -O sqlite.zip https://www.sqlite.org/2023/sqlite-amalgamation-3420000.zip
else
    curl -L -o sqlite.zip https://www.sqlite.org/2023/sqlite-amalgamation-3420000.zip
fi

unzip sqlite.zip
cd sqlite-amalgamation-3420000

gcc -O2 shell.c sqlite3.c -lpthread -ldl -lm -o /opt/sqlite/sqlite3

cd /
rm -rf /tmp/sqlite-build

echo "=== SQLite Sandbox Forged ==="
