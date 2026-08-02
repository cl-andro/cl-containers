#!/bin/sh
set -e

mkdir -p /opt/frankenphp
echo "Downloading FrankenPHP..."
curl -L --retry 3 --retry-delay 5 -o /opt/frankenphp/frankenphp https://github.com/dunglas/frankenphp/releases/download/v1.5.0/frankenphp-linux-x86_64
chmod +x /opt/frankenphp/frankenphp

mkdir -p /opt/owncloud

cat << 'EOF' > /opt/owncloud/index.php
<?php
// ownCloud Mockup Dashboard
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ownCloud - Files</title>
    <style>
        :root {
            --primary: #1d2d44;
            --secondary: #0d1b2a;
            --accent: #3e5c76;
            --text-main: #f0fbdc;
            --text-muted: #748cab;
            --bg-main: #131b26;
            --bg-sidebar: #0d141e;
            --bg-hover: #1c2838;
            --border-color: #2a3b50;
            --highlight: #0082c9; /* ownCloud blue */
            --danger: #e63946;
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background-color: var(--bg-main);
            color: var(--text-main);
            display: flex;
            height: 100vh;
            overflow: hidden;
        }

        /* Header / Top Bar */
        .header {
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 50px;
            background-color: var(--highlight);
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 20px;
            z-index: 10;
        }

        .header-logo {
            font-weight: bold;
            font-size: 1.2rem;
            color: white;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .header-logo span {
            font-size: 1.5rem;
        }

        .header-search {
            flex: 1;
            max-width: 400px;
            margin: 0 20px;
            position: relative;
        }

        .header-search input {
            width: 100%;
            padding: 8px 15px;
            border-radius: 20px;
            border: none;
            background-color: rgba(255, 255, 255, 0.2);
            color: white;
            outline: none;
        }
        
        .header-search input::placeholder {
            color: rgba(255, 255, 255, 0.7);
        }

        .header-actions {
            display: flex;
            gap: 15px;
            align-items: center;
        }

        .avatar {
            width: 32px;
            height: 32px;
            border-radius: 50%;
            background-color: white;
            color: var(--highlight);
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            cursor: pointer;
        }

        /* App Layout */
        .app-container {
            display: flex;
            width: 100%;
            margin-top: 50px;
            height: calc(100vh - 50px);
        }

        /* Sidebar */
        .sidebar {
            width: 250px;
            background-color: var(--bg-sidebar);
            border-right: 1px solid var(--border-color);
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        .nav-menu {
            list-style: none;
            padding: 20px 0;
        }

        .nav-item {
            padding: 12px 20px;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 12px;
            color: var(--text-muted);
            transition: all 0.2s;
        }

        .nav-item:hover {
            background-color: var(--bg-hover);
            color: var(--text-main);
        }

        .nav-item.active {
            color: var(--text-main);
            border-left: 4px solid var(--highlight);
            background-color: var(--bg-hover);
            padding-left: 16px;
        }

        .storage-info {
            padding: 20px;
            border-top: 1px solid var(--border-color);
            font-size: 0.85rem;
            color: var(--text-muted);
        }

        .progress-bar {
            height: 6px;
            background-color: var(--bg-hover);
            border-radius: 3px;
            margin: 10px 0;
            overflow: hidden;
        }

        .progress-fill {
            height: 100%;
            background-color: var(--highlight);
            width: 45%;
        }

        /* Main Content */
        .main-content {
            flex: 1;
            display: flex;
            flex-direction: column;
            background-color: var(--bg-main);
        }

        .controls-bar {
            padding: 15px 25px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 1px solid var(--border-color);
        }

        .breadcrumb {
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 1.1rem;
            color: var(--text-muted);
        }

        .breadcrumb span:last-child {
            color: var(--text-main);
            font-weight: 500;
        }
        
        .breadcrumb-separator {
            color: var(--text-muted);
        }

        .action-buttons {
            display: flex;
            gap: 10px;
        }

        .btn {
            padding: 8px 16px;
            border-radius: 4px;
            border: none;
            cursor: pointer;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 8px;
            transition: background 0.2s;
        }

        .btn-primary {
            background-color: var(--highlight);
            color: white;
        }

        .btn-primary:hover {
            background-color: #006eb0;
        }

        .btn-secondary {
            background-color: var(--bg-hover);
            color: var(--text-main);
            border: 1px solid var(--border-color);
        }

        .btn-secondary:hover {
            background-color: var(--border-color);
        }

        /* File List */
        .file-list {
            flex: 1;
            overflow-y: auto;
            padding: 10px 25px;
        }

        .file-list-header {
            display: grid;
            grid-template-columns: 50px 1fr 150px 100px 50px;
            padding: 10px 0;
            color: var(--text-muted);
            font-size: 0.9rem;
            border-bottom: 1px solid var(--border-color);
            margin-bottom: 5px;
        }

        .file-item {
            display: grid;
            grid-template-columns: 50px 1fr 150px 100px 50px;
            padding: 12px 0;
            border-bottom: 1px solid rgba(42, 59, 80, 0.5);
            align-items: center;
            cursor: pointer;
            border-radius: 4px;
        }

        .file-item:hover {
            background-color: var(--bg-hover);
        }

        .file-icon {
            display: flex;
            justify-content: center;
            font-size: 1.5rem;
        }
        
        .icon-folder { color: #f6c85f; }
        .icon-image { color: #d06079; }
        .icon-doc { color: #4b86b4; }
        .icon-video { color: #9c6cce; }

        .file-name {
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .file-modified, .file-size {
            color: var(--text-muted);
            font-size: 0.9rem;
        }

        .file-actions {
            opacity: 0;
            transition: opacity 0.2s;
            display: flex;
            justify-content: center;
            color: var(--text-muted);
        }

        .file-item:hover .file-actions {
            opacity: 1;
        }
        
        .file-actions span:hover {
            color: var(--text-main);
        }

        /* Modal */
        .modal-overlay {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: rgba(0, 0, 0, 0.6);
            display: flex;
            align-items: center;
            justify-content: center;
            z-index: 100;
            opacity: 0;
            pointer-events: none;
            transition: opacity 0.3s;
        }

        .modal-overlay.active {
            opacity: 1;
            pointer-events: auto;
        }

        .modal-content {
            background-color: var(--bg-sidebar);
            border-radius: 8px;
            width: 400px;
            padding: 20px;
            border: 1px solid var(--border-color);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.5);
        }

        .modal-header {
            font-size: 1.2rem;
            font-weight: 500;
            margin-bottom: 20px;
        }

        .modal-body input {
            width: 100%;
            padding: 10px;
            background-color: var(--bg-main);
            border: 1px solid var(--border-color);
            color: white;
            border-radius: 4px;
            margin-bottom: 20px;
            outline: none;
        }

        .modal-body input:focus {
            border-color: var(--highlight);
        }

        .modal-footer {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
        }
        
        /* Toast Notification */
        .toast {
            position: fixed;
            bottom: 20px;
            right: 20px;
            background-color: var(--highlight);
            color: white;
            padding: 12px 20px;
            border-radius: 4px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.3);
            transform: translateY(100px);
            opacity: 0;
            transition: all 0.3s cubic-bezier(0.68, -0.55, 0.265, 1.55);
            z-index: 1000;
        }
        
        .toast.show {
            transform: translateY(0);
            opacity: 1;
        }
    </style>
</head>
<body>

    <!-- Header -->
    <header class="header">
        <div class="header-logo">
            <span>☁️</span> ownCloud Mockup
        </div>
        <div class="header-search">
            <input type="text" placeholder="Search in ownCloud...">
        </div>
        <div class="header-actions">
            <div style="cursor: pointer;">🔔</div>
            <div style="cursor: pointer;">🔍</div>
            <div class="avatar">A</div>
        </div>
    </header>

    <div class="app-container">
        <!-- Sidebar -->
        <aside class="sidebar">
            <ul class="nav-menu">
                <li class="nav-item active">
                    <span>📁</span> All files
                </li>
                <li class="nav-item">
                    <span>🖼️</span> Photos
                </li>
                <li class="nav-item">
                    <span>⏱️</span> Recent
                </li>
                <li class="nav-item">
                    <span>⭐</span> Favorites
                </li>
                <li class="nav-item">
                    <span>🔗</span> Shares
                </li>
                <li class="nav-item" style="margin-top: 20px;">
                    <span>🗑️</span> Deleted files
                </li>
                <li class="nav-item">
                    <span>⚙️</span> Settings
                </li>
            </ul>

            <div class="storage-info">
                <div>4.5 GB of 10 GB used</div>
                <div class="progress-bar">
                    <div class="progress-fill"></div>
                </div>
            </div>
        </aside>

        <!-- Main Content -->
        <main class="main-content">
            <div class="controls-bar">
                <div class="breadcrumb">
                    <span>🏠</span>
                    <span class="breadcrumb-separator">/</span>
                    <span>Documents</span>
                    <span class="breadcrumb-separator">/</span>
                    <span>Projects</span>
                </div>
                <div class="action-buttons">
                    <button class="btn btn-secondary" onclick="openModal()">
                        <span>+</span> New Folder
                    </button>
                    <button class="btn btn-primary" onclick="simulateUpload()">
                        <span>⬆️</span> Upload
                    </button>
                </div>
            </div>

            <div class="file-list">
                <div class="file-list-header">
                    <div></div>
                    <div>Name</div>
                    <div>Modified</div>
                    <div>Size</div>
                    <div></div>
                </div>

                <!-- File Items -->
                <div class="file-item" onclick="toggleSelection(this)">
                    <div class="file-icon icon-folder">📁</div>
                    <div class="file-name">2024 Planning</div>
                    <div class="file-modified">2 days ago</div>
                    <div class="file-size">14 MB</div>
                    <div class="file-actions"><span>⋯</span></div>
                </div>

                <div class="file-item" onclick="toggleSelection(this)">
                    <div class="file-icon icon-folder">📁</div>
                    <div class="file-name">Invoices</div>
                    <div class="file-modified">Last week</div>
                    <div class="file-size">8.2 MB</div>
                    <div class="file-actions"><span>⋯</span></div>
                </div>

                <div class="file-item" onclick="toggleSelection(this)">
                    <div class="file-icon icon-image">🖼️</div>
                    <div class="file-name">team_photo.jpg</div>
                    <div class="file-modified">Yesterday</div>
                    <div class="file-size">3.4 MB</div>
                    <div class="file-actions"><span>⋯</span></div>
                </div>

                <div class="file-item" onclick="toggleSelection(this)">
                    <div class="file-icon icon-doc">📄</div>
                    <div class="file-name">Q3_Report.pdf</div>
                    <div class="file-modified">Today, 10:42 AM</div>
                    <div class="file-size">1.2 MB</div>
                    <div class="file-actions"><span>⋯</span></div>
                </div>
                
                <div class="file-item" onclick="toggleSelection(this)">
                    <div class="file-icon icon-video">🎥</div>
                    <div class="file-name">presentation_rec.mp4</div>
                    <div class="file-modified">Oct 15, 2023</div>
                    <div class="file-size">128 MB</div>
                    <div class="file-actions"><span>⋯</span></div>
                </div>
                
                <div class="file-item" onclick="toggleSelection(this)">
                    <div class="file-icon icon-doc">📊</div>
                    <div class="file-name">budget_draft.xlsx</div>
                    <div class="file-modified">Just now</div>
                    <div class="file-size">45 KB</div>
                    <div class="file-actions"><span>⋯</span></div>
                </div>

                <div id="new-items-container"></div>
            </div>
        </main>
    </div>

    <!-- New Folder Modal -->
    <div class="modal-overlay" id="folderModal">
        <div class="modal-content">
            <div class="modal-header">Create new folder</div>
            <div class="modal-body">
                <input type="text" id="folderNameInput" placeholder="Folder name" autofocus>
            </div>
            <div class="modal-footer">
                <button class="btn btn-secondary" onclick="closeModal()">Cancel</button>
                <button class="btn btn-primary" onclick="createFolder()">Create</button>
            </div>
        </div>
    </div>
    
    <!-- Toast Notification -->
    <div class="toast" id="toast">Action completed successfully.</div>

    <script>
        function openModal() {
            document.getElementById('folderModal').classList.add('active');
            document.getElementById('folderNameInput').focus();
        }

        function closeModal() {
            document.getElementById('folderModal').classList.remove('active');
            document.getElementById('folderNameInput').value = '';
        }

        function createFolder() {
            const folderName = document.getElementById('folderNameInput').value;
            if (folderName.trim() === '') {
                closeModal();
                return;
            }

            const container = document.getElementById('new-items-container');
            
            const newFolder = document.createElement('div');
            newFolder.className = 'file-item';
            newFolder.setAttribute('onclick', 'toggleSelection(this)');
            newFolder.innerHTML = `
                <div class="file-icon icon-folder">📁</div>
                <div class="file-name">${folderName}</div>
                <div class="file-modified">Just now</div>
                <div class="file-size">0 B</div>
                <div class="file-actions"><span>⋯</span></div>
            `;
            
            // Insert at top of list (visually after the existing ones in this simple mockup)
            container.appendChild(newFolder);
            
            closeModal();
            showToast(`Folder "${folderName}" created successfully`);
        }

        function simulateUpload() {
            showToast('Uploading file...');
            
            setTimeout(() => {
                const container = document.getElementById('new-items-container');
                const newFile = document.createElement('div');
                newFile.className = 'file-item';
                newFile.setAttribute('onclick', 'toggleSelection(this)');
                newFile.innerHTML = `
                    <div class="file-icon icon-doc">📄</div>
                    <div class="file-name">uploaded_file_${Math.floor(Math.random() * 1000)}.txt</div>
                    <div class="file-modified">Just now</div>
                    <div class="file-size">${Math.floor(Math.random() * 50) + 1} KB</div>
                    <div class="file-actions"><span>⋯</span></div>
                `;
                
                container.appendChild(newFile);
                showToast('Upload complete');
            }, 1500);
        }

        function toggleSelection(element) {
            const allItems = document.querySelectorAll('.file-item');
            allItems.forEach(item => {
                if(item !== element) item.style.backgroundColor = '';
            });
            
            if (element.style.backgroundColor === 'var(--bg-hover)') {
                element.style.backgroundColor = '';
            } else {
                element.style.backgroundColor = 'var(--bg-hover)';
            }
        }
        
        function showToast(message) {
            const toast = document.getElementById('toast');
            toast.innerText = message;
            toast.classList.add('show');
            
            setTimeout(() => {
                toast.classList.remove('show');
            }, 3000);
        }
        
        // Handle enter key in modal
        document.getElementById('folderNameInput').addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                createFolder();
            }
        });
    </script>
</body>
</html>
EOF

chmod +x /opt/owncloud/index.php
