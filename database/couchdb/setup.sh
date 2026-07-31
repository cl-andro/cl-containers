#!/bin/sh
exec > /install.log 2>&1
set -ex
echo "=== couch-db Sandbox Setup ==="
mkdir -p /opt/couchdb
mkdir -p /tmp/couchdb-build

echo "Downloading CouchDB package..."
curl -L -o /tmp/couchdb.deb https://apache.jfrog.io/artifactory/couchdb-deb/pool/C/CouchDB/couchdb_3.5.2~bookworm_amd64.deb

echo "Extracting package..."
mkdir -p /tmp/couchdb-extract
dpkg-deb -x /tmp/couchdb.deb /tmp/couchdb-extract

echo "Installing CouchDB..."
cp -r /tmp/couchdb-extract/opt/couchdb/* /opt/couchdb/

echo "Fixing symlinks..."
rm -f /opt/couchdb/data
mkdir -p /opt/couchdb/data

echo "Configuring CouchDB..."
mkdir -p /opt/couchdb/etc/local.d
cat <<EOF > /opt/couchdb/etc/local.d/10-custom.ini
[chttpd]
bind_address = 0.0.0.0

[admins]
admin = password

[log]
writer = stderr
EOF

echo "Setting permissions..."
if [ -n "$SUDO_UID" ] && [ -n "$SUDO_GID" ]; then
    chown -R "$SUDO_UID:$SUDO_GID" /opt/couchdb
else
    chmod -R 777 /opt/couchdb
fi

echo "Cleaning up..."
rm -rf /tmp/couchdb-build /tmp/couchdb-extract /tmp/couchdb.deb

echo "=== couch-db Sandbox Forged ==="
