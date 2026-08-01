#!/bin/sh
set -e
echo "=== trilium-notes Sandbox Setup ==="

# Clean and create directories
rm -rf /opt/trilium
mkdir -p /opt/trilium
mkdir -p /opt/trilium/data

# 1. Download and extract Trilium Notes Server bundle
echo "Downloading Trilium Notes Server..."
curl -L -o /tmp/trilium.tar.xz https://github.com/TriliumNext/Trilium/releases/download/v0.104.1/TriliumNotes-Server-v0.104.1-linux-x64.tar.xz
echo "Extracting Trilium..."
tar -C /opt/trilium --strip-components=1 -xJf /tmp/trilium.tar.xz
rm -f /tmp/trilium.tar.xz

# Setup proper permissions
echo "Setting permissions..."
chmod -R 777 /opt/trilium

if [ -n "$SUDO_UID" ] && [ -n "$SUDO_GID" ]; then
    chown -R "$SUDO_UID:$SUDO_GID" /opt/trilium
fi

echo "=== trilium-notes Sandbox Forged ==="
