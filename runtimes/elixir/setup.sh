#!/bin/sh
set -e
echo "=== Elixir & Erlang Sandbox Setup ==="
mkdir -p /opt/elixir
mkdir -p /tmp/elixir_extract
cd /tmp/elixir_extract

echo "Downloading Elixir and Erlang packages..."
apt-get download elixir erlang-base erlang-crypto erlang-inets erlang-parsetools erlang-public-key erlang-tools erlang-syntax-tools

echo "Extracting packages..."
for deb in *.deb; do
    dpkg-deb -x "$deb" /opt/elixir/
done

echo "Cleaning up temporary downloads..."
cd /
rm -rf /tmp/elixir_extract

echo "Patching Erlang ROOTDIR paths..."
if [ -f /opt/elixir/usr/bin/erl ]; then
    sed -i 's|ROOTDIR="/usr/lib/erlang"|ROOTDIR="/opt/elixir/usr/lib/erlang"|g' /opt/elixir/usr/bin/erl
fi
if [ -f /opt/elixir/usr/lib/erlang/bin/erl ]; then
    sed -i 's|ROOTDIR="/usr/lib/erlang"|ROOTDIR="/opt/elixir/usr/lib/erlang"|g' /opt/elixir/usr/lib/erlang/bin/erl
fi
if [ -f /opt/elixir/usr/lib/erlang/bin/start ]; then
    sed -i 's|ROOTDIR="/usr/lib/erlang"|ROOTDIR="/opt/elixir/usr/lib/erlang"|g' /opt/elixir/usr/lib/erlang/bin/start
fi

echo "Setting permissions..."
if [ -n "$SUDO_UID" ] && [ -n "$SUDO_GID" ]; then
    chown -R "$SUDO_UID:$SUDO_GID" /opt/elixir
else
    chmod -R 777 /opt/elixir
fi

echo "=== Elixir & Erlang Sandbox Forged ==="
