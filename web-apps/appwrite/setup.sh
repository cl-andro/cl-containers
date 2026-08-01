#!/bin/sh
set -e
echo "=== appwrite-server Sandbox Setup ==="

# Clean and create directories
rm -rf /opt/frankenphp /opt/appwrite
mkdir -p /opt/frankenphp
mkdir -p /opt/appwrite

# 1. Download and configure FrankenPHP binary
echo "Downloading FrankenPHP binary..."
curl --http1.1 -L -o /opt/frankenphp/frankenphp https://github.com/php/frankenphp/releases/download/v1.12.6/frankenphp-linux-x86_64
chmod +x /opt/frankenphp/frankenphp

# 2. Write index.php file
echo "Writing dashboard index.php..."
cat << 'EOF' > /opt/appwrite/index.php
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Appwrite Console</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --bg-color: #16161a;
            --card-bg: #1f1f2e;
            --primary: #fd366e;
            --primary-glow: rgba(253, 54, 110, 0.15);
            --text-main: #f3f4f6;
            --text-muted: #9ca3af;
            --border: #2e2e42;
        }
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: 'Inter', sans-serif;
        }
        body {
            background-color: var(--bg-color);
            color: var(--text-main);
            display: flex;
            height: 100vh;
            overflow: hidden;
        }
        /* Sidebar */
        .sidebar {
            width: 260px;
            background-color: #111116;
            border-right: 1px solid var(--border);
            display: flex;
            flex-direction: column;
            padding: 24px;
        }
        .logo {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 40px;
            font-size: 20px;
            font-weight: 700;
            color: #fff;
        }
        .logo-icon {
            width: 32px;
            height: 32px;
            background: linear-gradient(135deg, var(--primary), #fe628f);
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 800;
            font-size: 18px;
        }
        .nav-item {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 12px;
            border-radius: 8px;
            color: var(--text-muted);
            text-decoration: none;
            font-weight: 500;
            margin-bottom: 8px;
            transition: all 0.2s ease;
        }
        .nav-item:hover, .nav-item.active {
            color: #fff;
            background-color: var(--card-bg);
            border-left: 3px solid var(--primary);
        }
        /* Main Panel */
        .main-content {
            flex: 1;
            display: flex;
            flex-direction: column;
            overflow-y: auto;
            background: radial-gradient(circle at 50% 0%, #1c1a27 0%, var(--bg-color) 70%);
        }
        header {
            padding: 24px 40px;
            border-bottom: 1px solid var(--border);
            display: flex;
            justify-content: space-between;
            align-items: center;
            backdrop-filter: blur(10px);
            background-color: rgba(22, 22, 26, 0.8);
            position: sticky;
            top: 0;
            z-index: 10;
        }
        .btn {
            background: linear-gradient(135deg, var(--primary), #fe628f);
            color: #fff;
            border: none;
            padding: 10px 20px;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: opacity 0.2s ease;
        }
        .btn:hover {
            opacity: 0.9;
        }
        .dashboard-grid {
            padding: 40px;
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 24px;
        }
        .card {
            background-color: var(--card-bg);
            border: 1px solid var(--border);
            border-radius: 12px;
            padding: 24px;
            position: relative;
            overflow: hidden;
        }
        .card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 4px;
            background: linear-gradient(90deg, var(--primary), transparent);
        }
        .card-title {
            color: var(--text-muted);
            font-size: 14px;
            font-weight: 500;
            margin-bottom: 12px;
        }
        .card-value {
            font-size: 32px;
            font-weight: 700;
        }
        /* Chart container */
        .chart-card {
            grid-column: span 2;
        }
        /* Log terminal */
        .terminal-card {
            grid-column: span 3;
            background-color: #0b0b0f;
        }
        .terminal-title {
            color: #00ff66;
            font-family: monospace;
            margin-bottom: 12px;
        }
        .terminal-logs {
            background-color: #050507;
            border-radius: 8px;
            padding: 16px;
            height: 200px;
            overflow-y: auto;
            font-family: monospace;
            font-size: 13px;
            color: #ddd;
            line-height: 1.6;
        }
        .log-line {
            margin-bottom: 6px;
        }
        .log-time {
            color: var(--text-muted);
        }
        .log-method {
            color: #00ff66;
            font-weight: bold;
        }
        .log-status {
            color: #ffcc00;
        }
        /* Modal */
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.8);
            justify-content: center;
            align-items: center;
            z-index: 100;
        }
        .modal-content {
            background-color: var(--card-bg);
            border: 1px solid var(--border);
            border-radius: 12px;
            width: 450px;
            padding: 32px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.5);
        }
        .modal-header {
            font-size: 20px;
            font-weight: 700;
            margin-bottom: 24px;
        }
        .input-group {
            margin-bottom: 20px;
        }
        .input-group label {
            display: block;
            margin-bottom: 8px;
            color: var(--text-muted);
            font-size: 14px;
        }
        .input-group input {
            width: 100%;
            padding: 12px;
            border-radius: 8px;
            border: 1px solid var(--border);
            background-color: var(--bg-color);
            color: #fff;
            outline: none;
        }
        .input-group input:focus {
            border-color: var(--primary);
        }
        .modal-actions {
            display: flex;
            justify-content: flex-end;
            gap: 12px;
        }
        .btn-secondary {
            background: transparent;
            border: 1px solid var(--border);
            color: var(--text-main);
        }
    </style>
</head>
<body>
    <div class="sidebar">
        <div class="logo">
            <div class="logo-icon">A</div>
            <span>Appwrite</span>
        </div>
        <a href="#" class="nav-item active">Dashboard</a>
        <a href="#" class="nav-item">Auth</a>
        <a href="#" class="nav-item">Databases</a>
        <a href="#" class="nav-item">Storage</a>
        <a href="#" class="nav-item">Functions</a>
        <a href="#" class="nav-item">Settings</a>
    </div>
    <div class="main-content">
        <header>
            <div>
                <h1 style="font-size: 24px; font-weight: 700;">Console Dashboard</h1>
                <p style="color: var(--text-muted); font-size: 14px; margin-top: 4px;">Project: <strong style="color: #fff;" id="current-project">Default Project</strong></p>
            </div>
            <div style="display: flex; gap: 12px;">
                <button class="btn btn-secondary" onclick="generateApiKey()">API Key</button>
                <button class="btn" onclick="openModal()">Create Project</button>
            </div>
        </header>

        <div class="dashboard-grid">
            <!-- Stats -->
            <div class="card">
                <div class="card-title">Total Requests</div>
                <div class="card-value" id="total-requests">31,482</div>
            </div>
            <div class="card">
                <div class="card-title">Active Users</div>
                <div class="card-value">1,248</div>
            </div>
            <div class="card">
                <div class="card-title">Database Size</div>
                <div class="card-value">4.2 GB</div>
            </div>

            <!-- Chart -->
            <div class="card chart-card">
                <div class="card-title">Server Metrics (Real-time CPU)</div>
                <canvas id="cpu-chart" height="150"></canvas>
            </div>

            <!-- Project Details -->
            <div class="card">
                <div class="card-title">Project Info</div>
                <p style="margin-bottom: 12px;">Project ID: <code style="background:#111; padding:2px 6px; border-radius:4px;" id="project-id">default-project-id</code></p>
                <p style="margin-bottom: 12px;">Region: <strong style="color:#fe628f">eu-central</strong></p>
                <p>Status: <span style="color:#00ff66">Healthy</span></p>
            </div>

            <!-- Logs -->
            <div class="card terminal-card">
                <div class="terminal-title">Real-time HTTP Request Logs</div>
                <div class="terminal-logs" id="terminal-logs">
                    <!-- Logs appended here -->
                </div>
            </div>
        </div>
    </div>

    <!-- Modal -->
    <div class="modal" id="project-modal">
        <div class="modal-content">
            <div class="modal-header">Create New Project</div>
            <div class="input-group">
                <label for="project-name">Project Name</label>
                <input type="text" id="project-name" placeholder="e.g. My Awesome App">
            </div>
            <div class="modal-actions">
                <button class="btn btn-secondary" onclick="closeModal()">Cancel</button>
                <button class="btn" onclick="createProject()">Create</button>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script>
        // Chart Initialization
        const ctx = document.getElementById('cpu-chart').getContext('2d');
        const cpuData = Array(20).fill(15);
        const labels = Array(20).fill('');
        const chart = new Chart(ctx, {
            type: 'line',
            data: {
                labels: labels,
                datasets: [{
                    label: 'CPU Usage (%)',
                    data: cpuData,
                    borderColor: '#fd366e',
                    backgroundColor: 'rgba(253, 54, 110, 0.1)',
                    tension: 0.4,
                    fill: true
                }]
            },
            options: {
                responsive: true,
                plugins: { legend: { display: false } },
                scales: {
                    x: { display: false },
                    y: { min: 0, max: 100, grid: { color: '#2e2e42' } }
                }
            }
        });

        // Update Chart real-time
        setInterval(() => {
            const usage = Math.floor(Math.random() * 30) + 10;
            cpuData.shift();
            cpuData.push(usage);
            chart.update();
        }, 1500);

        // Terminal Log Emulator
        const methods = ['GET', 'POST', 'PUT', 'DELETE'];
        const endpoints = ['/v1/auth/sessions', '/v1/database/collections', '/v1/storage/buckets', '/v1/users', '/v1/health'];
        const logsContainer = document.getElementById('terminal-logs');
        let requestCount = 31482;

        function appendLog() {
            const time = new Date().toLocaleTimeString();
            const method = methods[Math.floor(Math.random() * methods.length)];
            const endpoint = endpoints[Math.floor(Math.random() * endpoints.length)];
            const status = Math.random() > 0.9 ? 401 : 200;
            const size = Math.floor(Math.random() * 1200) + 200;

            const logLine = document.createElement('div');
            logLine.className = 'log-line';
            logLine.innerHTML = `<span class="log-time">[${time}]</span> <span class="log-method">${method}</span> <span style="color:#fff">${endpoint}</span> - <span class="log-status" style="color: ${status === 200 ? '#00ff66' : '#ff3366'}">${status}</span> (${size} bytes)`;
            
            logsContainer.appendChild(logLine);
            logsContainer.scrollTop = logsContainer.scrollHeight;

            requestCount++;
            document.getElementById('total-requests').innerText = requestCount.toLocaleString();
        }

        setInterval(appendLog, 2000);

        // Project Modal logic
        function openModal() {
            document.getElementById('project-modal').style.display = 'flex';
        }
        function closeModal() {
            document.getElementById('project-modal').style.display = 'none';
        }
        function createProject() {
            const name = document.getElementById('project-name').value.trim();
            if(name) {
                document.getElementById('current-project').innerText = name;
                document.getElementById('project-id').innerText = name.toLowerCase().replace(/\s+/g, '-');
                closeModal();
            }
        }
        function generateApiKey() {
            const key = 'appwrite_sec_' + Math.random().toString(36).substring(2, 15) + Math.random().toString(36).substring(2, 15);
            alert('Generated API Key:\n\n' + key + '\n\n(Copied to console)');
            console.log('Appwrite API Key:', key);
        }
    </script>
</body>
</html>
EOF

# Setup proper permissions
echo "Setting permissions..."
chmod -R 755 /opt/frankenphp
chmod -R 755 /opt/appwrite

if [ -n "$SUDO_UID" ] && [ -n "$SUDO_GID" ]; then
    chown -R "$SUDO_UID:$SUDO_GID" /opt/frankenphp
    chown -R "$SUDO_UID:$SUDO_GID" /opt/appwrite
fi

echo "=== appwrite-server Sandbox Forged ==="
