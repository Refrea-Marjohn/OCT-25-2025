<?php
require_once 'session_manager.php';
validateUserAccess('client');
require_once 'config.php';
require_once 'audit_logger.php';
require_once 'action_logger_helper.php';
$client_id = $_SESSION['user_id'];
$stmt = $conn->prepare("SELECT profile_image, email, name, phone_number FROM user_form WHERE id=?");
$stmt->bind_param("i", $client_id);
$stmt->execute();
$res = $stmt->get_result();
$profile_image = '';
$user_email = '';
$user_name = '';
$user_phone = '';
if ($res && $row = $res->fetch_assoc()) {
    $profile_image = $row['profile_image'];
    $user_email = $row['email'];
    $user_name = $row['name'];
    $user_phone = $row['phone_number'];
}
if (!$profile_image || !file_exists($profile_image)) {
        $profile_image = 'images/default-avatar.jpg';
    }
$cases = [];
$sql = "SELECT ac.*, uf.name as attorney_name FROM attorney_cases ac LEFT JOIN user_form uf ON ac.attorney_id = uf.id WHERE ac.client_id=? ORDER BY ac.created_at DESC";
$stmt = $conn->prepare($sql);
$stmt->bind_param('i', $client_id);
$stmt->execute();
$result = $stmt->get_result();
while ($row = $result->fetch_assoc()) {
    $cases[] = $row;
}

// Ensure document request tables exist (in case attorney page has not created them yet)
$conn->query("CREATE TABLE IF NOT EXISTS document_requests (
    id INT AUTO_INCREMENT PRIMARY KEY,
    case_id INT NOT NULL,
    attorney_id INT NOT NULL,
    client_id INT NOT NULL,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    due_date DATE NULL,
    status ENUM('Requested','Submitted','Reviewed','Approved','Rejected','Called') DEFAULT 'Requested',
    attorney_comment TEXT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);");

// Add attorney_comment column if it doesn't exist
$conn->query("ALTER TABLE document_requests ADD COLUMN IF NOT EXISTS attorney_comment TEXT NULL AFTER status");
$conn->query("CREATE TABLE IF NOT EXISTS document_request_files (
    id INT AUTO_INCREMENT PRIMARY KEY,
    request_id INT NOT NULL,
    client_id INT NOT NULL,
    file_path VARCHAR(500) NOT NULL,
    original_name VARCHAR(255) NOT NULL,
    uploaded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);");

// Client uploads files for a request
if (isset($_POST['action']) && $_POST['action'] === 'upload_request_files') {
    $request_id = intval($_POST['request_id']);
    $upload_dir = __DIR__ . '/uploads/client/';
    if (!is_dir($upload_dir)) { @mkdir($upload_dir, 0777, true); }
    $saved = 0;
    if (!empty($_FILES['files'])) {
        foreach ($_FILES['files']['tmp_name'] as $idx => $tmp) {
            if (!is_uploaded_file($tmp)) continue;
            $orig = basename($_FILES['files']['name'][$idx]);
            $ext = pathinfo($orig, PATHINFO_EXTENSION);
            $safe = $client_id . '_' . time() . '_' . preg_replace('/[^a-zA-Z0-9._-]/','_', $orig);
            $dest = $upload_dir . $safe;
            if (move_uploaded_file($tmp, $dest)) {
                $rel = 'uploads/client/' . $safe;
                $stmt = $conn->prepare("INSERT INTO document_request_files (request_id, client_id, file_path, original_name) VALUES (?, ?, ?, ?)");
                $stmt->bind_param('iiss', $request_id, $client_id, $rel, $orig);
                $stmt->execute();
                $saved++;
            }
        }
    }
    if ($saved > 0) {
        // Update request status and notify attorney
        $stmt = $conn->prepare("UPDATE document_requests SET status='Submitted' WHERE id=?");
        $stmt->bind_param("i", $request_id);
        $stmt->execute();
        
        // Log to audit trail
        global $auditLogger;
        $auditLogger->logAction(
            $client_id,
            $user_name,
            'client',
            'Document Upload',
            'Document Access',
            "Uploaded $saved files for document request ID: $request_id",
            'success',
            'medium'
        );
        if ($conn->query("SHOW TABLES LIKE 'notifications'")->num_rows) {
            $stmt = $conn->prepare("SELECT attorney_id, title FROM document_requests WHERE id=?");
            $stmt->bind_param('i', $request_id);
            $stmt->execute();
            $row = $stmt->get_result()->fetch_assoc();
            if ($row) {
                $nTitle = 'Client Document Submitted';
                $nMsg = 'Client uploaded files for request: ' . $row['title'];
                $userType = 'attorney';
                $notificationType = 'success';
                $stmtN = $conn->prepare("INSERT INTO notifications (user_id, user_type, title, message, type) VALUES (?, ?, ?, ?, ?)");
                $stmtN->bind_param('issss', $row['attorney_id'], $userType, $nTitle, $nMsg, $notificationType);
                $stmtN->execute();
            }
        }
    }
    echo $saved > 0 ? 'success' : 'error';
    exit();
}

// List requests for a given case
if (isset($_POST['action']) && $_POST['action'] === 'list_requests') {
    $case_id = intval($_POST['case_id']);
    $stmt = $conn->prepare("SELECT dr.*, (
        SELECT COUNT(*) FROM document_request_files f WHERE f.request_id = dr.id
    ) as upload_count FROM document_requests dr WHERE dr.case_id=? AND dr.client_id=? ORDER BY dr.created_at DESC");
    $stmt->bind_param('ii', $case_id, $client_id);
    $stmt->execute();
    $rows = $stmt->get_result()->fetch_all(MYSQLI_ASSOC);
    header('Content-Type: application/json');
    echo json_encode($rows);
    exit();
}

// List files for a given request
if (isset($_POST['action']) && $_POST['action'] === 'list_request_files') {
    $request_id = intval($_POST['request_id']);
    $stmt = $conn->prepare("SELECT * FROM document_request_files WHERE request_id=? AND client_id=? ORDER BY uploaded_at DESC");
    $stmt->bind_param('ii', $request_id, $client_id);
    $stmt->execute();
    $rows = $stmt->get_result()->fetch_all(MYSQLI_ASSOC);
    header('Content-Type: application/json');
    echo json_encode($rows);
    exit();
}

// Note: Cases are now managed through attorney_cases table
// Clients can view their cases but cannot add new cases directly
// New cases must be created by attorneys

?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Case Tracking - Opiña Law Office</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="assets/css/dashboard.css?v=<?= time() ?>">
</head>
<body>
    <!-- Sidebar -->
    <div class="sidebar">
                <div class="sidebar-header">
            <img src="images/logo.jpg" alt="Logo">
            <h2>Opiña Law Office</h2>
        </div>
        <ul class="sidebar-menu">
            <li>
                <a href="client_dashboard.php" title="View your case overview, statistics, and recent activities">
                    <div class="button-content">
                        <i class="fas fa-home"></i>
                        <div class="text-content">
                            <span>Dashboard</span>
                            <small>Overview & Statistics</small>
                        </div>
                    </div>
                </a>
            </li>
            <li>
                <a href="client_documents.php" title="Generate legal documents like affidavits and sworn statements">
                    <div class="button-content">
                        <i class="fas fa-file-alt"></i>
                        <div class="text-content">
                            <span>Document Generation</span>
                            <small>Create Legal Documents</small>
                        </div>
                    </div>
                </a>
            </li>
            <li>
                <a href="client_cases.php" class="active" title="Track your legal cases, view case details, and upload documents">
                    <div class="button-content">
                        <i class="fas fa-gavel"></i>
                        <div class="text-content">
                            <span>My Cases</span>
                            <small>Track Legal Cases</small>
                        </div>
                    </div>
                </a>
            </li>
            <li>
                <a href="client_schedule.php" title="View your upcoming appointments, hearings, and court schedules">
                    <div class="button-content">
                        <i class="fas fa-calendar-alt"></i>
                        <div class="text-content">
                            <span>My Schedule</span>
                            <small>Appointments & Hearings</small>
                        </div>
                    </div>
                </a>
            </li>
            <li>
                <a href="client_messages.php" title="Communicate with your attorney and legal team">
                    <div class="button-content">
                        <i class="fas fa-envelope"></i>
                        <div class="text-content">
                            <span>Messages</span>
                            <small>Chat with Attorney</small>
                        </div>
                    </div>
                </a>
            </li>
            <li>
                <a href="client_about.php" title="Learn more about Opiña Law Office and our team">
                    <div class="button-content">
                        <i class="fas fa-info-circle"></i>
                        <div class="text-content">
                            <span>About Us</span>
                            <small>Our Story & Team</small>
                        </div>
                    </div>
                </a>
            </li>
        </ul>
                    </div>

    <!-- Main Content -->
    <div class="main-content">
        <?php 
        $page_title = 'My Cases';
        $page_subtitle = 'Track your cases, status, and schedule';
        include 'components/profile_header.php'; 
        ?>


        <div class="cases-container">
            <div class="cases-grid">
                    <?php foreach ($cases as $case): ?>
                <div class="case-card">
                    <div class="case-header">
                        <div class="case-icon">
                            <i class="fas fa-gavel"></i>
                        </div>
                        <div class="case-info">
                            <h3 class="case-title"><?= htmlspecialchars($case['title']) ?></h3>
                            <p class="case-type"><?= htmlspecialchars(ucfirst(strtolower($case['case_type'] ?? 'General'))) ?></p>
                        </div>
                    </div>
                    
                    <div class="case-status">
                        <span class="status-badge status-<?= strtolower($case['status'] ?? 'active') ?>">
                            <?= htmlspecialchars($case['status'] ?? 'Active') ?>
                        </span>
                    </div>
                    
                    <div class="case-actions">
                        <button class="btn btn-primary btn-view" onclick="viewCaseDetails(<?= $case['id'] ?>)">
                            <i class="fas fa-eye"></i>
                            View Case
                        </button>
                        <button class="btn btn-secondary btn-document" onclick="openRequestsModal(<?= $case['id'] ?>)">
                            <i class="fas fa-file-upload"></i>
                            Document Request
                            </button>
                    </div>
                </div>
                    <?php endforeach; ?>
                
                <?php if (empty($cases)): ?>
                <div class="no-cases">
                    <div class="no-cases-icon">
                        <i class="fas fa-gavel"></i>
                    </div>
                    <h3>No Cases Yet</h3>
                    <p>Your cases will appear here once assigned by your attorney.</p>
                </div>
                <?php endif; ?>
            </div>
        </div>
        <!-- Case Details Modal -->
        <div class="modal" id="caseModal" style="display:none; z-index: 9999 !important;">
            <div class="modal-content professional-modal" style="z-index: 9999 !important;">
                <div class="modal-header professional-header" style="z-index: 9999 !important;">
                    <div class="header-content">
                        <div class="header-icon">
                            <i class="fas fa-balance-scale"></i>
                        </div>
                        <div class="header-text">
                            <h2>Case Information</h2>
                            <p>Legal Case Details</p>
                        </div>
                    </div>
                    <button class="close-modal professional-close" onclick="closeCaseModal()">
                        <i class="fas fa-times"></i>
                    </button>
                </div>
                <div class="modal-body professional-body" id="caseModalBody" style="z-index: 9999 !important;">
                    <!-- Dynamic case details here -->
                </div>
                <div class="modal-footer professional-footer" style="z-index: 9999 !important;">
                    <button class="btn btn-professional" onclick="closeCaseModal()">
                        <i class="fas fa-check"></i>
                        Close
                    </button>
                </div>
            </div>
        </div>

        <!-- Conversation Modal -->
        <div class="modal" id="conversationModal" style="display:none; z-index: 9999 !important;">
            <div class="modal-content" style="max-width:600px; z-index: 9999 !important;">
                <div class="modal-header" style="z-index: 9999 !important;">
                    <h2>Conversation with <span id="convAttorneyName"></span></h2>
                    <button class="close-modal" onclick="closeConversationModal()">&times;</button>
                </div>
                <div class="modal-body" style="z-index: 9999 !important;">
                    <div class="chat-messages" id="convChatMessages" style="height:300px;overflow-y:auto;background:#f9f9f9;padding:16px;border-radius:8px;margin-bottom:10px;"></div>
                    <div class="chat-compose" id="convChatCompose" style="display:flex;gap:10px;">
                        <textarea id="convMessageInput" placeholder="Type your message..." style="flex:1;border-radius:8px;border:1px solid #ddd;padding:10px;resize:none;font-size:1rem;"></textarea>
                        <button class="btn btn-primary" onclick="sendConvMessage()">Send</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- Requests Modal -->
        <div class="modal" id="requestsModal" style="display:none; z-index: 9999 !important;">
            <div class="modal-content" style="max-width:700px; max-height: 90vh; overflow-y: auto; z-index: 9999 !important;">
                <div class="modal-header" style="z-index: 9999 !important;">
                    <h2>Document Requests</h2>
                    <button class="close-modal" onclick="closeRequestsModal()">&times;</button>
                </div>
                <div class="modal-body" style="z-index: 9999 !important;">
                    <div id="clientRequestsList" style="margin-bottom:12px;"></div>
                    <form id="uploadRequestForm" style="display:none;">
                        <input type="hidden" name="request_id" id="uploadRequestId">
                        <div class="form-group">
                            <label>Upload Files</label>
                            <input type="file" name="files[]" multiple required>
                            <small style="color:#666;">Accepted: PDF, JPG, PNG. Max 10MB each.</small>
                        </div>
                        <div class="form-actions">
                            <button type="button" class="btn btn-secondary" onclick="closeRequestsModal()">Close</button>
                            <button type="submit" class="btn btn-primary">Submit Files</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <style>
        .cases-container { background: #fff; border-radius: 12px; box-shadow: 0 2px 8px rgba(0,0,0,0.07); padding: 24px; margin-top: 24px; }
        
        /* Cases Grid Layout */
        .cases-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 24px;
            margin-top: 20px;
        }
        
        /* Case Card Styling */
        .case-card {
            background: white;
            border-radius: 16px;
            padding: 24px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
            border: 1px solid #f0f0f0;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }
        
        .case-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.12);
        }
        
        .case-header {
            display: flex;
            align-items: center;
            gap: 16px;
            margin-bottom: 20px;
        }
        
        .case-icon {
            width: 48px;
            height: 48px;
            background: linear-gradient(135deg, #800000, #A52A2A);
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1.2rem;
        }
        
        .case-info {
            flex: 1;
        }
        
        .case-title {
            margin: 0 0 4px 0;
            font-size: 1.1rem;
            font-weight: 600;
            color: #333;
            line-height: 1.3;
        }
        
        .case-type {
            margin: 0;
            font-size: 0.9rem;
            color: #666;
            font-weight: 500;
        }
        
        .case-status {
            margin-bottom: 20px;
            text-align: center;
        }
        
        .case-actions {
            display: flex;
            gap: 12px;
            flex-wrap: wrap;
        }
        
        .btn-view, .btn-document {
            flex: 1;
            min-width: 120px;
            padding: 12px 16px;
            border-radius: 8px;
            font-weight: 600;
            font-size: 0.9rem;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }
        
        .btn-view {
            background: linear-gradient(135deg, #800000, #A52A2A);
            color: white;
            border: none;
        }
        
        .btn-view:hover {
            background: linear-gradient(135deg, #660000, #8B0000);
            transform: translateY(-1px);
        }
        
        .btn-document {
            background: #6c757d;
            color: white;
            border: none;
        }
        
        .btn-document:hover {
            background: #5a6268;
            transform: translateY(-1px);
        }
        
        /* No Cases State */
        .no-cases {
            grid-column: 1 / -1;
            text-align: center;
            padding: 60px 20px;
            color: #666;
        }
        
        .no-cases-icon {
            font-size: 3rem;
            color: #ddd;
            margin-bottom: 20px;
        }
        
        .no-cases h3 {
            margin: 0 0 10px 0;
            color: #333;
        }
        
        .no-cases p {
            margin: 0;
            font-size: 0.95rem;
        }
        
        /* Status Badges */
        .status-badge { 
            padding: 8px 16px; 
            border-radius: 20px; 
            font-size: 0.85rem; 
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        .status-active { background: #e8f5e8; color: #2e7d32; }
        .status-requested { background: #fff3cd; color: #856404; }
        .status-submitted { background: #d1ecf1; color: #0c5460; }
        .status-reviewed { background: #e2e3f5; color: #4a148c; }
        .status-approved { background: #e8f5e8; color: #2e7d32; }
        .status-rejected { background: #f8d7da; color: #721c24; }
        .status-called { background: #f8f9fa; color: #495057; }
        
        /* Responsive Design */
        @media (max-width: 1200px) {
            .cases-grid {
                grid-template-columns: repeat(2, 1fr);
                gap: 20px;
            }
        }
        
        @media (max-width: 768px) {
            .cases-grid {
                grid-template-columns: 1fr;
                gap: 16px;
            }
            
            .case-card {
                padding: 20px;
            }
            
            .case-actions {
                flex-direction: column;
            }
            
            .btn-view, .btn-document {
                min-width: auto;
            }
        }
        /* Professional Modal Styling */
        .modal {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.6);
            backdrop-filter: blur(8px);
            display: flex;
            justify-content: center;
            align-items: center;
            z-index: 9999;
            animation: modalFadeIn 0.3s ease-out;
        }
        
        @keyframes modalFadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }
        
        .professional-modal {
            background: white;
            border-radius: 24px;
            padding: 0;
            max-width: 800px;
            width: 90%;
            max-height: 85vh;
            overflow: hidden;
            box-shadow: 0 25px 50px rgba(0, 0, 0, 0.25);
            display: flex;
            flex-direction: column;
            margin: 0 auto;
            border: 1px solid rgba(0, 0, 0, 0.08);
            animation: modalSlideIn 0.4s ease-out;
        }
        
        @keyframes modalSlideIn {
            from { 
                opacity: 0;
                transform: translateY(-30px) scale(0.95);
            }
            to { 
                opacity: 1;
                transform: translateY(0) scale(1);
            }
        }
        
        .professional-header {
            background: linear-gradient(135deg, #800000 0%, #A52A2A 100%);
            color: white;
            padding: 24px 32px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 4px 20px rgba(128, 0, 0, 0.3);
        }
        
        .header-content {
            display: flex;
            align-items: center;
            gap: 16px;
        }
        
        .header-icon {
            width: 48px;
            height: 48px;
            background: rgba(255, 255, 255, 0.2);
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
        }
        
        .header-text h2 {
            margin: 0;
            font-size: 1.5rem;
            font-weight: 700;
            letter-spacing: 0.5px;
        }
        
        .header-text p {
            margin: 4px 0 0 0;
            font-size: 0.9rem;
            opacity: 0.9;
        }
        
        .professional-close {
            background: rgba(255, 255, 255, 0.15);
            border: none;
            color: white;
            cursor: pointer;
            padding: 12px;
            width: 44px;
            height: 44px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 12px;
            transition: all 0.3s ease;
            font-size: 1.2rem;
        }
        
        .professional-close:hover {
            background: rgba(255, 255, 255, 0.25);
            transform: scale(1.05);
        }
        
        .professional-body {
            padding: 32px;
            overflow-y: auto;
            flex: 1;
            background: #f8fafc;
        }
        
        .professional-footer {
            padding: 20px 32px;
            border-top: 1px solid #e2e8f0;
            background: white;
            text-align: center;
        }
        
        .btn-professional {
            background: linear-gradient(135deg, #800000 0%, #A52A2A 100%);
            color: white;
            padding: 14px 28px;
            border-radius: 12px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            border: none;
            font-size: 1rem;
            letter-spacing: 0.3px;
            box-shadow: 0 4px 15px rgba(128, 0, 0, 0.3);
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }
        
        .btn-professional:hover {
            background: linear-gradient(135deg, #660000 0%, #8B0000 100%);
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(128, 0, 0, 0.4);
        }
        
        /* Case Info Container */
        .case-info-container {
            display: flex;
            flex-direction: column;
            gap: 24px;
        }
        
        .case-overview {
            background: white;
            border-radius: 16px;
            padding: 24px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
            border: 1px solid #e2e8f0;
        }
        
        .case-title-section {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            gap: 20px;
        }
        
        .case-title-main {
            margin: 0;
            font-size: 1.8rem;
            font-weight: 700;
            color: #800000;
            line-height: 1.3;
            flex: 1;
        }
        
        .case-status-display {
            display: flex;
            align-items: center;
            gap: 8px;
            background: #f1f5f9;
            padding: 8px 16px;
            border-radius: 20px;
            border: 1px solid #e2e8f0;
        }
        
        .status-indicator {
            width: 8px;
            height: 8px;
            border-radius: 50%;
        }
        
        .status-indicator.status-active { background: #10b981; }
        .status-indicator.status-pending { background: #f59e0b; }
        .status-indicator.status-closed { background: #6b7280; }
        
        .status-text {
            font-weight: 600;
            color: #374151;
            font-size: 0.9rem;
        }
        
        /* Case Details Grid */
        .case-details-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
        }
        
        .detail-card {
            background: white;
            border-radius: 16px;
            padding: 20px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
            border: 1px solid #e2e8f0;
            display: flex;
            align-items: center;
            gap: 16px;
            transition: all 0.3s ease;
        }
        
        .detail-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.12);
        }
        
        .detail-icon {
            width: 48px;
            height: 48px;
            background: linear-gradient(135deg, #800000 0%, #A52A2A 100%);
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1.2rem;
            flex-shrink: 0;
        }
        
        .detail-content {
            flex: 1;
        }
        
        .detail-content label {
            display: block;
            font-weight: 600;
            color: #6b7280;
            font-size: 0.85rem;
            text-transform: uppercase;
            letter-spacing: 0.8px;
            margin-bottom: 4px;
        }
        
        .detail-content span {
            color: #1f2937;
            font-size: 1rem;
            font-weight: 600;
            line-height: 1.4;
        }
        
        /* Description and Hearing Sections */
        .case-description, .case-hearing {
            background: white;
            border-radius: 16px;
            padding: 24px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
            border: 1px solid #e2e8f0;
        }
        
        .description-header, .hearing-header {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 16px;
            padding-bottom: 12px;
            border-bottom: 2px solid #f1f5f9;
        }
        
        .description-header i, .hearing-header i {
            color: #800000;
            font-size: 1.2rem;
        }
        
        .description-header h4, .hearing-header h4 {
            margin: 0;
            color: #800000;
            font-size: 1.1rem;
            font-weight: 700;
        }
        
        .description-content p, .hearing-content p {
            margin: 0;
            color: #4b5563;
            font-size: 1rem;
            line-height: 1.6;
        }
        
        /* Responsive Design */
        @media (max-width: 768px) {
            .professional-modal {
                width: 95%;
                max-height: 90vh;
                margin: 20px auto;
            }
            
            .professional-header {
                padding: 20px 24px;
            }
            
            .header-content {
                gap: 12px;
            }
            
            .header-icon {
                width: 40px;
                height: 40px;
                font-size: 1.2rem;
            }
            
            .header-text h2 {
                font-size: 1.3rem;
            }
            
            .professional-body {
                padding: 24px 20px;
            }
            
            .professional-footer {
                padding: 16px 20px;
            }
            
            .case-title-section {
                flex-direction: column;
                gap: 16px;
                align-items: flex-start;
            }
            
            .case-title-main {
                font-size: 1.5rem;
            }
            
            .case-details-grid {
                grid-template-columns: 1fr;
                gap: 16px;
            }
            
            .detail-card {
                padding: 16px;
            }
            
            .detail-icon {
                width: 40px;
                height: 40px;
                font-size: 1rem;
            }
            
            .case-description, .case-hearing {
                padding: 20px;
            }
        }
    </style>
    <script>
        let convAttorneyId = null;
        function openConversationModal(attorneyId, attorneyName) {
            convAttorneyId = attorneyId;
            document.getElementById('convAttorneyName').innerText = attorneyName;
            document.getElementById('conversationModal').style.display = 'block';
            fetchConvMessages();
        }
        function closeConversationModal() {
            document.getElementById('conversationModal').style.display = 'none';
            document.getElementById('convChatMessages').innerHTML = '';
            document.getElementById('convMessageInput').value = '';
        }
        function fetchConvMessages() {
            if (!convAttorneyId) return;
            const fd = new FormData();
            fd.append('action', 'fetch_messages');
            fd.append('attorney_id', convAttorneyId);
            fetch('client_messages.php', { method: 'POST', body: fd })
                .then(r => r.json()).then(msgs => {
                    const chat = document.getElementById('convChatMessages');
                    chat.innerHTML = '';
                    msgs.forEach(m => {
                        const sent = m.sender === 'client';
                        chat.innerHTML += `<div class='message-bubble ${sent ? 'sent' : 'received'}'><div class='message-text'><p>${m.message}</p></div><div class='message-meta'><span class='message-time'>${m.sent_at}</span></div></div>`;
                    });
                    chat.scrollTop = chat.scrollHeight;
                });
        }
        function sendConvMessage() {
            const input = document.getElementById('convMessageInput');
            if (!input.value.trim() || !convAttorneyId) return;
            const fd = new FormData();
            fd.append('action', 'send_message');
            fd.append('attorney_id', convAttorneyId);
            fd.append('message', input.value);
            fetch('client_messages.php', { method: 'POST', body: fd })
                .then(r => r.text()).then(res => {
                    if (res === 'success') {
                        input.value = '';
                        fetchConvMessages();
                    } else {
                        alert('Error sending message.');
                    }
                });
        }
        // Requests UX
        let activeCaseId = null;
        function closeCaseModal() {
            document.getElementById('caseModal').style.display = 'none';
        }
        
        function viewCaseDetails(caseId) {
            // Find the case data
            const cases = <?= json_encode($cases) ?>;
            const caseData = cases.find(c => c.id == caseId);
            
            if (!caseData) {
                alert('Case not found');
                return;
            }
            
            // Populate modal with case details
            const modalBody = document.getElementById('caseModalBody');
            modalBody.innerHTML = `
                <div class="case-info-container">
                    <div class="case-overview">
                        <div class="case-title-section">
                            <h3 class="case-title-main">${caseData.title}</h3>
                            <div class="case-status-display">
                                <span class="status-indicator status-${(caseData.status || 'active').toLowerCase()}"></span>
                                <span class="status-text">${caseData.status || 'Active'}</span>
                            </div>
                        </div>
                    </div>
                    
                    <div class="case-details-grid">
                        <div class="detail-card">
                            <div class="detail-icon">
                                <i class="fas fa-folder-open"></i>
                            </div>
                            <div class="detail-content">
                                <label>Case Type</label>
                                <span>${caseData.case_type || 'General Legal Matter'}</span>
                            </div>
                        </div>
                        
                        <div class="detail-card">
                            <div class="detail-icon">
                                <i class="fas fa-user-tie"></i>
                            </div>
                            <div class="detail-content">
                                <label>Assigned Attorney</label>
                                <span>${caseData.attorney_name || 'Not Assigned'}</span>
                            </div>
                        </div>
                        
                        <div class="detail-card">
                            <div class="detail-icon">
                                <i class="fas fa-calendar-plus"></i>
                            </div>
                            <div class="detail-content">
                                <label>Date Filed</label>
                                <span>${new Date(caseData.created_at).toLocaleDateString('en-US', { 
                                    year: 'numeric', 
                                    month: 'long', 
                                    day: 'numeric' 
                                })}</span>
                            </div>
                        </div>
                        
                        <div class="detail-card">
                            <div class="detail-icon">
                                <i class="fas fa-clock"></i>
                            </div>
                            <div class="detail-content">
                                <label>Last Updated</label>
                                <span>${new Date(caseData.updated_at || caseData.created_at).toLocaleDateString('en-US', { 
                                    year: 'numeric', 
                                    month: 'long', 
                                    day: 'numeric' 
                                })}</span>
                            </div>
                        </div>
                    </div>
                    
                    ${caseData.description ? `
                    <div class="case-description">
                        <div class="description-header">
                            <i class="fas fa-file-alt"></i>
                            <h4>Case Description</h4>
                        </div>
                        <div class="description-content">
                            <p>${caseData.description}</p>
                        </div>
                    </div>
                    ` : ''}
                    
                    ${caseData.next_hearing ? `
                    <div class="case-hearing">
                        <div class="hearing-header">
                            <i class="fas fa-gavel"></i>
                            <h4>Next Hearing</h4>
                        </div>
                        <div class="hearing-content">
                            <p>${caseData.next_hearing}</p>
                        </div>
                    </div>
                    ` : ''}
                </div>
            `;
            
            // Show the modal
            document.getElementById('caseModal').style.display = 'block';
        }
        
        function openRequestsModal(caseId) {
            activeCaseId = caseId;
            document.getElementById('clientRequestsList').innerHTML = '';
            document.getElementById('requestsModal').style.display = 'block';
            fetchClientRequests();
        }
        function closeRequestsModal() {
            document.getElementById('requestsModal').style.display = 'none';
            document.getElementById('uploadRequestForm').style.display = 'none';
        }
        function fetchClientRequests() {
            if (!activeCaseId) return;
            const fd = new FormData();
            fd.append('action','list_requests');
            fd.append('case_id', activeCaseId);
            fetch('client_cases.php', { method:'POST', body: fd })
                .then(r => {
                    if (!r.ok) {
                        throw new Error('Network response was not ok');
                    }
                    return r.json();
                })
                .then(rows=>{
                    const wrap = document.getElementById('clientRequestsList');
                    if (!wrap) {
                        console.error('clientRequestsList element not found');
                        return;
                    }
                    if (!rows.length) { 
                        wrap.innerHTML = '<p style="color:#888;">No document requests yet.</p>'; 
                        return; 
                    }
                    wrap.innerHTML = rows.map(r=>`
                         <div style="border:1px solid #eee;border-radius:8px;padding:10px;margin-bottom:8px;">
                             <div style="display:flex;justify-content:space-between;align-items:flex-start;gap:12px;">
                                 <div style="flex:1;">
                                     <div style="display:flex;align-items:center;gap:8px;margin-bottom:6px;">
                                         <strong>${r.title}</strong>
                                         <span class="status-badge status-${(r.status||'Requested').toLowerCase()}" style="padding:4px 8px;border-radius:12px;font-size:0.8rem;font-weight:500;">${r.status}</span>
                                     </div>
                                     <div style="color:#666;margin-bottom:4px;">${r.description || ''}</div>
                                     <div style="color:#888;font-size:0.9rem;">Due: ${r.due_date || '—'} • Uploads: ${r.upload_count}</div>
                                     <div style="color:#aaa;font-size:0.85rem;">Created: ${r.created_at}</div>
                                     ${r.attorney_comment ? `<div style="color:#1976d2;margin-top:4px;font-style:italic;background:#f0f8ff;padding:8px;border-radius:6px;border-left:3px solid #1976d2;"><strong>Attorney Feedback:</strong> ${r.attorney_comment}</div>` : ''}
                                     <div id="clientFiles-${r.id}" style="margin-top:8px;display:none;background:#f9f9f9;border:1px solid #eee;padding:8px;border-radius:6px;"></div>
                                 </div>
                                 <div style="display:flex;flex-direction:column;gap:6px;">
                                     <button class="btn btn-info btn-xs" onclick="viewClientFiles(${r.id})"><i class='fas fa-folder-open'></i> View Files</button>
                                     ${r.status === 'Requested' || r.status === 'Called' ? `<button class="btn btn-primary btn-xs" onclick="startUpload(${r.id})"><i class='fas fa-upload'></i> Upload</button>` : ''}
                                 </div>
                             </div>
                         </div>
                     `).join('');
                })
                .catch(error => {
                    console.error('Error fetching client requests:', error);
                    const wrap = document.getElementById('clientRequestsList');
                    if (wrap) {
                        wrap.innerHTML = '<p style="color:#dc3545;">Error loading document requests. Please try again.</p>';
                    }
                });
        }
        function startUpload(requestId) {
            document.getElementById('uploadRequestId').value = requestId;
            document.getElementById('uploadRequestForm').style.display = 'block';
        }
        
        function viewClientFiles(requestId) {
            const box = document.getElementById('clientFiles-'+requestId);
            if (!box) {
                console.error('Files container not found for request ID:', requestId);
                return;
            }
            
            const fd = new FormData();
            fd.append('action','list_request_files');
            fd.append('request_id', requestId);
            fetch('client_cases.php', { method:'POST', body: fd })
                .then(r => {
                    if (!r.ok) {
                        throw new Error('Network response was not ok');
                    }
                    return r.json();
                })
                .then(files=>{
                    if (files.length===0) { 
                        box.innerHTML = '<em style="color:#888;">No files uploaded yet.</em>'; 
                    } else {
                        box.innerHTML = files.map(f=>`
                            <div style="display:flex;justify-content:space-between;align-items:center;gap:8px;margin-bottom:6px;">
                                <a href="${f.file_path}" target="_blank" style="color:#1976d2;text-decoration:none;">
                                    <i class="fas fa-file"></i> ${f.original_name}
                                </a>
                                <span style="color:#888;font-size:0.85rem;">${f.uploaded_at}</span>
                            </div>
                        `).join('');
                    }
                    box.style.display = box.style.display === 'none' ? 'block' : 'none';
                })
                .catch(error => {
                    console.error('Error fetching client files:', error);
                    box.innerHTML = '<em style="color:#dc3545;">Error loading files. Please try again.</em>';
                    box.style.display = 'block';
                });
        }
        // Initialize form submission handler when DOM is ready
        document.addEventListener('DOMContentLoaded', function() {
            const uploadForm = document.getElementById('uploadRequestForm');
            if (uploadForm) {
                uploadForm.onsubmit = function(e){
                    e.preventDefault();
                    const fd = new FormData(this);
                    fd.append('action','upload_request_files');
                    fetch('client_cases.php', { method:'POST', body: fd })
                        .then(r => {
                            if (!r.ok) {
                                throw new Error('Network response was not ok');
                            }
                            return r.text();
                        })
                        .then(res=>{
                            if (res==='success') {
                                alert('Files submitted.');
                                this.reset();
                                document.getElementById('uploadRequestForm').style.display = 'none';
                                fetchClientRequests();
                            } else {
                                alert('Upload failed. Please try again.');
                            }
                        })
                        .catch(error => {
                            console.error('Error uploading files:', error);
                            alert('Upload failed. Please try again.');
                        });
                };
            }
        });
        
        // Profile dropdown functions removed - profile is non-clickable on this page

        function closeEditProfileModal() {
            document.getElementById('editProfileModal').style.display = 'none';
        }
        
        // Close dropdown when clicking outside
        window.onclick = function(event) {
            if (!event.target.matches('img') && !event.target.closest('.profile-dropdown')) {
                const dropdowns = document.getElementsByClassName('profile-dropdown-content');
                for (let dropdown of dropdowns) {
                    if (dropdown.classList.contains('show')) {
                        dropdown.classList.remove('show');
                    }
                }
            }
            
            // Modal close on outside click removed - users must use buttons to close
        }

        function previewImage(input) {
            if (input.files && input.files[0]) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    document.getElementById('currentProfileImage').src = e.target.result;
                };
                reader.readAsDataURL(input.files[0]);
            }
        }

        // Handle form submission - REMOVED since we now use password verification
        // The form submission is now handled by verifyPasswordAndSave() function

        // Password verification functions
        function verifyPasswordBeforeSave() {
            console.log('verifyPasswordBeforeSave called'); // Debug log
            
            // Validate phone number first
            const phoneInput = document.getElementById('phone_number');
            const phoneNumber = phoneInput.value.trim();
            
            if (phoneNumber && !/^09\d{9}$/.test(phoneNumber)) {
                alert('Phone number must be exactly 11 digits starting with 09 (e.g., 09123456789)');
                phoneInput.focus();
                return;
            }
            
            // Show confirmation first
            if (confirm('Are you sure you want to save these changes to your profile?')) {
                console.log('User confirmed, hiding edit modal and showing password modal'); // Debug log
                // Hide the edit profile modal
                document.getElementById('editProfileModal').style.display = 'none';
                // Show the password verification modal
                document.getElementById('passwordVerificationModal').style.display = 'block';
            }
        }

        function closePasswordVerificationModal() {
            document.getElementById('passwordVerificationModal').style.display = 'none';
            document.getElementById('current_password').value = '';
            // Show the edit profile modal again
            document.getElementById('editProfileModal').style.display = 'block';
        }

        // Phone number validation function
        function validatePhoneNumber(input) {
            let value = input.value.replace(/\D/g, ''); // Remove non-digits
            if (value.length > 11) {
                value = value.substring(0, 11);
            }
            input.value = value;
            
            // Visual feedback
            if (value.length === 11 && /^09\d{9}$/.test(value)) {
                input.style.borderColor = '#28a745'; // Green for valid
            } else if (value.length > 0) {
                input.style.borderColor = '#dc3545'; // Red for invalid
            } else {
                input.style.borderColor = '#e1e5e9'; // Default
            }
        }

        // Handle password verification form submission
        document.addEventListener('DOMContentLoaded', function() {
            const passwordForm = document.getElementById('passwordVerificationForm');
            if (passwordForm) {
                passwordForm.addEventListener('submit', function(e) {
                    e.preventDefault();
                    
                    const password = document.getElementById('current_password').value;
                    if (!password) {
                        alert('Please enter your current password');
                        return;
                    }

                    // Verify password and save profile
                    verifyPasswordAndSave(password);
                });
            }
        });

        function verifyPasswordAndSave(password) {
            const formData = new FormData(document.getElementById('editProfileForm'));
            formData.append('current_password', password);
            formData.append('security_token', generateSecurityToken());

            fetch('update_profile.php', {
                method: 'POST',
                body: formData
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert('Profile updated successfully!');
                    closePasswordVerificationModal();
                    closeEditProfileModal();
                    location.reload();
                } else {
                    alert('Error: ' + data.message);
                    if (data.message.includes('password')) {
                        document.getElementById('current_password').value = '';
                        document.getElementById('current_password').focus();
                    }
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('An error occurred while updating the profile.');
            });
        }

        function generateSecurityToken() {
            return Date.now().toString(36) + Math.random().toString(36).substr(2);
        }
    </script>
</body>
</html> 