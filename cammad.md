# 📦 Cluster Container Operations & CLI Commands

This guide describes how to install, manage, and execute containerized services using the native **Cluster Container Engine (`clc`)**.

---

## 🛠️ CLI Operations

### 1. Install / Forge a Container Recipe
Download the configuration template and compile the isolated environment locally:
```bash
sudo ./cl-container install <recipe-name>
```
*Example (Install Nginx):*
```bash
sudo ./cl-container install nginx
```

### 2. Run a Forged Container Sandbox
Launch the isolated process in its namespaces:
```bash
sudo ./cl-container run <recipe-name>
```
*Example (Run Nginx):*
```bash
sudo ./cl-container run nginx
```

### 3. Stop a Container
To stop any active foreground container (like Nginx or Gitea), press:
```text
Ctrl + C
```
*The engine automatically intercepts the interrupt signal, performs lazy unmounting of all namespace files, and exits cleanly.*

---

## 📋 Available Recipes

| Recipe Name | Category | Service Port | Run Mode |
| :--- | :--- | :--- | :--- |
| **`gitea`** | `git` | `3000` | Unprivileged (`alamgir-zk` user) |
| **`forgejo`** | `git` | `3000` | Forgejo Git Server |
| **`nginx`** | `reverse-proxy` | `8080` | Unprivileged (`nobody` user) |
| **`postgres`** | `database` | `5432` | Postgres Database |
| **`mysql`** | `database` | `3306` | MySQL Database |
| **`mariadb`** | `database` | `3306` | MariaDB Database |
| **`redis`** | `database` | `6379` | Cache / Key-Value Store |
| **`mongodb`** | `database` | `27017` | NoSQL Database |
| **`memcached`** | `database` | `11211` | Memcached Cache Store |
| **`sqlite`** | `database` | - | SQLite DB Client CLI |
| **`elasticsearch`** | `database` | `9200` | Elasticsearch Engine |
| **`influxdb`** | `database` | `8086` | InfluxDB Time Series |
| **`cassandra`** | `database` | `9042` | Cassandra Database |
| **`neo4j`** | `database` | `7474` | Neo4j Graph Database |
| **`rabbitmq`** | `message-broker` | `5672` | RabbitMQ Message Queue |
| **`kafka`** | `message-broker` | `9092` | Apache Kafka Broker |
| **`activemq`** | `message-broker` | `61616` | Apache ActiveMQ Broker |
| **`clickhouse`** | `database` | `8123` | ClickHouse Analytics DB |
| **`prometheus`** | `monitoring` | `9090` | Time Series Monitor |
| **`grafana`** | `monitoring` | `3000` | Visualization Dashboard |
| **`caddy`** | `reverse-proxy` | `8080` | Caddy Web Server |
| **`haproxy`** | `reverse-proxy` | `9000` | HAProxy Load Balancer |
| **`traefik`** | `reverse-proxy` | `8000` | Traefik Edge Router |
| **`zookeeper`** | `coordination` | `2181` | ZooKeeper Server |
| **`etcd`** | `coordination` | `2379` | etcd Distributed Key-Value |
| **`consul`** | `coordination` | `8500` | Consul Service Registry |
| **`nats`** | `message-broker` | `4222` | NATS Messaging Server |
| **`loki`** | `monitoring` | `3100` | Grafana Loki Log Engine |
| **`jenkins`** | `ci-cd` | `8085` | Jenkins Automation Server |
| **`uptime-kuma`** | `monitoring` | `3001` | Uptime Kuma Monitor |
| **`apache`** | `web-servers` | `8080` | Apache HTTP Server |
| **`meilisearch`** | `database` | `7700` | Meilisearch Search Engine |
| **`keydb`** | `database` | `6379` | KeyDB Cache Store |
| **`couchdb`** | `database` | `5984` | CouchDB NoSQL Document Store |
| **`netdata`** | `monitoring` | `19999` | Netdata System Metrics Dashboard |
| **`telegraf`** | `monitoring` | - | Telegraf Metrics Gathering Agent |
| **`varnish`** | `reverse-proxy` | `6081` | Varnish Cache Proxy |
| **`squid`** | `reverse-proxy` | `3128` | Squid Caching Proxy Server |
| **`wordpress`** | `web-apps` | `8080` | WordPress CMS Application |
| **`nodered`** | `web-apps` | `1880` | Node-RED Flow Orchestrator |
| **`python`** | `runtimes` | - | Python Runtime Environment |
| **`golang`** | `runtimes` | - | Go Compiler Environment |
| **`rust`** | `runtimes` | - | Rust Compiler Toolchain & Cargo |
| **`nodejs`** | `runtimes` | - | Node.js Runtime Environment |
| **`bind9`** | `reverse-proxy` | `1053` | BIND9 DNS Caching Proxy |
| **`dnsmasq`** | `reverse-proxy` | `1053` | Dnsmasq DNS Server |
| **`fluentbit`** | `monitoring` | - | Fluent Bit Log Forwarder |
| **`fluentd`** | `monitoring` | `9880` | Fluentd Log Forwarder |
| **`arangodb`** | `database` | `8529` | ArangoDB Multi-model NoSQL DB |
| **`cockroachdb`** | `database` | `26257` | CockroachDB Distributed SQL DB |
| **`java`** | `runtimes` | - | Java JDK 17 Runtime Environment |
| **`php`** | `runtimes` | - | PHP 8.4 CLI Runtime |
| **`ruby`** | `runtimes` | - | Ruby 3.3.8 Runtime |
| **`gcc-cpp`** | `runtimes` | - | GNU C++ Compiler (g++) |
| **`dotnet`** | `runtimes` | - | Microsoft .NET 8.0 SDK |
| **`swift`** | `runtimes` | - | Swift 6.0.2 Compiler Toolchain |
| **`perl`** | `runtimes` | - | Perl 5.40.1 scripting language |
| **`elixir`** | `runtimes` | - | Elixir 1.18.3 & Erlang OTP 27 |
| **`kotlin`** | `runtimes` | - | Kotlin 2.0.21 JVM Compiler |
| **`scala`** | `runtimes` | - | Scala 3.5.2 Compiler & Runner |
