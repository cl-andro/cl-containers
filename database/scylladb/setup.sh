#!/bin/sh
set -e
echo "=== scylla-db Sandbox Setup ==="

# Create necessary runtime data directories
mkdir -p /var/lib/scylla
mkdir -p /var/log/scylla
mkdir -p /var/lib/scylla/data
mkdir -p /var/lib/scylla/commitlog
mkdir -p /var/lib/scylla/hints
mkdir -p /var/lib/scylla/view_hints

# Download scylla-server and scylla-conf deb packages
echo "Downloading ScyllaDB server and config packages..."
curl -L -o /tmp/scylla-server.deb https://downloads.scylladb.com/downloads/scylla/deb/debian-ubuntu/scylladb-5.4/pool/main/s/scylla-server/scylla-server_5.4.9-0.20240703.fdcbbb85adcd-1_amd64.deb
curl -L -o /tmp/scylla-conf.deb https://downloads.scylladb.com/downloads/scylla/deb/debian-ubuntu/scylladb-5.4/pool/main/s/scylla-server/scylla-conf_5.4.9-0.20240703.fdcbbb85adcd-1_amd64.deb

echo "Extracting packages rootlessly to guest root..."
dpkg -x /tmp/scylla-server.deb /
dpkg -x /tmp/scylla-conf.deb /

# Clean up deb files
rm -f /tmp/scylla-server.deb /tmp/scylla-conf.deb

# Setup proper permissions
echo "Setting permissions..."
chmod -R 777 /var/lib/scylla
chmod -R 777 /var/log/scylla
if [ -n "$SUDO_UID" ] && [ -n "$SUDO_GID" ]; then
    chown -R "$SUDO_UID:$SUDO_GID" /var/lib/scylla
    chown -R "$SUDO_UID:$SUDO_GID" /var/log/scylla
fi

echo "=== scylla-db Sandbox Forged ==="
