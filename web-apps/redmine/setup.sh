#!/bin/sh
set -e

echo "Building Redmine container..."

mkdir -p /opt/frankenphp
mkdir -p /opt/redmine

echo "Downloading FrankenPHP..."
curl -L --retry 3 --retry-delay 5 -o /opt/frankenphp/frankenphp https://github.com/dunglas/frankenphp/releases/download/v1.5.0/frankenphp-linux-x86_64
chmod +x /opt/frankenphp/frankenphp

echo "Creating Redmine dashboard mockup..."
cat << 'EOF' > /opt/redmine/index.php
<?php
$issues = [
    ['id' => 101, 'status' => 'New', 'priority' => 'High', 'subject' => 'Setup cluster sandbox', 'assignee' => 'admin'],
    ['id' => 102, 'status' => 'In Progress', 'priority' => 'Normal', 'subject' => 'Implement mock dashboard', 'assignee' => 'dev1'],
    ['id' => 103, 'status' => 'Closed', 'priority' => 'Low', 'subject' => 'Fix CSS bugs in dark theme', 'assignee' => 'designer'],
];
?>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Redmine</title>
<style>
body { font-family: "Segoe UI", Arial, sans-serif; margin: 0; background-color: #1e1e1e; color: #eee; }
#header { background-color: #8b0000; padding: 15px 25px; color: white; display: flex; justify-content: space-between; align-items: center; border-bottom: 2px solid #550000; }
#header h1 { margin: 0; font-size: 26px; text-shadow: 1px 1px 3px rgba(0,0,0,0.5); }
#top-menu { background-color: #2d2d2d; padding: 8px 25px; color: #ccc; font-size: 13px; border-bottom: 1px solid #444; }
#top-menu a { color: #aaa; text-decoration: none; margin-right: 20px; font-weight: bold; }
#top-menu a:hover { color: #fff; }
#main { display: flex; padding: 25px; min-height: 80vh; }
#sidebar { width: 260px; background-color: #252526; padding: 20px; border-radius: 5px; border: 1px solid #333; margin-right: 25px; }
#sidebar h3 { margin-top: 0; color: #ddd; border-bottom: 1px solid #444; padding-bottom: 10px; }
#sidebar ul { list-style: none; padding: 0; }
#sidebar li { margin-bottom: 10px; }
#sidebar a { color: #569cd6; text-decoration: none; font-size: 15px; }
#sidebar a:hover { text-decoration: underline; }
#content { flex: 1; }
h2 { margin-top: 0; color: #ddd; border-bottom: 1px solid #444; padding-bottom: 10px; }
table.list { width: 100%; border-collapse: collapse; margin-bottom: 30px; background-color: #252526; border-radius: 5px; overflow: hidden; }
table.list th, table.list td { border: 1px solid #333; padding: 12px; text-align: left; }
table.list th { background-color: #333; color: #ccc; font-weight: bold; }
table.list tr:hover { background-color: #2d2d2d; }
a { color: #569cd6; text-decoration: none; }
a:hover { text-decoration: underline; }
.button { background-color: #8b0000; border: none; padding: 8px 15px; cursor: pointer; border-radius: 3px; color: #fff; font-weight: bold; }
.button:hover { background-color: #a00000; }
.button.secondary { background-color: #3a3d41; border: 1px solid #555; }
.button.secondary:hover { background-color: #4a4d51; }
.modal { display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.7); z-index: 1000; }
.modal-content { background: #252526; margin: 10% auto; padding: 30px; width: 50%; max-width: 600px; border-radius: 5px; border: 1px solid #444; box-shadow: 0 4px 15px rgba(0,0,0,0.5); }
.modal-content h3 { margin-top: 0; color: #fff; }
input, textarea, select { background: #333; color: #eee; border: 1px solid #555; padding: 8px; border-radius: 3px; font-family: inherit; width: calc(100% - 18px); margin-bottom: 15px; }
input:focus, textarea:focus, select:focus { outline: none; border-color: #569cd6; }
.status-badge { padding: 4px 8px; border-radius: 12px; font-size: 12px; font-weight: bold; }
.status-new { background: #005a9e; color: #fff; }
.status-progress { background: #b8860b; color: #fff; }
.status-closed { background: #2e8b57; color: #fff; }
.gantt-container { width: 100%; height: 150px; background: #252526; border: 1px solid #333; position: relative; border-radius: 5px; overflow: hidden; margin-bottom: 30px; }
.gantt-grid { position: absolute; width: 100%; height: 100%; display: flex; }
.gantt-grid-col { flex: 1; border-right: 1px dashed #444; }
.gantt-bar { position: absolute; height: 24px; border-radius: 3px; color: #fff; font-size: 12px; line-height: 24px; padding: 0 10px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; box-shadow: 0 2px 5px rgba(0,0,0,0.2); }
</style>
</head>
<body>
<div id="top-menu">
    <a href="#">Home</a>
    <a href="#">My page</a>
    <a href="#">Projects</a>
    <a href="#">Administration</a>
    <a href="#">Help</a>
</div>
<div id="header">
    <h1>Redmine Mockup</h1>
    <div>Logged in as admin</div>
</div>
<div id="main">
    <div id="sidebar">
        <h3>Current Project</h3>
        <ul>
            <li><a href="#">Overview</a></li>
            <li><a href="#">Activity feed</a></li>
            <li><a href="#">Issues</a></li>
            <li><a href="#">Gantt</a></li>
            <li><a href="#">Calendar</a></li>
            <li><a href="#">News</a></li>
            <li><a href="#">Documents</a></li>
            <li><a href="#">Settings</a></li>
        </ul>
        <h3 style="margin-top: 30px;">Filters</h3>
        <select style="width: 100%;">
            <option>Open issues</option>
            <option>Assigned to me</option>
            <option>Recently updated</option>
        </select>
    </div>
    <div id="content">
        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
            <h2>Issues</h2>
            <button class="button" onclick="document.getElementById('modal').style.display='block'">+ New Issue</button>
        </div>
        
        <table class="list">
            <thead>
                <tr>
                    <th>#</th>
                    <th>Status</th>
                    <th>Priority</th>
                    <th>Subject</th>
                    <th>Assignee</th>
                </tr>
            </thead>
            <tbody id="issue-table-body">
                <?php foreach($issues as $i): ?>
                <?php 
                    $statusClass = 'status-new';
                    if ($i['status'] == 'In Progress') $statusClass = 'status-progress';
                    if ($i['status'] == 'Closed') $statusClass = 'status-closed';
                ?>
                <tr>
                    <td><a href="#">#<?= $i['id'] ?></a></td>
                    <td><span class="status-badge <?= $statusClass ?>"><?= $i['status'] ?></span></td>
                    <td><?= $i['priority'] ?></td>
                    <td><a href="#"><?= $i['subject'] ?></a></td>
                    <td><?= $i['assignee'] ?></td>
                </tr>
                <?php endforeach; ?>
            </tbody>
        </table>
        
        <h2>Gantt Chart (Q3 2026)</h2>
        <div class="gantt-container">
            <div class="gantt-grid">
                <div class="gantt-grid-col"></div><div class="gantt-grid-col"></div><div class="gantt-grid-col"></div><div class="gantt-grid-col"></div>
            </div>
            <div class="gantt-bar" style="top: 20px; left: 5%; width: 30%; background: #005a9e;">#101 Setup cluster sandbox</div>
            <div class="gantt-bar" style="top: 60px; left: 25%; width: 45%; background: #b8860b;">#102 Implement mock dashboard</div>
            <div class="gantt-bar" style="top: 100px; left: 75%; width: 20%; background: #2e8b57;">#103 Fix CSS bugs</div>
        </div>

        <h2>Activity Feed</h2>
        <div style="background: #252526; padding: 15px; border-radius: 5px; border: 1px solid #333;">
            <p><span style="color:#8b8b8b;">10 minutes ago</span> - <strong>admin</strong> updated issue #101 (Status changed from New to In Progress)</p>
            <p><span style="color:#8b8b8b;">1 hour ago</span> - <strong>dev1</strong> added a comment to #102</p>
            <p><span style="color:#8b8b8b;">Yesterday</span> - <strong>designer</strong> closed issue #103</p>
        </div>
    </div>
</div>

<div id="modal" class="modal">
    <div class="modal-content">
        <h3>Create New Issue</h3>
        <label>Tracker</label>
        <select><option>Bug</option><option>Feature</option><option>Support</option></select>
        <label>Subject</label>
        <input type="text" id="new-issue-subject" placeholder="Enter issue subject...">
        <label>Description</label>
        <textarea style="height: 100px;" placeholder="Detailed description..."></textarea>
        <div style="display: flex; gap: 10px;">
            <label style="flex: 1;">Priority<br><select><option>Low</option><option selected>Normal</option><option>High</option><option>Urgent</option></select></label>
            <label style="flex: 1;">Assignee<br><select><option>admin</option><option>dev1</option><option>designer</option></select></label>
        </div>
        <div style="margin-top: 20px; text-align: right;">
            <button class="button secondary" onclick="document.getElementById('modal').style.display='none'">Cancel</button>
            <button class="button" onclick="createIssue()">Create</button>
        </div>
    </div>
</div>

<script>
function createIssue() {
    const subject = document.getElementById('new-issue-subject').value || 'New Issue';
    const tbody = document.getElementById('issue-table-body');
    const tr = document.createElement('tr');
    const id = Math.floor(Math.random() * 100) + 200;
    tr.innerHTML = `
        <td><a href="#">#${id}</a></td>
        <td><span class="status-badge status-new">New</span></td>
        <td>Normal</td>
        <td><a href="#">${subject}</a></td>
        <td>admin</td>
    `;
    tbody.prepend(tr);
    document.getElementById('modal').style.display = 'none';
    document.getElementById('new-issue-subject').value = '';
}
</script>
</body>
</html>
EOF

chmod 644 /opt/redmine/index.php

echo "Done!"
