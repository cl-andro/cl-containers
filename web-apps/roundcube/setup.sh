#!/bin/sh
set -e
echo "=== roundcube-mail Sandbox Setup ==="

# Clean and create directories
rm -rf /opt/php /opt/roundcube
mkdir -p /opt/php
mkdir -p /opt/roundcube
mkdir -p /opt/roundcube/db

# 1. Download and extract PMMP static PHP CLI binary
echo "Downloading static PHP CLI binary..."
curl -L -o /tmp/php.tar.gz https://github.com/pmmp/PHP-Binaries/releases/download/pm5-php-8.3-latest/PHP-8.3-Linux-x86_64-PM5.tar.gz
echo "Extracting PHP..."
tar -C /opt/php -xzf /tmp/php.tar.gz
rm -f /tmp/php.tar.gz

# 2. Download and extract Roundcube Complete package
echo "Downloading Roundcube complete package..."
curl -L -o /tmp/roundcube.tar.gz https://github.com/roundcube/roundcubemail/releases/download/1.6.6/roundcubemail-1.6.6-complete.tar.gz
echo "Extracting Roundcube..."
tar -C /opt/roundcube --strip-components=1 -xzf /tmp/roundcube.tar.gz
rm -f /tmp/roundcube.tar.gz

# 3. Configure Roundcube
echo "Configuring Roundcube..."
cp /opt/roundcube/config/config.inc.php.sample /opt/roundcube/config/config.inc.php
echo "\$config['db_dsnw'] = 'sqlite:////opt/roundcube/db/sqlite.db?mode=0666';" >> /opt/roundcube/config/config.inc.php
echo "\$config['des_key'] = 'rcmail-166-some-random-salt';" >> /opt/roundcube/config/config.inc.php

# 4. Initialize SQLite Database
echo "Initializing SQLite database..."
/opt/php/bin/php7/bin/php /opt/roundcube/bin/initdb.sh --update || echo "Database initialized (or skipped)"

# Setup proper permissions
echo "Setting permissions..."
chmod -R 777 /opt/php
chmod -R 777 /opt/roundcube

if [ -n "$SUDO_UID" ] && [ -n "$SUDO_GID" ]; then
    chown -R "$SUDO_UID:$SUDO_GID" /opt/php
    chown -R "$SUDO_UID:$SUDO_GID" /opt/roundcube
fi

echo "=== roundcube-mail Sandbox Forged ==="
