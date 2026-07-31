#!/bin/sh
set -e
echo "=== Rust Compiler Sandbox Setup ==="
mkdir -p /opt/rust
mkdir -p /tmp/rust_install

echo "Downloading Rust standalone installer..."
curl -L -o /tmp/rust.tar.gz https://static.rust-lang.org/dist/rust-1.75.0-x86_64-unknown-linux-gnu.tar.gz

echo "Extracting installer..."
tar -xzf /tmp/rust.tar.gz -C /tmp/rust_install --strip-components=1
rm -f /tmp/rust.tar.gz

echo "Executing installer..."
/tmp/rust_install/install.sh --prefix=/opt/rust
rm -rf /tmp/rust_install

echo "Setting permissions..."
if [ -n "$SUDO_UID" ] && [ -n "$SUDO_GID" ]; then
    chown -R "$SUDO_UID:$SUDO_GID" /opt/rust
else
    chmod -R 777 /opt/rust
fi

echo "=== Rust Compiler Sandbox Forged ==="
