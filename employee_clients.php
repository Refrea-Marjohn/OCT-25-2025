<?php
require_once 'session_manager.php';
validateUserAccess('employee');
require_once 'config.php';
require_once 'audit_logger.php';
require_once 'action_logger_helper.php';
$employee_id = $_SESSION['user_id'];
$stmt = $conn->prepare("SELECT profile_image FROM user_form WHERE id=?");
$stmt->bind_param("i", $employee_id);
$stmt->execute();
$res = $stmt->get_result();
$profile_image = '';
if ($res && $row = $res->fetch_assoc()) {
    $profile_image = $row['profile_image'];
}
if (!$profile_image || !file_exists($profile_image)) {
        $profile_image = 'images/default-avatar.jpg';
    }

// Get all clients with case information
$clients = [];
$result = $conn->query("SELECT uf.*, 
    (SELECT COUNT(*) FROM attorney_cases WHERE client_id = uf.id) as total_cases,
    (SELECT COUNT(*) FROM attorney_cases WHERE client_id = uf.id AND status = 'Active') as active_cases,
    (SELECT COUNT(*) FROM attorney_cases WHERE client_id = uf.id AND status = 'Closed') as closed_cases,
    DATE_FORMAT(uf.created_at, '%M %Y') as member_since
    FROM user_form uf 
    WHERE uf.user_type = 'client' 
    ORDER BY uf.name ASC");

if ($result && $result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $clients[] = $row;
    }
}

// Search functionality
$search = isset($_GET['search']) ? $_GET['search'] : '';
$filtered_clients = [];
if (!empty($search)) {
    foreach ($clients as $client) {
        if (stripos($client['name'], $search) !== false || 
            stripos($client['email'], $search) !== false || 
            stripos($client['phone_number'], $search) !== false) {
            $filtered_clients[] = $client;
        }
    }
} else {
    $filtered_clients = $clients;
}

// Handle AJAX requests
if (isset($_POST['action'])) {
    $response = array();
    
    switch ($_POST['action']) {
        case 'get_client_details':
            $client_id = intval($_POST['client_id']);
            $stmt = $conn->prepare("SELECT * FROM user_form WHERE id = ? AND user_type = 'client'");
            $stmt->bind_param("i", $client_id);
            $stmt->execute();
            $client_result = $stmt->get_result();
            if ($client_result && $row = $client_result->fetch_assoc()) {
                $response['success'] = true;
                $response['client'] = $row;
            } else {
                $response['success'] = false;
                $response['message'] = 'Client not found';
            }
            break;
            
        case 'get_client_cases':
            $client_id = intval($_POST['client_id']);
            $stmt = $conn->prepare("SELECT ac.*, uf.name as attorney_name FROM attorney_cases ac LEFT JOIN user_form uf ON ac.attorney_id = uf.id WHERE ac.client_id = ? ORDER BY ac.created_at DESC");
            $stmt->bind_param("i", $client_id);
            $stmt->execute();
            $cases_result = $stmt->get_result();
            $cases = array();
            if ($cases_result && $cases_result->num_rows > 0) {
                while ($case = $cases_result->fetch_assoc()) {
                    $cases[] = $case;
                }
            }
            $response['success'] = true;
            $response['cases'] = $cases;
            break;
            
        case 'get_client_documents':
            $client_id = intval($_POST['client_id']);
            // Get documents from attorney_documents that are related to this client's cases
            $stmt = $conn->prepare("SELECT ad.*, ac.title as case_title 
                FROM attorney_documents ad 
                LEFT JOIN attorney_cases ac ON ad.case_id = ac.id 
                WHERE ac.client_id = ? 
                ORDER BY ad.upload_date DESC");
            $stmt->bind_param("i", $client_id);
            $stmt->execute();
            $docs_result = $stmt->get_result();
            $documents = array();
            if ($docs_result && $docs_result->num_rows > 0) {
                while ($doc = $docs_result->fetch_assoc()) {
                    $documents[] = $doc;
                }
            }
            $response['success'] = true;
            $response['documents'] = $documents;
            break;
            
        case 'export_clients':
            $export_data = array();
            foreach ($filtered_clients as $client) {
                $export_data[] = array(
                    'Name' => $client['name'],
                    'Email' => $client['email'],
                    'Phone' => $client['phone_number'],
                    'Total Cases' => $client['total_cases'],
                    'Active Cases' => $client['active_cases'],
                    'Closed Cases' => $client['closed_cases'],
                    'Member Since' => $client['member_since'] ?? 'N/A'
                );
            }
            $response['success'] = true;
            $response['data'] = $export_data;
            break;
            
        case 'delete_client':
            $client_id = intval($_POST['client_id']);
            
            // Check if client has active cases
            $active_cases = $conn->query("SELECT COUNT(*) as count FROM attorney_cases WHERE client_id = $client_id AND status = 'Active'");
            $active_count = $active_cases->fetch_assoc()['count'];
            
            if ($active_count > 0) {
                $response['success'] = false;
                $response['message'] = 'Cannot delete client with active cases. Please close all active cases first.';
            } else {
                // Delete client cases first
                $conn->query("DELETE FROM attorney_cases WHERE client_id = $client_id");
                
                // Delete client messages
                $conn->query("DELETE FROM client_messages WHERE client_id = $client_id");
                
                // Delete client from user_form
                $delete_result = $conn->query("DELETE FROM user_form WHERE id = $client_id AND user_type = 'client'");
                
                if ($delete_result && $conn->affected_rows > 0) {
                    $response['success'] = true;
                    $response['message'] = 'Client deleted successfully';
                } else {
                    $response['success'] = false;
                    $response['message'] = 'Failed to delete client';
                }
            }
            break;
    }
    
    header('Content-Type: application/json');
    echo json_encode($response);
    exit();
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Client Management - Opiña Law Office</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="assets/css/dashboard.css?v=<?= time() ?>">
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const submenuToggles = document.querySelectorAll('.submenu-toggle');
            
            submenuToggles.forEach(toggle => {
                toggle.addEventListener('click', function(e) {
                    e.preventDefault();
                    const submenu = this.parentElement;
                    submenu.classList.toggle('open');
                });
            });
        });
    </script>
</head>
<body>
    <!-- Sidebar -->
    <div class="sidebar">
                <div class="sidebar-header">
            <img src="images/logo.jpg" alt="Logo">
            <h2>Opiña Law Office</h2>
        </div>
        <ul class="sidebar-menu">
            <li><a href="employee_dashboard.php"><i class="fas fa-home"></i><span>Dashboard</span></a></li>
            <li><a href="employee_documents.php"><i class="fas fa-file-alt"></i><span>Document Storage</span></a></li>
            <li class="has-submenu">
                <a href="#" class="submenu-toggle"><i class="fas fa-file-alt"></i><span>Document Generations</span><i class="fas fa-chevron-down submenu-arrow"></i></a>
                <ul class="submenu">
                    <li><a href="employee_document_generation.php"><i class="fas fa-file-plus"></i><span>Generate Documents</span></a></li>
                    <li><a href="employee_send_files.php"><i class="fas fa-paper-plane"></i><span>Send Files</span></a></li>
                </ul>
            </li>
            <li><a href="employee_schedule.php"><i class="fas fa-calendar-alt"></i><span>Schedule</span></a></li>
            <li><a href="employee_clients.php" class="active"><i class="fas fa-users"></i><span>Client Management</span></a></li>
            <li><a href="employee_request_management.php"><i class="fas fa-clipboard-check"></i><span>Request Review</span></a></li>
            <li><a href="employee_messages.php"><i class="fas fa-envelope"></i><span>Messages</span></a></li>
            <li><a href="employee_audit.php"><i class="fas fa-history"></i><span>Audit Trail</span></a></li>
        </ul>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <?php 
        $page_title = 'Client Management';
        $page_subtitle = 'View and manage client information';
        include 'components/profile_header.php'; 
        ?>

        <!-- Statistics Cards -->
        <div class="dashboard-cards">
            <div class="card">
                <div class="card-icon">
                    <i class="fas fa-users"></i>
                </div>
                <div class="card-info">
                    <h3>Total Clients</h3>
                    <p><?= count($clients) ?></p>
                </div>
            </div>
            <div class="card">
                <div class="card-icon">
                    <i class="fas fa-gavel"></i>
                </div>
                <div class="card-info">
                    <h3>Total Cases</h3>
                    <p><?= array_sum(array_column($clients, 'total_cases')) ?></p>
                </div>
            </div>
            <div class="card">
                <div class="card-icon">
                    <i class="fas fa-clock"></i>
                </div>
                <div class="card-info">
                    <h3>Active Cases</h3>
                    <p><?= array_sum(array_column($clients, 'active_cases')) ?></p>
                </div>
            </div>
            <div class="card">
                <div class="card-icon">
                    <i class="fas fa-calendar"></i>
                </div>
                <div class="card-info">
                    <h3>New This Month</h3>
                    <p><?= count(array_filter($clients, function($client) {
                        return isset($client['created_at']) && 
                               date('Y-m', strtotime($client['created_at'])) === date('Y-m');
                    })) ?></p>
                </div>
            </div>
        </div>

        <!-- Search and Filter -->
        <div class="action-buttons">
            <div class="search-box">
                <i class="fas fa-search"></i>
                <input type="text" id="searchInput" placeholder="Search clients by name, email, or phone..." value="<?= htmlspecialchars($search) ?>">
            </div>
            <button class="btn btn-secondary" onclick="exportClients()">
                <i class="fas fa-download"></i> Export List
            </button>
        </div>

        <!-- Clients Grid -->
        <div class="clients-grid">
            <?php if (empty($filtered_clients)): ?>
                <div class="no-clients">
                    <i class="fas fa-users"></i>
                    <h3>No clients found</h3>
                    <p><?= empty($search) ? 'No clients registered yet.' : 'No clients match your search criteria.' ?></p>
                </div>
            <?php else: ?>
                <?php foreach ($filtered_clients as $client): ?>
                    <div class="client-card">
                        <div class="client-header">
                            <div class="client-avatar">
                                <?php if ($client['profile_image'] && file_exists($client['profile_image'])): ?>
                                    <img src="<?= htmlspecialchars($client['profile_image']) ?>" alt="Client" style="width: 100%; height: 100%; object-fit: cover; border-radius: 50%;">
                                <?php else: ?>
                                    <div class="default-avatar">
                                        <i class="fas fa-user"></i>
                                    </div>
                                <?php endif; ?>
                            </div>
                            <div class="client-info">
                                <h3><?= htmlspecialchars($client['name']) ?></h3>
                                <p class="client-email"><?= htmlspecialchars($client['email']) ?></p>
                                <p class="client-phone"><?= htmlspecialchars($client['phone_number']) ?></p>
                            </div>
                            <div class="client-status">
                                <span class="status-badge <?= $client['active_cases'] > 0 ? 'active' : 'inactive' ?>">
                                    <?= $client['active_cases'] > 0 ? 'Active' : 'Inactive' ?>
                                </span>
                            </div>
                        </div>
                        <div class="client-stats">
                            <div class="stat-item">
                                <span class="stat-label">Total Cases</span>
                                <span class="stat-value"><?= $client['total_cases'] ?></span>
                            </div>
                            <div class="stat-item">
                                <span class="stat-label">Active Cases</span>
                                <span class="stat-value"><?= $client['active_cases'] ?></span>
                            </div>
                            <div class="stat-item">
                                <span class="stat-label">Member Since</span>
                                <span class="stat-value"><?= $client['member_since'] ?? 'N/A' ?></span>
                            </div>
                        </div>
                        <div class="client-actions">
                            <button class="btn btn-icon" onclick="viewClientDetails(<?= $client['id'] ?>)" title="View Details">
                                <i class="fas fa-eye"></i>
                            </button>
                            <button class="btn btn-icon" onclick="viewClientCases(<?= $client['id'] ?>)" title="View Cases">
                                <i class="fas fa-gavel"></i>
                            </button>
                            
                            <button class="btn btn-icon btn-danger" onclick="deleteClient(<?= $client['id'] ?>, '<?= htmlspecialchars($client['name']) ?>')" title="Delete Client">
                                <i class="fas fa-trash"></i>
                            </button>
                        </div>
                    </div>
                <?php endforeach; ?>
            <?php endif; ?>
        </div>
    </div>

    <!-- Client Details Modal -->
    <div id="clientModal" class="modal-overlay" style="display:none;" style="z-index: 9999 !important;">
        <div class="modal-content modern-modal" style="z-index: 9999 !important;" style="z-index: 10000 !important;">
            <div class="modal-header">
                <h2><i class="fas fa-user"></i> Client Details</h2>
                <button class="close-modal-btn" onclick="closeClientModal()" title="Close">
                    <i class="fas fa-times"></i>
                </button>
            </div>
            <div id="clientDetails">
                <!-- Client details will be loaded here -->
            </div>
        </div>
    </div>

    <!-- Client Cases Modal -->
    <div id="casesModal" class="modal-overlay" style="display:none;" style="z-index: 9999 !important;">
        <div class="modal-content modern-modal large-modal" style="z-index: 9999 !important;" style="z-index: 10000 !important;">
            <button class="close-modal-btn" onclick="closeCasesModal()" title="Close">&times;</button>
            <h2 style="margin-bottom:18px;">Client Cases</h2>
            <div id="clientCases">
                <!-- Client cases will be loaded here -->
            </div>
        </div>
    </div>

    <!-- Client Documents Modal -->
    <div id="documentsModal" class="modal-overlay" style="display:none;" style="z-index: 9999 !important;">
        <div class="modal-content modern-modal large-modal" style="z-index: 9999 !important;" style="z-index: 10000 !important;">
            <button class="close-modal-btn" onclick="closeDocumentsModal()" title="Close">&times;</button>
            <h2 style="margin-bottom:18px;">Client Documents</h2>
            <div id="clientDocuments">
                <!-- Client documents will be loaded here -->
            </div>
        </div>
    </div>

    <script>
        // Search functionality
        document.getElementById('searchInput').addEventListener('input', function() {
            const searchTerm = this.value.toLowerCase();
            const clientCards = document.querySelectorAll('.client-card');
            
            clientCards.forEach(card => {
                const name = card.querySelector('h3').textContent.toLowerCase();
                const email = card.querySelector('.client-email').textContent.toLowerCase();
                const phone = card.querySelector('.client-phone').textContent.toLowerCase();
                
                if (name.includes(searchTerm) || email.includes(searchTerm) || phone.includes(searchTerm)) {
                    card.style.display = 'block';
                } else {
                    card.style.display = 'none';
                }
            });
        });

        function viewClientDetails(clientId) {
            fetch('employee_clients.php', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: 'action=get_client_details&client_id=' + clientId
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    const client = data.client;
                    document.getElementById('clientDetails').innerHTML = `
                    <div class="client-detail-grid">
                            <div class="detail-item">
                                <label>Phone:</label>
                                <span>${client.phone_number || 'N/A'}</span>
                            </div>
                            <div class="detail-item">
                                <label>User Type:</label>
                                <span>${client.user_type}</span>
                            </div>
                            <div class="detail-item">
                                <label>Last Login:</label>
                                <span>${client.last_login ? new Date(client.last_login).toLocaleString() : 'Never'}</span>
                            </div>
                            <div class="detail-item">
                                <label>Member Since:</label>
                                <span>${client.created_at ? new Date(client.created_at).toLocaleDateString('en-US', {year: 'numeric', month: 'long'}) : 'N/A'}</span>
                            </div>
                        </div>
                    `;
                    
                    // Update modal header with client info
                    const modalHeader = document.querySelector('#clientModal .modal-header h2');
                    modalHeader.innerHTML = `
                        <div class="client-header-info">
                            <div class="client-avatar">
                                ${client.profile_image && client.profile_image !== 'images/default-avatar.jpg' ? 
                                    `<img src="${client.profile_image}" alt="Client">` : 
                                    `<i class="fas fa-user"></i>`
                                }
                            </div>
                            <div class="client-basic-info">
                                <h3>${client.name}</h3>
                                <p>${client.email}</p>
                            </div>
                        </div>
                    `;
                    document.getElementById('clientModal').style.display = 'block';
                } else {
                    alert('Error loading client details: ' + data.message);
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('Error loading client details');
            });
        }

        function viewClientCases(clientId) {
            fetch('employee_clients.php', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: 'action=get_client_cases&client_id=' + clientId
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    let casesHtml = '';
                    if (data.cases.length > 0) {
                        casesHtml = '<div class="cases-list">';
                        data.cases.forEach(caseItem => {
                            casesHtml += `
                                <div class="case-item">
                                    <div class="case-header">
                                        <h4>${caseItem.title}</h4>
                                        <span class="status-badge ${caseItem.status === 'Active' ? 'active' : 'inactive'}">
                                            ${caseItem.status}
                                        </span>
                                    </div>
                                    <p class="case-description">${caseItem.description}</p>
                                    <div class="case-meta">
                                        <span><i class="fas fa-calendar"></i> Created: ${new Date(caseItem.created_at).toLocaleDateString()}</span>
                                        <span><i class="fas fa-gavel"></i> Type: ${caseItem.case_type || 'N/A'}</span>
                                        ${caseItem.next_hearing ? `<span><i class="fas fa-clock"></i> Next Hearing: ${new Date(caseItem.next_hearing).toLocaleDateString()}</span>` : ''}
                                    </div>
                                </div>
                            `;
                        });
                        casesHtml += '</div>';
                    } else {
                        casesHtml = '<div class="no-data"><i class="fas fa-gavel"></i><p>No cases found for this client.</p></div>';
                    }
                    document.getElementById('clientCases').innerHTML = casesHtml;
                    document.getElementById('casesModal').style.display = 'block';
                } else {
                    alert('Error loading client cases');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('Error loading client cases');
            });
        }

        // viewClientDocuments removed per request

        function viewDocument(filePath) {
            window.open(filePath, '_blank');
        }

        function downloadDocument(filePath, fileName) {
            const link = document.createElement('a');
            link.href = filePath;
            link.download = fileName;
            document.body.appendChild(link);
            link.click();
            document.body.removeChild(link);
        }

        function closeClientModal() {
            document.getElementById('clientModal').style.display = 'none';
        }

        function closeCasesModal() {
            document.getElementById('casesModal').style.display = 'none';
        }

        function closeDocumentsModal() {
            document.getElementById('documentsModal').style.display = 'none';
        }

        function exportClients() {
            fetch('employee_clients.php', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: 'action=export_clients'
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    // Create CSV content
                    let csvContent = "data:text/csv;charset=utf-8,";
                    
                    // Add headers
                    csvContent += "Name,Email,Phone,Total Cases,Active Cases,Closed Cases,Member Since\n";
                    
                    // Add data
                    data.data.forEach(row => {
                        csvContent += `"${row.Name}","${row.Email}","${row.Phone}",${row['Total Cases']},${row['Active Cases']},${row['Closed Cases']},"${row['Member Since']}"\n`;
                    });
                    
                    // Create download link
                    const encodedUri = encodeURI(csvContent);
                    const link = document.createElement("a");
                    link.setAttribute("href", encodedUri);
                    link.setAttribute("download", "clients_list.csv");
                    document.body.appendChild(link);
                    link.click();
                    document.body.removeChild(link);
                } else {
                    alert('Error exporting client list');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('Error exporting client list');
            });
        }

        function deleteClient(clientId, clientName) {
            // First confirmation
            const firstConfirm = confirm(`⚠️ WARNING: Delete Client "${clientName}"?\n\nThis action will permanently delete:\n• All client cases\n• All client messages\n• Client account\n\nNote: Clients with active cases cannot be deleted.\n\nAre you sure you want to proceed?`);
            
            if (firstConfirm) {
                // Second confirmation - stricter
                const secondConfirm = confirm(`🚨 FINAL CONFIRMATION 🚨\n\nYou are about to PERMANENTLY DELETE client "${clientName}".\n\nThis action CANNOT be undone!\n\nType "DELETE" in the next prompt to confirm.`);
                
                if (secondConfirm) {
                    // Third confirmation with text input
                    const deleteText = prompt(`Type "DELETE" (in capital letters) to confirm deletion of client "${clientName}":`);
                    
                    if (deleteText === 'DELETE') {
                        fetch('employee_clients.php', {
                            method: 'POST',
                            headers: {
                                'Content-Type': 'application/x-www-form-urlencoded',
                            },
                            body: 'action=delete_client&client_id=' + clientId
                        })
                        .then(response => response.json())
                        .then(data => {
                            if (data.success) {
                                alert('Client deleted successfully!');
                                location.reload(); // Refresh the page to update the list
                            } else {
                                alert('Error: ' + data.message);
                            }
                        })
                        .catch(error => {
                            console.error('Error:', error);
                            alert('Error deleting client');
                        });
                    } else if (deleteText !== null) {
                        alert('Deletion cancelled. You must type "DELETE" exactly to confirm.');
                    }
                }
            }
        }

        // Close modals when clicking outside
        window.onclick = function(event) {
            const clientModal = document.getElementById('clientModal');
            const casesModal = document.getElementById('casesModal');
            const documentsModal = document.getElementById('documentsModal');
            
            if (event.target === clientModal) {
                clientModal.style.display = 'none';
            }
            if (event.target === casesModal) {
                casesModal.style.display = 'none';
            }
            if (event.target === documentsModal) {
                documentsModal.style.display = 'none';
            }
        }
    </script>

    <style>
        .dashboard-cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .card {
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.07);
            padding: 20px;
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .card-icon {
            width: 50px;
            height: 50px;
            background: linear-gradient(135deg, #5D0E26, #8B1538);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .card-icon i {
            color: white;
            font-size: 20px;
        }

        .card-info h3 {
            margin: 0;
            font-size: 14px;
            color: #666;
            font-weight: 500;
        }

        .card-info p {
            margin: 5px 0 0 0;
            font-size: 24px;
            font-weight: 700;
            color: #333;
        }

        .action-buttons {
            display: flex;
            gap: 15px;
            margin-bottom: 30px;
            align-items: center;
        }

        .search-box {
            position: relative;
            flex: 1;
            max-width: 400px;
        }

        .search-box i {
            position: absolute;
            left: 10px;
            top: 50%;
            transform: translateY(-50%);
            color: #666;
        }

        .search-box input {
            width: 100%;
            padding: 10px 10px 10px 35px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 0.9rem;
        }

        .clients-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 14px; /* tighter grid spacing */
        }

        .client-card {
            background: linear-gradient(180deg, #ffffff 0%, #fbfbfc 100%);
            border-radius: 14px;
            padding: 12px; /* reduced inner padding for compact look */
            box-shadow: 0 4px 14px rgba(0, 0, 0, 0.06);
            transition: transform 0.25s ease, box-shadow 0.25s ease;
            border: 1px solid #eef2f7;
        }

        .client-card:hover {
            transform: scale(1.02);
            box-shadow: 0 16px 40px rgba(93, 14, 38, 0.18);
        }

        .client-header {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 8px; /* tighter header */
        }

        .client-avatar {
            width: 48px;
            height: 48px;
            border-radius: 50%;
            background: linear-gradient(135deg, #5D0E26, #8B1538);
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            flex-shrink: 0;
            border: 2px solid #fff;
            box-shadow: 0 3px 10px rgba(0,0,0,0.1);
        }

        .client-avatar img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            border-radius: 50%;
        }

        .default-avatar {
            width: 100%;
            height: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
            background: linear-gradient(135deg, #5D0E26, #8B1538);
            border-radius: 50%;
        }

        .default-avatar i {
            font-size: 18px;
            color: white;
        }

        .client-info {
            flex: 1;
            min-width: 0;
        }

        .client-info h3 {
            margin: 0 0 2px 0;
            font-size: 1.05rem;
            color: #111827;
            font-weight: 700;
            letter-spacing: .2px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .client-email {
            margin: 2px 0 0 0;
            font-size: 0.9rem;
            color: #374151;
            font-weight: 500;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .client-phone {
            margin: 0;
            font-size: 0.8rem;
            color: #9ca3af;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .client-status {
            margin-left: auto;
            flex-shrink: 0;
        }

        .status-badge {
            padding: 6px 12px;
            border-radius: 999px;
            font-size: 0.78rem;
            font-weight: 700;
            letter-spacing: .2px;
            border: 1px solid rgba(0,0,0,0.06);
        }

        .status-badge.active {
            background: #d1fae5;
            color: #065f46;
            box-shadow: inset 0 0 0 1px rgba(6,95,70,.08);
        }

        .status-badge.inactive {
            background: #fee2e2;
            color: #991b1b;
            box-shadow: inset 0 0 0 1px rgba(153,27,27,.08);
        }

        .client-stats {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 8px;
            margin-bottom: 8px;
            padding: 6px 0; /* reduce vertical padding to lower height */
            border-top: 1px solid #f0f0f0;
            border-bottom: 1px solid #f0f0f0;
        }

        .stat-item {
            text-align: center;
            padding: 8px 6px; /* compact inner spacing of each card */
        }

        .stat-label {
            display: block;
            font-size: 0.68rem; /* slightly smaller */
            color: #666;
            margin-bottom: 2px;
            font-weight: 600;
            letter-spacing: .2px;
        }

        .stat-value {
            display: block;
            font-size: 0.95rem; /* smaller to reduce height */
            font-weight: 700;
            color: #5D0E26;
            line-height: 1; /* tighter line height */
        }

        .client-actions {
            display: flex;
            gap: 12px; /* equal spacing */
            justify-content: center; /* centered */
        }

        .btn-icon {
            min-width: 72px; /* widened */
            height: 40px;
            padding: 0 12px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 6px;
            border-radius: 10px;
            border: 1px solid #e9ecef;
            background: #ffffff;
            color: #5D0E26;
            cursor: pointer;
            transition: transform 0.2s ease, box-shadow 0.2s ease, background 0.2s ease, color 0.2s ease;
            font-size: 0.95rem;
        }

        .btn-icon:hover {
            background: #5D0E26;
            color: white;
            transform: translateY(-2px) scale(1.03);
            box-shadow: 0 10px 20px rgba(93, 14, 38, 0.22);
        }

        .btn-icon.btn-danger {
            background: #f8f9fa;
            color: #dc3545;
        }

        .btn-icon.btn-danger:hover {
            background: #dc3545;
            color: white;
        }

        .no-clients {
            text-align: center;
            padding: 60px 20px;
            color: #666;
        }

        .no-clients i {
            font-size: 48px;
            margin-bottom: 15px;
            color: #ccc;
        }

        .no-clients h3 {
            margin-bottom: 10px;
            color: #333;
        }

        /* Modal styles */
        .modal-overlay {
            position: fixed;
            top: 0; left: 0; right: 0; bottom: 0;
            background: rgba(0,0,0,0.45);
            z-index: 10000;
            display: flex;
            align-items: center;
            justify-content: center;
            animation: fadeIn 0.2s;
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        .modern-modal {
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.15);
            padding: 0;
            min-width: 0;
            max-width: 600px;
            width: 100%;
            position: relative;
            animation: modalPop 0.3s;
            margin: 0 auto;
            border: 1px solid #e9ecef;
            overflow: hidden;
        }

        .large-modal {
            max-width: 800px;
            max-height: 80vh;
            overflow-y: auto;
        }

        @keyframes modalPop {
            from { transform: scale(0.95); opacity: 0; }
            to { transform: scale(1); opacity: 1; }
        }

        .modal-header {
            background: linear-gradient(135deg, #5D0E26, #8B1538);
            color: white;
            padding: 20px 25px;
            margin: 0;
            border-radius: 12px 12px 0 0;
            position: relative;
        }

        .modal-header h2 {
            margin: 0;
            font-size: 1.4rem;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .modal-header h2 i {
            font-size: 1.2rem;
            opacity: 0.9;
        }

        .client-header-info {
            display: flex;
            align-items: center;
            gap: 15px;
            width: 100%;
        }

        .client-avatar {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.2);
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            border: 2px solid rgba(255, 255, 255, 0.3);
            flex-shrink: 0;
        }

        .client-avatar img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .client-avatar i {
            font-size: 20px;
            color: white;
        }

        .client-basic-info {
            flex: 1;
        }

        .client-basic-info h3 {
            margin: 0 0 5px 0;
            font-size: 1.3rem;
            font-weight: 700;
            color: white;
            line-height: 1.2;
        }

        .client-basic-info p {
            margin: 0;
            font-size: 0.95rem;
            color: rgba(255, 255, 255, 0.9);
            font-weight: 400;
        }

        .close-modal-btn {
            position: absolute;
            top: 15px;
            right: 20px;
            background: rgba(255, 255, 255, 0.2);
            border: none;
            font-size: 1.2rem;
            color: white;
            cursor: pointer;
            transition: all 0.3s;
            z-index: 2;
            width: 32px;
            height: 32px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .close-modal-btn:hover {
            background: rgba(255, 255, 255, 0.3);
            transform: scale(1.1);
        }

        /* Client Details Styles */
        .client-detail-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
            padding: 25px;
        }

        .detail-item {
            display: flex;
            flex-direction: column;
            padding: 15px;
            background: #f8f9fa;
            border-radius: 8px;
            border-left: 4px solid #5D0E26;
            transition: all 0.3s ease;
        }

        .detail-item:hover {
            background: #f0f0f0;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(93, 14, 38, 0.1);
        }

        .detail-item label {
            font-weight: 600;
            color: #5D0E26;
            font-size: 0.85rem;
            margin-bottom: 8px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .detail-item span {
            color: #333;
            font-size: 1rem;
            font-weight: 500;
        }

        .status-badge {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            display: inline-block;
        }

        .status-badge.active {
            background: #e8f5e8;
            color: #2e7d32;
            border: 1px solid #c8e6c9;
        }

        .status-badge.inactive {
            background: #fff3e0;
            color: #f57c00;
            border: 1px solid #ffcc02;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .client-detail-grid {
                grid-template-columns: 1fr;
                gap: 15px;
                padding: 20px;
            }
        }

        /* Cases List Styles */
        .cases-list {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }

        .case-item {
            background: #f8f9fa;
            border-radius: 8px;
            padding: 15px;
            border-left: 4px solid #5D0E26;
        }

        .case-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 10px;
        }

        .case-header h4 {
            margin: 0;
            color: #333;
            font-size: 1.1rem;
        }

        .case-description {
            color: #666;
            margin-bottom: 10px;
            line-height: 1.5;
        }

        .case-meta {
            display: flex;
            gap: 15px;
            flex-wrap: wrap;
        }

        .case-meta span {
            font-size: 0.9rem;
            color: #888;
            display: flex;
            align-items: center;
            gap: 5px;
        }

        /* Documents List Styles */
        .documents-list {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }

        .document-item {
            display: flex;
            align-items: center;
            gap: 15px;
            background: #f8f9fa;
            border-radius: 8px;
            padding: 15px;
            border-left: 4px solid #28a745;
        }

        .document-icon {
            width: 40px;
            height: 40px;
            background: #28a745;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
        }

        .document-info {
            flex: 1;
        }

        .document-info h4 {
            margin: 0 0 5px 0;
            color: #333;
            font-size: 1rem;
        }

        .document-category, .document-case, .document-date {
            margin: 2px 0;
            font-size: 0.9rem;
            color: #666;
        }

        .document-actions {
            display: flex;
            gap: 8px;
        }

        .btn-sm {
            width: 30px;
            height: 30px;
            padding: 0;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 4px;
            border: none;
            background: #e9ecef;
            color: #666;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .btn-sm:hover {
            background: #5D0E26;
            color: white;
        }

        .no-data {
            text-align: center;
            padding: 40px 20px;
            color: #666;
        }

        .no-data i {
            font-size: 48px;
            margin-bottom: 15px;
            color: #ccc;
        }

        .no-data p {
            margin: 0;
            font-size: 1.1rem;
        }

        @media (max-width: 768px) {
            .action-buttons {
                flex-direction: column;
                align-items: stretch;
            }

            .search-box {
                max-width: none;
            }

            .clients-grid {
                grid-template-columns: 1fr;
            }

            .client-stats {
                grid-template-columns: 1fr;
                gap: 10px;
            }

            .detail-item {
                flex-direction: column;
                align-items: flex-start;
                gap: 5px;
            }

            .case-meta {
                flex-direction: column;
                gap: 8px;
            }

            .document-item {
                flex-direction: column;
                align-items: flex-start;
                gap: 10px;
            }

            .document-actions {
                align-self: flex-end;
            }
        }
    </style>
</body>
</html> 