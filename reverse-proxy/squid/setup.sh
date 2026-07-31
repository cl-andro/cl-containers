#!/bin/sh
set -e
echo "=== squid-proxy Sandbox Setup ==="
mkdir -p /opt/squid
mkdir -p /opt/squid/var/run
mkdir -p /opt/squid/var/log

echo "Downloading Squid package and dependencies..."
curl -L -o /tmp/squid.deb https://deb.debian.org/debian/pool/main/s/squid/squid_5.7-2+deb12u5_amd64.deb
curl -L -o /tmp/squid-common.deb https://deb.debian.org/debian/pool/main/s/squid/squid-common_5.7-2+deb12u5_all.deb
curl -L -o /tmp/libecap.deb https://deb.debian.org/debian/pool/main/libe/libecap/libecap3_1.0.1-3.4_amd64.deb

echo "Extracting packages..."
dpkg-deb -x /tmp/squid.deb /opt/squid/
dpkg-deb -x /tmp/squid-common.deb /opt/squid/
dpkg-deb -x /tmp/libecap.deb /opt/squid/

echo "Fixing broken symlinks..."
rm -f /opt/squid/usr/share/squid/errors
mkdir -p /opt/squid/usr/share/squid/errors

echo "Configuring squid.conf..."
sed -i 's|^include /etc/squid/conf.d/.*|#include /etc/squid/conf.d/*.conf|g' /opt/squid/etc/squid/squid.conf

if [ -n "$INVOKING_USER" ]; then
    echo "cache_effective_user $INVOKING_USER" >> /opt/squid/etc/squid/squid.conf
fi

cat <<EOF >> /opt/squid/etc/squid/squid.conf
pid_filename /opt/squid/var/run/squid.pid
access_log stdio:/opt/squid/var/log/access.log
cache_log /opt/squid/var/log/cache.log
mime_table /opt/squid/usr/share/squid/mime.conf
unlinkd_program /opt/squid/usr/lib/squid/unlinkd
logfile_daemon /opt/squid/usr/lib/squid/log_file_daemon
icon_directory /opt/squid/usr/share/squid/icons
EOF

echo "Setting permissions..."
if [ -n "$SUDO_UID" ] && [ -n "$SUDO_GID" ]; then
    chown -R "$SUDO_UID:$SUDO_GID" /opt/squid
else
    chmod -R 777 /opt/squid
fi

echo "Cleaning up..."
rm -f /tmp/squid.deb /tmp/squid-common.deb /tmp/libecap.deb

echo "=== squid-proxy Sandbox Forged ==="
