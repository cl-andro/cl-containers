#!/bin/sh
set -e
echo "=== julia-runtime Sandbox Setup ==="
mkdir -p /opt/julia
cd /opt/julia

echo "Downloading Julia 1.11.2..."
if command -v wget >/dev/null 2>&1; then
    wget -O julia.tar.gz https://julialang-s3.julialang.org/bin/linux/x64/1.11/julia-1.11.2-linux-x86_64.tar.gz
else
    curl -L -o julia.tar.gz https://julialang-s3.julialang.org/bin/linux/x64/1.11/julia-1.11.2-linux-x86_64.tar.gz
fi

echo "Extracting package..."
tar -xzf julia.tar.gz --strip-components=1
rm -f julia.tar.gz

echo "Setting permissions..."
if [ -n "$SUDO_UID" ] && [ -n "$SUDO_GID" ]; then
    chown -R "$SUDO_UID:$SUDO_GID" /opt/julia
else
    chmod -R 777 /opt/julia
fi

echo "=== julia-runtime Sandbox Forged ==="
