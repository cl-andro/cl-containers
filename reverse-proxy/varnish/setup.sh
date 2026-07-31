#!/bin/sh
set -e
echo "=== varnish-cache Sandbox Setup ==="
mkdir -p /opt/varnish
mkdir -p /opt/varnish/var/lib/varnish

echo "Downloading Varnish package and dependencies..."
curl -L -o /tmp/varnish.deb https://deb.debian.org/debian/pool/main/v/varnish/varnish_7.1.1-2+deb12u1_amd64.deb
curl -L -o /tmp/libvarnishapi.deb https://deb.debian.org/debian/pool/main/v/varnish/libvarnishapi3_7.1.1-2+deb12u1_amd64.deb
curl -L -o /tmp/libjemalloc.deb https://deb.debian.org/debian/pool/main/j/jemalloc/libjemalloc2_5.3.0-1_amd64.deb

echo "Extracting packages..."
dpkg-deb -x /tmp/varnish.deb /opt/varnish/
dpkg-deb -x /tmp/libvarnishapi.deb /opt/varnish/
dpkg-deb -x /tmp/libjemalloc.deb /opt/varnish/

echo "Setting permissions..."
if [ -n "$SUDO_UID" ] && [ -n "$SUDO_GID" ]; then
    chown -R "$SUDO_UID:$SUDO_GID" /opt/varnish
else
    chmod -R 777 /opt/varnish
fi

echo "Cleaning up..."
rm -f /tmp/varnish.deb /tmp/libvarnishapi.deb /tmp/libjemalloc.deb

echo "=== varnish-cache Sandbox Forged ==="
