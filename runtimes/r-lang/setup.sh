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

echo "Resolving Renviron configuration..."
if [ -f /opt/r-lang/usr/lib/R/etc/Renviron.ucf ] && [ ! -f /opt/r-lang/etc/R/Renviron ]; then
    mkdir -p /opt/r-lang/etc/R
    cp /opt/r-lang/usr/lib/R/etc/Renviron.ucf /opt/r-lang/etc/R/Renviron
fi

echo "Fixing R configuration symlinks..."
rm -f /opt/r-lang/usr/lib/R/etc/ldpaths
rm -f /opt/r-lang/usr/lib/R/etc/Makeconf
rm -f /opt/r-lang/usr/lib/R/etc/Renviron
rm -f /opt/r-lang/usr/lib/R/etc/Renviron.site
rm -f /opt/r-lang/usr/lib/R/etc/repositories
rm -f /opt/r-lang/usr/lib/R/etc/Rprofile.site

ln -sf /opt/r-lang/etc/R/ldpaths /opt/r-lang/usr/lib/R/etc/ldpaths
ln -sf /opt/r-lang/etc/R/Makeconf /opt/r-lang/usr/lib/R/etc/Makeconf
ln -sf /opt/r-lang/etc/R/Renviron /opt/r-lang/usr/lib/R/etc/Renviron
ln -sf /opt/r-lang/etc/R/Renviron.site /opt/r-lang/usr/lib/R/etc/Renviron.site
ln -sf /opt/r-lang/etc/R/repositories /opt/r-lang/usr/lib/R/etc/repositories
ln -sf /opt/r-lang/etc/R/Rprofile.site /opt/r-lang/usr/lib/R/etc/Rprofile.site

echo "Setting permissions..."
chmod -R 755 /opt/r-lang
if [ -n "$SUDO_UID" ] && [ -n "$SUDO_GID" ]; then
    chown -R "$SUDO_UID:$SUDO_GID" /opt/r-lang
fi

echo "=== r-runtime Sandbox Forged ==="
