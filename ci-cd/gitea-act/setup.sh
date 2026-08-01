#!/bin/sh
set -e
echo "=== gitea-act Sandbox Setup ==="
rm -rf /opt/gitea-act
mkdir -p /opt/gitea-act/bin

echo "Downloading act standalone tarball..."
curl -L -o /tmp/act.tar.gz https://github.com/nektos/act/releases/download/v0.2.68/act_Linux_x86_64.tar.gz

echo "Extracting act binary..."
tar -C /opt/gitea-act/bin -xzf /tmp/act.tar.gz act
rm -f /tmp/act.tar.gz

echo "Making binary executable..."
chmod +x /opt/gitea-act/bin/act

echo "Setting permissions..."
if [ -n "$SUDO_UID" ] && [ -n "$SUDO_GID" ]; then
    chown -R "$SUDO_UID:$SUDO_GID" /opt/gitea-act
else
    chmod -R 777 /opt/gitea-act
fi

echo "=== gitea-act Sandbox Forged ==="
