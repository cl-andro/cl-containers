#!/bin/sh
set -e
echo "=== swift-compiler Sandbox Setup ==="
mkdir -p /opt/swift
cd /opt/swift

echo "Downloading Swift 6.0..."
if command -v wget >/dev/null 2>&1; then
    wget -O swift.tar.gz https://download.swift.org/swift-6.0.2-release/debian12/swift-6.0.2-RELEASE/swift-6.0.2-RELEASE-debian12.tar.gz
else
    curl -L -o swift.tar.gz https://download.swift.org/swift-6.0.2-release/debian12/swift-6.0.2-RELEASE/swift-6.0.2-RELEASE-debian12.tar.gz
fi

echo "Extracting package..."
tar -xzf swift.tar.gz --strip-components=1
rm -f swift.tar.gz

echo "Setting permissions..."
if [ -n "$SUDO_UID" ] && [ -n "$SUDO_GID" ]; then
    chown -R "$SUDO_UID:$SUDO_GID" /opt/swift
else
    chmod -R 777 /opt/swift
fi

echo "=== swift-compiler Sandbox Forged ==="
