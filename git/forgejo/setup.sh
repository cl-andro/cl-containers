#!/bin/sh
set -e
echo "=== Forgejo Sandbox Provisioning & Installation ==="

mkdir -p /opt/forgejo/custom/conf
mkdir -p /opt/forgejo/data
mkdir -p /opt/forgejo/log

cd /opt/forgejo

# Download Forgejo binary
echo "Downloading Forgejo release binary..."
if command -v wget >/dev/null 2>&1; then
    wget -O forgejo https://codeberg.org/forgejo/forgejo/releases/download/v8.0.0/forgejo-8.0.0-linux-amd64
else
    curl -L -o forgejo https://codeberg.org/forgejo/forgejo/releases/download/v8.0.0/forgejo-8.0.0-linux-amd64
fi

chmod +x forgejo
echo "✓ Forgejo binary installed successfully."

# Create default config
cat <<EOF > custom/conf/app.ini
RUN_USER = ${INVOKING_USER:-root}

[database]
DB_TYPE = sqlite3
PATH = /opt/forgejo/data/forgejo.db

[server]
SSH_PORT = 2222
HTTP_PORT = 3000
DISABLE_SSH = false
OFFLINE_MODE = true

[security]
INSTALL_LOCK = false
EOF

echo "✓ Default config written to app.ini."
echo "=== Forging Complete ==="
