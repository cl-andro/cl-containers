#!/bin/sh
set -e
echo "=== zipkin-tracer Sandbox Setup ==="
mkdir -p /opt/zipkin
cd /opt/zipkin
if command -v wget >/dev/null 2>&1; then
    wget -O zipkin.jar https://search.maven.org/remote_content?g=io.zipkin&a=zipkin-server&v=LATEST&c=exec
else
    curl -L -o zipkin.jar https://search.maven.org/remote_content?g=io.zipkin&a=zipkin-server&v=LATEST&c=exec
fi

echo "=== zipkin-tracer Sandbox Forged ==="
