#!/bin/sh
set -e
echo "=== rethink-db Sandbox Setup ==="

# Clean and create directory structures
rm -rf /opt/rethinkdb
mkdir -p /opt/rethinkdb
mkdir -p /var/lib/rethinkdb

# Download rethinkdb deb package
echo "Downloading RethinkDB deb package..."
curl -L --retry 5 --retry-delay 3 -o /tmp/rethinkdb.deb https://download.rethinkdb.com/repository/debian-bookworm/pool/r/rethinkdb/rethinkdb_2.4.4~0bookworm_amd64.deb

echo "Extracting package rootlessly to /opt/rethinkdb..."
dpkg -x /tmp/rethinkdb.deb /opt/rethinkdb
rm -f /tmp/rethinkdb.deb

# Setup proper permissions
echo "Setting permissions..."
chmod -R 777 /opt/rethinkdb
chmod -R 777 /var/lib/rethinkdb

if [ -n "$SUDO_UID" ] && [ -n "$SUDO_GID" ]; then
    chown -R "$SUDO_UID:$SUDO_GID" /opt/rethinkdb
    chown -R "$SUDO_UID:$SUDO_GID" /var/lib/rethinkdb
fi

echo "=== rethink-db Sandbox Forged ==="
