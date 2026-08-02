#!/bin/sh
set -e

mkdir -p /opt/frankenphp
mkdir -p /opt/kanboard

echo "Downloading FrankenPHP..."
curl -L --retry 3 --retry-delay 5 -o /opt/frankenphp/frankenphp https://github.com/dunglas/frankenphp/releases/download/v1.5.0/frankenphp-linux-x86_64
chmod +x /opt/frankenphp/frankenphp

echo "Creating Kanboard mockup..."
cat << 'EOF' > /opt/kanboard/index.php
<?php
// Kanboard mockup index.php
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kanboard Mockup</title>
    <style>
        :root {
            --bg-color: #121212;
            --text-color: #e0e0e0;
            --header-bg: #1e1e1e;
            --column-bg: #2d2d2d;
            --card-bg: #3d3d3d;
            --primary: #4a90e2;
            --border: #444;
        }
        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
            background-color: var(--bg-color);
            color: var(--text-color);
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            height: 100vh;
        }
        header {
            background-color: var(--header-bg);
            padding: 15px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 1px solid var(--border);
        }
        header h1 {
            margin: 0;
            font-size: 1.2rem;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .board {
            display: flex;
            flex: 1;
            padding: 20px;
            gap: 20px;
            overflow-x: auto;
        }
        .column {
            background-color: var(--column-bg);
            border-radius: 6px;
            min-width: 300px;
            width: 300px;
            display: flex;
            flex-direction: column;
            border: 1px solid var(--border);
        }
        .column-header {
            padding: 15px;
            font-weight: bold;
            border-bottom: 1px solid var(--border);
            display: flex;
            justify-content: space-between;
        }
        .column-content {
            padding: 10px;
            flex: 1;
            overflow-y: auto;
            min-height: 50px;
        }
        .card {
            background-color: var(--card-bg);
            border-radius: 4px;
            padding: 12px;
            margin-bottom: 10px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.3);
            cursor: grab;
            border-left: 4px solid var(--primary);
            position: relative;
        }
        .card:active {
            cursor: grabbing;
        }
        .card-title {
            font-weight: bold;
            margin-bottom: 8px;
        }
        .card-meta {
            display: flex;
            justify-content: space-between;
            font-size: 0.8rem;
            color: #aaa;
        }
        .add-task-btn {
            background-color: var(--primary);
            color: white;
            border: none;
            padding: 8px 15px;
            border-radius: 4px;
            cursor: pointer;
            font-weight: bold;
        }
        .add-task-btn:hover {
            background-color: #357abd;
        }
        
        /* Modal */
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.7);
            justify-content: center;
            align-items: center;
        }
        .modal-content {
            background-color: var(--header-bg);
            padding: 20px;
            border-radius: 6px;
            width: 400px;
            border: 1px solid var(--border);
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
        }
        .form-group input, .form-group select {
            width: 100%;
            padding: 8px;
            background-color: var(--column-bg);
            border: 1px solid var(--border);
            color: white;
            border-radius: 4px;
            box-sizing: border-box;
        }
        .modal-actions {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
        }
        .btn {
            padding: 8px 15px;
            border-radius: 4px;
            cursor: pointer;
            border: none;
        }
        .btn-cancel {
            background-color: transparent;
            color: var(--text-color);
            border: 1px solid var(--border);
        }
    </style>
</head>
<body>
    <header>
        <h1>
            <svg width="24" height="24" viewBox="0 0 24 24" fill="var(--primary)"><path d="M19 3H5c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2zM9 17H7V7h2v10zm4 0h-2V7h2v10zm4 0h-2V7h2v10z"/></svg>
            Kanboard Project
            <select style="margin-left:20px; background:#2d2d2d; color:white; border:1px solid #444; padding:5px;">
                <option>Project Alpha</option>
                <option>Project Beta</option>
            </select>
        </h1>
        <button class="add-task-btn" onclick="openModal()">+ Add Task</button>
    </header>

    <div class="board">
        <div class="column">
            <div class="column-header">
                Backlog <span id="count-backlog">1</span>
            </div>
            <div class="column-content" id="col-backlog" ondrop="drop(event)" ondragover="allowDrop(event)">
                <div class="card" draggable="true" ondragstart="drag(event)" id="task-1" style="border-left-color: #ff9800;">
                    <div class="card-title" onclick="editTask(this)">Research competitor analysis</div>
                    <div class="card-meta">
                        <span>#1</span>
                        <span>Assignee: Unassigned</span>
                    </div>
                </div>
            </div>
        </div>

        <div class="column">
            <div class="column-header">
                Ready <span id="count-ready">1</span>
            </div>
            <div class="column-content" id="col-ready" ondrop="drop(event)" ondragover="allowDrop(event)">
                <div class="card" draggable="true" ondragstart="drag(event)" id="task-2" style="border-left-color: #4caf50;">
                    <div class="card-title" onclick="editTask(this)">Setup database schema</div>
                    <div class="card-meta">
                        <span>#2</span>
                        <span>Assignee: Jane</span>
                    </div>
                </div>
            </div>
        </div>

        <div class="column">
            <div class="column-header">
                Work in Progress <span id="count-wip">1</span>
            </div>
            <div class="column-content" id="col-wip" ondrop="drop(event)" ondragover="allowDrop(event)">
                <div class="card" draggable="true" ondragstart="drag(event)" id="task-3" style="border-left-color: #f44336;">
                    <div class="card-title" onclick="editTask(this)">Implement login API</div>
                    <div class="card-meta">
                        <span>#3</span>
                        <span>Assignee: John</span>
                    </div>
                </div>
            </div>
        </div>

        <div class="column">
            <div class="column-header">
                Done <span id="count-done">1</span>
            </div>
            <div class="column-content" id="col-done" ondrop="drop(event)" ondragover="allowDrop(event)">
                <div class="card" draggable="true" ondragstart="drag(event)" id="task-4" style="border-left-color: #9c27b0;">
                    <div class="card-title" onclick="editTask(this)">Initial project setup</div>
                    <div class="card-meta">
                        <span>#4</span>
                        <span>Assignee: John</span>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal -->
    <div id="taskModal" class="modal">
        <div class="modal-content">
            <h2 style="margin-top:0">New Task</h2>
            <div class="form-group">
                <label>Title</label>
                <input type="text" id="taskTitle">
            </div>
            <div class="form-group">
                <label>Assignee</label>
                <input type="text" id="taskAssignee">
            </div>
            <div class="form-group">
                <label>Color</label>
                <select id="taskColor">
                    <option value="#4a90e2">Blue</option>
                    <option value="#ff9800">Orange</option>
                    <option value="#4caf50">Green</option>
                    <option value="#f44336">Red</option>
                </select>
            </div>
            <div class="modal-actions">
                <button class="btn btn-cancel" onclick="closeModal()">Cancel</button>
                <button class="btn add-task-btn" onclick="saveTask()">Save</button>
            </div>
        </div>
    </div>

    <script>
        let taskIdCounter = 5;
        
        function allowDrop(ev) {
            ev.preventDefault();
        }

        function drag(ev) {
            ev.dataTransfer.setData("text", ev.target.id);
        }

        function drop(ev) {
            ev.preventDefault();
            var data = ev.dataTransfer.getData("text");
            var col = ev.target.closest('.column-content');
            if (col) {
                col.appendChild(document.getElementById(data));
                updateCounts();
            }
        }
        
        function updateCounts() {
            document.getElementById('count-backlog').innerText = document.getElementById('col-backlog').children.length;
            document.getElementById('count-ready').innerText = document.getElementById('col-ready').children.length;
            document.getElementById('count-wip').innerText = document.getElementById('col-wip').children.length;
            document.getElementById('count-done').innerText = document.getElementById('col-done').children.length;
        }

        function openModal() {
            document.getElementById('taskTitle').value = '';
            document.getElementById('taskAssignee').value = '';
            document.getElementById('taskModal').style.display = 'flex';
        }

        function closeModal() {
            document.getElementById('taskModal').style.display = 'none';
        }

        function saveTask() {
            const title = document.getElementById('taskTitle').value;
            const assignee = document.getElementById('taskAssignee').value || 'Unassigned';
            const color = document.getElementById('taskColor').value;
            
            if (!title) return;
            
            const card = document.createElement('div');
            card.className = 'card';
            card.draggable = true;
            card.id = 'task-' + taskIdCounter;
            card.style.borderLeftColor = color;
            card.ondragstart = drag;
            
            card.innerHTML = \`
                <div class="card-title" onclick="editTask(this)">\${title}</div>
                <div class="card-meta">
                    <span>#\${taskIdCounter}</span>
                    <span>Assignee: \${assignee}</span>
                </div>
            \`;
            
            document.getElementById('col-backlog').appendChild(card);
            taskIdCounter++;
            updateCounts();
            closeModal();
        }

        function editTask(element) {
            const newTitle = prompt("Edit Task Title:", element.innerText);
            if (newTitle !== null && newTitle.trim() !== '') {
                element.innerText = newTitle;
            }
        }
    </script>
</body>
</html>
EOF

echo "Kanboard mockup and FrankenPHP setup complete."
