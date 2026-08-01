#!/bin/sh
set -e
echo "=== mosquitto-broker Sandbox Setup ==="

# Clean and create directory structures
rm -rf /opt/mosquitto
mkdir -p /opt/mosquitto
mkdir -p /var/lib/mosquitto
mkdir -p /var/log/mosquitto

# Download mosquitto and its dependency deb packages
echo "Downloading Mosquitto and dependency packages..."
curl -L -o /tmp/mosquitto.deb http://deb.debian.org/debian/pool/main/m/mosquitto/mosquitto_2.0.21-1_amd64.deb
curl -L -o /tmp/libmosquitto.deb http://deb.debian.org/debian/pool/main/m/mosquitto/libmosquitto1_2.0.21-1_amd64.deb
curl -L -o /tmp/libwebsockets.deb http://deb.debian.org/debian/pool/main/libw/libwebsockets/libwebsockets19t64_4.3.5-1+deb13u1_amd64.deb
curl -L -o /tmp/libdlt.deb http://deb.debian.org/debian/pool/main/d/dlt-daemon/libdlt2_2.18.10-10+b1_amd64.deb

echo "Extracting packages rootlessly to /opt/mosquitto..."
dpkg -x /tmp/mosquitto.deb /opt/mosquitto
dpkg -x /tmp/libmosquitto.deb /opt/mosquitto
dpkg -x /tmp/libwebsockets.deb /opt/mosquitto
dpkg -x /tmp/libdlt.deb /opt/mosquitto

# Clean up deb files
rm -f /tmp/mosquitto.deb /tmp/libmosquitto.deb /tmp/libwebsockets.deb /tmp/libdlt.deb

# Set up configuration
echo "Configuring Mosquitto..."
mkdir -p /etc/mosquitto
if [ -f /opt/mosquitto/etc/mosquitto/mosquitto.conf ]; then
    cp /opt/mosquitto/etc/mosquitto/mosquitto.conf /etc/mosquitto/mosquitto.conf
else
    touch /etc/mosquitto/mosquitto.conf
fi

# Append custom configuration options
echo "listener 1883 0.0.0.0" >> /etc/mosquitto/mosquitto.conf
echo "allow_anonymous true" >> /etc/mosquitto/mosquitto.conf
echo "user root" >> /etc/mosquitto/mosquitto.conf

# Setup proper permissions
echo "Setting permissions..."
chmod -R 777 /opt/mosquitto
chmod -R 777 /var/lib/mosquitto
chmod -R 777 /var/log/mosquitto
chmod -R 777 /etc/mosquitto

if [ -n "$SUDO_UID" ] && [ -n "$SUDO_GID" ]; then
    chown -R "$SUDO_UID:$SUDO_GID" /opt/mosquitto
    chown -R "$SUDO_UID:$SUDO_GID" /var/lib/mosquitto
    chown -R "$SUDO_UID:$SUDO_GID" /var/log/mosquitto
    chown -R "$SUDO_UID:$SUDO_GID" /etc/mosquitto
fi

echo "=== mosquitto-broker Sandbox Forged ==="
