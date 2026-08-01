#!/bin/sh
set -e
echo "=== n8n-workflow Sandbox Setup ==="

# Clean and create directories
rm -rf /opt/node /opt/n8n /opt/python-deps
mkdir -p /opt/node
mkdir -p /opt/n8n
mkdir -p /opt/python-deps

# 1. Download and extract Node.js v20.11.0
echo "Downloading Node.js v20.11.0..."
curl -L -o /tmp/node.tar.xz https://nodejs.org/dist/v20.11.0/node-v20.11.0-linux-x64.tar.xz
echo "Extracting Node.js..."
tar -C /opt/node --strip-components=1 -xJf /tmp/node.tar.xz
rm -f /tmp/node.tar.xz

# 2. Download and unpack setuptools wheel
echo "Downloading setuptools wheel..."
curl -L -o /tmp/setuptools.zip https://files.pythonhosted.org/packages/5d/40/e1e72872c6354b306daef1703549e8e83b4d43cfea356311bf722a043752/setuptools-83.0.0-py3-none-any.whl
echo "Unpacking setuptools build dependency..."
python3 -m zipfile -e /tmp/setuptools.zip /opt/python-deps
rm -f /tmp/setuptools.zip

# 3. Copy setuptools/_distutils to top-level distutils to make it directly importable
echo "Mapping distutils package..."
cp -r /opt/python-deps/setuptools/_distutils /opt/python-deps/distutils

# 4. Create python wrapper shims inside /opt/node/bin to inject PYTHONPATH
echo "Creating python wrappers..."
cat << 'EOF' > /opt/node/bin/python3
#!/bin/sh
export PYTHONPATH="/opt/python-deps"
exec /usr/bin/python3 "$@"
EOF
chmod +x /opt/node/bin/python3

cat << 'EOF' > /opt/node/bin/python
#!/bin/sh
export PYTHONPATH="/opt/python-deps"
exec /usr/bin/python3 "$@"
EOF
chmod +x /opt/node/bin/python

# 5. Install n8n globally using local Node toolchain with PYTHONPATH, PYTHON wrapper, and npm_config_python overrides
echo "Installing n8n globally..."
npm_config_python="/opt/node/bin/python3" PYTHON="/opt/node/bin/python3" PYTHONPATH="/opt/python-deps" PATH="/opt/node/bin:$PATH" /opt/node/bin/npm install -g n8n

# Setup proper permissions
echo "Setting permissions..."
chmod -R 755 /opt/node
chmod -R 777 /opt/n8n
chmod -R 755 /opt/python-deps

if [ -n "$SUDO_UID" ] && [ -n "$SUDO_GID" ]; then
    chown -R "$SUDO_UID:$SUDO_GID" /opt/node
    chown -R "$SUDO_UID:$SUDO_GID" /opt/n8n
    chown -R "$SUDO_UID:$SUDO_GID" /opt/python-deps
fi

echo "=== n8n-workflow Sandbox Forged ==="
