#!/bin/sh
set -e
echo "=== gatsby-builder Sandbox Setup ==="
mkdir -p /opt/gatsby
cd /opt/gatsby

echo "Installing gatsby-cli locally..."
npm install gatsby-cli

echo "Setting permissions..."
if [ -n "$SUDO_UID" ] && [ -n "$SUDO_GID" ]; then
    chown -R "$SUDO_UID:$SUDO_GID" /opt/gatsby
else
    chmod -R 777 /opt/gatsby
fi

echo "=== gatsby-builder Sandbox Forged ==="
