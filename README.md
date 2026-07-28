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

> [!NOTE]
> All other folders in this repository contain recipes that are currently unverified or undergoing sequencing tests. Do not attempt to run `install` or `run` on them yet.

---

## 🚀 Priority Releases Queue (Top 20)

We are actively validating the top 20 most popular developer containers. The remaining message brokers and monitoring tools undergoing sequence verification are:

16. **`kafka`** *(Event Streaming)*
17. **`activemq`** *(Message Broker)*
18. **`clickhouse`** *(Analytics Database)*
19. **`prometheus`** *(Metrics & Monitoring)*
20. **`grafana`** *(Visualization)*
