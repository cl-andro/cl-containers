#!/bin/sh
set -e
echo "=== loki-collector Sandbox Setup ==="
mkdir -p /opt/loki
cd /opt/loki
if command -v wget >/dev/null 2>&1; then
    wget -O loki.zip https://github.com/grafana/loki/releases/download/v2.8.2/loki-linux-amd64.zip
    wget https://raw.githubusercontent.com/grafana/loki/main/cmd/loki/loki-local-config.yaml
else
    curl -L -o loki.zip https://github.com/grafana/loki/releases/download/v2.8.2/loki-linux-amd64.zip
    curl -O https://raw.githubusercontent.com/grafana/loki/main/cmd/loki/loki-local-config.yaml
fi
unzip loki.zip
mv loki-linux-amd64 loki
chmod +x loki
rm -f loki.zip

# 2. Create persistent data directories
mkdir -p /var/lib/loki

# 3. Create local configuration file
mkdir -p /etc/loki
cat <<EOF > /etc/loki/loki.yaml
auth_enabled: false

server:
  http_listen_port: 3100
  grpc_listen_port: 9096

common:
  instance_addr: 127.0.0.1
  path_prefix: /var/lib/loki
  storage:
    filesystem:
      chunks_directory: /var/lib/loki/chunks
      rules_directory: /var/lib/loki/rules
  replication_factor: 1
  ring:
    kvstore:
      store: inmemory

query_range:
  results_cache:
    cache:
      embedded_collector:
        store: inmemory

schema_config:
  configs:
    - from: 2020-10-24
      store: boltdb-shipper
      object_store: filesystem
      schema: v11
      index:
        prefix: index_
        period: 24h
EOF

echo "=== loki-collector Sandbox Forged ==="
