#!/bin/sh
set -e
echo "=== ansible Sandbox Setup ==="
rm -rf /opt/ansible
mkdir -p /opt/ansible

echo "Creating python virtual environment..."
python3 -m venv /opt/ansible/venv

echo "Upgrading pip inside venv..."
/opt/ansible/venv/bin/pip install --upgrade pip

echo "Installing ansible-core via pip..."
/opt/ansible/venv/bin/pip install ansible-core

echo "Setting permissions..."
if [ -n "$SUDO_UID" ] && [ -n "$SUDO_GID" ]; then
    chown -R "$SUDO_UID:$SUDO_GID" /opt/ansible
else
    chmod -R 777 /opt/ansible
fi

echo "=== ansible Sandbox Forged ==="
