#!/bin/sh
set -e
echo "=== shadowsocks-proxy Sandbox Setup ==="
mkdir -p /opt/shadowsocks
mkdir -p /tmp/ss_extract
cd /tmp/ss_extract

echo "Downloading Shadowsocks-libev package..."
curl -L -o shadowsocks.deb https://deb.debian.org/debian/pool/main/s/shadowsocks-libev/shadowsocks-libev_3.3.5%2Bds-16_amd64.deb

echo "Downloading library dependencies..."
curl -L -o libbloom.deb https://deb.debian.org/debian/pool/main/libb/libbloom/libbloom2_2.0-0.2%2Bb2_amd64.deb
curl -L -o libcork.deb https://deb.debian.org/debian/pool/main/libc/libcork/libcork16_1.0.0~rc3-4_amd64.deb
curl -L -o libcorkipset.deb https://deb.debian.org/debian/pool/main/libc/libcorkipset/libcorkipset1_1.1.1%2Bgit20171111.6842a63-2%2Bb2_amd64.deb
curl -L -o libjsonparser.deb https://deb.debian.org/debian/pool/main/libj/libjsonparser/libjsonparser1.1_1.1.0-2%2Bb2_amd64.deb
curl -L -o libev.deb https://deb.debian.org/debian/pool/main/libe/libev/libev4t64_4.33-2.1%2Bb1_amd64.deb

echo "Extracting packages..."
for deb in *.deb; do
    dpkg-deb -x "$deb" /opt/shadowsocks/
done

# Clean up temp folder
cd /
rm -rf /tmp/ss_extract

# Write default configuration
echo "Writing default Shadowsocks configuration..."
mkdir -p /etc
cat << 'EOF' > /etc/shadowsocks.json
{
    "server":"0.0.0.0",
    "server_port":8388,
    "local_address":"127.0.0.1",
    "local_port":1080,
    "password":"barry",
    "timeout":300,
    "method":"aes-256-gcm"
}
EOF

echo "Setting permissions..."
if [ -n "$SUDO_UID" ] && [ -n "$SUDO_GID" ]; then
    chown -R "$SUDO_UID:$SUDO_GID" /opt/shadowsocks
else
    chmod -R 777 /opt/shadowsocks
fi

echo "=== shadowsocks-proxy Sandbox Forged ==="
