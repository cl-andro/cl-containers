#!/bin/sh
set -e

echo "=== Gitea Sandbox Provisioning & Installation ==="

# 1. Create directory structures
mkdir -p /opt/gitea
mkdir -p /opt/gitea/data
mkdir -p /opt/gitea/custom/conf

# 2. Download pre-built Gitea binary
echo "Downloading Gitea release binary..."
if command -v wget >/dev/null 2>&1; then
    wget -O /opt/gitea/gitea "https://dl.gitea.com/gitea/1.22.0/gitea-1.22.0-linux-amd64"
else
    curl -L -o /opt/gitea/gitea "https://dl.gitea.com/gitea/1.22.0/gitea-1.22.0-linux-amd64"
fi

chmod +x /opt/gitea/gitea
echo "✓ Gitea binary installed successfully."

# 3. Create default minimal configuration (SQLite)
cat <<EOF > /opt/gitea/custom/conf/app.ini
RUN_USER = ${INVOKING_USER:-root}

[database]
DB_TYPE = sqlite3
PATH = /opt/gitea/data/gitea.db

[server]
PROTOCOL = http
DOMAIN = localhost
HTTP_PORT = 3000
ROOT_URL = http://localhost:3000/
DISABLE_SSH = true

[security]
INSTALL_LOCK = true
EOF

echo "✓ Default config written to app.ini."
echo "=== Forging Complete ==="
