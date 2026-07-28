#!/bin/sh
set -e
echo "=== RabbitMQ Sandbox Provisioning (Self-Contained) ==="

# 1. Download and extract Erlang 26.2.5.20 (glibc variant)
mkdir -p /opt/erlang
cd /opt/erlang
echo "Downloading precompiled Erlang/OTP..."
if command -v wget >/dev/null 2>&1; then
    wget -O erlang.tar.gz https://github.com/gleam-community/erlang-linux-builds/releases/download/OTP-26.2.5.20/erlang-26.2.5.20-x64-glibc.tar.gz
else
    curl -L -o erlang.tar.gz https://github.com/gleam-community/erlang-linux-builds/releases/download/OTP-26.2.5.20/erlang-26.2.5.20-x64-glibc.tar.gz
fi
tar -xzf erlang.tar.gz
rm -f erlang.tar.gz

# 2. Download and extract RabbitMQ 3.13.7
mkdir -p /opt/rabbitmq
cd /opt/rabbitmq
echo "Downloading RabbitMQ Server..."
if command -v wget >/dev/null 2>&1; then
    wget -O rabbitmq.tar.xz https://github.com/rabbitmq/rabbitmq-server/releases/download/v3.13.7/rabbitmq-server-generic-unix-3.13.7.tar.xz
else
    curl -L -o rabbitmq.tar.xz https://github.com/rabbitmq/rabbitmq-server/releases/download/v3.13.7/rabbitmq-server-generic-unix-3.13.7.tar.xz
fi
tar -xJf rabbitmq.tar.xz --strip-components=1
rm -f rabbitmq.tar.xz

# Create user home directory inside the guest to allow writing .erlang.cookie
if [ -n "$INVOKING_USER" ] && [ "$INVOKING_USER" != "root" ]; then
    mkdir -p "/home/$INVOKING_USER"
    chown "$INVOKING_USER" "/home/$INVOKING_USER"
fi

# Create RabbitMQ data and log directories
mkdir -p /var/lib/rabbitmq
mkdir -p /var/log/rabbitmq
mkdir -p /etc/rabbitmq

# Enable Management Plugin
echo "Enabling RabbitMQ Management Plugin..."
PATH=/opt/erlang/bin:$PATH /opt/rabbitmq/sbin/rabbitmq-plugins enable rabbitmq_management

echo "=== rabbitmq-broker Sandbox Forged ==="
