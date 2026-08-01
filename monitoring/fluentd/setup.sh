#!/bin/sh
set -e
echo "=== fluentd-agent Sandbox Setup ==="
mkdir -p /etc/fluentd
mkdir -p /var/log/fluent

echo "Downloading Fluent Package (Fluentd)..."
curl -L -o /tmp/fluent-package.deb https://fluentd.cdn.cncf.io/5/debian/bookworm/pool/contrib/f/fluent-package/fluent-package_5.2.0-1_amd64.deb

echo "Extracting package to guest root..."
mkdir -p /tmp/fluent_extract
dpkg-deb -x /tmp/fluent-package.deb /tmp/fluent_extract
cp -r /tmp/fluent_extract/opt/* /opt/
rm -rf /tmp/fluent-package.deb /tmp/fluent_extract

echo "Creating custom sandbox-friendly Fluentd configuration..."
cat << 'EOF' > /etc/fluentd/fluent.conf
<source>
  @type http
  port 9880
  bind 0.0.0.0
</source>

<match **>
  @type stdout
</match>
EOF

echo "Setting permissions..."
if [ -n "$SUDO_UID" ] && [ -n "$SUDO_GID" ]; then
    chown -R "$SUDO_UID:$SUDO_GID" /opt/fluent /etc/fluentd /var/log/fluent
else
    chmod -R 777 /opt/fluent /etc/fluentd /var/log/fluent
fi

echo "=== fluentd-agent Sandbox Forged ==="
