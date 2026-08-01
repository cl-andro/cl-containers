#!/bin/sh
set -e
echo "=== gitlab-runner Sandbox Setup ==="
rm -rf /opt/gitlab-runner
mkdir -p /opt/gitlab-runner/bin

echo "Downloading gitlab-runner standalone binary..."
curl -L -o /opt/gitlab-runner/bin/gitlab-runner https://s3.dualstack.us-east-1.amazonaws.com/gitlab-runner-downloads/latest/binaries/gitlab-runner-linux-amd64

echo "Making binary executable..."
chmod +x /opt/gitlab-runner/bin/gitlab-runner

echo "Setting permissions..."
if [ -n "$SUDO_UID" ] && [ -n "$SUDO_GID" ]; then
    chown -R "$SUDO_UID:$SUDO_GID" /opt/gitlab-runner
else
    chmod -R 777 /opt/gitlab-runner
fi

echo "=== gitlab-runner Sandbox Forged ==="
