#!/bin/sh
set -e
echo "=== jaeger-tracer Sandbox Setup ==="
mkdir -p /opt/jaeger
cd /opt/jaeger
if command -v wget >/dev/null 2>&1; then
    wget -O jaeger.tar.gz https://github.com/jaegertracing/jaeger/releases/download/v1.46.0/jaeger-1.46.0-linux-amd64.tar.gz
else
    curl -L -o jaeger.tar.gz https://github.com/jaegertracing/jaeger/releases/download/v1.46.0/jaeger-1.46.0-linux-amd64.tar.gz
fi
tar -xzf jaeger.tar.gz --strip-components=1
rm -f jaeger.tar.gz

echo "=== jaeger-tracer Sandbox Forged ==="
