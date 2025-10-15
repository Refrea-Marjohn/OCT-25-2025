<?php
session_start();
require_once 'config.php';

// Access control: only admin users allowed (admin can also act as attorney)
if (!isset($_SESSION['admin_name']) || $_SESSION['user_type'] !== 'admin') {
    header('Location: login_form.php');
    exit();
}

$admin_id = (int)($_SESSION['user_id'] ?? 0);

// Ensure efiling_history table exists
@mysqli_query($conn, "CREATE TABLE IF NOT EXISTS efiling_history (
  id int(11) NOT NULL AUTO_INCREMENT,
  attorney_id int(11) NOT NULL,
  case_id int(11) DEFAULT NULL,
  document_category varchar(50) DEFAULT NULL,
  file_name varchar(255) NOT NULL,
  original_file_name varchar(255) DEFAULT NULL,
  stored_file_path varchar(500) DEFAULT NULL,
  receiver_email varchar(255) NOT NULL,
  message text,
  status enum('Sent','Failed') NOT NULL DEFAULT 'Sent',
  created_at timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (id),
  KEY attorney_id (attorney_id),
  KEY case_id (case_id),
  KEY created_at (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;");

// Profile image
$stmt = $conn->prepare("SELECT profile_image, name FROM user_form WHERE id=?");
$stmt->bind_param("i", $admin_id);
$stmt->execute();
$res = $stmt->get_result();
$profile_image = '';
$admin_name = $_SESSION['admin_name'] ?? 'Admin';
if ($res && $row = $res->fetch_assoc()) {
    $profile_image = $row['profile_image'];
    $admin_name = $row['name'] ?: $admin_name;
}
if (!$profile_image || !file_exists($profile_image)) {
    $profile_image = 'images/default-avatar.jpg';
}

// Fetch all cases (admin can see all)
$cases = [];
$q = $conn->query("SELECT c.id, c.title, c.case_type, u.name as client_name FROM attorney_cases c LEFT JOIN user_form u ON c.client_id = u.id ORDER BY c.title ASC");
while ($row = $q->fetch_assoc()) $cases[] = $row;

// Fetch recent eFiling history by admin user id
$history = [];
// Admin sees ALL efiling submissions from all attorneys
$stmt = $conn->prepare("SELECT ef.*, c.title as case_title, c.case_type, u.name as client_name, ua.name as attorney_name
                        FROM efiling_history ef
                        LEFT JOIN attorney_cases c ON ef.case_id = c.id
                        LEFT JOIN user_form u ON c.client_id = u.id
                        LEFT JOIN user_form ua ON ef.attorney_id = ua.id
                        ORDER BY ef.created_at DESC LIMIT 300");
$stmt->execute();
$res = $stmt->get_result();
while ($row = $res->fetch_assoc()) $history[] = $row;
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin E-Filing - Opiña Law Office</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="assets/css/dashboard.css?v=<?= time() ?>">
</head>
<body>
    <div class="sidebar">
        <div class="sidebar-header">
            <img src="images/logo.jpg" alt="Logo">
            <h2>Opiña Law Office</h2>
        </div>
        <ul class="sidebar-menu">
            <li><a href="admin_dashboard.php"><i class="fas fa-home"></i><span>Dashboard</span></a></li>
            <li><a href="admin_documents.php"><i class="fas fa-file-alt"></i><span>Document Storage</span></a></li>
            <li><a href="admin_document_generation.php"><i class="fas fa-file-alt"></i><span>Document Generations</span></a></li>
            <li><a href="admin_schedule.php"><i class="fas fa-calendar-alt"></i><span>Schedule</span></a></li>
            <li><a href="admin_efiling.php" class="active"><i class="fas fa-paper-plane"></i><span>E-Filing</span></a></li>
            <li><a href="admin_usermanagement.php"><i class="fas fa-users-cog"></i><span>User Management</span></a></li>
            <li><a href="admin_managecases.php"><i class="fas fa-gavel"></i><span>Case Management</span></a></li>
            <li><a href="admin_clients.php"><i class="fas fa-users"></i><span>My Clients</span></a></li>
            <li><a href="admin_messages.php"><i class="fas fa-comments"></i><span>Messages</span></a></li>
            <li><a href="admin_audit.php"><i class="fas fa-history"></i><span>Audit Trail</span></a></li>
        </ul>
    </div>

    <div class="main-content">
        <!-- Header -->
        <?php 
        $page_title = 'E-Filing';
        $page_subtitle = 'Send court submissions via firm email';
        include 'components/profile_header.php'; 
        ?>

        <div class="efiling-grid">
            <div class="efiling-card">
                <div class="card-header">
                    <h2><i class="fas fa-paper-plane"></i> New eFiling Submission</h2>
                    <p>Send documents using the firm's Gmail. * Required fields.</p>
                </div>
                <div class="card-body">
                    <form id="efilingForm" enctype="multipart/form-data">
                        <div class="form-row">
                            <div class="form-group">
                                <label>Case Selection (Optional)</label>
                                <select name="case_id">
                                    <option value="">— No case —</option>
                                    <?php foreach ($cases as $c): ?>
                                        <option value="<?= $c['id'] ?>">#<?= $c['id'] ?> — <?= htmlspecialchars($c['title']) ?> <?= $c['client_name']? ' — '.htmlspecialchars($c['client_name']): '' ?></option>
                                    <?php endforeach; ?>
                                </select>
                            </div>
                            <div class="form-group">
                                <label>Document Category *</label>
                                <select name="document_category" required>
                                    <option value="">Select Document Type</option>
                                    <option value="Motion">Motion</option>
                                    <option value="Petition">Petition</option>
                                    <option value="Complaint">Complaint</option>
                                </select>
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label>Receiver Email *</label>
                                <input type="email" name="receiver_email" id="receiver_email" required>
                            </div>
                            <div class="form-group">
                                <label>Confirm Receiver Email *</label>
                                <input type="email" name="receiver_email_confirm" id="receiver_email_confirm" required>
                                <small id="emailMatchMsg" class="warn" style="display:none;">Emails do not match.</small>
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label>Document Name *</label>
                                <input type="text" name="desired_filename" id="desired_filename" placeholder="Enter document name with .pdf extension" required>
                            </div>
                            <div class="form-group">
                                <label>Upload Document (PDF only) *</label>
                                <input type="file" name="document" id="document" accept="application/pdf,.pdf" required onchange="validateFileSize(this)">
                                <small class="hint">Allowed: PDF only • Max 5MB</small>
                                <div id="fileSizeError" class="error-message" style="display: none; color: #dc3545; font-size: 0.8rem; margin-top: 5px;"></div>
                            </div>
                        </div>

                        <div class="form-group">
                            <label>Message (optional)</label>
                            <textarea name="message" rows="3" placeholder="Additional notes to include in email body (optional)"></textarea>
                        </div>

                        <div class="form-actions">
                            <button type="submit" class="btn btn-primary" id="sendBtn"><i class="fas fa-paper-plane"></i> Send eFiling</button>
                            <button type="reset" class="btn btn-secondary" id="resetBtn">Clear</button>
                        </div>
                    </form>
                    <div id="resultMsg" class="result" style="display:none;"></div>
                </div>
            </div>

            <div class="efiling-card">
                <div class="card-header">
                    <h2><i class="fas fa-history"></i> Submission History</h2>
                </div>
                <div class="card-body">
                    <table class="history-table">
                        <thead>
                            <tr>
                                <th>Date & Time</th>
                                <th>File Name (Used)</th>
                                <th>Category</th>
                                <th>Original File Name</th>
                                <th>Receiver Email</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php if (empty($history)): ?>
                                <tr><td colspan="6" style="text-align:center;color:#6b7280;padding:40px;font-style:italic;font-size:14px;">
                                    <i class="fas fa-inbox" style="font-size:24px;margin-bottom:8px;display:block;color:#d1d5db;"></i>
                                    No e-filing submissions yet
                                </td></tr>
                            <?php else: foreach ($history as $h): ?>
                                <tr>
                                    <td class="date-time"><?= date('M j, Y g:i A', strtotime($h['created_at'])) ?></td>
                                    <td><span class="file-name-cell" title="<?= htmlspecialchars($h['file_name']) ?>"><?= strlen($h['file_name']) > 20 ? substr(htmlspecialchars($h['file_name']), 0, 20) . '...' : htmlspecialchars($h['file_name']) ?></span></td>
                                    <td><span class="category-badge"><?= htmlspecialchars($h['document_category'] ?? 'N/A') ?></span></td>
                                    <td><span class="original-file-name" title="<?= htmlspecialchars($h['original_file_name'] ?? '-') ?>"><?= strlen($h['original_file_name'] ?? '-') > 25 ? substr(htmlspecialchars($h['original_file_name'] ?? '-'), 0, 25) . '...' : htmlspecialchars($h['original_file_name'] ?? '-') ?></span></td>
                                    <td><span class="receiver-email" title="<?= htmlspecialchars($h['receiver_email']) ?>"><?= strlen($h['receiver_email']) > 25 ? substr(htmlspecialchars($h['receiver_email']), 0, 25) . '...' : htmlspecialchars($h['receiver_email']) ?></span></td>
                                    <td><span class="status-badge status-<?= strtolower($h['status']) ?>"><?= htmlspecialchars($h['status']) ?></span></td>
                                    <td style="text-align: center; white-space: nowrap;">
                                        <button onclick="viewCaseInfo(<?= $h['case_id'] ?? 'null' ?>, '<?= htmlspecialchars($h['case_title'] ?? '') ?>', '<?= htmlspecialchars($h['case_type'] ?? '') ?>', '<?= htmlspecialchars($h['client_name'] ?? '') ?>', '<?= htmlspecialchars($h['attorney_name'] ?? 'Unknown') ?>')" class="btn-view-case" title="View Case Info">
                                            <i class="fas fa-info-circle"></i>
                                        </button>
                                        <?php if (!empty($h['stored_file_path']) && file_exists($h['stored_file_path'])): ?>
                                            <a href="view_efiling_file.php?id=<?= $h['id'] ?>" target="_blank" class="btn-view-file" title="View File">
                                                <i class="fas fa-eye"></i>
                                            </a>
                                            <a href="download_efiling_file.php?id=<?= $h['id'] ?>" class="btn-download-file" title="Download File">
                                                <i class="fas fa-download"></i>
                                            </a>
                                        <?php else: ?>
                                            <span style="color:#999;font-size:11px;font-style:italic;padding: 8px 12px;background: #f5f5f5;border-radius: 6px;">File not available</span>
                                        <?php endif; ?>
                                    </td>
                                </tr>
                            <?php endforeach; endif; ?>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <style>
        .efiling-grid { display: grid; grid-template-columns: 1fr; gap: 24px; }
        .efiling-card { background:#fff; border:1px solid #e5e7eb; border-radius:16px; box-shadow:0 8px 25px rgba(16,24,40,0.08); overflow:hidden; }
        .efiling-card .card-header { padding:20px 24px; border-bottom:1px solid #f1f3f4; background:linear-gradient(135deg, #f8f9fa, #ffffff); display:flex; justify-content:space-between; align-items:center; }
        .efiling-card .card-header h2 { margin:0; font-size:1.2rem; display:flex; align-items:center; gap:12px; color:#1f2937; font-weight:600; }
        .efiling-card .card-header p { margin:8px 0 0 32px; color:#6b7280; font-size:0.9rem; }
        .efiling-card .card-body { padding:24px; }
        .form-row { display:grid; grid-template-columns: 1fr 1fr; gap:16px; }
        .form-group { margin-bottom:16px; }
        .form-group label { display:block; margin-bottom:8px; font-weight:600; color:#5D0E26; font-size:14px; text-transform:uppercase; letter-spacing:.5px; }
        .form-group input, .form-group select, .form-group textarea { width:100%; padding:12px 14px; border:1px solid #d6d9de; background:#fafbfc; border-radius:10px; font-size:14px; box-shadow: inset 0 1px 2px rgba(16,24,40,0.04); }
        .form-group input:focus, .form-group select:focus, .form-group textarea:focus { outline:none; border-color:#8B1538; box-shadow:0 0 0 4px rgba(139,21,56,.12); }
        .hint{ color:#6b7280; font-size:12px; display:block; margin-top:6px; }
        .warn{ color:#b91c1c; font-size:12px; }
        .form-actions{ display:flex; gap:12px; justify-content:flex-end; border-top:1px solid #edf0f3; padding-top:16px; margin-top:8px; }
        .btn{ border:none; border-radius:10px; padding:12px 18px; cursor:pointer; font-weight:600; }
        .btn-primary{ background:#7C0F2F; color:#fff; }
        .btn-primary:hover{ background:#8B1538; }
        .btn-secondary{ background:#697586; color:#fff; }
        .history-table{ width:100%; border-collapse:collapse; background:#fff; border-radius:12px; overflow:hidden; box-shadow:0 4px 12px rgba(0,0,0,0.08); }
        .history-table th{ background:linear-gradient(135deg,#7C0F2F,#8B1538); color:#fff; font-weight:600; font-size:13px; text-transform:uppercase; letter-spacing:.5px; padding:16px 12px; text-align:left; border:none; }
        .history-table td{ padding:16px 12px; border-bottom:1px solid #f1f3f4; font-size:14px; color:#374151; vertical-align:middle; }
        .file-name-cell{ font-family:'Courier New',monospace; font-size:13px; color:#374151; background:#f8f9fa; padding:4px 8px; border-radius:4px; display:inline-block; max-width:200px; overflow:hidden; text-overflow:ellipsis; white-space:nowrap; }
        .original-file-name{ font-size:12px; color:#6b7280; font-style:italic; max-width:200px; overflow:hidden; text-overflow:ellipsis; white-space:nowrap; }
        .receiver-email{ font-family:'Courier New',monospace; font-size:13px; color:#7C0F2F; font-weight:500; }
        .date-time{ font-size:13px; color:#374151; font-weight:500; }
        .status-badge{ padding:6px 12px; border-radius:20px; font-size:11px; font-weight:600; text-transform:uppercase; letter-spacing:.3px; display:inline-block; }
        .status-sent{ background:linear-gradient(135deg,#10b981,#059669); color:#fff; box-shadow:0 2px 4px rgba(16,185,129,.3); }
        .status-failed{ background:linear-gradient(135deg,#ef4444,#dc2626); color:#fff; box-shadow:0 2px 4px rgba(239,68,68,.3); }
        /* Action buttons */
        .btn-view-file, .btn-download-file, .btn-view-case {
            display:inline-flex; align-items:center; justify-content:center;
            width:36px; height:36px; padding:8px 10px; margin:0 2px;
            border:none; border-radius:8px; text-decoration:none; cursor:pointer;
            font-size:12px; font-weight:600; transition:all .3s ease;
            box-shadow:0 2px 6px rgba(0,0,0,0.15);
        }
        .btn-view-case { background:linear-gradient(135deg,#6b7280,#4b5563); color:#fff; }
        .btn-view-case:hover { background:linear-gradient(135deg,#4b5563,#374151); transform:translateY(-2px); box-shadow:0 4px 12px rgba(107,114,128,.4); }
        .btn-view-file { background:linear-gradient(135deg,#3b82f6,#2563eb); color:#fff; }
        .btn-view-file:hover { background:linear-gradient(135deg,#2563eb,#1d4ed8); transform:translateY(-2px); box-shadow:0 4px 12px rgba(59,130,246,.4); }
        .btn-download-file { background:linear-gradient(135deg,#10b981,#059669); color:#fff; }
        .btn-download-file:hover { background:linear-gradient(135deg,#059669,#047857); transform:translateY(-2px); box-shadow:0 4px 12px rgba(16,185,129,.4); }
        @media (max-width: 768px){ .form-row{ grid-template-columns: 1fr; } }
    </style>

    <script>
        const email1 = document.getElementById('receiver_email');
        const email2 = document.getElementById('receiver_email_confirm');
        const matchMsg = document.getElementById('emailMatchMsg');
        const desiredFilename = document.getElementById('desired_filename');
        const fileInput = document.getElementById('document');
        const resultMsg = document.getElementById('resultMsg');
        const form = document.getElementById('efilingForm');

        function validateEmails(){ const same = email1.value.trim().toLowerCase() === email2.value.trim().toLowerCase(); matchMsg.style.display = same ? 'none' : 'block'; return same; }
        email1.addEventListener('input', validateEmails);
        email2.addEventListener('input', validateEmails);

        function getExtension(name){ const idx = name.lastIndexOf('.'); return idx >= 0 ? name.substring(idx+1).toLowerCase() : ''; }
        function ensureDesiredFilenameExtension(uploadedExt){ let name = desiredFilename.value.trim(); if(!name) return; const ext = getExtension(name); if(!ext){ desiredFilename.value = name + '.' + uploadedExt; return; } if(ext !== uploadedExt){ desiredFilename.value = name.slice(0, -(ext.length+1)) + '.' + uploadedExt; } }

        fileInput.addEventListener('change', function(){ if(!fileInput.files.length) return; const uploadedExt = getExtension(fileInput.files[0].name); if(uploadedExt !== 'pdf'){ resultMsg.className='result error'; resultMsg.textContent='Only PDF files are allowed.'; resultMsg.style.display='block'; fileInput.value=''; return; } ensureDesiredFilenameExtension(uploadedExt); resultMsg.style.display='none'; });

        document.getElementById('resetBtn').addEventListener('click', function(){ form.reset(); resultMsg.style.display='none'; matchMsg.style.display='none'; });

        // View Case Info modal, including submitting attorney
        function viewCaseInfo(caseId, caseTitle, caseType, clientName, attorneyName) {
            if (!caseId || caseId === 'null' || caseId === null) {
                let modalContent = `
                    <div style="background: #fff; border-radius: 16px; max-width: 500px; width: 90%; box-shadow: 0 20px 60px rgba(0,0,0,0.15); overflow: hidden; border:1px solid #eee;">
                        <div style="background: linear-gradient(135deg,#6c757d,#495057); color:#fff; padding: 18px 22px; display:flex; align-items:center; justify-content:space-between;">
                            <h3 style="margin:0; font-size:18px; font-weight:700; display:flex; align-items:center; gap:10px;"><i class='fas fa-info-circle'></i> Case Information</h3>
                            <button onclick="closeCaseModal()" style="background:rgba(255,255,255,0.2); border:none; color:#fff; padding:6px 10px; border-radius:8px; cursor:pointer"><i class='fas fa-times'></i></button>
                        </div>
                        <div style="padding: 24px;">
                            <div style="display:flex; align-items:center; padding:12px; background:#eef2ff; border-left:4px solid #3b82f6; border-radius:8px; margin-bottom:12px;">
                                <i class="fas fa-user-tie" style="color:#1d4ed8; margin-right:10px;"></i>
                                <div>
                                    <div style="font-size:12px; color:#1e40af; font-weight:700; text-transform:uppercase;">Submitted By</div>
                                    <div style="font-size:15px; color:#111827; font-weight:600;">${attorneyName || 'Unknown'}</div>
                                </div>
                            </div>
                            <div style="background:#fffbe6; border:1px solid #ffe58f; padding:16px; border-radius:10px;">
                                <i class="fas fa-exclamation-triangle" style="color:#d97706; margin-right:8px;"></i>
                                This submission was sent without associating it to any specific case.
                            </div>
                        </div>
                        <div style="padding: 16px 22px; border-top:1px solid #eee; text-align:center;">
                            <button onclick="closeCaseModal()" style="background: linear-gradient(135deg,#6c757d,#495057); color:#fff; border:none; padding:10px 20px; border-radius:10px; font-weight:600; cursor:pointer;">
                                <i class="fas fa-check" style="margin-right:6px;"></i> Close
                            </button>
                        </div>
                    </div>
                `;
                const modal = document.createElement('div');
                modal.id = 'caseModal';
                modal.style.cssText = 'position:fixed;inset:0;background:rgba(0,0,0,0.45);display:flex;align-items:center;justify-content:center;z-index:10000;backdrop-filter:blur(2px)';
                modal.innerHTML = modalContent;
                document.body.appendChild(modal);
                modal.addEventListener('click', function(e){ if(e.target===modal) closeCaseModal(); });
                return;
            }

            let modalContent = `
                <div style="background:#fff; border-radius:16px; max-width:560px; width:90%; box-shadow:0 20px 60px rgba(0,0,0,0.15); overflow:hidden; border:1px solid #eee;">
                    <div style="background: linear-gradient(135deg,#7C0F2F,#8B1538); color:#fff; padding:18px 22px; display:flex; align-items:center; justify-content:space-between;">
                        <h3 style="margin:0; font-size:18px; font-weight:700; display:flex; align-items:center; gap:10px;"><i class='fas fa-gavel'></i> Case Information</h3>
                        <button onclick="closeCaseModal()" style="background:rgba(255,255,255,0.2); border:none; color:#fff; padding:6px 10px; border-radius:8px; cursor:pointer"><i class='fas fa-times'></i></button>
                    </div>
                    <div style="padding:24px;">
                        <div style="display:flex; align-items:center; padding:12px; background:#eef2ff; border-left:4px solid #3b82f6; border-radius:8px; margin-bottom:12px;">
                            <i class="fas fa-user-tie" style="color:#1d4ed8; margin-right:10px;"></i>
                            <div>
                                <div style="font-size:12px; color:#1e40af; font-weight:700; text-transform:uppercase;">Submitted By</div>
                                <div style="font-size:15px; color:#111827; font-weight:600;">${attorneyName || 'Unknown'}</div>
                            </div>
                        </div>
                        <div style="background: #f8f9fa; padding:16px; border-left:4px solid #7C0F2F; border-radius:10px; margin-bottom:16px;">
                            <h4 style="margin:0; font-size:16px; color:#1f2937;">${caseTitle || 'Untitled Case'}</h4>
                        </div>
                        ${caseType ? `
                            <div style="display:flex; align-items:center; padding:12px; background:#e8f5e9; border-left:4px solid #4caf50; border-radius:10px; margin-bottom:10px;">
                                <i class=\"fas fa-balance-scale\" style=\"color:#388e3c; margin-right:10px;\"></i>
                                <div><div style=\"font-size:12px; color:#388e3c; font-weight:700; text-transform:uppercase;\">Case Type</div><div style=\"font-size:15px;\">${caseType}</div></div>
                            </div>` : ''}
                        ${clientName ? `
                            <div style="display:flex; align-items:center; padding:12px; background:#f3e5f5; border-left:4px solid #9c27b0; border-radius:10px;">
                                <i class=\"fas fa-user\" style=\"color:#7b1fa2; margin-right:10px;\"></i>
                                <div><div style=\"font-size:12px; color:#7b1fa2; font-weight:700; text-transform:uppercase;\">Client</div><div style=\"font-size:15px;\">${clientName}</div></div>
                            </div>` : ''}
                    </div>
                    <div style="padding: 16px 22px; border-top:1px solid #eee; text-align:center;">
                        <button onclick="closeCaseModal()" style="background: linear-gradient(135deg,#7C0F2F,#8B1538); color:#fff; border:none; padding:10px 20px; border-radius:10px; font-weight:600; cursor:pointer;">
                            <i class="fas fa-check" style="margin-right:6px;"></i> Close
                        </button>
                    </div>
                </div>`;
            const modal = document.createElement('div');
            modal.id = 'caseModal';
            modal.style.cssText = 'position:fixed;inset:0;background:rgba(0,0,0,0.45);display:flex;align-items:center;justify-content:center;z-index:10000;backdrop-filter:blur(2px)';
            modal.innerHTML = modalContent;
            document.body.appendChild(modal);
            modal.addEventListener('click', function(e){ if(e.target===modal) closeCaseModal(); });
        }

        function closeCaseModal(){ const modal = document.getElementById('caseModal'); if(modal) modal.remove(); }

        // Single-submit guard + proper Sending state + timeout + robust parsing
        let isSubmitting = false;
        
        // Function to validate file size on selection
        function validateFileSize(input) {
            const fileSizeError = document.getElementById('fileSizeError');
            const maxSize = 5 * 1024 * 1024; // 5MB
            
            if (input.files && input.files[0]) {
                const fileSize = input.files[0].size;
                const fileSizeMB = (fileSize / (1024 * 1024)).toFixed(1);
                
                if (fileSize > maxSize) {
                    fileSizeError.textContent = `File size (${fileSizeMB}MB) exceeds the 5MB limit. Please select a smaller file.`;
                    fileSizeError.style.display = 'block';
                    input.value = ''; // Clear the file input
                    return false;
                } else {
                    fileSizeError.style.display = 'none';
                    return true;
                }
            }
            return true;
        }
        
        form.addEventListener('submit', function(e){
            e.preventDefault();
            if (isSubmitting) return;
            resultMsg.style.display='none';
            if(!validateEmails()) return;
            if(!fileInput.files.length) return;

            // Check file size (max 5MB)
            const fileSize = fileInput.files[0].size;
            const maxSize = 5 * 1024 * 1024; // 5MB
            if (fileSize > maxSize) {
                resultMsg.className = 'result error';
                resultMsg.textContent = 'File size too large. Maximum allowed size is 5MB.';
                resultMsg.style.display = 'block';
                return;
            }
            
            const fileSizeMB = (fileSize / (1024 * 1024)).toFixed(1);
            
            isSubmitting = true;
            const sendBtn = document.getElementById('sendBtn');
            const originalText = sendBtn.innerHTML;
            sendBtn.innerHTML = `<i class="fas fa-spinner fa-spin"></i> Sending ${fileSizeMB}MB file...`;
            sendBtn.disabled = true;

            const fd = new FormData(form);
            const controller = new AbortController();
            const timeoutId = setTimeout(() => controller.abort(), 60000); // 1 minute timeout
            fetch('process_efiling.php', { method:'POST', body: fd, signal: controller.signal })
                .then(async (r) => {
                    clearTimeout(timeoutId);
                    const text = await r.text();
                    try { return JSON.parse(text); } catch { throw new Error(text || 'Invalid server response'); }
                })
                .then(data => {
                    if (data.status === 'success') {
                        resultMsg.className = 'result success';
                        resultMsg.textContent = data.message || 'Submission sent successfully.';
                        resultMsg.style.display = 'block';
                        setTimeout(() => window.location.reload(), 1200);
                    } else {
                        resultMsg.className = 'result error';
                        resultMsg.textContent = data.message || 'Failed to send submission.';
                        resultMsg.style.display = 'block';
                        sendBtn.innerHTML = originalText;
                        sendBtn.disabled = false;
                        isSubmitting = false;
                    }
                })
                .catch((err) => {
                    resultMsg.className = 'result error';
                    resultMsg.textContent = (err && err.name === 'AbortError') ? 'Request timed out. Please try again.' : (err && err.message ? err.message : 'Unexpected error. Please try again.');
                    resultMsg.style.display = 'block';
                    sendBtn.innerHTML = originalText;
                    sendBtn.disabled = false;
                    isSubmitting = false;
                });
        });
    </script>
</body>
</html>
