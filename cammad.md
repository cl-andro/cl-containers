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
| **`nginx`** | `reverse-proxy` | `8080` | Unprivileged (`nobody` user) |
| **`postgres`** | `database` | `5432` | Postgres Database |
| **`redis`** | `database` | `6379` | Cache / Key-Value Store |
| **`mongodb`** | `database` | `27017` | NoSQL Database |
| **`prometheus`**| `monitoring` | `9090` | Time Series Monitor |
| **`grafana`** | `monitoring` | `3000` | Visualization Dashboard |
| **`jenkins`** | `ci-cd` | `8080` | Jenkins Automation Server |
| **`nodejs`** | `runtimes` | - | Node.js Runtime Environment |
| **`python`** | `runtimes` | - | Python Runtime Environment |
| **`golang`** | `runtimes` | - | Go Compiler Environment |
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
