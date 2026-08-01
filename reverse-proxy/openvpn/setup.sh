#!/bin/sh
set -e
echo "=== openvpn-vpn Sandbox Setup ==="
mkdir -p /opt/openvpn
mkdir -p /tmp/openvpn_extract
cd /tmp/openvpn_extract

echo "Downloading OpenVPN package..."
curl -L -o openvpn.deb https://deb.debian.org/debian/pool/main/o/openvpn/openvpn_2.6.14-1%2Bdeb13u3_amd64.deb

echo "Extracting package..."
dpkg-deb -x openvpn.deb /opt/openvpn/
rm -f openvpn.deb

# Clean up temp folder
cd /
rm -rf /tmp/openvpn_extract

# Write server config
echo "Creating static key and server configuration..."
mkdir -p /etc/openvpn
/opt/openvpn/usr/sbin/openvpn --genkey secret /etc/openvpn/static.key

cat << 'EOF' > /etc/openvpn/server.conf
dev tun
proto udp
port 1194
secret /etc/openvpn/static.key
verb 3
EOF

echo "Setting permissions..."
if [ -n "$SUDO_UID" ] && [ -n "$SUDO_GID" ]; then
    chown -R "$SUDO_UID:$SUDO_GID" /opt/openvpn
else
    chmod -R 777 /opt/openvpn
fi

echo "=== openvpn-vpn Sandbox Forged ==="
