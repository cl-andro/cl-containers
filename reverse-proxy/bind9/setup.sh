#!/bin/sh
set -e
echo "=== BIND9 Sandbox Provisioning ==="
mkdir -p /opt/bind9
mkdir -p /etc/bind
mkdir -p /var/cache/bind

echo "Downloading BIND9 and library packages..."
curl -L -o /tmp/bind9.deb http://security.debian.org/debian-security/pool/updates/main/b/bind9/bind9_9.20.26-1~deb13u1_amd64.deb
curl -L -o /tmp/bind9-libs.deb http://security.debian.org/debian-security/pool/updates/main/b/bind9/bind9-libs_9.20.26-1~deb13u1_amd64.deb
curl -L -o /tmp/libjemalloc2.deb http://deb.debian.org/debian/pool/main/j/jemalloc/libjemalloc2_5.3.0-3_amd64.deb
curl -L -o /tmp/libmaxminddb0.deb http://deb.debian.org/debian/pool/main/libm/libmaxminddb/libmaxminddb0_1.12.2-1_amd64.deb
curl -L -o /tmp/libfstrm0.deb http://deb.debian.org/debian/pool/main/f/fstrm/libfstrm0_0.6.1-1+b3_amd64.deb
curl -L -o /tmp/libuv1t64.deb http://deb.debian.org/debian/pool/main/libu/libuv1/libuv1t64_1.50.0-2_amd64.deb
curl -L -o /tmp/libprotobuf-c1.deb http://deb.debian.org/debian/pool/main/p/protobuf-c/libprotobuf-c1_1.5.1-1_amd64.deb

echo "Extracting packages..."
dpkg-deb -x /tmp/bind9.deb /opt/bind9/
dpkg-deb -x /tmp/bind9-libs.deb /opt/bind9/
dpkg-deb -x /tmp/libjemalloc2.deb /opt/bind9/
dpkg-deb -x /tmp/libmaxminddb0.deb /opt/bind9/
dpkg-deb -x /tmp/libfstrm0.deb /opt/bind9/
dpkg-deb -x /tmp/libuv1t64.deb /opt/bind9/
dpkg-deb -x /tmp/libprotobuf-c1.deb /opt/bind9/
rm -f /tmp/*.deb

echo "Creating custom sandbox-friendly BIND9 configuration..."
cat << 'EOF' > /etc/bind/named.conf
options {
    directory "/var/cache/bind";
    pid-file none;
    listen-on port 1053 { any; };
    listen-on-v6 port 1053 { any; };
    allow-query { any; };
    dnssec-validation no;
};

logging {
    channel default_stderr {
        stderr;
        severity info;
    };
    category default { default_stderr; };
    category general { default_stderr; };
};
EOF

echo "Setting permissions..."
if [ -n "$SUDO_UID" ] && [ -n "$SUDO_GID" ]; then
    chown -R "$SUDO_UID:$SUDO_GID" /opt/bind9 /etc/bind /var/cache/bind
else
    chmod -R 777 /opt/bind9 /etc/bind /var/cache/bind
fi

echo "=== BIND9 Sandbox Forged ==="
