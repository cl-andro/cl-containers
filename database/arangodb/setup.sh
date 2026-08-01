#!/bin/sh
set -e
echo "=== arango-db Sandbox Setup ==="
mkdir -p /opt/arangodb
mkdir -p /etc/arangodb3
mkdir -p /var/lib/arangodb3
mkdir -p /var/lib/arangodb3-apps

echo "Downloading ArangoDB Community package..."
curl -L -o /tmp/arangodb.deb https://download.arangodb.com/arangodb311/DEBIAN/amd64/arangodb3_3.11.0-1_amd64.deb

echo "Extracting package..."
dpkg-deb -x /tmp/arangodb.deb /opt/arangodb/
rm -f /tmp/arangodb.deb

echo "Creating custom sandbox-friendly ArangoDB configuration..."
cat << 'EOF' > /etc/arangodb3/arangod.conf
[server]
endpoint = tcp://0.0.0.0:8529
storage-engine = auto
authentication = false

[database]
directory = /var/lib/arangodb3

[javascript]
startup-directory = /opt/arangodb/usr/share/arangodb3/js
app-path = /var/lib/arangodb3-apps

[log]
level = info
output = file://-
EOF

echo "Setting permissions..."
if [ -n "$SUDO_UID" ] && [ -n "$SUDO_GID" ]; then
    chown -R "$SUDO_UID:$SUDO_GID" /opt/arangodb /etc/arangodb3 /var/lib/arangodb3 /var/lib/arangodb3-apps
else
    chmod -R 777 /opt/arangodb /etc/arangodb3 /var/lib/arangodb3 /var/lib/arangodb3-apps
fi

echo "=== arango-db Sandbox Forged ==="
