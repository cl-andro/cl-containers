#!/bin/sh
set -e
echo "=== cockroach-db Sandbox Setup ==="
mkdir -p /opt/cockroach
mkdir -p /opt/cockroach/data
cd /opt/cockroach
if command -v wget >/dev/null 2>&1; then
    wget -O cockroach.tgz https://binaries.cockroachdb.com/cockroach-v23.1.3.linux-amd64.tgz
else
    curl -L -o cockroach.tgz https://binaries.cockroachdb.com/cockroach-v23.1.3.linux-amd64.tgz
fi
tar -xzf cockroach.tgz --strip-components=1
rm -f cockroach.tgz

echo "Setting permissions..."
if [ -n "$SUDO_UID" ] && [ -n "$SUDO_GID" ]; then
    chown -R "$SUDO_UID:$SUDO_GID" /opt/cockroach
else
    chmod -R 777 /opt/cockroach
fi

echo "=== cockroach-db Sandbox Forged ==="
