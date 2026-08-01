#!/bin/sh
set -e
echo "=== ansible Sandbox Setup ==="
rm -rf /opt/ansible
mkdir -p /opt/ansible

echo "Creating python virtual environment..."
python3 -m venv --without-pip /opt/ansible/venv

echo "Installing pip using bootstrap script..."
curl -sS https://bootstrap.pypa.io/get-pip.py -o /tmp/get-pip.py
/opt/ansible/venv/bin/python3 /tmp/get-pip.py
rm -f /tmp/get-pip.py

echo "Installing ansible-core via pip..."
/opt/ansible/venv/bin/pip install ansible-core

echo "Setting permissions..."
if [ -n "$SUDO_UID" ] && [ -n "$SUDO_GID" ]; then
    chown -R "$SUDO_UID:$SUDO_GID" /opt/ansible
else
    chmod -R 777 /opt/ansible
fi

echo "=== ansible Sandbox Forged ==="
