#!/bin/sh
set -e
echo "=== dotnet-sdk Sandbox Setup ==="
mkdir -p /opt/dotnet
cd /opt/dotnet

echo "Downloading .NET 8.0 SDK..."
if command -v wget >/dev/null 2>&1; then
    wget -O dotnet.tar.gz https://builds.dotnet.microsoft.com/dotnet/Sdk/8.0.412/dotnet-sdk-8.0.412-linux-x64.tar.gz
else
    curl -L -o dotnet.tar.gz https://builds.dotnet.microsoft.com/dotnet/Sdk/8.0.412/dotnet-sdk-8.0.412-linux-x64.tar.gz
fi

echo "Extracting package..."
tar -xzf dotnet.tar.gz
rm -f dotnet.tar.gz

echo "Setting permissions..."
if [ -n "$SUDO_UID" ] && [ -n "$SUDO_GID" ]; then
    chown -R "$SUDO_UID:$SUDO_GID" /opt/dotnet
else
    chmod -R 777 /opt/dotnet
fi

echo "=== dotnet-sdk Sandbox Forged ==="
