# 📦 Cluster Container Recipes

This repository contains sandboxed, self-contained, and compiler-forged container recipes designed natively for the **Cluster Container Engine (`clc` / `cl-container`)**.

These recipes provision lightweight guest root filesystems (rootfs) with private namespaces (Mount, PID, UTS, IPC), user boundaries, and memory constraints.

---

## 🛠️ Getting Started with CLI Commands

### 1. Install & Forge a Sandbox
Compile the isolated sandboxed environment and download the service dependencies:
```bash
sudo ./cl-container install <recipe-name>
```

### 2. Launch the Sandbox Process
Run the compiled container inside isolated kernel namespaces:
```bash
sudo ./cl-container run <recipe-name>
```

### 3. Stop the Sandbox
To stop any active service container running in the foreground, press:
```text
Ctrl + C
```
*The engine intercepts the SIGINT/SIGTERM signals, detaches all procfs/sysfs and bind mounts safely, and performs clean namespace reclamation.*

---

## 📋 Officially Verified & Available Recipes

The following recipes have been **100% tested, fixed, and verified** to run successfully inside the container engine:

| Recipe Name | Category | Primary Port | Isolation details | Status |
| :--- | :--- | :--- | :--- | :--- |
| **`gitea`** | Collaboration / Git | `3000` | Unprivileged (`alamgir-zk` user) | Verified ✓ |
| **`forgejo`** | Collaboration / Git | `3000` | Unprivileged (`alamgir-zk` user) | Verified ✓ |
| **`nginx`** | Reverse Proxy / Web | `8080` | Unprivileged (`nobody` user) | Verified ✓ |
| **`postgres`** | Database | `5432` | Relational database engine | Verified ✓ |
| **`mysql`** | Database | `3306` | Relational database (v8.4.10) with source-compiled `libaio` | Verified ✓ |
| **`mariadb`** | Database | `3306` | Relational database engine | Verified ✓ |
| **`redis`** | Database | `6379` | Key-value cache | Verified ✓ |
| **`mongodb`** | Database | `27017` | Document database | Verified ✓ |
| **`memcached`** | Database / Cache | `11211` | Statistically compiled libevent standalone | Verified ✓ |
| **`sqlite`** | Database | - | Compiled natively from official amalgamation | Verified ✓ |
| **`elasticsearch`** | Database / Search | `9200` | Search engine with single-node discovery heap limits | Verified ✓ |
| **`influxdb`** | Database / Time Series | `8086` | Time-series engine (v1.8.10) | Verified ✓ |
| **`cassandra`** | Database / NoSQL | `9042` | NoSQL database on JRE 17 with module-open overrides | Verified ✓ |
| **`neo4j`** | Database / Graph | `7687` (Bolt) / `7474` (HTTP) | Graph database on JDK 17 with double-fork PID procfs isolation | Verified ✓ |
| **`rabbitmq`** | Message Broker | `5672` (AMQP) / `15672` (Web) | Broker on Erlang 26 with guest home workspace cookie creation | Verified ✓ |
| **`kafka`** | Event Streaming | `9092` | KRaft standalone event streamer on JRE 17 | Verified ✓ |
| **`activemq`** | Message Broker | `61616` (JMS) / `8161` (Web) | Multi-protocol message broker on JRE 17 | Verified ✓ |
| **`clickhouse`** | Database | `8123` (HTTP) / `9000` (Native) | Columnar analytical database | Verified ✓ |
| **`prometheus`** | Monitoring | `9090` | Time-series system metrics monitor | Verified ✓ |
| **`grafana`** | Visualization | `3000` | Metric dashboard dashboard aggregator | Verified ✓ |
| **`caddy`** | Reverse Proxy / Web | `8080` | Ultra-lightweight reverse proxy with auto_https disabled | Verified ✓ |
| **`haproxy`** | Reverse Proxy / LB | `9000` | High-performance load balancer compiled natively from source | Verified ✓ |
| **`traefik`** | Reverse Proxy / Edge | `8000` (Web) / `8082` (Dashboard) | Edge proxy with dynamic configuration and dashboard enabled | Verified ✓ |
| **`zookeeper`** | Distributed Coordination | `2181` | ZooKeeper server running on self-contained JRE 17 | Verified ✓ |
| **`etcd`** | Distributed Coordination / KV | `2379` | Distributed consistent key-value store database | Verified ✓ |
| **`consul`** | Distributed Coordination / KV | `8500` | Consul service discovery store and mesh gateway | Verified ✓ |
| **`nats`** | Message Broker | `4222` | NATS high-performance pub/sub message broker | Verified ✓ |
| **`loki`** | Monitoring / Logs | `3100` | Log aggregation engine from Grafana | Verified ✓ |
| **`jenkins`** | CI/CD | `8085` | Automation build server running on self-contained JRE 17 | Verified ✓ |
| **`uptime-kuma`** | Monitoring / Status | `3001` | Self-hosted monitoring dashboard on self-contained Node.js 18 | Verified ✓ |
| **`apache`** | Web Servers / HTTP | `8080` | Apache HTTP Server with custom non-privileged port configuration | Verified ✓ |
| **`meilisearch`** | Database / Search | `7700` | Lightning-fast search engine running on self-contained binary | Verified ✓ |
| **`keydb`** | Database / Cache | `6379` | Multithreaded Redis fork with custom client credentials | Verified ✓ |
| **`couchdb`** | Database / NoSQL | `5984` | CouchDB document database with custom workspace logging and databases | Verified ✓ |
| **`netdata`** | Monitoring | `19999` | Real-time system monitoring dashboard on static standalone build | Verified ✓ |
| **`telegraf`** | Monitoring | - | Telegraf system metrics collector with basic active plugin configuration | Verified ✓ |
| **`varnish`** | Reverse Proxy / Cache | `6081` | Varnish Cache proxy utilizing self-contained Debian jemalloc | Verified ✓ |
| **`squid`** | Reverse Proxy / Proxy | `3128` | Squid caching proxy utilizing LD_PRELOAD mock for rootless execution | Verified ✓ |
| **`wordpress`** | Web Apps / CMS | `8080` | WordPress CMS utilizing self-contained PHP 8.4 runtime and MySQL drivers | Verified ✓ |
| **`nodered`** | Web Apps / Flow | `1880` | Node-RED flow builder running on self-contained Node.js v22.11.0 | Verified ✓ |
| **`python`** | Runtimes / Python | - | Python compiler and interpreter runtime environment | Verified ✓ |
| **`golang`** | Runtimes / Go | - | Go compiler and standard development tools | Verified ✓ |
| **`rust`** | Runtimes / Rust | - | Rust compiler toolchain and cargo package manager | Verified ✓ |
| **`nodejs`** | Runtimes / JS | - | Node.js JavaScript runtime engine (v18.16.1) | Verified ✓ |
| **`bind9`** | Reverse Proxy / DNS | `1053` | BIND9 DNS caching proxy running rootlessly on custom port | Verified ✓ |
| **`dnsmasq`** | Reverse Proxy / DNS | `1053` | Dnsmasq DNS server with query logging to stderr | Verified ✓ |
| **`fluentbit`** | Monitoring / Agent | - | Fluent Bit log forwarder collecting CPU metrics | Verified ✓ |
| **`fluentd`** | Monitoring / Agent | `9880` | Fluentd log agent collecting HTTP traffic and writing to stdout | Verified ✓ |
| **`arangodb`** | Database / Graph | `8529` | ArangoDB multi-model NoSQL document and graph database | Verified ✓ |
| **`cockroachdb`** | Database / SQL | `26257` | CockroachDB cloud-native distributed SQL database in single-node mode | Verified ✓ |
| **`java`** | Runtimes / Java | - | Eclipse Temurin OpenJDK 17 JDK & JRE development environment | Verified ✓ |
| **`php`** | Runtimes / PHP | - | PHP 8.4 command-line interpreter runtime environment | Verified ✓ |
| **`ruby`** | Runtimes / Ruby | - | Ruby 3.3.8 command-line interpreter runtime environment | Verified ✓ |
| **`gcc-cpp`** | Runtimes / C++ | - | GNU C++ Compiler (g++) development environment | Verified ✓ |
| **`dotnet`** | Runtimes / .NET | - | Microsoft .NET 8.0 SDK compiler and runtime CLI | Verified ✓ |
| **`swift`** | Runtimes / Swift | - | Apple Swift 6.0.2 compiler and runtime CLI toolchain | Verified ✓ |
| **`perl`** | Runtimes / Perl | - | Perl 5.40.1 scripting language interpreter runtime environment | Verified ✓ |
| **`elixir`** | Runtimes / Elixir | - | Elixir 1.18.3 & Erlang OTP 27 compiler and interpreter runtime | Verified ✓ |
| **`kotlin`** | Runtimes / Kotlin | - | JetBrains Kotlin 2.0.21 JVM compiler (kotlinc) toolchain | Verified ✓ |
| **`scala`** | Runtimes / Scala | - | Scala 3.5.2 compiler (scalac) and runtime runner environment | Verified ✓ |
| **`drupal`** | Web Apps / CMS | `8080` | Drupal CMS running on PHP 8.4 runtime and SQLite database | Verified ✓ |
| **`joomla`** | Web Apps / CMS | `8080` | Joomla CMS running on PHP 8.4 runtime and SQLite database | Verified ✓ |
| **`nextcloud`** | Web Apps / Cloud | `8080` | Nextcloud collaboration suite running on rootless PHP 8.4 and SQLite | Verified ✓ |
| **`openvpn`** | VPN / Proxy | `1194` | OpenVPN secure tunneling server in static-key cipher mode | Verified ✓ |
| **`wireguard`** | VPN / Proxy | - | WireGuard userland administration utility (`wg`) | Verified ✓ |
| **`shadowsocks`** | VPN / Proxy | `8388` | Shadowsocks SOCKS5 secure proxy server with custom config | Verified ✓ |
| **`privoxy`** | VPN / Proxy | `8118` (or `--version`) | Privoxy ad-blocking web proxy running rootlessly | Verified ✓ |
| **`hugo`** | Static Site Generator | - | Hugo Extended static site compiler and server | Verified ✓ |
| **`gatsby`** | Static Site Generator | - | Gatsby CLI site generator running on self-contained Node.js v22 | Verified ✓ |
| **`ghost`** | Web Apps / CMS | `2368` | Ghost CMS blogging platform running on self-contained Node.js v22 and pnpm | Verified ✓ |
| **`git-client`** | CI/CD / Git | - | Git CLI client running rootlessly with host sharing | Verified ✓ |
| **`wget-cli`** | CI/CD / Utilities | - | GNU Wget CLI tool for fetching network resources | Verified ✓ |
| **`curl-cli`** | CI/CD / Utilities | - | Curl command line tool for transferring data with URLs | Verified ✓ |
| **`aws-cli`** | CI/CD / Cloud | - | AWS CLI v2 command-line tool for managing AWS services | Verified ✓ |
| **`gcloud-cli`** | CI/CD / Cloud | - | Google Cloud SDK CLI tool for managing GCP resources | Verified ✓ |
| **`kubectl`** | CI/CD / Containers | - | Kubernetes command-line tool for controlling clusters | Verified ✓ |
| **`terraform`** | CI/CD / IaC | - | HashiCorp Terraform CLI for infrastructure as code | Verified ✓ |
| **`ansible`** | CI/CD / Automation | - | Ansible IT automation engine running in rootless python venv | Verified ✓ |
| **`gitlab-runner`** | CI/CD / Runners | - | GitLab Runner service for executing GitLab CI/CD jobs | Verified ✓ |
| **`gitea-runner`** | CI/CD / Runners | - | Gitea Actions CI/CD runner execution binary (act_runner) | Verified ✓ |
| **`gitea-act`** | CI/CD / Runners | - | Act runner for Gitea Actions local runner execution | Verified ✓ |
| **`typesense`** | Database / Search | `8108` | Singly-searchable typosensitive search engine | Verified ✓ |
| **`scylladb`** | Database / NoSQL | `9042` | ScyllaDB NoSQL engine compatible with Apache Cassandra | Verified ✓ |
| **`mqtt`** | Message Broker | `1883` | Mosquitto MQTT message broker SAPI | Verified ✓ |
| **`rethinkdb`** | Database / NoSQL | `28015` | RethinkDB real-time JSON document database | Verified ✓ |
| **`roundcube`** | Web Apps / Collaboration | `8080` | Roundcube webmail client running on static FrankenPHP SAPI | Verified ✓ |
| **`freshrss`** | Web Apps / Reader | `8080` | FreshRSS self-hosted feed aggregator running on FrankenPHP | Verified ✓ |
| **`wekan`** | Web Apps / Collaboration | `8080` | Wekan Trello-like Kanban board running on Node.js and MongoDB | Verified ✓ |
| **`trilium`** | Web Apps / Notes | `8080` | Trilium Notes hierarchical note-taking app running on Node.js | Verified ✓ |
| **`mediawiki`** | Web Apps / Wiki | `8080` | MediaWiki wiki engine running on static FrankenPHP SAPI | Verified ✓ |

> [!NOTE]
> All other folders in this repository contain recipes that are currently unverified or undergoing sequencing tests. Do not attempt to run `install` or `run` on them yet.

---

## 🚀 Priority Releases Queue (Top 90 Complete)

We have successfully verified and released the top 90 most popular developer container environments! We will continue expansion to further milestones.
