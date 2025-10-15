<?php
session_start();
if (!isset($_SESSION['client_name']) || $_SESSION['user_type'] !== 'client') {
    header('Location: login_form.php');
    exit();
}

// Set cache control headers to prevent back button access after logout
header('Cache-Control: no-cache, no-store, must-revalidate');
header('Pragma: no-cache');
header('Expires: 0');

require_once 'config.php';
$client_id = $_SESSION['user_id'];
$stmt = $conn->prepare("SELECT profile_image FROM user_form WHERE id=?");
$stmt->bind_param("i", $client_id);
$stmt->execute();
$res = $stmt->get_result();
$profile_image = '';
if ($res && $row = $res->fetch_assoc()) {
    $profile_image = $row['profile_image'];
}
if (!$profile_image || !file_exists($profile_image)) {
        $profile_image = 'images/default-avatar.jpg';
    }
// Total cases
$stmt = $conn->prepare("SELECT COUNT(*) FROM attorney_cases WHERE client_id=?");
$stmt->bind_param("i", $client_id);
$stmt->execute();
$total_cases = $stmt->get_result()->fetch_row()[0];
// Total documents (from attorney_documents related to client's cases)
$stmt = $conn->prepare("SELECT COUNT(*) FROM attorney_document_activity ada 
    INNER JOIN attorney_cases ac ON ada.case_id = ac.id 
    WHERE ac.client_id = ?");
$stmt->bind_param("i", $client_id);
$stmt->execute();
$total_documents = $stmt->get_result()->fetch_row()[0];
// Upcoming hearings (next 7 days)
$today = date('Y-m-d');
$next_week = date('Y-m-d', strtotime('+7 days'));
$stmt = $conn->prepare("SELECT COUNT(*) FROM case_schedules WHERE client_id=? AND date BETWEEN ? AND ?");
$stmt->bind_param("iss", $client_id, $today, $next_week);
$stmt->execute();
$upcoming_hearings = $stmt->get_result()->fetch_row()[0];

// Recent chat: get the latest message between this client and any attorney
$recent_chat = null;
$stmt = $conn->prepare("SELECT message, sent_at, 'client' as sender, recipient_id as attorney_id FROM client_messages WHERE client_id=?
        UNION ALL
        SELECT message, sent_at, 'attorney' as sender, attorney_id as attorney_id FROM attorney_messages WHERE recipient_id=?
        ORDER BY sent_at DESC LIMIT 1");
$stmt->bind_param("ii", $client_id, $client_id);
$stmt->execute();
$res = $stmt->get_result();
if ($res && $row = $res->fetch_assoc()) {
    $recent_chat = $row;
}

// Case status distribution for this client
$status_counts = [];
$stmt = $conn->prepare("SELECT status, COUNT(*) as cnt FROM attorney_cases WHERE client_id=? GROUP BY status");
$stmt->bind_param("i", $client_id);
$stmt->execute();
$res = $stmt->get_result();
while ($row = $res->fetch_assoc()) {
    $status_counts[$row['status'] ?? 'Unknown'] = (int)$row['cnt'];
}

// If no cases exist, show sample data
if (empty($status_counts) || array_sum($status_counts) == 0) {
    $status_counts = [
        'Active' => 8,
        'Pending' => 5,
        'Completed' => 12
    ];
}

// Recent activities
$recent_activities = [];
$stmt = $conn->prepare("SELECT 'case' as type, title, created_at FROM attorney_cases WHERE client_id=? ORDER BY created_at DESC LIMIT 3");
$stmt->bind_param("i", $client_id);
$stmt->execute();
$res = $stmt->get_result();
while ($row = $res->fetch_assoc()) {
    $recent_activities[] = ['type' => 'Case', 'title' => $row['title'], 'date' => $row['created_at']];
}

// Sort by date
usort($recent_activities, function($a, $b) {
    return strtotime($b['date']) - strtotime($a['date']);
});

$recent_activities = array_slice($recent_activities, 0, 5);

// Monthly case trends for this client
$monthly_cases = array_fill(1, 12, 0);
$year = date('Y');
$stmt = $conn->prepare("SELECT MONTH(created_at) as month, COUNT(*) as cnt FROM attorney_cases WHERE client_id=? AND YEAR(created_at) = ? GROUP BY month");
$stmt->bind_param("ii", $client_id, $year);
$stmt->execute();
$res = $stmt->get_result();
while ($row = $res->fetch_assoc()) {
    $monthly_cases[(int)$row['month']] = (int)$row['cnt'];
}

// If no monthly data exists, show sample data
if (array_sum($monthly_cases) == 0) {
    $monthly_cases = [2, 3, 5, 2, 6, 4, 7, 5, 3, 6, 4, 2]; // Sample data for each month
}

// Fetch recent announcements
$announcements = [];
$stmt = $conn->prepare("SELECT * FROM announcements ORDER BY created_at DESC LIMIT 2");
$stmt->execute();
$res = $stmt->get_result();
while ($row = $res->fetch_assoc()) {
    $announcements[] = $row;
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Client Dashboard - Opiña Law Office</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="assets/css/dashboard.css?v=<?= time() ?>">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        .chart-container {
            position: relative;
            height: 300px;
        }

        .sample-data-overlay {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: rgba(255, 255, 255, 0.95);
            border: 2px solid #5D0E26;
            border-radius: 8px;
            padding: 10px 15px;
            font-size: 13px;
            font-weight: bold;
            color: #5D0E26;
            display: flex;
            align-items: center;
            gap: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
            z-index: 1000;
            pointer-events: none;
        }

        .sample-data-overlay i {
            font-size: 11px;
        }
    </style>
</head>
<body>
    <div class="sidebar client-sidebar">
        <div class="sidebar-header">
            <img src="images/logo.jpg" alt="Logo">
            <h2>Opiña Law Office</h2>
        </div>
        <ul class="sidebar-menu">
            <li>
                <a href="client_dashboard.php" class="active" title="View your case overview, statistics, and recent activities">
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
                <a href="client_cases.php" title="Track your legal cases, view case details, and upload documents">
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
    <div class="main-content">
        <?php 
        $page_title = 'Client Dashboard';
        $page_subtitle = 'Overview of your cases and legal matters';
        include 'components/profile_header.php'; 
        ?>
        

        <!-- Statistics Cards -->
        <div class="dashboard-cards">
            <div class="card">
                <div class="card-header">
                    <div class="card-icon">
                        <i class="fas fa-gavel"></i>
                    </div>
                </div>
                <div class="card-title">Total Cases</div>
                <div class="card-value"><?= number_format($total_cases) ?></div>
                <div class="card-description">Your cases</div>
            </div>
            <div class="card">
                <div class="card-header">
                    <div class="card-icon">
                        <i class="fas fa-calendar-check"></i>
                    </div>
                </div>
                <div class="card-title">Upcoming Schedules</div>
                <div class="card-value"><?= number_format($upcoming_hearings) ?></div>
                <div class="card-description">Next 7 days</div>
            </div>
            <div class="card">
                <div class="card-header">
                    <div class="card-icon">
                        <i class="fas fa-comments"></i>
                    </div>

                </div>
                <div class="card-title">Recent Chat</div>
                <?php if ($recent_chat): ?>
                    <div style="font-size: 1rem; margin-bottom: 4px; color: var(--primary-color); font-weight: 600;">
                        <?= $recent_chat['sender'] === 'client' ? 'You' : 'Attorney' ?>
                    </div>
                    <div style="color: #666; font-size: 0.9rem; line-height: 1.4;">
                        <?= htmlspecialchars(mb_strimwidth($recent_chat['message'], 0, 50, '...')) ?>
                    </div>
                <?php else: ?>
                    <div style="color: #888; font-size: 0.9rem;">No recent chat yet</div>
                <?php endif; ?>
            </div>
        </div>

        <!-- Announcements and Weather Container -->
        <div style="display: grid; grid-template-columns: 1fr calc(33.333% - 16px); gap: 24px; margin-bottom: 32px; align-items: stretch;">
            <!-- Announcements Container -->
            <div class="dashboard-graph" style="grid-column: 1;">
                <h3><i class="fas fa-bullhorn"></i> Announcements</h3>
                <?php if (count($announcements) > 0): ?>
                    <div id="announcementCarousel" style="position: relative;">
                        <?php foreach ($announcements as $index => $announcement): ?>
                            <div class="announcement-slide" style="display: <?= $index === 0 ? 'block' : 'none' ?>;">
                                <!-- Large Image -->
                                <div style="width: 100%; height: 400px; border-radius: 12px; margin-bottom: 16px; overflow: hidden; cursor: pointer; position: relative;" onclick="openImageModal('<?= htmlspecialchars($announcement['image_path']) ?>')">
                                    <?php if ($announcement['image_path'] && file_exists($announcement['image_path'])): ?>
                                        <img src="<?= htmlspecialchars($announcement['image_path']) ?>" alt="Announcement Image" style="width: 100%; height: 100%; object-fit: contain;">
                                        <!-- Zoom Icon Overlay -->
                                        <div style="position: absolute; top: 10px; right: 10px; background: rgba(0,0,0,0.6); color: white; padding: 8px; border-radius: 50%; width: 32px; height: 32px; display: flex; align-items: center; justify-content: center; font-size: 14px;">
                                            <i class="fas fa-search-plus"></i>
                                        </div>
                                    <?php else: ?>
                                        <div style="width: 100%; height: 100%; background: var(--gradient-primary); display: flex; align-items: center; justify-content: center; color: white; font-size: 4rem;">
                                            <i class="fas fa-image"></i>
                                        </div>
                                    <?php endif; ?>
                                </div>
                                
                                <!-- Content Below Image -->
                                <div style="text-align: left;">
                                    <p style="color: #555; line-height: 1.6; margin: 0;">
                                        <?= htmlspecialchars($announcement['description']) ?>
                                    </p>
                                </div>
                            </div>
                        <?php endforeach; ?>
                        
                        <!-- Navigation Buttons -->
                        <?php if (count($announcements) > 1): ?>
                            <div style="display: flex; justify-content: space-between; align-items: center; margin-top: 16px;">
                                <button onclick="previousAnnouncement()" class="nav-btn" style="background: #f8f9fa; border: 1px solid #e9ecef; border-radius: 8px; padding: 8px 16px; cursor: pointer; color: #666; transition: all 0.2s;">
                                    <i class="fas fa-chevron-left"></i> Previous
                                </button>
                                <div style="display: flex; gap: 8px;">
                                    <?php for ($i = 0; $i < count($announcements); $i++): ?>
                                        <button onclick="goToAnnouncement(<?= $i ?>)" class="nav-dot" style="width: 8px; height: 8px; border-radius: 50%; border: none; background: <?= $i === 0 ? 'var(--primary-color)' : '#e9ecef' ?>; cursor: pointer; transition: all 0.2s;"></button>
                                    <?php endfor; ?>
                                </div>
                                <button onclick="nextAnnouncement()" class="nav-btn" style="background: #f8f9fa; border: 1px solid #e9ecef; border-radius: 8px; padding: 8px 16px; cursor: pointer; color: #666; transition: all 0.2s;">
                                    Next <i class="fas fa-chevron-right"></i>
                                </button>
                            </div>
                        <?php endif; ?>
                    </div>
                <?php else: ?>
                    <div style="text-align: center; padding: 40px; color: #666;">
                        <i class="fas fa-bullhorn" style="font-size: 3rem; margin-bottom: 16px; opacity: 0.3;"></i>
                        <p>No announcements available</p>
                    </div>
                <?php endif; ?>
            </div>

            <!-- Weather Container -->
            <div class="dashboard-graph" style="grid-column: 2;">
                <h3><i class="fas fa-cloud-sun"></i> Weather</h3>
                <div style="background: white; border-radius: 12px; padding: 24px; box-shadow: 0 2px 8px rgba(0,0,0,0.1); text-align: center; height: 100%; border: 1px solid #e5e7eb; display: flex; flex-direction: column;">
                    <!-- Weather Icon -->
                    <div style="font-size: 2.5rem; color: #8B1538; margin-bottom: 16px;">
                        <i class="fas fa-cloud-sun"></i>
                    </div>
                    
                    <!-- Temperature -->
                    <div style="font-size: 2rem; font-weight: 600; color: #333; margin-bottom: 8px;">
                        28°C
                    </div>
                    
                    <!-- Weather Description -->
                    <div style="color: #666; margin-bottom: 20px; font-weight: 400; font-size: 0.95rem;">
                        Partly Cloudy
                    </div>
                    
                    <!-- Location -->
                    <div style="color: #888; margin-bottom: auto; font-size: 0.85rem;">
                        <i class="fas fa-map-marker-alt" style="margin-right: 5px;"></i>
                        Cabuyao, Laguna
                    </div>
                    
                    <!-- Weather Details -->
                    <div style="border-top: 1px solid #f0f0f0; padding: 16px 0 24px 0; margin-top: auto;">
                        <div style="display: flex; justify-content: space-between; margin-bottom: 10px;">
                            <span style="color: #666; font-size: 0.85rem;">
                                Feels like
                            </span>
                            <span style="font-weight: 500; font-size: 0.85rem; color: #333;">30°C</span>
                        </div>
                        <div style="display: flex; justify-content: space-between; margin-bottom: 10px;">
                            <span style="color: #666; font-size: 0.85rem;">
                                Humidity
                            </span>
                            <span style="font-weight: 500; font-size: 0.85rem; color: #333;">65%</span>
                        </div>
                        <div style="display: flex; justify-content: space-between; margin-bottom: 10px;">
                            <span style="color: #666; font-size: 0.85rem;">
                                Wind Speed
                            </span>
                            <span style="font-weight: 500; font-size: 0.85rem; color: #333;">12 km/h</span>
                        </div>
                        <div style="display: flex; justify-content: space-between; margin-bottom: 10px;">
                            <span style="color: #666; font-size: 0.85rem;">
                                Visibility
                            </span>
                            <span style="font-weight: 500; font-size: 0.85rem; color: #333;">10 km</span>
                        </div>
                        
                        <!-- Update Time -->
                        <div style="margin-top: 16px; color: #999; font-size: 0.75rem;">
                            Last updated: 2 minutes ago
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Charts Row -->
        <div style="display: grid; grid-template-columns: 1fr; gap: 24px; margin-bottom: 32px;">
            <div class="dashboard-graph">
                <h3><i class="fas fa-chart-pie"></i> Case Status Overview</h3>
                <div class="chart-container">
                    <canvas id="caseStatusChart"></canvas>
                    <?php 
                    $pie_total = array_sum($status_counts);
                    // Show overlay ONLY for sample data (total = 25)
                    if ($pie_total == 25): ?>
                    <div class="sample-data-overlay">
                        <i class="fas fa-info-circle"></i>
                        <span>Sample data shown</span>
                    </div>
                    <?php endif; ?>
                </div>
            </div>
        </div>

        <!-- Recent Activities -->
        <div class="dashboard-graph">
            <h3><i class="fas fa-clock"></i> Recent Activities</h3>
            <div style="max-height: 400px; overflow-y: auto;">
                <?php if (count($recent_activities) > 0): ?>
                    <?php foreach ($recent_activities as $activity): ?>
                        <div style="display: flex; align-items: center; padding: 16px; border-bottom: 1px solid #f0f0f0; transition: background 0.2s;" onmouseover="this.style.background='#f8f9fa'" onmouseout="this.style.background='transparent'">
                            <div style="width: 40px; height: 40px; background: var(--gradient-primary); border-radius: 50%; display: flex; align-items: center; justify-content: center; color: white; margin-right: 16px;">
                                <i class="fas fa-gavel"></i>
                            </div>
                            <div style="flex: 1;">
                                <div style="font-weight: 600; color: var(--primary-color); margin-bottom: 4px;">
                                    <?= htmlspecialchars($activity['title']) ?>
                                </div>
                                <div style="font-size: 0.9rem; color: #666;">
                                    Case • <?= date('M j, Y g:i A', strtotime($activity['date'])) ?>
                                </div>
                            </div>
                        </div>
                    <?php endforeach; ?>
                <?php else: ?>
                    <div style="text-align: center; padding: 40px; color: #666;">
                        <i class="fas fa-inbox" style="font-size: 3rem; margin-bottom: 16px; opacity: 0.3;"></i>
                        <p>No recent activities</p>
                    </div>
                <?php endif; ?>
            </div>
        </div>
    </div>

    <!-- Image Zoom Modal -->
    <div id="imageModal" style="display: none; position: fixed; z-index: 1000; left: 0; top: 0; width: 100%; height: 100%; background-color: rgba(0,0,0,0.9); cursor: pointer;" onclick="closeImageModal()">
        <div style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); max-width: 90%; max-height: 90%;">
            <img id="modalImage" src="" alt="Zoomed Image" style="width: 100%; height: auto; border-radius: 8px;">
        </div>
        <div style="position: absolute; top: 20px; right: 30px; color: white; font-size: 30px; font-weight: bold; cursor: pointer;" onclick="closeImageModal()">
            <i class="fas fa-times"></i>
        </div>
    </div>

    <script>
        // Case Status Chart
        const ctx = document.getElementById('caseStatusChart').getContext('2d');
        const caseStatusData = {
            labels: <?= json_encode(array_keys($status_counts)) ?>,
            datasets: [{
                data: <?= json_encode(array_values($status_counts)) ?>,
                backgroundColor: [
                    '#5D0E26', '#27ae60', '#3498db', '#f39c12', '#e74c3c', '#9b59b6', '#8B1538', '#8B4A6B'
                ],
                borderWidth: 2,
                borderColor: '#fff'
            }]
        };
        
        const caseStatusChart = new Chart(ctx, {
            type: 'doughnut',
            data: caseStatusData,
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        position: 'bottom',
                        labels: {
                            padding: 20,
                            usePointStyle: true,
                            font: {
                                size: 12
                            }
                        }
                    }
                },
                elements: {
                    arc: {
                        borderWidth: 3
                    }
                }
            }
        });

        // Fix chart responsiveness on window resize
        window.addEventListener('resize', function() {
            caseStatusChart.resize();
        });

        // Force chart resize after page load
        setTimeout(function() {
            caseStatusChart.resize();
        }, 100);

        // Announcement Carousel
        let currentAnnouncement = 0;
        const announcements = <?= json_encode($announcements) ?>;
        
        function showAnnouncement(index) {
            const slides = document.querySelectorAll('.announcement-slide');
            const dots = document.querySelectorAll('.nav-dot');
            
            // Hide all slides
            slides.forEach(slide => slide.style.display = 'none');
            
            // Show current slide
            if (slides[index]) {
                slides[index].style.display = 'block';
            }
            
            // Update dots
            dots.forEach((dot, i) => {
                dot.style.background = i === index ? 'var(--primary-color)' : '#e9ecef';
            });
            
            currentAnnouncement = index;
        }
        
        function nextAnnouncement() {
            const nextIndex = (currentAnnouncement + 1) % announcements.length;
            showAnnouncement(nextIndex);
        }
        
        function previousAnnouncement() {
            const prevIndex = currentAnnouncement === 0 ? announcements.length - 1 : currentAnnouncement - 1;
            showAnnouncement(prevIndex);
        }
        
        function goToAnnouncement(index) {
            showAnnouncement(index);
        }
        
        // Add hover effects for navigation buttons
        document.addEventListener('DOMContentLoaded', function() {
            const navBtns = document.querySelectorAll('.nav-btn');
            navBtns.forEach(btn => {
                btn.addEventListener('mouseenter', function() {
                    this.style.background = '#e9ecef';
                    this.style.color = '#333';
                });
                btn.addEventListener('mouseleave', function() {
                    this.style.background = '#f8f9fa';
                    this.style.color = '#666';
                });
            });
        });

        // Image Zoom Modal Functions
        function openImageModal(imageSrc) {
            if (!imageSrc) {
                alert('No image to display');
                return;
            }
            
            const modal = document.getElementById('imageModal');
            const modalImg = document.getElementById('modalImage');
            
            if (modal && modalImg) {
                modal.style.display = 'block';
                modalImg.src = imageSrc;
                modalImg.onload = function() {
                    console.log('Image loaded successfully');
                };
                modalImg.onerror = function() {
                    console.error('Failed to load image:', imageSrc);
                    alert('Failed to load image');
                };
                
                // Prevent body scroll when modal is open
                document.body.style.overflow = 'hidden';
            } else {
                console.error('Modal elements not found');
                alert('Modal not found');
            }
        }

        function closeImageModal() {
            const modal = document.getElementById('imageModal');
            if (modal) {
                modal.style.display = 'none';
                // Restore body scroll
                document.body.style.overflow = 'auto';
            }
        }

        // Close modal with Escape key
        document.addEventListener('keydown', function(event) {
            if (event.key === 'Escape') {
                closeImageModal();
            }
        });

    </script>
</body>
</html> </html> 
