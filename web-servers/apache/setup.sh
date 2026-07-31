#!/bin/sh
set -e
echo "=== Apache Sandbox Provisioning (Self-Contained Build) ==="

# 1. Prepare build directories
mkdir -p /tmp/pcre-build
mkdir -p /tmp/httpd-build

# 2. Download and extract PCRE dependency
echo "Downloading PCRE..."
curl -L -o /tmp/pcre.tar.gz https://sourceforge.net/projects/pcre/files/pcre/8.45/pcre-8.45.tar.gz/download
tar -xzf /tmp/pcre.tar.gz -C /tmp/pcre-build --strip-components=1

# Compile PCRE
echo "Compiling PCRE..."
cd /tmp/pcre-build
./configure --prefix=/opt/pcre --disable-shared --enable-static
make -j2
make install

# Compile Expat dependency
echo "Downloading Expat..."
mkdir -p /tmp/expat-build
curl -L -o /tmp/expat.tar.gz https://github.com/libexpat/libexpat/releases/download/R_2_5_0/expat-2.5.0.tar.gz
tar -xzf /tmp/expat.tar.gz -C /tmp/expat-build --strip-components=1
echo "Compiling Expat..."
cd /tmp/expat-build
./configure --prefix=/opt/expat --disable-shared --enable-static CFLAGS="-fPIC" CXXFLAGS="-fPIC"
make -j2
make install

# 3. Download and extract HTTPD, APR, and APR-Util
echo "Downloading Apache HTTPD, APR, and APR-Util..."
curl -L -o /tmp/httpd.tar.gz https://archive.apache.org/dist/httpd/httpd-2.4.58.tar.gz
curl -L -o /tmp/apr.tar.gz https://archive.apache.org/dist/apr/apr-1.7.4.tar.gz
curl -L -o /tmp/apr-util.tar.gz https://archive.apache.org/dist/apr/apr-util-1.6.3.tar.gz

tar -xzf /tmp/httpd.tar.gz -C /tmp/httpd-build --strip-components=1

mkdir -p /tmp/httpd-build/srclib/apr
tar -xzf /tmp/apr.tar.gz -C /tmp/httpd-build/srclib/apr --strip-components=1

mkdir -p /tmp/httpd-build/srclib/apr-util
tar -xzf /tmp/apr-util.tar.gz -C /tmp/httpd-build/srclib/apr-util --strip-components=1

# Add compiled PCRE to PATH so configure script can execute pcre-config
export PATH=/opt/pcre/bin:$PATH

# 4. Compile Apache HTTPD
echo "Compiling Apache HTTPD..."
cd /tmp/httpd-build
./configure --prefix=/opt/apache \
            --with-included-apr \
            --with-pcre=/opt/pcre \
            --with-expat=/opt/expat \
            --enable-mods-shared=all \
            --enable-mpms-shared=all
make -j2
make install

# 5. Clean up build files
echo "Cleaning up build files..."
rm -rf /tmp/pcre-build /tmp/expat-build /tmp/httpd-build /tmp/pcre.tar.gz /tmp/expat.tar.gz /tmp/httpd.tar.gz /tmp/apr.tar.gz /tmp/apr-util.tar.gz

# 6. Configure Apache HTTPD to run on port 8080 as unprivileged user
echo "Configuring Apache HTTPD..."
HTTPD_CONF="/opt/apache/conf/httpd.conf"
if [ -f "$HTTPD_CONF" ]; then
    # Listen on port 8080 instead of 80
    sed -i 's/Listen 80/Listen 8080/g' "$HTTPD_CONF"
fi

# Ensure log directory is world-writable so daemon user (mapping to nobody outside) can write to it
chmod 777 /opt/apache/logs

echo "=== Apache Sandbox Forged ==="
