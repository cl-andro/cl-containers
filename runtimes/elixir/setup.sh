#!/bin/sh
set -e
echo "=== Elixir & Erlang Sandbox Setup ==="
mkdir -p /opt/elixir
mkdir -p /tmp/elixir_extract
cd /tmp/elixir_extract

BASE_URL="https://deb.debian.org/debian/pool/main/e/erlang"
ERL_VERSION="27.3.4.1+dfsg-1+deb13u2"

echo "Downloading Erlang packages..."
curl -L -o erlang-base.deb "$BASE_URL/erlang-base_${ERL_VERSION}_amd64.deb"
curl -L -o erlang-crypto.deb "$BASE_URL/erlang-crypto_${ERL_VERSION}_amd64.deb"
curl -L -o erlang-inets.deb "$BASE_URL/erlang-inets_${ERL_VERSION}_amd64.deb"
curl -L -o erlang-parsetools.deb "$BASE_URL/erlang-parsetools_${ERL_VERSION}_amd64.deb"
curl -L -o erlang-public-key.deb "$BASE_URL/erlang-public-key_${ERL_VERSION}_amd64.deb"
curl -L -o erlang-syntax-tools.deb "$BASE_URL/erlang-syntax-tools_${ERL_VERSION}_amd64.deb"
curl -L -o erlang-tools.deb "$BASE_URL/erlang-tools_${ERL_VERSION}_amd64.deb"

echo "Downloading Elixir package..."
curl -L -o elixir.deb https://deb.debian.org/debian/pool/main/e/elixir-lang/elixir_1.18.3.dfsg-1_amd64.deb

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
