#!/bin/sh
set -e
echo "=== Gitea Runner Sandbox Provisioning ==="
mkdir -p /opt/gitea-runner
cd /opt/gitea-runner
if command -v wget >/dev/null 2>&1; then
    wget -O act_runner https://gitea.com/gitea/act_runner/releases/download/v0.2.6/act_runner-0.2.6-linux-amd64
else
    curl -L -o act_runner https://gitea.com/gitea/act_runner/releases/download/v0.2.6/act_runner-0.2.6-linux-amd64
fi
chmod +x act_runner

echo "Setting permissions..."
if [ -n "$SUDO_UID" ] && [ -n "$SUDO_GID" ]; then
    chown -R "$SUDO_UID:$SUDO_GID" /opt/gitea-runner
else
    chmod -R 777 /opt/gitea-runner
fi

echo "=== Gitea Runner Sandbox Forged ==="
