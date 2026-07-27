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
echo "=== Gitea Runner Sandbox Forged ==="
