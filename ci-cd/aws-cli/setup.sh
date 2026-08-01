#!/bin/sh
set -e
echo "=== aws-cli Sandbox Setup ==="
mkdir -p /opt/aws-cli
mkdir -p /tmp/aws_extract
cd /tmp/aws_extract

echo "Downloading AWS CLI v2 zip..."
curl -L -o aws.zip https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip

echo "Extracting zip archive..."
if command -v unzip >/dev/null 2>&1; then
    unzip -q aws.zip
else
    python3 -c "import zipfile; zipfile.ZipFile('aws.zip').extractall('.')"
fi

echo "Running AWS CLI installer..."
./aws/install -i /opt/aws-cli -b /opt/aws-cli/bin

# Clean up temp folder
cd /
rm -rf /tmp/aws_extract

echo "Setting permissions..."
if [ -n "$SUDO_UID" ] && [ -n "$SUDO_GID" ]; then
    chown -R "$SUDO_UID:$SUDO_GID" /opt/aws-cli
else
    chmod -R 777 /opt/aws-cli
fi

echo "=== aws-cli Sandbox Forged ==="
