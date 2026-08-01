#!/bin/sh
set -e
echo "=== r-runtime Sandbox Setup ==="
mkdir -p /opt/r-lang
mkdir -p /tmp/r_extract
cd /tmp/r_extract

echo "Downloading R core package..."
curl -L -o r-base-core.deb https://deb.debian.org/debian/pool/main/r/r-base/r-base-core_4.5.0-3_amd64.deb

echo "Extracting package..."
dpkg-deb -x r-base-core.deb /opt/r-lang/
rm -f r-base-core.deb

echo "Cleaning up temporary downloads..."
cd /
rm -rf /tmp/r_extract

echo "Patching R home and config paths..."
if [ -f /opt/r-lang/usr/bin/R ]; then
    sed -i 's|R_HOME_DIR=/usr/lib/R|R_HOME_DIR=/opt/r-lang/usr/lib/R|g' /opt/r-lang/usr/bin/R
    sed -i 's|R_SHARE_DIR=/usr/share/R/share|R_SHARE_DIR=/opt/r-lang/usr/share/R/share|g' /opt/r-lang/usr/bin/R
    sed -i 's|R_DOC_DIR=/usr/share/R/doc|R_DOC_DIR=/opt/r-lang/usr/share/R/doc|g' /opt/r-lang/usr/bin/R
fi

if [ -f /opt/r-lang/usr/lib/R/bin/R ]; then
    sed -i 's|R_HOME_DIR=/usr/lib/R|R_HOME_DIR=/opt/r-lang/usr/lib/R|g' /opt/r-lang/usr/lib/R/bin/R
    sed -i 's|R_SHARE_DIR=/usr/share/R/share|R_SHARE_DIR=/opt/r-lang/usr/share/R/share|g' /opt/r-lang/usr/lib/R/bin/R
    sed -i 's|R_DOC_DIR=/usr/share/R/doc|R_DOC_DIR=/opt/r-lang/usr/share/R/doc|g' /opt/r-lang/usr/lib/R/bin/R
fi

if [ -f /opt/r-lang/usr/lib/R/etc/ldpaths ]; then
    sed -i 's|/usr/lib/R|/opt/r-lang/usr/lib/R|g' /opt/r-lang/usr/lib/R/etc/ldpaths
fi

echo "Setting permissions..."
if [ -n "$SUDO_UID" ] && [ -n "$SUDO_GID" ]; then
    chown -R "$SUDO_UID:$SUDO_GID" /opt/r-lang
else
    chmod -R 777 /opt/r-lang
fi

echo "=== r-runtime Sandbox Forged ==="
