#!/bin/sh
set -e
echo "=== terraform Sandbox Setup ==="
rm -rf /opt/terraform
mkdir -p /opt/terraform/bin

echo "Downloading Terraform zip archive..."
curl -L -o /tmp/terraform.zip https://releases.hashicorp.com/terraform/1.10.5/terraform_1.10.5_linux_amd64.zip

echo "Extracting Terraform binary..."
if command -v unzip >/dev/null 2>&1; then
    unzip -q /tmp/terraform.zip -d /opt/terraform/bin
else
    python3 -c "import zipfile; zipfile.ZipFile('/tmp/terraform.zip').extractall('/opt/terraform/bin')"
fi
rm -f /tmp/terraform.zip

echo "Making binary executable..."
chmod +x /opt/terraform/bin/terraform

echo "Setting permissions..."
if [ -n "$SUDO_UID" ] && [ -n "$SUDO_GID" ]; then
    chown -R "$SUDO_UID:$SUDO_GID" /opt/terraform
else
    chmod -R 777 /opt/terraform
fi

echo "=== terraform Sandbox Forged ==="
