#!/bin/sh
set -e
echo "=== drupal-app Sandbox Setup ==="
mkdir -p /opt/drupal
cd /opt/drupal
if command -v wget >/dev/null 2>&1; then
    wget -O drupal.tar.gz https://www.drupal.org/download-latest/tar.gz
else
    curl -L -o drupal.tar.gz https://www.drupal.org/download-latest/tar.gz
fi
tar -xzf drupal.tar.gz --strip-components=1
rm -f drupal.tar.gz

echo "=== drupal-app Sandbox Forged ==="
