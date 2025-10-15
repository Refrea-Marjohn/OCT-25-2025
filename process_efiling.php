<?php
session_start();
header('Content-Type: application/json');

require_once 'config.php';
require_once 'vendor/autoload.php';
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

// Security: allow attorneys and admins (admin may also act as attorney)
if (!isset($_SESSION['user_id']) || !in_array($_SESSION['user_type'] ?? '', ['attorney','admin_attorney','admin'])) {
    echo json_encode(['status' => 'error', 'message' => 'Unauthorized']);
    exit();
}

$attorney_id = (int)$_SESSION['user_id'];

// Get attorney details for email
$stmt = $conn->prepare("SELECT name, email FROM user_form WHERE id=?");
$stmt->bind_param("i", $attorney_id);
$stmt->execute();
$res = $stmt->get_result();
$attorney_name = '';
$attorney_email = '';
if ($res && $row = $res->fetch_assoc()) {
    $attorney_name = $row['name'];
    $attorney_email = $row['email'];
}

// Handle clear history request
if (isset($_POST['action']) && $_POST['action'] === 'clear_history') {
    // Delete all eFiling history for this attorney
    $stmt = $conn->prepare("DELETE FROM efiling_history WHERE attorney_id=?");
    $stmt->bind_param("i", $attorney_id);
    $stmt->execute();
    
    // Also delete the stored files
    $stmt = $conn->prepare("SELECT stored_file_path FROM efiling_history WHERE attorney_id=?");
    $stmt->bind_param("i", $attorney_id);
    $stmt->execute();
    $res = $stmt->get_result();
    
    while ($row = $res->fetch_assoc()) {
        if (!empty($row['stored_file_path']) && file_exists($row['stored_file_path'])) {
            unlink($row['stored_file_path']);
        }
    }
    
    // Clean up any orphaned files in efiling directory
    $efilingDir = 'uploads/efiling/';
    if (is_dir($efilingDir)) {
        $files = glob($efilingDir . 'ef_*');
        foreach ($files as $file) {
            if (is_file($file)) {
                unlink($file);
            }
        }
    }
    
    echo json_encode(['status' => 'success', 'message' => 'All eFiling history cleared']);
    exit();
}

// Validate inputs
$case_id = isset($_POST['case_id']) && $_POST['case_id'] !== '' ? (int)$_POST['case_id'] : null;
$document_category = trim($_POST['document_category'] ?? '');
$receiver_email = trim($_POST['receiver_email'] ?? '');
$receiver_email_confirm = trim($_POST['receiver_email_confirm'] ?? '');
$desired_filename = trim($_POST['desired_filename'] ?? '');
$message = trim($_POST['message'] ?? '');

if ($receiver_email === '' || $receiver_email_confirm === '' || $desired_filename === '' || $document_category === '') {
    echo json_encode(['status' => 'error', 'message' => 'Please complete all required fields.']);
    exit();
}

if (strtolower($receiver_email) !== strtolower($receiver_email_confirm)) {
    echo json_encode(['status' => 'error', 'message' => 'Receiver emails do not match.']);
    exit();
}

// Check if file was uploaded
if (!isset($_FILES['document']) || $_FILES['document']['error'] !== UPLOAD_ERR_OK) {
    echo json_encode(['status' => 'error', 'message' => 'No file uploaded or upload error occurred.']);
    exit();
}

// Check file size (max 5MB)
$file_size = $_FILES['document']['size'];
$max_file_size = 5 * 1024 * 1024; // 5MB
if ($file_size > $max_file_size) {
    echo json_encode(['status' => 'error', 'message' => 'File size too large. Maximum allowed size is 5MB.']);
    exit();
}

if (!filter_var($receiver_email, FILTER_VALIDATE_EMAIL)) {
    echo json_encode(['status' => 'error', 'message' => 'Invalid email address.']);
    exit();
}

if (!isset($_FILES['document']) || $_FILES['document']['error'] !== UPLOAD_ERR_OK) {
    echo json_encode(['status' => 'error', 'message' => 'Document upload failed.']);
    exit();
}

// Validate file size and type
$allowed_ext = ['pdf'];
$uploaded_name = $_FILES['document']['name'];
$uploaded_tmp = $_FILES['document']['tmp_name'];
$uploaded_ext = strtolower(pathinfo($uploaded_name, PATHINFO_EXTENSION));
$original_file_name = $uploaded_name; // Store the original uploaded filename

if (!in_array($uploaded_ext, $allowed_ext, true)) {
    echo json_encode(['status' => 'error', 'message' => 'Only PDF files are allowed.']);
    exit();
}

if (filesize($uploaded_tmp) > 5 * 1024 * 1024) { // 5MB
    echo json_encode(['status' => 'error', 'message' => 'File too large (max 5MB).']);
    exit();
}

// Ensure desired filename has same extension
// Force desired filename to .pdf and sanitize
$base = pathinfo($desired_filename, PATHINFO_FILENAME);
$base = trim($base);
if ($base === '') { $base = 'document'; }
// Replace spaces with underscores and strip unsafe chars
$base = preg_replace('/\s+/', '_', $base);
$base = preg_replace('/[^A-Za-z0-9._-]/', '', $base);
if ($base === '' || $base === '.' || $base === '..') { $base = 'document'; }
$desired_filename = $base . '.pdf';

// Get case details if case is selected
$case_title = '';
$case_type = '';
$case_client = '';

if ($case_id) {
    // Check if current user is admin - admins can access all cases
    $is_admin = ($_SESSION['user_type'] ?? '') === 'admin';
    
    if ($is_admin) {
        // Admin can access any case
        $stmt = $conn->prepare("SELECT ac.title, ac.case_type, uf.name as client_name FROM attorney_cases ac LEFT JOIN user_form uf ON ac.client_id = uf.id WHERE ac.id = ?");
        $stmt->bind_param("i", $case_id);
    } else {
        // Attorney can only access their own cases
        $stmt = $conn->prepare("SELECT ac.title, ac.case_type, uf.name as client_name FROM attorney_cases ac LEFT JOIN user_form uf ON ac.client_id = uf.id WHERE ac.id = ? AND ac.attorney_id = ?");
        $stmt->bind_param("ii", $case_id, $attorney_id);
    }
    
    $stmt->execute();
    $res = $stmt->get_result();
    if ($res && $row = $res->fetch_assoc()) {
        $case_title = $row['title'];
        $case_type = $row['case_type'];
        $case_client = $row['client_name'];
    } else {
        echo json_encode(['status' => 'error', 'message' => 'Invalid case selected.']);
        exit();
    }
}

// Move the uploaded file to a permanent storage directory
$uploadDir = 'uploads/efiling/';
if (!is_dir($uploadDir)) {
    mkdir($uploadDir, 0755, true);
}

// Create unique filename to avoid conflicts
$uniqueFilename = uniqid('ef_', true) . '_' . $desired_filename;
$targetPath = $uploadDir . $uniqueFilename;
if (!move_uploaded_file($uploaded_tmp, $targetPath)) {
    echo json_encode(['status' => 'error', 'message' => 'Could not process the uploaded file.']);
    exit();
}

// Prepare email
$mail = new PHPMailer(true);
$status = 'Failed';

// Set execution time limit for optimal performance
set_time_limit(60); // 1 minute for 5MB max files
ini_set('memory_limit', '128M'); // Sufficient memory for 5MB files
ini_set('max_execution_time', 60); // 1 minute execution time

try {
    if (defined('MAIL_DEBUG') && MAIL_DEBUG) {
        $mail->SMTPDebug = 2;
    }
    $mail->isSMTP();
    $mail->Host = MAIL_HOST;
    $mail->SMTPAuth = true;
    $mail->Username = MAIL_USERNAME;
    $mail->Password = MAIL_PASSWORD;
    
    // Try STARTTLS first (more reliable for Gmail)
    $mail->SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS;
    $mail->Port = 587;
    
    // Optimize for faster sending
    $mail->SMTPOptions = array(
        'ssl' => array(
            'verify_peer' => false,
            'verify_peer_name' => false,
            'allow_self_signed' => true
        )
    );
    $mail->Timeout = 60; // 1 minute timeout for 5MB max files
    $mail->SMTPKeepAlive = false; // Disable keep-alive to avoid connection issues
    $mail->SMTPAutoTLS = true; // Enable auto TLS for better compatibility
    $mail->Debugoutput = 'error_log'; // Log errors for debugging
    $mail->SMTPDebug = 0; // Disable debug output for production
    
    // Additional connection settings for stability
    $mail->SMTPOptions['ssl']['crypto_method'] = STREAM_CRYPTO_METHOD_TLS_CLIENT;
    $mail->CharSet = 'UTF-8';
    $mail->setFrom(MAIL_FROM, MAIL_FROM_NAME);
    $mail->addAddress($receiver_email);
    if (defined('MAIL_FROM') && defined('MAIL_FROM_NAME')) {
        $mail->addReplyTo(MAIL_FROM, MAIL_FROM_NAME);
    }

    // Build professional court submission email body
    $body = "<div style='font-family: Arial, sans-serif; line-height: 1.6; color: #333; max-width: 600px; margin: 0 auto;'>" .
            "<div style='background: #f8f9fa; padding: 20px; border-left: 4px solid #7C0F2F; margin-bottom: 20px;'>" .
            "<h2 style='margin: 0; color: #7C0F2F; font-size: 18px; font-weight: 600;'>OFFICIAL COURT FILING SUBMISSION</h2>" .
            "</div>" .
            
            "<p style='margin-bottom: 15px;'><strong>To:</strong> Honorable Court</p>" .
            "<p style='margin-bottom: 15px;'><strong>From:</strong> " . htmlspecialchars($attorney_name) . " - Opiña Law Office</p>" .
            "<p style='margin-bottom: 15px;'><strong>Attorney Email:</strong> " . htmlspecialchars($attorney_email) . "</p>" .
            "<p style='margin-bottom: 20px;'><strong>Date:</strong> " . date('F d, Y \a\t g:i A') . "</p>" .
            
            "<div style='background: #fff; border: 1px solid #e0e0e0; padding: 20px; border-radius: 8px; margin-bottom: 20px;'>" .
            "<p style='margin-bottom: 15px; font-size: 16px;'>Respectfully submitted for filing and consideration of this Honorable Court:</p>" .
            
            "<div style='background: #f8f9fa; padding: 15px; border-radius: 6px; margin: 15px 0;'>" .
            "<h3 style='margin: 0 0 10px 0; color: #7C0F2F; font-size: 14px;'>FILING DETAILS:</h3>" .
            "<table style='width: 100%; border-collapse: collapse;'>" .
            "<tr><td style='padding: 5px 0; font-weight: 600; width: 30%;'>Document Category:</td><td style='padding: 5px 0;'>" . htmlspecialchars($document_category) . "</td></tr>" .
            "<tr><td style='padding: 5px 0; font-weight: 600;'>Document:</td><td style='padding: 5px 0;'>" . htmlspecialchars($desired_filename) . "</td></tr>" .
            "<tr><td style='padding: 5px 0; font-weight: 600;'>Submission Date:</td><td style='padding: 5px 0;'>" . date('F d, Y') . "</td></tr>" .
            "</table>" .
            "</div>" .
            
            ($message !== '' ? 
                "<div style='background: #fff3cd; border: 1px solid #ffeaa7; padding: 15px; border-radius: 6px; margin: 15px 0;'>" .
                "<h4 style='margin: 0 0 10px 0; color: #856404; font-size: 14px;'>ATTORNEY'S NOTES:</h4>" .
                "<p style='margin: 0; font-style: italic;'>" . nl2br(htmlspecialchars($message)) . "</p>" .
                "</div>" : '') .
            
            "<p style='margin: 20px 0 10px 0; font-size: 16px;'>Please find the attached document for your review and filing.</p>" .
            "</div>" .
            
            "<div style='background: #f8f9fa; padding: 15px; border-radius: 6px; text-align: center; margin-top: 20px;'>" .
            "<p style='margin: 0; font-size: 12px; color: #666;'>" .
            "<strong>OPIÑA LAW OFFICE</strong><br>" .
            "Submitted by: " . htmlspecialchars($attorney_name) . "<br>" .
            "Attorney Email: " . htmlspecialchars($attorney_email) . "<br>" .
            "Electronic Filing System<br>" .
            "Submitted on " . date('F d, Y \a\t g:i A') . "<br>" .
            "Reference ID: EF-" . date('YmdHis') .
            "</p>" .
            "</div>" .
            
            "<hr style='border: none; border-top: 1px solid #e0e0e0; margin: 20px 0;'>" .
            "<p style='font-size: 12px; color: #666; text-align: center; margin: 0;'>" .
            "This is an automated submission from Opiña Law Office Electronic Filing System. " .
            "For any inquiries, please contact our office directly." .
            "</p>" .
            "</div>";

    $mail->isHTML(true);
    $mail->Subject = 'OFFICIAL COURT FILING - ' . $document_category . ' - ' . $desired_filename;
    $mail->Body = $body;
    $mail->AltBody = "OFFICIAL COURT FILING SUBMISSION\n\n" .
                     "To: Honorable Court\n" .
                     "From: " . $attorney_name . " - Opiña Law Office\n" .
                     "Attorney Email: " . $attorney_email . "\n" .
                     "Date: " . date('F d, Y \a\t g:i A') . "\n\n" .
                     "Respectfully submitted for filing and consideration:\n\n" .
                     "FILING DETAILS:\n" .
                     "Document Category: $document_category\n" .
                     "Document: $desired_filename\n" .
                     "Submission Date: " . date('F d, Y') . "\n\n" .
                     ($message !== '' ? "ATTORNEY'S NOTES:\n$message\n\n" : '') .
                     "Please find the attached document for your review and filing.\n\n" .
                     "OPIÑA LAW OFFICE\n" .
                     "Electronic Filing System\n" .
                     "Reference ID: EF-" . date('YmdHis') . "\n\n" .
                     "This is an automated submission from Opiña Law Office Electronic Filing System.";

    // Attach the file using the new path and desired filename
    $mail->addAttachment($targetPath, $desired_filename);

    if ($mail->send()) {
        $status = 'Sent';
    }
} catch (Exception $e) {
    error_log('eFiling send error: ' . $mail->ErrorInfo . ' Exception: ' . $e->getMessage());
    $status = 'Failed';
}

// Log to history regardless of result
$stmt = $conn->prepare("INSERT INTO efiling_history (attorney_id, case_id, file_name, original_file_name, stored_file_path, receiver_email, message, status, document_category) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)");
$stmt->bind_param('iisssssss', $attorney_id, $case_id, $desired_filename, $original_file_name, $targetPath, $receiver_email, $message, $status, $document_category);
$stmt->execute();

if ($status === 'Sent') {
    echo json_encode(['status' => 'success', 'message' => 'Submission sent successfully.']);
} else {
    echo json_encode(['status' => 'error', 'message' => 'Failed to send submission.']);
}
?>


