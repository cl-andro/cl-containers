#!/bin/sh
set -e
echo "=== gcloud-cli Sandbox Setup ==="
rm -rf /opt/google-cloud-sdk
mkdir -p /opt

echo "Downloading Google Cloud CLI tarball..."
curl -L -o /tmp/gcloud.tar.gz https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-linux-x86_64.tar.gz

echo "Extracting Google Cloud CLI..."
tar -C /opt -xzf /tmp/gcloud.tar.gz
rm -f /tmp/gcloud.tar.gz

echo "Running Google Cloud CLI installer..."
/opt/google-cloud-sdk/install.sh --quiet --path-update false --command-completion false

echo "Setting permissions..."
if [ -n "$SUDO_UID" ] && [ -n "$SUDO_GID" ]; then
    chown -R "$SUDO_UID:$SUDO_GID" /opt/google-cloud-sdk
else
    chmod -R 777 /opt/google-cloud-sdk
fi

echo "=== gcloud-cli Sandbox Forged ==="
