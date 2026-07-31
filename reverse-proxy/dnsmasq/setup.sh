#!/bin/sh
set -e
echo "=== dnsmasq-dns Sandbox Setup ==="
mkdir -p /opt/dnsmasq
mkdir -p /etc/dnsmasq.d

echo "Compiling privilege-mocking helper library..."
cat << 'EOF' > /tmp/mock.c
int setgid(int gid) { return 0; }
int setuid(int uid) { return 0; }
int setregid(int rgid, int egid) { return 0; }
int setreuid(int ruid, int euid) { return 0; }
int setresgid(int rgid, int egid, int sgid) { return 0; }
int setresuid(int ruid, int euid, int suid) { return 0; }
int initgroups(const char *user, int group) { return 0; }
int setgroups(int size, const int *list) { return 0; }
EOF
gcc -shared -fPIC -o /opt/dnsmasq/libmock.so /tmp/mock.c
rm -f /tmp/mock.c

echo "Setting permissions..."
if [ -n "$SUDO_UID" ] && [ -n "$SUDO_GID" ]; then
    chown -R "$SUDO_UID:$SUDO_GID" /opt/dnsmasq
else
    chmod -R 777 /opt/dnsmasq
fi

echo "=== dnsmasq-dns Sandbox Forged ==="
