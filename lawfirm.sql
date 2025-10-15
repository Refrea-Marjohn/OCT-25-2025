-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3307:3307
-- Generation Time: Oct 12, 2025 at 02:54 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `lawfirm`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin_messages`
--

CREATE TABLE `admin_messages` (
  `id` int(11) NOT NULL,
  `admin_id` int(11) NOT NULL,
  `recipient_id` int(11) NOT NULL,
  `message` text NOT NULL,
  `sent_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `announcements`
--

CREATE TABLE `announcements` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `image_path` varchar(500) DEFAULT NULL,
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `announcements`
--

INSERT INTO `announcements` (`id`, `title`, `description`, `image_path`, `created_by`, `created_at`, `updated_at`) VALUES
(4, '', 'qweq', 'uploads/announcements/announcement_2025-10-12_08-38-58_68eb4d020363b.png', 34, '2025-10-12 06:38:58', '2025-10-12 06:38:58'),
(5, '', 'qwe', 'uploads/announcements/announcement_2025-10-12_08-42-21_68eb4dcd3d489.png', 34, '2025-10-12 06:42:21', '2025-10-12 06:42:21');

-- --------------------------------------------------------

--
-- Table structure for table `attorney_cases`
--

CREATE TABLE `attorney_cases` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `attorney_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `client_id` int(11) DEFAULT NULL,
  `case_type` varchar(100) DEFAULT NULL,
  `status` varchar(50) DEFAULT 'Active',
  `next_hearing` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `attorney_documents`
--

CREATE TABLE `attorney_documents` (
  `id` int(11) NOT NULL,
  `file_size` bigint(20) DEFAULT NULL,
  `file_type` varchar(50) DEFAULT NULL,
  `file_name` varchar(255) NOT NULL,
  `file_path` varchar(255) NOT NULL,
  `category` varchar(100) NOT NULL,
  `uploaded_by` int(11) NOT NULL,
  `upload_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `attorney_document_activity`
--

CREATE TABLE `attorney_document_activity` (
  `id` int(11) NOT NULL,
  `document_id` int(11) NOT NULL,
  `action` varchar(50) NOT NULL,
  `user_id` int(11) NOT NULL,
  `case_id` int(11) DEFAULT NULL,
  `file_name` varchar(255) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  `user_name` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `attorney_document_activity`
--

INSERT INTO `attorney_document_activity` (`id`, `document_id`, `action`, `user_id`, `case_id`, `file_name`, `timestamp`, `user_name`) VALUES
(8, 22, 'Deleted', 1, NULL, '1759848712_0_dawdaw dadaw dawwdaw.pdf', '2025-10-10 17:59:55', 'Opiña, Leif Laiglon Abriz'),
(9, 21, 'Edited', 1, NULL, '1759849799_0_dawdawd dawadadawdawdadw dawdawdawdawdawdaw', '2025-10-10 18:00:15', 'Opiña, Leif Laiglon Abriz');

-- --------------------------------------------------------

--
-- Table structure for table `attorney_messages`
--

CREATE TABLE `attorney_messages` (
  `id` int(11) NOT NULL,
  `attorney_id` int(11) NOT NULL,
  `recipient_id` int(11) NOT NULL,
  `message` text NOT NULL,
  `sent_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `audit_trail`
--

CREATE TABLE `audit_trail` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `user_name` varchar(100) NOT NULL,
  `user_type` enum('admin','attorney','client','employee') NOT NULL,
  `action` varchar(255) NOT NULL,
  `module` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `status` enum('success','failed','warning','info') DEFAULT 'success',
  `priority` enum('low','medium','high','critical') DEFAULT 'low',
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  `additional_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`additional_data`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `audit_trail`
--

INSERT INTO `audit_trail` (`id`, `user_id`, `user_name`, `user_type`, `action`, `module`, `description`, `ip_address`, `user_agent`, `status`, `priority`, `timestamp`, `additional_data`) VALUES
(2397, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_audit', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-08 03:46:50', NULL),
(2398, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 16:02:07', NULL),
(2399, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 16:05:01', NULL),
(2400, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 16:05:10', NULL),
(2401, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 16:09:23', NULL),
(2402, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 16:10:17', NULL),
(2403, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 16:16:18', NULL),
(2404, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_usermanagement', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 16:20:30', NULL),
(2405, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: add_user', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 16:21:12', NULL),
(2406, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'User Create', 'User Management', 'Created new attorney account: Refrea, Laica Castillo (castillolaica30@gmail.com) - Email sent successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-10 16:21:18', NULL),
(2407, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_usermanagement', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 16:21:18', NULL),
(2408, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_usermanagement', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 16:21:24', NULL),
(2409, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 16:21:25', NULL),
(2410, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 16:21:26', NULL),
(2411, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 16:21:30', NULL),
(2412, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 16:28:32', NULL),
(2413, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 16:28:34', NULL),
(2414, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 16:29:06', NULL),
(2415, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 16:29:12', NULL),
(2416, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 16:29:18', NULL),
(2417, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 16:29:31', NULL),
(2418, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 16:32:57', NULL),
(2419, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 16:38:47', NULL),
(2420, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 16:39:10', NULL),
(2421, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 16:39:17', NULL),
(2422, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 16:40:01', NULL),
(2423, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 16:40:50', NULL),
(2424, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 16:41:24', NULL),
(2425, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 16:41:56', NULL),
(2426, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 16:46:42', NULL),
(2427, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 16:47:13', NULL),
(2428, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 16:47:20', NULL),
(2429, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 16:47:26', NULL),
(2430, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 16:47:27', NULL),
(2431, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 16:47:32', NULL),
(2432, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 16:47:36', NULL),
(2433, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 16:48:56', NULL),
(2434, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 16:49:18', NULL),
(2435, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 16:49:22', NULL),
(2436, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 16:50:28', NULL),
(2437, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 16:50:31', NULL),
(2438, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 16:50:31', NULL),
(2439, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 16:51:00', NULL),
(2440, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 16:52:15', NULL),
(2441, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 16:52:33', NULL),
(2442, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 16:53:14', NULL),
(2443, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 16:57:55', NULL),
(2444, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 16:58:55', NULL),
(2445, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:00:05', NULL),
(2446, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:01:23', NULL),
(2447, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:06:34', NULL),
(2448, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:06:43', NULL),
(2449, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:09:12', NULL),
(2450, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:11:58', NULL),
(2451, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:12:05', NULL),
(2452, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:12:46', NULL),
(2453, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Document Upload', 'Document Management', 'Uploaded document: REFREA_INFOGRAPHIC.pdf to attorney documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-10 17:12:46', NULL),
(2454, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:12:47', NULL),
(2455, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:13:04', NULL),
(2456, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:13:09', NULL),
(2457, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:13:20', NULL),
(2458, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Document Upload', 'Document Management', 'Uploaded document: REFREA_SLOGAN.pdf to attorney documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-10 17:13:20', NULL),
(2459, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:13:21', NULL),
(2460, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:13:24', NULL),
(2461, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:16:02', NULL),
(2462, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:16:35', NULL),
(2463, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Document Upload', 'Document Management', 'Uploaded document: 1759848954_0_dawdwad dawda dwadaw 1.pdf to attorney documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-10 17:16:36', NULL),
(2464, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Document Upload', 'Document Management', 'Uploaded document: 1759848954_0_dawdwad dawda dwadaw.pdf to attorney documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-10 17:16:36', NULL),
(2465, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:16:37', NULL),
(2466, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:17:05', NULL),
(2467, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Document Upload', 'Document Management', 'Uploaded document: 1759849799_0_dawdawd dawadadawdawdadw dawdawdawdawdawdaw.pdf to attorney documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-10 17:17:05', NULL),
(2468, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:17:06', NULL),
(2469, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:17:08', NULL),
(2470, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:19:30', NULL),
(2471, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:21:00', NULL),
(2472, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:21:20', NULL),
(2473, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:23:29', NULL),
(2474, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:24:35', NULL),
(2475, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Document Upload', 'Document Management', 'Uploaded document: 1759848954_0_dawdwad dawda dwadaw.pdf to attorney documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-10 17:24:35', NULL),
(2476, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:24:36', NULL),
(2477, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:24:44', NULL),
(2478, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:24:58', NULL),
(2479, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Document Upload', 'Document Management', 'Uploaded document: dawdwa.pdf to employee documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-10 17:24:58', NULL),
(2480, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:24:58', NULL),
(2481, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:25:00', NULL),
(2482, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:25:01', NULL),
(2483, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:25:01', NULL),
(2484, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:25:01', NULL),
(2485, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:25:02', NULL),
(2486, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:26:38', NULL),
(2487, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:26:44', NULL),
(2488, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:26:45', NULL),
(2489, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:26:47', NULL),
(2490, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:26:48', NULL),
(2491, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_usermanagement', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:26:50', NULL),
(2492, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_managecases', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:26:51', NULL),
(2493, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_clients', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:26:52', NULL),
(2494, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:26:53', NULL),
(2495, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_audit', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:26:53', NULL),
(2496, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_managecases', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:26:56', NULL),
(2497, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:26:59', NULL),
(2498, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:27:31', NULL),
(2499, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:27:48', NULL),
(2500, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Document Upload', 'Document Management', 'Uploaded document: dawdaw.pdf to employee documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-10 17:27:48', NULL),
(2501, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:27:49', NULL),
(2502, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:29:46', NULL),
(2503, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:30:27', NULL),
(2504, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:30:28', NULL),
(2505, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:30:38', NULL),
(2506, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:30:39', NULL),
(2507, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:30:39', NULL),
(2508, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:30:39', NULL),
(2509, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:30:41', NULL),
(2510, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:31:01', NULL),
(2511, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:31:06', NULL),
(2512, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:31:31', NULL),
(2513, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:31:31', NULL),
(2514, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:31:33', NULL),
(2515, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:31:38', NULL),
(2516, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:32:12', NULL),
(2517, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:32:22', NULL),
(2518, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:32:41', NULL),
(2519, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:33:33', NULL),
(2520, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Document Upload', 'Document Management', 'Uploaded document: 1759848954_0_dawdwad dawda dwadaw 1.pdf to attorney documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-10 17:33:33', NULL),
(2521, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Document Upload', 'Document Management', 'Uploaded document: 1759848954_0_dawdwad dawda dwadaw.pdf to attorney documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-10 17:33:33', NULL),
(2522, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:33:34', NULL),
(2523, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:34:51', NULL),
(2524, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:35:08', NULL),
(2525, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Document Upload', 'Document Management', 'Uploaded document: 1759848954_0_dawdwad dawda dwadaw 1.pdf to attorney documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-10 17:35:08', NULL),
(2526, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Document Upload', 'Document Management', 'Uploaded document: 1759848954_0_dawdwad dawda dwadaw.pdf to attorney documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-10 17:35:08', NULL),
(2527, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Document Upload', 'Document Management', 'Uploaded document: 1759849799_0_dawdawd dawadadawdawdadw dawdawdawdawdawdaw.pdf to attorney documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-10 17:35:08', NULL),
(2528, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Document Upload', 'Document Management', 'Uploaded document: 1759848712_0_dawdaw dadaw dawwdaw.pdf to attorney documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-10 17:35:08', NULL),
(2529, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:35:09', NULL),
(2530, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:39:40', NULL),
(2531, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:39:49', NULL),
(2532, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:40:32', NULL),
(2533, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:45:05', NULL),
(2534, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:46:31', NULL),
(2535, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:48:00', NULL),
(2536, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:48:25', NULL),
(2537, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:48:26', NULL),
(2538, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:49:18', NULL),
(2539, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:49:20', NULL),
(2540, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_usermanagement', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:49:22', NULL),
(2541, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:49:23', NULL),
(2542, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:49:24', NULL),
(2543, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:49:25', NULL),
(2544, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:49:26', NULL),
(2545, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_usermanagement', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:49:27', NULL),
(2546, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_managecases', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:49:28', NULL),
(2547, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_audit', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:49:29', NULL),
(2548, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:49:30', NULL),
(2549, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_clients', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:49:31', NULL),
(2550, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_managecases', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:49:33', NULL),
(2551, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:49:40', NULL),
(2552, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:50:08', NULL),
(2553, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:52:41', NULL),
(2554, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:52:48', NULL),
(2555, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:52:56', NULL),
(2556, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:54:05', NULL),
(2557, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:54:10', NULL),
(2558, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:54:17', NULL),
(2559, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:54:26', NULL),
(2560, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:54:31', NULL),
(2561, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:54:35', NULL),
(2562, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:54:39', NULL),
(2563, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:54:47', NULL),
(2564, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:56:21', NULL),
(2565, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:56:29', NULL),
(2566, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:56:32', NULL),
(2567, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:56:36', NULL),
(2568, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:56:43', NULL),
(2569, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:56:48', NULL),
(2570, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:56:56', NULL);
INSERT INTO `audit_trail` (`id`, `user_id`, `user_name`, `user_type`, `action`, `module`, `description`, `ip_address`, `user_agent`, `status`, `priority`, `timestamp`, `additional_data`) VALUES
(2571, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:59:55', NULL),
(2572, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Document Delete', 'Document Management', 'Deleted document: 1759848712_0_dawdaw dadaw dawwdaw.pdf (Source: attorney)', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'high', '2025-10-10 17:59:55', NULL),
(2573, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 17:59:55', NULL),
(2574, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:00:04', NULL),
(2575, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:00:07', NULL),
(2576, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:00:15', NULL),
(2577, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Document Edit', 'Document Management', 'Edited attorney document: 1759849799_0_dawdawd dawadadawdawdadw dawdawdawdawdawdaw (Category: Court Documents)', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-10 18:00:15', NULL),
(2578, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:00:15', NULL),
(2579, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:00:26', NULL),
(2580, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:00:29', NULL),
(2581, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:01:12', NULL),
(2582, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:03:48', NULL),
(2583, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:03:50', NULL),
(2584, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:03:55', NULL),
(2585, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:04:01', NULL),
(2586, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:04:07', NULL),
(2587, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:04:18', NULL),
(2588, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:04:54', NULL),
(2589, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:04:57', NULL),
(2590, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:06:26', NULL),
(2591, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:06:27', NULL),
(2592, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:06:32', NULL),
(2593, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:06:34', NULL),
(2594, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:06:36', NULL),
(2595, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:06:38', NULL),
(2596, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:06:40', NULL),
(2597, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:06:44', NULL),
(2598, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:06:48', NULL),
(2599, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:07:03', NULL),
(2600, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:07:19', NULL),
(2601, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:07:23', NULL),
(2602, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:07:26', NULL),
(2603, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:07:27', NULL),
(2604, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:07:28', NULL),
(2605, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:07:32', NULL),
(2606, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:07:40', NULL),
(2607, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:07:48', NULL),
(2608, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:08:52', NULL),
(2609, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:08:56', NULL),
(2610, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:09:01', NULL),
(2611, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:09:06', NULL),
(2612, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:09:10', NULL),
(2613, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:09:13', NULL),
(2614, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:09:29', NULL),
(2615, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:09:44', NULL),
(2616, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:09:51', NULL),
(2617, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:09:53', NULL),
(2618, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:09:53', NULL),
(2619, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:10:01', NULL),
(2620, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:10:06', NULL),
(2621, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:12:25', NULL),
(2622, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:12:28', NULL),
(2623, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:12:34', NULL),
(2624, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:12:38', NULL),
(2625, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:12:42', NULL),
(2626, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:13:39', NULL),
(2627, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:13:45', NULL),
(2628, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:13:49', NULL),
(2629, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:13:52', NULL),
(2630, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:13:59', NULL),
(2631, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:14:08', NULL),
(2632, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:14:10', NULL),
(2633, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:14:11', NULL),
(2634, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:14:16', NULL),
(2635, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:15:23', NULL),
(2636, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:15:26', NULL),
(2637, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:15:32', NULL),
(2638, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:15:33', NULL),
(2639, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:15:40', NULL),
(2640, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:15:43', NULL),
(2641, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:15:47', NULL),
(2642, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:15:49', NULL),
(2643, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:15:56', NULL),
(2644, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:16:02', NULL),
(2645, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:16:05', NULL),
(2646, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:16:09', NULL),
(2647, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:16:12', NULL),
(2648, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:18:51', NULL),
(2649, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:19:15', NULL),
(2650, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:19:15', NULL),
(2651, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:19:18', NULL),
(2652, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:20:11', NULL),
(2653, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:21:21', NULL),
(2654, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:21:42', NULL),
(2655, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:22:29', NULL),
(2656, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:24:47', NULL),
(2657, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:25:01', NULL),
(2658, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:26:46', NULL),
(2659, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:29:57', NULL),
(2660, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:30:13', NULL),
(2661, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:30:14', NULL),
(2662, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:30:39', NULL),
(2663, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:30:42', NULL),
(2664, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:30:43', NULL),
(2665, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_usermanagement', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:30:44', NULL),
(2666, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_usermanagement', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:30:45', NULL),
(2667, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:31:48', NULL),
(2668, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:32:54', NULL),
(2669, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_usermanagement', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:33:08', NULL),
(2670, 27, 'Refrea, Laica Castillo', 'attorney', 'User Login', 'Authentication', 'User logged in successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:33:18', NULL),
(2671, 27, 'Refrea, Laica Castillo', 'attorney', 'Page Access', 'Page Access', 'Accessed page: attorney_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:33:37', NULL),
(2672, 27, 'Refrea, Laica Castillo', 'attorney', 'Page Access', 'Page Access', 'Accessed page: attorney_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:33:39', NULL),
(2673, 27, 'Refrea, Laica Castillo', 'attorney', 'Page Access', 'Page Access', 'Accessed page: attorney_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:33:42', NULL),
(2674, 27, 'Refrea, Laica Castillo', 'attorney', 'Page Access', 'Page Access', 'Accessed page: attorney_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:39:56', NULL),
(2675, 27, 'Refrea, Laica Castillo', 'attorney', 'Page Access', 'Page Access', 'Accessed page: attorney_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:40:54', NULL),
(2676, 27, 'Refrea, Laica Castillo', 'attorney', 'Page Access', 'Page Access', 'Accessed page: attorney_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:42:10', NULL),
(2677, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_usermanagement', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:44:46', NULL),
(2678, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_usermanagement', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:44:46', NULL),
(2679, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_usermanagement', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:44:46', NULL),
(2680, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_usermanagement', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:44:46', NULL),
(2681, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: add_user', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:45:18', NULL),
(2682, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'User Create', 'User Management', 'Created new attorney account: adwdaw, dadw dwawd (marjohnrefrea1215@gmail.com) - Email sent successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-10 18:45:25', NULL),
(2683, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_usermanagement', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:45:25', NULL),
(2684, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_usermanagement', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:45:53', NULL),
(2685, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_usermanagement', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:45:56', NULL),
(2686, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:45:59', NULL),
(2687, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:46:01', NULL),
(2688, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_clients', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:47:10', NULL),
(2689, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Client Create', 'Client Management', 'Created new client account: dadw, dadaw ddadw (baomacky99@gmail.com) - Email sent successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-10 18:47:36', NULL),
(2690, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_clients', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:47:38', NULL),
(2691, 27, 'Refrea, Laica Castillo', 'attorney', 'User Logout', 'Authentication', 'User logged out successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:47:46', NULL),
(2692, 29, 'dadw, dadaw ddadw', 'client', 'User Login', 'Authentication', 'User logged in successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:47:54', NULL),
(2693, 29, 'dadw, dadaw ddadw', 'client', 'Page Access', 'Page Access', 'Accessed page: client_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:47:55', NULL),
(2694, 29, 'dadw, dadaw ddadw', 'client', 'Page Access', 'Page Access', 'Accessed page: client_request_access', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:48:20', NULL),
(2695, 29, 'dadw, dadaw ddadw', 'client', 'Request Form Submission', 'Communication', 'Submitted messaging request form with ID: REQ-20251010-0029-1613', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-10 18:48:20', NULL),
(2696, 29, 'dadw, dadaw ddadw', 'client', 'Page Access', 'Page Access', 'Accessed page: client_request_access', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:48:20', NULL),
(2697, 29, 'dadw, dadaw ddadw', 'client', 'Page Access', 'Page Access', 'Accessed page: client_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:48:22', NULL),
(2698, 29, 'dadw, dadaw ddadw', 'client', 'User Logout', 'Authentication', 'User logged out successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:48:26', NULL),
(2699, 28, 'adwdaw, dadw dwawd', 'attorney', 'User Login', 'Authentication', 'User logged in successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:48:42', NULL),
(2700, 28, 'adwdaw, dadw dwawd', 'attorney', 'Page Access', 'Page Access', 'Accessed page: attorney_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:48:46', NULL),
(2701, 28, 'adwdaw, dadw dwawd', 'attorney', 'User Logout', 'Authentication', 'User logged out successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:48:50', NULL),
(2702, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_usermanagement', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:48:53', NULL),
(2703, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: add_user', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:49:35', NULL),
(2704, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'User Create', 'User Management', 'Created new employee account: dawdaw, dadadad dadaw (marjohnrefrea123456@gmail.com) - Email sent successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-10 18:49:40', NULL),
(2705, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_usermanagement', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:49:40', NULL),
(2706, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_usermanagement', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:49:46', NULL),
(2707, 30, 'dawdaw, dadadad dadaw', 'employee', 'User Login', 'Authentication', 'User logged in successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:49:57', NULL),
(2708, 30, 'dawdaw, dadadad dadaw', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_request_management', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:50:01', NULL),
(2709, 30, 'dawdaw, dadadad dadaw', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_request_management', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:50:19', NULL),
(2710, 30, 'dawdaw, dadadad dadaw', 'employee', 'Request Review', 'Communication', 'Request ID: 12 - Action: Approved with attorney assignment', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-10 18:50:19', NULL),
(2711, 30, 'dawdaw, dadadad dadaw', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_request_management', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:50:19', NULL),
(2712, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:50:25', NULL),
(2713, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:50:26', NULL),
(2714, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:50:26', NULL),
(2715, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:50:29', NULL),
(2716, 30, 'dawdaw, dadadad dadaw', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_request_management', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:50:32', NULL),
(2717, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:50:34', NULL),
(2718, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_clients', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:50:40', NULL),
(2719, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:50:41', NULL),
(2720, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:50:42', NULL),
(2721, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:50:42', NULL),
(2722, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:52:18', NULL),
(2723, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:52:19', NULL),
(2724, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:52:19', NULL),
(2725, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:52:21', NULL),
(2726, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:52:21', NULL),
(2727, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:53:02', NULL),
(2728, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:53:04', NULL),
(2729, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:53:04', NULL),
(2730, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_clients', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:53:13', NULL),
(2731, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:53:13', NULL),
(2732, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:53:14', NULL),
(2733, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:53:14', NULL),
(2734, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:53:17', NULL),
(2735, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_clients', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:53:18', NULL),
(2736, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:53:19', NULL),
(2737, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:53:19', NULL),
(2738, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:53:19', NULL),
(2739, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:53:19', NULL),
(2740, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:53:19', NULL),
(2741, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_managecases', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:53:21', NULL),
(2742, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_clients', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:53:22', NULL),
(2743, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:53:22', NULL),
(2744, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:53:23', NULL),
(2745, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:53:24', NULL);
INSERT INTO `audit_trail` (`id`, `user_id`, `user_name`, `user_type`, `action`, `module`, `description`, `ip_address`, `user_agent`, `status`, `priority`, `timestamp`, `additional_data`) VALUES
(2746, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:53:24', NULL),
(2747, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:53:24', NULL),
(2748, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:55:07', NULL),
(2749, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:55:08', NULL),
(2750, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:55:08', NULL),
(2751, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:55:50', NULL),
(2752, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:55:50', NULL),
(2753, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_clients', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:55:53', NULL),
(2754, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Client Create', 'Client Management', 'Created new client account: dawd, dawdaw wdawd (refreamarjohn91@gmail.com) - Email sent successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-10 18:56:26', NULL),
(2755, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_clients', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:56:28', NULL),
(2756, 30, 'dawdaw, dadadad dadaw', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_request_management', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:56:31', NULL),
(2757, 31, 'dawd, dawdaw wdawd', 'client', 'User Login', 'Authentication', 'User logged in successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:56:47', NULL),
(2758, 31, 'dawd, dawdaw wdawd', 'client', 'Page Access', 'Page Access', 'Accessed page: client_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:56:49', NULL),
(2759, 31, 'dawd, dawdaw wdawd', 'client', 'Page Access', 'Page Access', 'Accessed page: client_request_access', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:57:11', NULL),
(2760, 31, 'dawd, dawdaw wdawd', 'client', 'Request Form Submission', 'Communication', 'Submitted messaging request form with ID: REQ-20251010-0031-2511', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-10 18:57:12', NULL),
(2761, 31, 'dawd, dawdaw wdawd', 'client', 'Page Access', 'Page Access', 'Accessed page: client_request_access', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:57:12', NULL),
(2762, 31, 'dawd, dawdaw wdawd', 'client', 'Page Access', 'Page Access', 'Accessed page: client_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:57:13', NULL),
(2763, 30, 'dawdaw, dadadad dadaw', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_request_management', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:57:14', NULL),
(2764, 30, 'dawdaw, dadadad dadaw', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_request_management', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:57:19', NULL),
(2765, 30, 'dawdaw, dadadad dadaw', 'employee', 'Request Review', 'Communication', 'Request ID: 13 - Action: Approved with attorney assignment', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-10 18:57:19', NULL),
(2766, 30, 'dawdaw, dadadad dadaw', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_request_management', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:57:19', NULL),
(2767, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_clients', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:57:22', NULL),
(2768, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:57:24', NULL),
(2769, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:57:25', NULL),
(2770, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:57:25', NULL),
(2771, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:57:26', NULL),
(2772, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:57:26', NULL),
(2773, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:57:27', NULL),
(2774, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:57:27', NULL),
(2775, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:57:27', NULL),
(2776, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:57:29', NULL),
(2777, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:57:29', NULL),
(2778, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:57:30', NULL),
(2779, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:57:30', NULL),
(2780, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:57:30', NULL),
(2781, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:57:30', NULL),
(2782, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:57:30', NULL),
(2783, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:57:30', NULL),
(2784, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:57:31', NULL),
(2785, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:57:31', NULL),
(2786, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:57:35', NULL),
(2787, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:57:36', NULL),
(2788, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:57:36', NULL),
(2789, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:57:36', NULL),
(2790, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:57:36', NULL),
(2791, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:57:37', NULL),
(2792, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:57:37', NULL),
(2793, 30, 'dawdaw, dadadad dadaw', 'employee', 'Schedule Created', 'Schedule Management', 'Created by: dawdaw, dadadad dadaw; Attorney: Opiña, Leif Laiglon Abriz; Client: dadw, dadaw ddadw; Title: dawdaw; Type: Appointment; Date: 2025-10-11; Time: 03:58-06:58; Location: dawdawdawda', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-10 18:58:33', NULL),
(2794, 31, 'dawd, dawdaw wdawd', 'client', 'Page Access', 'Page Access', 'Accessed page: client_cases', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:58:38', NULL),
(2795, 30, 'dawdaw, dadadad dadaw', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:59:40', NULL),
(2796, 30, 'dawdaw, dadadad dadaw', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:59:41', NULL),
(2797, 30, 'dawdaw, dadadad dadaw', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:59:41', NULL),
(2798, 30, 'dawdaw, dadadad dadaw', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:59:41', NULL),
(2799, 30, 'dawdaw, dadadad dadaw', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:59:42', NULL),
(2800, 30, 'dawdaw, dadadad dadaw', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:59:42', NULL),
(2801, 30, 'dawdaw, dadadad dadaw', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:59:42', NULL),
(2802, 30, 'dawdaw, dadadad dadaw', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:59:42', NULL),
(2803, 30, 'dawdaw, dadadad dadaw', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:59:42', NULL),
(2804, 30, 'dawdaw, dadadad dadaw', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:59:42', NULL),
(2805, 30, 'dawdaw, dadadad dadaw', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:59:43', NULL),
(2806, 30, 'dawdaw, dadadad dadaw', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:59:43', NULL),
(2807, 30, 'dawdaw, dadadad dadaw', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:59:43', NULL),
(2808, 30, 'dawdaw, dadadad dadaw', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:59:43', NULL),
(2809, 30, 'dawdaw, dadadad dadaw', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:59:43', NULL),
(2810, 30, 'dawdaw, dadadad dadaw', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:59:43', NULL),
(2811, 30, 'dawdaw, dadadad dadaw', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:59:43', NULL),
(2812, 30, 'dawdaw, dadadad dadaw', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:59:44', NULL),
(2813, 30, 'dawdaw, dadadad dadaw', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:59:44', NULL),
(2814, 30, 'dawdaw, dadadad dadaw', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_request_management', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:59:46', NULL),
(2815, 30, 'dawdaw, dadadad dadaw', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:59:46', NULL),
(2816, 30, 'dawdaw, dadadad dadaw', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_request_management', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:59:47', NULL),
(2817, 30, 'dawdaw, dadadad dadaw', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:59:49', NULL),
(2818, 30, 'dawdaw, dadadad dadaw', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:59:49', NULL),
(2819, 30, 'dawdaw, dadadad dadaw', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:59:49', NULL),
(2820, 30, 'dawdaw, dadadad dadaw', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:59:49', NULL),
(2821, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:59:52', NULL),
(2822, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:59:52', NULL),
(2823, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:59:52', NULL),
(2824, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:59:53', NULL),
(2825, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:59:53', NULL),
(2826, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:59:55', NULL),
(2827, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 18:59:55', NULL),
(2828, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_clients', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 19:00:05', NULL),
(2829, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Client Create', 'Client Management', 'Created new client account: dadawd, dawdaw dadw (yuhanerfy@gmail.com) - Email sent successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-10 19:00:49', NULL),
(2830, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_clients', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 19:00:49', NULL),
(2831, 31, 'dawd, dawdaw wdawd', 'client', 'User Logout', 'Authentication', 'User logged out successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 19:01:09', NULL),
(2832, 32, 'dadawd, dawdaw dadw', 'client', 'User Login', 'Authentication', 'User logged in successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 19:01:19', NULL),
(2833, 32, 'dadawd, dawdaw dadw', 'client', 'Page Access', 'Page Access', 'Accessed page: client_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 19:01:20', NULL),
(2834, 32, 'dadawd, dawdaw dadw', 'client', 'Page Access', 'Page Access', 'Accessed page: client_request_access', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 19:01:40', NULL),
(2835, 32, 'dadawd, dawdaw dadw', 'client', 'Request Form Submission', 'Communication', 'Submitted messaging request form with ID: REQ-20251010-0032-4687', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-10 19:01:40', NULL),
(2836, 32, 'dadawd, dawdaw dadw', 'client', 'Page Access', 'Page Access', 'Accessed page: client_request_access', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 19:01:40', NULL),
(2837, 32, 'dadawd, dawdaw dadw', 'client', 'Page Access', 'Page Access', 'Accessed page: client_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 19:01:41', NULL),
(2838, 30, 'dawdaw, dadadad dadaw', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_request_management', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 19:01:45', NULL),
(2839, 30, 'dawdaw, dadadad dadaw', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_request_management', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 19:01:49', NULL),
(2840, 30, 'dawdaw, dadadad dadaw', 'employee', 'Request Review', 'Communication', 'Request ID: 14 - Action: Approved with attorney assignment', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-10 19:01:49', NULL),
(2841, 30, 'dawdaw, dadadad dadaw', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_request_management', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 19:01:49', NULL),
(2842, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 19:01:54', NULL),
(2843, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 19:01:55', NULL),
(2844, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 19:01:55', NULL),
(2845, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 19:01:56', NULL),
(2846, 30, 'dawdaw, dadadad dadaw', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_request_management', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 19:02:35', NULL),
(2847, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 19:02:37', NULL),
(2848, 32, 'dadawd, dawdaw dadw', 'client', 'Page Access', 'Page Access', 'Accessed page: client_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 19:02:40', NULL),
(2849, 32, 'dadawd, dawdaw dadw', 'client', 'Page Access', 'Page Access', 'Accessed page: client_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 19:02:41', NULL),
(2850, 32, 'dadawd, dawdaw dadw', 'client', 'Page Access', 'Page Access', 'Accessed page: client_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 19:02:41', NULL),
(2851, 32, 'dadawd, dawdaw dadw', 'client', 'Page Access', 'Page Access', 'Accessed page: client_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 19:02:43', NULL),
(2852, 32, 'dadawd, dawdaw dadw', 'client', 'Message Send', 'Communication', 'Sent message to attorney in conversation ID: 12', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 19:02:43', NULL),
(2853, 32, 'dadawd, dawdaw dadw', 'client', 'Page Access', 'Page Access', 'Accessed page: client_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 19:02:43', NULL),
(2854, 32, 'dadawd, dawdaw dadw', 'client', 'Page Access', 'Page Access', 'Accessed page: client_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 19:02:44', NULL),
(2855, 32, 'dadawd, dawdaw dadw', 'client', 'Page Access', 'Page Access', 'Accessed page: client_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 19:02:44', NULL),
(2856, 32, 'dadawd, dawdaw dadw', 'client', 'Page Access', 'Page Access', 'Accessed page: client_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 19:02:46', NULL),
(2857, 32, 'dadawd, dawdaw dadw', 'client', 'Message Send', 'Communication', 'Sent message to employee in conversation ID: 12', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 19:02:46', NULL),
(2858, 32, 'dadawd, dawdaw dadw', 'client', 'Page Access', 'Page Access', 'Accessed page: client_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 19:02:46', NULL),
(2859, 32, 'dadawd, dawdaw dadw', 'client', 'User Logout', 'Authentication', 'User logged out successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 19:02:51', NULL),
(2860, 32, 'dadawd, dawdaw dadw', 'client', 'User Login', 'Authentication', 'User logged in successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 19:03:04', NULL),
(2861, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 19:05:57', NULL),
(2862, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 19:06:00', NULL),
(2863, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 19:06:13', NULL),
(2864, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 19:06:20', NULL),
(2865, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 19:06:24', NULL),
(2866, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Schedule Created', 'Schedule Management', 'Created by: Opiña, Leif Laiglon Abriz; Attorney: Opiña, Leif Laiglon Abriz; Client: dadawd, dawdaw dadw; Title: dawdwa; Type: Appointment; Date: 2025-10-17; Time: 04:06-06:08; Location: ddawdaw', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-10 19:06:24', NULL),
(2867, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 19:06:26', NULL),
(2868, 32, 'dadawd, dawdaw dadw', 'client', 'Page Access', 'Page Access', 'Accessed page: client_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 19:17:00', NULL),
(2869, 32, 'dadawd, dawdaw dadw', 'client', 'Page Access', 'Page Access', 'Accessed page: client_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 19:17:01', NULL),
(2870, 32, 'dadawd, dawdaw dadw', 'client', 'Page Access', 'Page Access', 'Accessed page: client_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 19:17:01', NULL),
(2871, 32, 'dadawd, dawdaw dadw', 'client', 'Page Access', 'Page Access', 'Accessed page: client_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 19:17:01', NULL),
(2872, 32, 'dadawd, dawdaw dadw', 'client', 'Page Access', 'Page Access', 'Accessed page: client_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 19:17:01', NULL),
(2873, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 19:19:44', NULL),
(2874, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 19:19:54', NULL),
(2875, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 19:19:57', NULL),
(2876, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Schedule Created', 'Schedule Management', 'Created by: Opiña, Leif Laiglon Abriz; Attorney: Opiña, Leif Laiglon Abriz; Client: dadawd, dawdaw dadw; Title: dawdawd; Type: Appointment; Date: 2025-10-31; Time: 04:19-06:19; Location: dawdaw', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-10 19:19:57', NULL),
(2877, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 19:20:00', NULL),
(2878, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 19:20:20', NULL),
(2879, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 19:20:22', NULL),
(2880, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 19:20:22', NULL),
(2881, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 19:20:22', NULL),
(2882, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 19:20:22', NULL),
(2883, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 19:20:24', NULL),
(2884, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Message Send', 'Communication', 'Sent message in attorney conversation ID: 12', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 19:20:24', NULL),
(2885, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 19:20:24', NULL),
(2886, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_usermanagement', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 19:20:26', NULL),
(2887, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_clients', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 19:20:26', NULL),
(2888, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 19:21:00', NULL),
(2889, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 19:21:18', NULL),
(2890, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_clients', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 19:21:41', NULL),
(2891, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 19:21:42', NULL),
(2892, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_clients', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 19:21:44', NULL),
(2893, 30, 'dawdaw, dadadad dadaw', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_clients', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 19:21:46', NULL),
(2894, 30, 'dawdaw, dadadad dadaw', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_clients', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 19:21:47', NULL),
(2895, 30, 'dawdaw, dadadad dadaw', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_clients', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 19:21:48', NULL),
(2896, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_clients', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 19:22:38', NULL),
(2897, 32, 'dadawd, dawdaw dadw', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 19:23:20', NULL),
(2898, 32, 'dadawd, dawdaw dadw', 'client', 'Page Access', 'Page Access', 'Accessed page: client_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 19:23:25', NULL),
(2899, 32, 'dadawd, dawdaw dadw', 'client', 'Page Access', 'Page Access', 'Accessed page: client_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 19:23:27', NULL),
(2900, 32, 'dadawd, dawdaw dadw', 'client', 'Page Access', 'Page Access', 'Accessed page: client_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 19:23:27', NULL),
(2901, 32, 'dadawd, dawdaw dadw', 'client', 'Page Access', 'Page Access', 'Accessed page: client_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 19:23:27', NULL),
(2902, 32, 'dadawd, dawdaw dadw', 'client', 'Page Access', 'Page Access', 'Accessed page: client_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 19:23:27', NULL),
(2903, 32, 'dadawd, dawdaw dadw', 'client', 'Page Access', 'Page Access', 'Accessed page: client_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 19:23:28', NULL),
(2904, 32, 'dadawd, dawdaw dadw', 'client', 'Page Access', 'Page Access', 'Accessed page: client_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 19:23:28', NULL),
(2905, 32, 'dadawd, dawdaw dadw', 'client', 'Page Access', 'Page Access', 'Accessed page: client_cases', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 19:23:29', NULL),
(2906, 32, 'dadawd, dawdaw dadw', 'client', 'Page Access', 'Page Access', 'Accessed page: client_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 19:23:37', NULL),
(2907, 32, 'dadawd, dawdaw dadw', 'client', 'Page Access', 'Page Access', 'Accessed page: client_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 19:23:38', NULL),
(2908, 32, 'dadawd, dawdaw dadw', 'client', 'Page Access', 'Page Access', 'Accessed page: client_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 19:23:38', NULL),
(2909, 32, 'dadawd, dawdaw dadw', 'client', 'Page Access', 'Page Access', 'Accessed page: client_cases', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 19:30:48', NULL),
(2910, 32, 'dadawd, dawdaw dadw', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 19:30:48', NULL),
(2911, 32, 'dadawd, dawdaw dadw', 'client', 'Page Access', 'Page Access', 'Accessed page: client_cases', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 19:30:49', NULL),
(2912, 32, 'dadawd, dawdaw dadw', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 19:30:50', NULL),
(2913, 32, 'dadawd, dawdaw dadw', 'client', 'Page Access', 'Page Access', 'Accessed page: client_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 19:31:01', NULL),
(2914, 30, 'dawdaw, dadadad dadaw', 'employee', 'Walk-in Schedule Created', 'Schedule Management', 'Created by: dawdaw, dadadad dadaw; Attorney: adwdaw, dadw dwawd; Walk-in Client: dawdawd, dadaw dawda (Contact: 12312312312); Title: dawdaw; Type: Appointment; Date: 2025-10-11; Time: 04:32-05:32; Location: dawdadaw', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-10 19:32:58', NULL),
(2915, 30, 'dawdaw, dadadad dadaw', 'employee', 'Event Status Update', 'Case Management', 'Updated event #22 status to: Completed', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-10 19:35:51', NULL),
(2916, 30, 'dawdaw, dadadad dadaw', 'employee', 'Event Status Update', 'Case Management', 'Updated event #23 status to: Completed', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-10 19:35:59', NULL),
(2917, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 19:44:01', NULL),
(2918, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 19:46:51', NULL),
(2919, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 19:47:34', NULL);
INSERT INTO `audit_trail` (`id`, `user_id`, `user_name`, `user_type`, `action`, `module`, `description`, `ip_address`, `user_agent`, `status`, `priority`, `timestamp`, `additional_data`) VALUES
(2920, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 19:49:27', NULL),
(2921, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 19:49:37', NULL),
(2922, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 19:49:44', NULL),
(2923, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 19:49:51', NULL),
(2924, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 19:51:00', NULL),
(2925, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 19:53:22', NULL),
(2926, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 19:53:45', NULL),
(2927, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 19:53:48', NULL),
(2928, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 19:53:48', NULL),
(2929, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 19:53:48', NULL),
(2930, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 19:53:49', NULL),
(2931, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 19:53:51', NULL),
(2932, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 19:54:16', NULL),
(2933, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 19:54:16', NULL),
(2934, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 19:54:16', NULL),
(2935, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 19:54:16', NULL),
(2936, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 19:54:33', NULL),
(2937, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 19:59:15', NULL),
(2938, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 19:59:32', NULL),
(2939, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 20:00:34', NULL),
(2940, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 20:06:26', NULL),
(2941, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 20:07:31', NULL),
(2942, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 20:08:22', NULL),
(2943, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 20:09:52', NULL),
(2944, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 20:14:18', NULL),
(2945, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 20:14:37', NULL),
(2946, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 20:15:28', NULL),
(2947, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 20:16:53', NULL),
(2948, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 20:18:16', NULL),
(2949, 28, 'adwdaw, dadw dwawd', 'attorney', 'User Login', 'Authentication', 'User logged in successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 20:18:40', NULL),
(2950, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 20:20:39', NULL),
(2951, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Walk-in Schedule Created', 'Schedule Management', 'Created by: Opiña, Leif Laiglon Abriz; Attorney: Refrea, Laica Castillo; Walk-in Client: dawdw, dadaw dwad (Contact: 12312312312); Title: dawdaw; Type: Free Legal Advice; Date: 2025-10-15; Time: 04:20-05:20; Location: dawdawd', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-10 20:20:39', NULL),
(2952, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 20:20:40', NULL),
(2953, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 20:21:22', NULL),
(2954, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 20:21:31', NULL),
(2955, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Schedule Created', 'Schedule Management', 'Created by: Opiña, Leif Laiglon Abriz; Attorney: Opiña, Leif Laiglon Abriz; Client: dadawd, dawdaw dadw; Title: dawdawdaw; Type: Appointment; Date: 2025-10-18; Time: 17:21-20:20; Location: dadadawdaw', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-10 20:21:31', NULL),
(2956, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 20:21:33', NULL),
(2957, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 20:23:29', NULL),
(2958, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 20:23:34', NULL),
(2959, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Event Status Update', 'Case Management', 'Updated event #22 status to: Cancelled', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-10 20:23:54', NULL),
(2960, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 20:23:56', NULL),
(2961, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Event Status Update', 'Case Management', 'Updated event #22 status to: Completed', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-10 20:24:01', NULL),
(2962, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 20:24:11', NULL),
(2963, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 20:24:13', NULL),
(2964, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 20:24:18', NULL),
(2965, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 20:25:24', NULL),
(2966, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 20:25:35', NULL),
(2967, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 20:27:16', NULL),
(2968, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 20:27:20', NULL),
(2969, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 20:27:24', NULL),
(2970, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 20:29:22', NULL),
(2971, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 20:29:34', NULL),
(2972, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 20:29:41', NULL),
(2973, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Event Status Update', 'Case Management', 'Updated event #27 status to: Completed', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-10 20:30:09', NULL),
(2974, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 20:30:14', NULL),
(2975, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 20:30:20', NULL),
(2976, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 20:30:22', NULL),
(2977, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 20:30:28', NULL),
(2978, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 20:32:19', NULL),
(2979, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 20:33:29', NULL),
(2980, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 20:34:35', NULL),
(2981, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 20:35:46', NULL),
(2982, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 20:36:13', NULL),
(2983, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 20:39:03', NULL),
(2984, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 20:39:05', NULL),
(2985, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Event Status Update', 'Case Management', 'Updated event #24 status to: Completed', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-10 20:39:13', NULL),
(2986, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Event Status Update', 'Case Management', 'Updated event #25 status to: Completed', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-10 20:39:39', NULL),
(2987, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 20:41:21', NULL),
(2988, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Walk-in Schedule Created', 'Schedule Management', 'Created by: Opiña, Leif Laiglon Abriz; Attorney: Refrea, Laica Castillo; Walk-in Client: dawdw, dadwa dwadaw (Contact: 12312312312); Title: adawdwa; Type: Appointment; Date: 2025-10-12; Time: 04:41-05:41; Location: dawdaw', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-10 20:41:21', NULL),
(2989, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 20:41:22', NULL),
(2990, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 20:41:35', NULL),
(2991, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 20:41:42', NULL),
(2992, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Schedule Created', 'Schedule Management', 'Created by: Opiña, Leif Laiglon Abriz; Attorney: Opiña, Leif Laiglon Abriz; Client: dadw, dadaw ddadw; Title: dawdawd; Type: Appointment; Date: 2025-10-15; Time: 05:41-06:41; Location: dawdwa', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-10 20:41:42', NULL),
(2993, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 20:41:43', NULL),
(2994, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 20:44:35', NULL),
(2995, 30, 'dawdaw, dadadad dadaw', 'employee', 'Event Status Update', 'Case Management', 'Updated event #28 status to: Completed', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-10 20:56:06', NULL),
(2996, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 20:56:14', NULL),
(2997, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 20:57:56', NULL),
(2998, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 20:57:56', NULL),
(2999, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Event Status Update', 'Case Management', 'Updated event #26 status to: Completed', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-10 20:58:00', NULL),
(3000, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 21:01:46', NULL),
(3001, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 21:01:47', NULL),
(3002, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 21:01:48', NULL),
(3003, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 21:01:56', NULL),
(3004, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 21:03:06', NULL),
(3005, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 21:03:13', NULL),
(3006, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 21:03:14', NULL),
(3007, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-10 21:03:15', NULL),
(3008, 30, 'dawdaw, dadadad dadaw', 'employee', 'User Login', 'Authentication', 'User logged in successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 03:55:58', NULL),
(3009, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'User Login', 'Authentication', 'User logged in successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 03:56:11', NULL),
(3010, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_usermanagement', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 03:56:21', NULL),
(3011, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 03:56:27', NULL),
(3012, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 03:57:06', NULL),
(3013, 30, 'dawdaw, dadadad dadaw', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 03:59:01', NULL),
(3014, 30, 'dawdaw, dadadad dadaw', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_clients', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 03:59:03', NULL),
(3015, 30, 'dawdaw, dadadad dadaw', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_request_management', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 03:59:07', NULL),
(3016, 30, 'dawdaw, dadadad dadaw', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 03:59:07', NULL),
(3017, 30, 'dawdaw, dadadad dadaw', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_audit', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 03:59:08', NULL),
(3018, 30, 'dawdaw, dadadad dadaw', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_clients', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 03:59:09', NULL),
(3019, 30, 'dawdaw, dadadad dadaw', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_clients', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 03:59:56', NULL),
(3020, 30, 'dawdaw, dadadad dadaw', 'employee', 'User Login', 'Authentication', 'User logged in successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 04:02:03', NULL),
(3021, 30, 'dawdaw, dadadad dadaw', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 04:02:04', NULL),
(3022, 30, 'dawdaw, dadadad dadaw', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_request_management', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 04:02:05', NULL),
(3023, 30, 'dawdaw, dadadad dadaw', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 04:02:06', NULL),
(3024, 30, 'dawdaw, dadadad dadaw', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 04:02:07', NULL),
(3025, 30, 'dawdaw, dadadad dadaw', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 04:02:07', NULL),
(3026, 30, 'dawdaw, dadadad dadaw', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 04:02:07', NULL),
(3027, 30, 'dawdaw, dadadad dadaw', 'employee', 'User Logout', 'Authentication', 'User logged out successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 04:02:10', NULL),
(3028, 27, 'Refrea, Laica Castillo', 'attorney', 'User Login', 'Authentication', 'User logged in successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 04:02:23', NULL),
(3029, 27, 'Refrea, Laica Castillo', 'attorney', 'Page Access', 'Page Access', 'Accessed page: attorney_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 04:02:25', NULL),
(3030, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 04:08:36', NULL),
(3031, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 04:09:07', NULL),
(3032, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 04:09:24', NULL),
(3033, 30, 'dawdaw, dadadad dadaw', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_request_management', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 04:24:47', NULL),
(3034, 30, 'dawdaw, dadadad dadaw', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_clients', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 04:24:48', NULL),
(3035, 30, 'dawdaw, dadadad dadaw', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_clients', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 04:24:50', NULL),
(3036, 30, 'dawdaw, dadadad dadaw', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 04:24:53', NULL),
(3037, 30, 'dawdaw, dadadad dadaw', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_clients', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 04:25:00', NULL),
(3038, 30, 'dawdaw, dadadad dadaw', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_clients', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 04:25:09', NULL),
(3039, 30, 'dawdaw, dadadad dadaw', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_request_management', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 04:25:11', NULL),
(3040, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 04:25:30', NULL),
(3041, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 04:26:09', NULL),
(3042, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 04:26:50', NULL),
(3043, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 04:27:44', NULL),
(3044, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Event Status Update', 'Case Management', 'Updated event #29 status to: Cancelled', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-11 04:29:54', NULL),
(3045, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 04:29:55', NULL),
(3046, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 04:32:09', NULL),
(3047, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 04:34:02', NULL),
(3048, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 04:34:15', NULL),
(3049, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 04:35:14', NULL),
(3050, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 04:36:17', NULL),
(3051, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 04:36:24', NULL),
(3052, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 04:36:38', NULL),
(3053, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 04:37:51', NULL),
(3054, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 04:41:46', NULL),
(3055, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 04:43:43', NULL),
(3056, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 04:44:34', NULL),
(3057, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 04:45:24', NULL),
(3058, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 04:45:48', NULL),
(3059, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 04:53:14', NULL),
(3060, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 04:55:07', NULL),
(3061, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 04:55:18', NULL),
(3062, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 04:57:16', NULL),
(3063, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 04:57:32', NULL),
(3064, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 04:57:44', NULL),
(3065, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 04:58:50', NULL),
(3066, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 05:05:58', NULL),
(3067, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 05:10:39', NULL),
(3068, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 05:11:00', NULL),
(3069, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 05:13:01', NULL),
(3070, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 05:13:06', NULL),
(3071, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 05:13:08', NULL),
(3072, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 05:13:08', NULL),
(3073, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 05:13:08', NULL),
(3074, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 05:13:08', NULL),
(3075, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 05:13:10', NULL),
(3076, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 05:13:10', NULL),
(3077, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 05:13:10', NULL),
(3078, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 05:13:10', NULL),
(3079, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 05:13:11', NULL),
(3080, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 05:13:12', NULL),
(3081, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 05:13:12', NULL),
(3082, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 05:13:12', NULL),
(3083, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 05:13:12', NULL),
(3084, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 05:13:13', NULL),
(3085, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 05:13:13', NULL),
(3086, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 05:13:13', NULL),
(3087, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 05:13:13', NULL),
(3088, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 05:13:14', NULL),
(3089, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 05:13:14', NULL),
(3090, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 05:13:14', NULL),
(3091, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 05:13:14', NULL),
(3092, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 05:14:09', NULL),
(3093, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 05:14:10', NULL);
INSERT INTO `audit_trail` (`id`, `user_id`, `user_name`, `user_type`, `action`, `module`, `description`, `ip_address`, `user_agent`, `status`, `priority`, `timestamp`, `additional_data`) VALUES
(3094, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 05:14:10', NULL),
(3095, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 05:14:10', NULL),
(3096, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 05:14:11', NULL),
(3097, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 05:14:11', NULL),
(3098, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 05:14:11', NULL),
(3099, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 05:14:11', NULL),
(3100, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 05:14:11', NULL),
(3101, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 05:14:12', NULL),
(3102, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 05:14:12', NULL),
(3103, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 05:14:12', NULL),
(3104, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 05:14:12', NULL),
(3105, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 05:14:21', NULL),
(3106, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 05:14:21', NULL),
(3107, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 05:14:21', NULL),
(3108, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 05:14:21', NULL),
(3109, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 05:14:21', NULL),
(3110, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 05:14:22', NULL),
(3111, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 05:14:22', NULL),
(3112, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 05:14:22', NULL),
(3113, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 05:14:22', NULL),
(3114, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 05:14:22', NULL),
(3115, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 05:14:22', NULL),
(3116, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 05:14:22', NULL),
(3117, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 05:14:23', NULL),
(3118, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 05:14:23', NULL),
(3119, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 05:14:23', NULL),
(3120, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 05:14:23', NULL),
(3121, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 05:14:23', NULL),
(3122, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 05:16:02', NULL),
(3123, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 05:16:04', NULL),
(3124, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 05:16:10', NULL),
(3125, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_usermanagement', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 05:16:29', NULL),
(3126, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_managecases', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 05:16:30', NULL),
(3127, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_clients', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 05:16:31', NULL),
(3128, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 05:16:32', NULL),
(3129, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_audit', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 05:16:33', NULL),
(3130, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 05:16:35', NULL),
(3131, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 05:16:36', NULL),
(3132, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 05:16:37', NULL),
(3133, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 05:17:10', NULL),
(3134, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 05:17:10', NULL),
(3135, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_usermanagement', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 05:17:13', NULL),
(3136, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 05:19:31', NULL),
(3137, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Event Status Update', 'Case Management', 'Updated event #23 status to: Cancelled', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-11 05:19:48', NULL),
(3138, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 05:19:50', NULL),
(3139, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 05:28:37', NULL),
(3140, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 05:28:45', NULL),
(3141, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 05:37:02', NULL),
(3142, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 05:37:09', NULL),
(3143, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Event Status Update', 'Case Management', 'Updated event #29 status to: Completed', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-11 05:37:16', NULL),
(3144, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 05:37:21', NULL),
(3145, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 05:37:23', NULL),
(3146, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 05:40:40', NULL),
(3147, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Event Status Update', 'Case Management', 'Updated event #23 status to: Completed', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-11 05:40:46', NULL),
(3148, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 05:40:50', NULL),
(3149, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 05:40:54', NULL),
(3150, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 05:44:42', NULL),
(3151, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 05:44:44', NULL),
(3152, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Event Status Update', 'Case Management', 'Updated event #22 status to: Scheduled', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-11 05:45:02', NULL),
(3153, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 05:45:03', NULL),
(3154, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Event Status Update', 'Case Management', 'Updated event #22 status to: Completed', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-11 05:45:12', NULL),
(3155, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 05:46:11', NULL),
(3156, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 05:46:20', NULL),
(3157, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Schedule Created', 'Schedule Management', 'Created by: Opiña, Leif Laiglon Abriz; Attorney: Opiña, Leif Laiglon Abriz; Client: dadawd, dawdaw dadw; Title: dawdwad; Type: Free Legal Advice; Date: 2025-10-11; Time: 15:45-17:46; Location: dawdawdaw', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-11 05:46:20', NULL),
(3158, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 05:46:22', NULL),
(3159, 30, 'dawdaw, dadadad dadaw', 'employee', 'Event Status Update', 'Case Management', 'Updated event #22 status to: Cancelled', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-11 05:57:32', NULL),
(3160, 30, 'dawdaw, dadadad dadaw', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_clients', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 05:59:45', NULL),
(3161, 30, 'dawdaw, dadadad dadaw', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_request_management', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 05:59:46', NULL),
(3162, 30, 'dawdaw, dadadad dadaw', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 05:59:47', NULL),
(3163, 30, 'dawdaw, dadadad dadaw', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_audit', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 05:59:48', NULL),
(3164, 30, 'dawdaw, dadadad dadaw', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_clients', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 05:59:50', NULL),
(3165, 30, 'dawdaw, dadadad dadaw', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 05:59:53', NULL),
(3166, 30, 'dawdaw, dadadad dadaw', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 05:59:59', NULL),
(3167, 30, 'dawdaw, dadadad dadaw', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_clients', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 06:00:02', NULL),
(3168, 30, 'dawdaw, dadadad dadaw', 'employee', 'Event Status Update', 'Case Management', 'Updated event #22 status to: Completed', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-11 06:29:36', NULL),
(3169, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 06:30:12', NULL),
(3170, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Event Status Update', 'Case Management', 'Updated event #30 status to: Completed', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-11 06:30:20', NULL),
(3171, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 06:34:02', NULL),
(3172, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 06:34:31', NULL),
(3173, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Event Status Update', 'Case Management', 'Updated event #28 status to: Rescheduled', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-11 06:34:38', NULL),
(3174, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 06:34:39', NULL),
(3175, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 06:38:42', NULL),
(3176, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 06:39:07', NULL),
(3177, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 06:42:38', NULL),
(3178, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 06:43:30', NULL),
(3179, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 07:15:40', NULL),
(3180, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 07:15:44', NULL),
(3181, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 07:43:19', NULL),
(3182, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 07:43:32', NULL),
(3183, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 07:43:36', NULL),
(3184, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Schedule Created', 'Schedule Management', 'Created by: Opiña, Leif Laiglon Abriz; Attorney: Opiña, Leif Laiglon Abriz; Client: dadawd, dawdaw dadw; Title: dawdawdwa; Type: Free Legal Advice; Date: 2025-10-12; Time: 16:43-17:43; Location: dwadwada', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-11 07:43:36', NULL),
(3185, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 07:43:38', NULL),
(3186, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 07:43:57', NULL),
(3187, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Walk-in Schedule Created', 'Schedule Management', 'Created by: Opiña, Leif Laiglon Abriz; Attorney: adwdaw, dadw dwawd; Walk-in Client: dawdaw, dadaw dwadaw (Contact: 12312312312); Title: dawdawdwa; Type: Appointment; Date: 2025-10-12; Time: 15:43-16:43; Location: dadwa', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-11 07:43:57', NULL),
(3188, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 07:43:58', NULL),
(3189, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 07:44:13', NULL),
(3190, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 07:44:16', NULL),
(3191, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Schedule Created', 'Schedule Management', 'Created by: Opiña, Leif Laiglon Abriz; Attorney: Opiña, Leif Laiglon Abriz; Client: dawd, dawdaw wdawd; Title: dawdaw; Type: Hearing; Date: 2025-10-15; Time: 17:44-19:44; Location: dawdaw', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-11 07:44:16', NULL),
(3192, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 07:44:18', NULL),
(3193, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 07:45:01', NULL),
(3194, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Walk-in Schedule Created', 'Schedule Management', 'Created by: Opiña, Leif Laiglon Abriz; Attorney: Refrea, Laica Castillo; Walk-in Client: dawdww, dadawda dawdaw (Contact: 12312312312); Title: dawdawdaw; Type: Free Legal Advice; Date: 2025-10-12; Time: 15:44-16:44; Location: dawdawd', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-11 07:45:01', NULL),
(3195, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 07:45:02', NULL),
(3196, 27, 'Refrea, Laica Castillo', 'attorney', 'Event Status Update', 'Case Management', 'Updated event #34 status to: Completed', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-11 07:45:35', NULL),
(3197, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 07:45:45', NULL),
(3198, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 07:46:03', NULL),
(3199, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 07:46:08', NULL),
(3200, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 07:46:52', NULL),
(3201, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Walk-in Schedule Created', 'Schedule Management', 'Created by: Opiña, Leif Laiglon Abriz; Attorney: Refrea, Laica Castillo; Walk-in Client: dawdaw, dadaw dawdaw (Contact: 12312312312); Title: dawdwa; Type: Appointment; Date: 2025-10-13; Time: 15:46-16:46; Location: dawdaw', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-11 07:46:52', NULL),
(3202, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 07:46:53', NULL),
(3203, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Event Status Update', 'Case Management', 'Updated event #35 status to: Completed', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-11 07:46:58', NULL),
(3204, 30, 'dawdaw, dadadad dadaw', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_clients', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 07:48:43', NULL),
(3205, 30, 'dawdaw, dadadad dadaw', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_request_management', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 07:48:43', NULL),
(3206, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 08:00:05', NULL),
(3207, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'User Login', 'Authentication', 'User logged in successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 13:16:37', NULL),
(3208, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 13:17:02', NULL),
(3209, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 13:17:04', NULL),
(3210, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 13:17:06', NULL),
(3211, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_usermanagement', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 13:17:10', NULL),
(3212, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_managecases', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 13:17:15', NULL),
(3213, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_managecases', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 14:03:12', NULL),
(3214, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'User Logout', 'Authentication', 'User logged out successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 14:03:28', NULL),
(3215, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'User Login', 'Authentication', 'User logged in successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 14:07:38', NULL),
(3216, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'User Logout', 'Authentication', 'User logged out successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 14:07:45', NULL),
(3217, 33, 'Miranda, Client to', 'client', 'User Login', 'Authentication', 'User logged in successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 14:10:26', NULL),
(3218, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 14:12:56', NULL),
(3219, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_cases', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 14:12:59', NULL),
(3220, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 14:13:02', NULL),
(3221, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 14:14:21', NULL),
(3222, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 14:15:51', NULL),
(3223, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 14:15:55', NULL),
(3224, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 14:16:01', NULL),
(3225, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 14:16:03', NULL),
(3226, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 14:16:06', NULL),
(3227, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_about', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 14:17:20', NULL),
(3228, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 14:17:23', NULL),
(3229, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_cases', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 14:17:25', NULL),
(3230, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 14:17:27', NULL),
(3231, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_about', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 14:17:28', NULL),
(3232, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 14:17:32', NULL),
(3233, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 14:18:51', NULL),
(3234, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_about', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 14:19:21', NULL),
(3235, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 14:19:23', NULL),
(3236, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_cases', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 14:19:25', NULL),
(3237, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 14:19:26', NULL),
(3238, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 14:19:41', NULL),
(3239, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_cases', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 14:19:44', NULL),
(3240, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 14:19:46', NULL),
(3241, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_about', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 14:19:48', NULL),
(3242, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_cases', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 14:19:51', NULL),
(3243, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 14:19:54', NULL),
(3244, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 14:20:52', NULL),
(3245, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_about', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 14:20:54', NULL),
(3246, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 14:20:56', NULL),
(3247, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_cases', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 14:20:58', NULL),
(3248, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 14:21:01', NULL),
(3249, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 14:21:41', NULL),
(3250, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 14:21:45', NULL),
(3251, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 14:21:48', NULL),
(3252, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_about', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 14:21:50', NULL),
(3253, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 14:21:51', NULL),
(3254, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 14:21:53', NULL),
(3255, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_about', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 14:21:55', NULL),
(3256, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_about', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 14:22:01', NULL),
(3257, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 14:22:04', NULL),
(3258, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_cases', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 14:22:06', NULL),
(3259, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 14:22:08', NULL),
(3260, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_about', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 14:22:10', NULL),
(3261, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_about', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 14:22:59', NULL),
(3262, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 14:23:02', NULL),
(3263, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_cases', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 14:23:03', NULL),
(3264, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 14:23:05', NULL),
(3265, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_about', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 14:23:06', NULL),
(3266, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_about', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 14:24:14', NULL);
INSERT INTO `audit_trail` (`id`, `user_id`, `user_name`, `user_type`, `action`, `module`, `description`, `ip_address`, `user_agent`, `status`, `priority`, `timestamp`, `additional_data`) VALUES
(3267, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_about', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 14:25:29', NULL),
(3268, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_about', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 14:26:52', NULL),
(3269, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 14:27:07', NULL),
(3270, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_request_access', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 14:27:45', NULL),
(3271, 33, 'Miranda, Client to', 'client', 'Request Form Submission', 'Communication', 'Submitted messaging request form with ID: REQ-20251011-0033-8073', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-11 14:27:45', NULL),
(3272, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_request_access', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 14:27:45', NULL),
(3273, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 14:27:48', NULL),
(3274, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 14:27:51', NULL),
(3275, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_about', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 14:27:55', NULL),
(3276, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 14:27:56', NULL),
(3277, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_cases', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 14:27:59', NULL),
(3278, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 14:28:00', NULL),
(3279, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_cases', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 14:28:01', NULL),
(3280, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_cases', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 14:30:22', NULL),
(3281, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 14:30:26', NULL),
(3282, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_about', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 14:30:27', NULL),
(3283, 33, 'Miranda, Client to', 'client', 'User Logout', 'Authentication', 'User logged out successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 14:30:44', NULL),
(3284, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'User Login', 'Authentication', 'User logged in successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 14:32:10', NULL),
(3285, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 14:32:14', NULL),
(3286, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 14:32:48', NULL),
(3287, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_usermanagement', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 14:34:49', NULL),
(3288, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: add_user', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 14:35:42', NULL),
(3289, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'User Create', 'User Management', 'Created new employee account: employee, to bro (nelmiranda145@gmail.com) - Email sent successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-11 14:35:47', NULL),
(3290, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_usermanagement', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 14:35:47', NULL),
(3291, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_usermanagement', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 14:35:48', NULL),
(3292, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'User Logout', 'Authentication', 'User logged out successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 14:35:55', NULL),
(3293, 34, 'employee, to bro', 'employee', 'User Login', 'Authentication', 'User logged in successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 14:37:25', NULL),
(3294, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 14:37:38', NULL),
(3295, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 14:40:47', NULL),
(3296, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 14:40:57', NULL),
(3297, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 14:41:41', NULL),
(3298, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 14:42:02', NULL),
(3299, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 14:43:14', NULL),
(3300, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 14:43:47', NULL),
(3301, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 14:43:48', NULL),
(3302, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 14:43:51', NULL),
(3303, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 14:43:52', NULL),
(3304, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 14:43:54', NULL),
(3305, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 14:44:49', NULL),
(3306, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 14:45:23', NULL),
(3307, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_clients', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 14:45:24', NULL),
(3308, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 14:49:41', NULL),
(3309, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 14:49:49', NULL),
(3310, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 14:52:10', NULL),
(3311, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 14:57:20', NULL),
(3312, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_handler', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 14:57:40', NULL),
(3313, 34, 'employee, to bro', 'employee', 'Document Generated', 'Document Generation', 'Generated swornAffidavitMother document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-11 14:57:40', NULL),
(3314, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_handler', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 14:58:10', NULL),
(3315, 34, 'employee, to bro', 'employee', 'Document Generated', 'Document Generation', 'Generated pwdLoss document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-11 14:58:11', NULL),
(3316, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_handler', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 14:58:51', NULL),
(3317, 34, 'employee, to bro', 'employee', 'Document Generated', 'Document Generation', 'Generated boticabLoss document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-11 14:58:51', NULL),
(3318, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_handler', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 14:59:34', NULL),
(3319, 34, 'employee, to bro', 'employee', 'Document Generated', 'Document Generation', 'Generated soloParent document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-11 14:59:34', NULL),
(3320, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 14:59:49', NULL),
(3321, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_handler', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 15:00:10', NULL),
(3322, 34, 'employee, to bro', 'employee', 'Document Generated', 'Document Generation', 'Generated swornAffidavitMother document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-11 15:00:10', NULL),
(3323, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 15:06:05', NULL),
(3324, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 15:06:09', NULL),
(3325, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_handler', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 15:06:18', NULL),
(3326, 34, 'employee, to bro', 'employee', 'Document Generated', 'Document Generation', 'Generated affidavitLoss document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-11 15:06:19', NULL),
(3327, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_handler', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 15:06:44', NULL),
(3328, 34, 'employee, to bro', 'employee', 'Document Generated', 'Document Generation', 'Generated soloParent document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-11 15:06:44', NULL),
(3329, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_handler', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 15:07:57', NULL),
(3330, 34, 'employee, to bro', 'employee', 'Document Generated', 'Document Generation', 'Generated swornAffidavitMother document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-11 15:07:58', NULL),
(3331, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 15:11:34', NULL),
(3332, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 15:11:37', NULL),
(3333, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_handler', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 15:11:55', NULL),
(3334, 34, 'employee, to bro', 'employee', 'Document Generated', 'Document Generation', 'Generated soloParent document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-11 15:11:55', NULL),
(3335, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 15:12:05', NULL),
(3336, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 15:13:50', NULL),
(3337, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 15:14:15', NULL),
(3338, 34, 'employee, to bro', 'employee', 'User Logout', 'Authentication', 'User logged out successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 15:14:40', NULL),
(3339, 33, 'Miranda, Client to', 'client', 'User Login', 'Authentication', 'User logged in successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 15:14:49', NULL),
(3340, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 15:14:50', NULL),
(3341, 33, 'Miranda, Client to', 'client', 'User Logout', 'Authentication', 'User logged out successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 15:14:53', NULL),
(3342, 34, 'employee, to bro', 'employee', 'User Login', 'Authentication', 'User logged in successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 15:15:00', NULL),
(3343, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_request_management', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 15:15:01', NULL),
(3344, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_request_management', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 15:15:07', NULL),
(3345, 34, 'employee, to bro', 'employee', 'Request Review', 'Communication', 'Request ID: 15 - Action: Approved with attorney assignment', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-11 15:15:08', NULL),
(3346, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_request_management', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 15:15:08', NULL),
(3347, 34, 'employee, to bro', 'employee', 'User Logout', 'Authentication', 'User logged out successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 15:15:11', NULL),
(3348, 33, 'Miranda, Client to', 'client', 'User Login', 'Authentication', 'User logged in successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 15:15:18', NULL),
(3349, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 15:15:21', NULL),
(3350, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_cases', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 15:15:23', NULL),
(3351, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 15:15:25', NULL),
(3352, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 15:15:29', NULL),
(3353, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 15:15:31', NULL),
(3354, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_cases', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 15:15:34', NULL),
(3355, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 15:15:36', NULL),
(3356, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_cases', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 15:15:37', NULL),
(3357, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 15:15:38', NULL),
(3358, 34, 'employee, to bro', 'employee', 'Failed Login Attempt', 'Security', 'Failed login attempt from IP: ::1 for email: nelmiranda145@gmail.com (Attempt 1/5)', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'warning', 'medium', '2025-10-11 15:16:39', NULL),
(3359, 0, 'System', '', 'Failed Login Attempt', 'Security', 'Failed login attempt for email: nelmiranda145@gmail.com (Attempt 1/4)', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'warning', 'medium', '2025-10-11 15:16:39', NULL),
(3360, 33, 'Miranda, Client to', 'client', 'User Login', 'Authentication', 'User logged in successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 15:17:04', NULL),
(3361, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_cases', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 15:17:31', NULL),
(3362, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_cases', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 15:17:35', NULL),
(3363, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 15:17:36', NULL),
(3364, 33, 'Miranda, Client to', 'client', 'User Logout', 'Authentication', 'User logged out successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 15:17:41', NULL),
(3365, 34, 'employee, to bro', 'employee', 'User Login', 'Authentication', 'User logged in successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 15:17:49', NULL),
(3366, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 15:17:52', NULL),
(3367, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 15:19:40', NULL),
(3368, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_cases', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 15:21:24', NULL),
(3369, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 15:21:26', NULL),
(3370, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 15:24:34', NULL),
(3371, 33, 'Miranda, Client to', 'client', 'Document Submission', 'Document Generation', 'Submitted affidavitLoss document with request ID: DOC_20251011173037_0033_8880', 'Unknown', '', 'success', 'medium', '2025-10-11 15:30:37', NULL),
(3372, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 15:31:58', NULL),
(3373, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 15:32:15', NULL),
(3374, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 15:32:18', NULL),
(3375, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 15:32:25', NULL),
(3376, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 15:32:52', NULL),
(3377, 34, 'employee, to bro', 'employee', 'Document Rejection', 'Document Management', 'Rejected document with request ID: DOC_20251011173037_0033_8880 (Type: affidavitLoss) for client: Miranda, Client to. Reason: asd', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'warning', 'medium', '2025-10-11 15:32:52', NULL),
(3378, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 15:32:55', NULL),
(3379, 34, 'employee, to bro', 'employee', 'Document Rejection', 'Document Management', 'Rejected document with request ID: DOC_20250101120000_0033_1234 (Type: affidavitLoss) for client: Miranda, Client to. Reason: asd', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'warning', 'medium', '2025-10-11 15:32:56', NULL),
(3380, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 15:32:56', NULL),
(3381, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 15:33:00', NULL),
(3382, 34, 'employee, to bro', 'employee', 'Document Rejection', 'Document Management', 'Rejected document with request ID: DOC_20250101120002_0033_1236 (Type: pwdLoss) for client: Miranda, Client to. Reason: asd', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'warning', 'medium', '2025-10-11 15:33:00', NULL),
(3383, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 15:33:03', NULL),
(3384, 34, 'employee, to bro', 'employee', 'Document Rejection', 'Document Management', 'Rejected document with request ID: DOC_20250101120000_0001_1234 (Type: affidavitLoss) for client: Opiña, Leif Laiglon Abriz. Reason: asd', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'warning', 'medium', '2025-10-11 15:33:03', NULL),
(3385, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 15:33:03', NULL),
(3386, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 15:33:08', NULL),
(3387, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 15:33:08', NULL),
(3388, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 15:33:22', NULL),
(3389, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 15:33:39', NULL),
(3390, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 15:33:40', NULL),
(3391, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 15:33:40', NULL),
(3392, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 15:35:07', NULL),
(3393, 33, 'Miranda, Client to', 'client', 'Document Submission', 'Document Generation', 'Submitted affidavitLoss document with request ID: DOC_20251011173517_0033_3179', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-11 15:35:18', NULL),
(3394, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 15:35:22', NULL),
(3395, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 15:35:25', NULL),
(3396, 33, 'Miranda, Client to', 'client', 'Document Submission', 'Document Generation', 'Submitted soloParent document with request ID: DOC_20251011173558_0033_3634', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-11 15:35:58', NULL),
(3397, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 15:36:01', NULL),
(3398, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 15:36:04', NULL),
(3399, 33, 'Miranda, Client to', 'client', 'Document Submission', 'Document Generation', 'Submitted seniorIDLoss document with request ID: DOC_20251011173625_0033_6493', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-11 15:36:25', NULL),
(3400, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 15:36:32', NULL),
(3401, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 15:36:34', NULL),
(3402, 33, 'Miranda, Client to', 'client', 'Document Submission', 'Document Generation', 'Submitted swornAffidavitMother document with request ID: DOC_20251011173710_0033_8865', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-11 15:37:10', NULL),
(3403, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 15:37:14', NULL),
(3404, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 15:37:21', NULL),
(3405, 33, 'Miranda, Client to', 'client', 'Document Submission', 'Document Generation', 'Submitted pwdLoss document with request ID: DOC_20251011173744_0033_1722', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-11 15:37:44', NULL),
(3406, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 15:37:49', NULL),
(3407, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 15:37:51', NULL),
(3408, 33, 'Miranda, Client to', 'client', 'Document Submission', 'Document Generation', 'Submitted boticabLoss document with request ID: DOC_20251011173827_0033_4842', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-11 15:38:28', NULL),
(3409, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 15:38:32', NULL),
(3410, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 15:38:34', NULL),
(3411, 33, 'Miranda, Client to', 'client', 'Document Submission', 'Document Generation', 'Submitted jointAffidavit document with request ID: DOC_20251011173906_0033_5163', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-11 15:39:07', NULL),
(3412, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 15:39:10', NULL),
(3413, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 15:39:13', NULL),
(3414, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 15:46:14', NULL),
(3415, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 15:46:22', NULL),
(3416, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_handler', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 15:46:32', NULL),
(3417, 34, 'employee, to bro', 'employee', 'Document Generated', 'Document Generation', 'Generated affidavitLoss document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-11 15:46:33', NULL),
(3418, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_handler', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 15:46:55', NULL),
(3419, 34, 'employee, to bro', 'employee', 'Document Generated', 'Document Generation', 'Generated soloParent document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-11 15:46:55', NULL),
(3420, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 15:50:46', NULL),
(3421, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 15:50:48', NULL),
(3422, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_handler', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 15:51:04', NULL),
(3423, 34, 'employee, to bro', 'employee', 'Document Generated', 'Document Generation', 'Generated soloParent document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-11 15:51:04', NULL),
(3424, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 15:51:29', NULL),
(3425, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 15:51:30', NULL),
(3426, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 15:51:31', NULL),
(3427, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 15:51:31', NULL),
(3428, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_handler', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 15:51:44', NULL),
(3429, 34, 'employee, to bro', 'employee', 'Document Generated', 'Document Generation', 'Generated soloParent document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-11 15:51:45', NULL),
(3430, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 16:00:26', NULL),
(3431, 33, 'Miranda, Client to', 'client', 'Document Submission', 'Document Generation', 'Submitted soloParent document with request ID: DOC_20251011180043_0033_3256', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-11 16:00:44', NULL),
(3432, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 16:00:53', NULL),
(3433, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_handler', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 16:01:08', NULL),
(3434, 34, 'employee, to bro', 'employee', 'Document Generated', 'Document Generation', 'Generated soloParent document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-11 16:01:09', NULL),
(3435, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 16:01:48', NULL),
(3436, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 16:01:55', NULL),
(3437, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 16:02:02', NULL),
(3438, 34, 'employee, to bro', 'employee', 'Document Rejection', 'Document Management', 'Rejected document with request ID: DOC_20251011180043_0033_3256 (Type: soloParent) for client: Miranda, Client to. Reason: ads', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'warning', 'medium', '2025-10-11 16:02:02', NULL);
INSERT INTO `audit_trail` (`id`, `user_id`, `user_name`, `user_type`, `action`, `module`, `description`, `ip_address`, `user_agent`, `status`, `priority`, `timestamp`, `additional_data`) VALUES
(3439, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 16:02:03', NULL),
(3440, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 16:02:06', NULL),
(3441, 33, 'Miranda, Client to', 'client', 'Document Submission', 'Document Generation', 'Submitted soloParent document with request ID: DOC_20251011180225_0033_2582', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-11 16:02:25', NULL),
(3442, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 16:02:31', NULL),
(3443, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 16:02:33', NULL),
(3444, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 16:04:06', NULL),
(3445, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 16:04:57', NULL),
(3446, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 16:05:06', NULL),
(3447, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 16:05:31', NULL),
(3448, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 16:05:41', NULL),
(3449, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 16:05:43', NULL),
(3450, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 16:05:45', NULL),
(3451, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 16:07:10', NULL),
(3452, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 16:07:49', NULL),
(3453, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_handler', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 16:08:04', NULL),
(3454, 34, 'employee, to bro', 'employee', 'Document Generated', 'Document Generation', 'Generated affidavitLoss document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-11 16:08:04', NULL),
(3455, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_handler', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 16:08:22', NULL),
(3456, 34, 'employee, to bro', 'employee', 'Document Generated', 'Document Generation', 'Generated soloParent document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-11 16:08:23', NULL),
(3457, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 16:08:41', NULL),
(3458, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 16:10:47', NULL),
(3459, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 16:10:54', NULL),
(3460, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 16:16:37', NULL),
(3461, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 16:16:38', NULL),
(3462, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 16:16:38', NULL),
(3463, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_handler', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 16:16:51', NULL),
(3464, 34, 'employee, to bro', 'employee', 'Document Generated', 'Document Generation', 'Generated soloParent document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-11 16:16:51', NULL),
(3465, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_handler', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 16:18:08', NULL),
(3466, 34, 'employee, to bro', 'employee', 'Document Generated', 'Document Generation', 'Generated soloParent document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-11 16:18:08', NULL),
(3467, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 16:18:20', NULL),
(3468, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 16:18:24', NULL),
(3469, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 16:21:49', NULL),
(3470, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 16:21:53', NULL),
(3471, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 16:21:57', NULL),
(3472, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_handler', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 16:22:16', NULL),
(3473, 34, 'employee, to bro', 'employee', 'Document Generated', 'Document Generation', 'Generated soloParent document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-11 16:22:17', NULL),
(3474, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 16:22:40', NULL),
(3475, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 16:22:44', NULL),
(3476, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 16:23:48', NULL),
(3477, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 16:23:51', NULL),
(3478, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 16:24:12', NULL),
(3479, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 16:24:16', NULL),
(3480, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 16:24:30', NULL),
(3481, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_handler', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 16:24:55', NULL),
(3482, 34, 'employee, to bro', 'employee', 'Document Generated', 'Document Generation', 'Generated jointAffidavit document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-11 16:24:55', NULL),
(3483, 34, 'employee, to bro', 'employee', 'User Login', 'Authentication', 'User logged in successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 16:27:24', NULL),
(3484, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 16:27:29', NULL),
(3485, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_clients', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 16:27:30', NULL),
(3486, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 16:27:33', NULL),
(3487, 34, 'employee, to bro', 'employee', 'User Logout', 'Authentication', 'User logged out successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'success', 'low', '2025-10-11 16:27:43', NULL),
(3488, 34, 'employee, to bro', 'employee', 'User Login', 'Authentication', 'User logged in successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 03:38:03', NULL),
(3489, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 03:38:12', NULL),
(3490, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_handler', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 03:38:24', NULL),
(3491, 34, 'employee, to bro', 'employee', 'Document Generated', 'Document Generation', 'Generated affidavitLoss document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-12 03:38:25', NULL),
(3492, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 03:42:57', NULL),
(3493, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_handler', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 03:43:07', NULL),
(3494, 34, 'employee, to bro', 'employee', 'Document Generated', 'Document Generation', 'Generated affidavitLoss document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-12 03:43:07', NULL),
(3495, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_handler', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 03:43:28', NULL),
(3496, 34, 'employee, to bro', 'employee', 'Document Generated', 'Document Generation', 'Generated seniorIDLoss document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-12 03:43:29', NULL),
(3497, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_handler', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 03:43:52', NULL),
(3498, 34, 'employee, to bro', 'employee', 'Document Generated', 'Document Generation', 'Generated soloParent document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-12 03:43:52', NULL),
(3499, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_handler', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 03:44:19', NULL),
(3500, 34, 'employee, to bro', 'employee', 'Document Generated', 'Document Generation', 'Generated swornAffidavitMother document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-12 03:44:20', NULL),
(3501, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 03:44:33', NULL),
(3502, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 03:44:34', NULL),
(3503, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 03:44:34', NULL),
(3504, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 03:44:34', NULL),
(3505, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 03:44:34', NULL),
(3506, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_handler', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 03:44:41', NULL),
(3507, 34, 'employee, to bro', 'employee', 'Document Generated', 'Document Generation', 'Generated pwdLoss document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-12 03:44:41', NULL),
(3508, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_handler', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 03:45:04', NULL),
(3509, 34, 'employee, to bro', 'employee', 'Document Generated', 'Document Generation', 'Generated boticabLoss document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-12 03:45:04', NULL),
(3510, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_handler', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 03:45:33', NULL),
(3511, 34, 'employee, to bro', 'employee', 'Document Generated', 'Document Generation', 'Generated jointAffidavit document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-12 03:45:33', NULL),
(3512, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 03:48:10', NULL),
(3513, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 03:48:10', NULL),
(3514, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 03:48:10', NULL),
(3515, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 03:48:10', NULL),
(3516, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 03:48:10', NULL),
(3517, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 03:48:10', NULL),
(3518, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 03:48:11', NULL),
(3519, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 03:48:11', NULL),
(3520, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 03:48:11', NULL),
(3521, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 03:48:11', NULL),
(3522, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_handler', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 03:48:23', NULL),
(3523, 34, 'employee, to bro', 'employee', 'Document Generated', 'Document Generation', 'Generated soloParent document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-12 03:48:24', NULL),
(3524, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 03:49:06', NULL),
(3525, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 03:49:10', NULL),
(3526, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 03:49:30', NULL),
(3527, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 03:52:31', NULL),
(3528, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 03:52:33', NULL),
(3529, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 03:52:53', NULL),
(3530, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 03:52:53', NULL),
(3531, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_handler', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 03:53:06', NULL),
(3532, 34, 'employee, to bro', 'employee', 'Document Generated', 'Document Generation', 'Generated soloParent document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-12 03:53:06', NULL),
(3533, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 03:55:04', NULL),
(3534, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 03:55:04', NULL),
(3535, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 03:55:04', NULL),
(3536, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 03:55:04', NULL),
(3537, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_handler', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 03:55:16', NULL),
(3538, 34, 'employee, to bro', 'employee', 'Document Generated', 'Document Generation', 'Generated soloParent document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-12 03:55:17', NULL),
(3539, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 03:56:03', NULL),
(3540, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 03:56:06', NULL),
(3541, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 03:57:44', NULL),
(3542, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 03:57:48', NULL),
(3543, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_handler', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 03:58:00', NULL),
(3544, 34, 'employee, to bro', 'employee', 'Document Generated', 'Document Generation', 'Generated soloParent document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-12 03:58:01', NULL),
(3545, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 03:58:19', NULL),
(3546, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 03:58:22', NULL),
(3547, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 03:58:24', NULL),
(3548, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 03:58:54', NULL),
(3549, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_handler', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 03:59:06', NULL),
(3550, 34, 'employee, to bro', 'employee', 'Document Generated', 'Document Generation', 'Generated swornAffidavitMother document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-12 03:59:06', NULL),
(3551, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:00:38', NULL),
(3552, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:00:39', NULL),
(3553, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_handler', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:00:52', NULL),
(3554, 34, 'employee, to bro', 'employee', 'Document Generated', 'Document Generation', 'Generated swornAffidavitMother document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-12 04:00:52', NULL),
(3555, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:01:02', NULL),
(3556, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:01:08', NULL),
(3557, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:02:48', NULL),
(3558, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:02:52', NULL),
(3559, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:02:54', NULL),
(3560, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_handler', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:03:05', NULL),
(3561, 34, 'employee, to bro', 'employee', 'Document Generated', 'Document Generation', 'Generated swornAffidavitMother document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-12 04:03:05', NULL),
(3562, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:03:24', NULL),
(3563, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:03:30', NULL),
(3564, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:04:35', NULL),
(3565, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:04:41', NULL),
(3566, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:09:01', NULL),
(3567, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:09:06', NULL),
(3568, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_handler', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:09:26', NULL),
(3569, 34, 'employee, to bro', 'employee', 'Document Generated', 'Document Generation', 'Generated jointAffidavit document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-12 04:09:28', NULL),
(3570, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:09:36', NULL),
(3571, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:09:37', NULL),
(3572, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:09:47', NULL),
(3573, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:10:07', NULL),
(3574, 34, 'employee, to bro', 'employee', 'Document Rejection', 'Document Management', 'Rejected document with request ID: DOC_20251011173906_0033_5163 (Type: jointAffidavit) for client: Miranda, Client to. Reason: 234324', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'warning', 'medium', '2025-10-12 04:10:07', NULL),
(3575, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:10:09', NULL),
(3576, 34, 'employee, to bro', 'employee', 'User Logout', 'Authentication', 'User logged out successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:10:11', NULL),
(3577, 33, 'Miranda, Client to', 'client', 'User Login', 'Authentication', 'User logged in successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:10:21', NULL),
(3578, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_cases', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:10:24', NULL),
(3579, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:10:25', NULL),
(3580, 33, 'Miranda, Client to', 'client', 'Document Submission', 'Document Generation', 'Submitted jointAffidavit document with request ID: DOC_20251012061048_0033_1144', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-12 04:10:48', NULL),
(3581, 33, 'Miranda, Client to', 'client', 'User Logout', 'Authentication', 'User logged out successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:10:52', NULL),
(3582, 34, 'employee, to bro', 'employee', 'User Login', 'Authentication', 'User logged in successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:11:02', NULL),
(3583, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:11:04', NULL),
(3584, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:11:08', NULL),
(3585, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:17:42', NULL),
(3586, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:17:47', NULL),
(3587, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:17:52', NULL),
(3588, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_handler', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:18:10', NULL),
(3589, 34, 'employee, to bro', 'employee', 'Document Generated', 'Document Generation', 'Generated jointAffidavit document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-12 04:18:10', NULL),
(3590, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:19:26', NULL),
(3591, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:19:26', NULL),
(3592, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_handler', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:19:45', NULL),
(3593, 34, 'employee, to bro', 'employee', 'Document Generated', 'Document Generation', 'Generated jointAffidavit document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-12 04:19:45', NULL),
(3594, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:21:29', NULL),
(3595, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:21:31', NULL),
(3596, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_handler', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:21:44', NULL),
(3597, 34, 'employee, to bro', 'employee', 'Document Generated', 'Document Generation', 'Generated jointAffidavit document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-12 04:21:45', NULL),
(3598, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_handler', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:22:26', NULL),
(3599, 34, 'employee, to bro', 'employee', 'Document Generated', 'Document Generation', 'Generated jointAffidavit document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-12 04:22:26', NULL),
(3600, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:24:57', NULL),
(3601, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_clients', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:25:00', NULL),
(3602, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_request_management', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:25:01', NULL),
(3603, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:25:02', NULL),
(3604, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_audit', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:25:03', NULL),
(3605, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:25:05', NULL),
(3606, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:27:36', NULL),
(3607, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:27:39', NULL),
(3608, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:30:28', NULL),
(3609, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:31:06', NULL),
(3610, 34, 'employee, to bro', 'employee', 'Document Upload', 'Document Management', 'Uploaded document: sd sd sd.pdf (Category: Notarized Documents, Doc #: 32, Book #: 10)', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-12 04:31:06', NULL),
(3611, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:31:08', NULL),
(3612, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:31:12', NULL);
INSERT INTO `audit_trail` (`id`, `user_id`, `user_name`, `user_type`, `action`, `module`, `description`, `ip_address`, `user_agent`, `status`, `priority`, `timestamp`, `additional_data`) VALUES
(3613, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:31:19', NULL),
(3614, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:31:20', NULL),
(3615, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:31:21', NULL),
(3616, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:31:23', NULL),
(3617, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:32:12', NULL),
(3618, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:32:59', NULL),
(3619, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:33:02', NULL),
(3620, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:33:49', NULL),
(3621, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:33:52', NULL),
(3622, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:33:53', NULL),
(3623, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_clients', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:33:55', NULL),
(3624, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_request_management', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:33:56', NULL),
(3625, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:33:57', NULL),
(3626, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_audit', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:33:58', NULL),
(3627, 34, 'employee, to bro', 'employee', 'User Logout', 'Authentication', 'User logged out successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:34:01', NULL),
(3628, 33, 'Miranda, Client to', 'client', 'User Login', 'Authentication', 'User logged in successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:34:53', NULL),
(3629, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:34:56', NULL),
(3630, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:34:59', NULL),
(3631, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:35:00', NULL),
(3632, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_cases', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:35:02', NULL),
(3633, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:35:05', NULL),
(3634, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_about', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:35:06', NULL),
(3635, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:35:06', NULL),
(3636, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:35:40', NULL),
(3637, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:37:17', NULL),
(3638, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:37:19', NULL),
(3639, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:38:54', NULL),
(3640, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:39:56', NULL),
(3641, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:40:35', NULL),
(3642, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:40:53', NULL),
(3643, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:41:36', NULL),
(3644, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:41:44', NULL),
(3645, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:46:20', NULL),
(3646, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:46:22', NULL),
(3647, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_cases', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:46:24', NULL),
(3648, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:46:32', NULL),
(3649, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_cases', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:46:33', NULL),
(3650, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:46:35', NULL),
(3651, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_about', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:46:36', NULL),
(3652, 33, 'Miranda, Client to', 'client', 'User Logout', 'Authentication', 'User logged out successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:46:55', NULL),
(3653, 34, 'employee, to bro', 'employee', 'User Login', 'Authentication', 'User logged in successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:47:03', NULL),
(3654, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:47:05', NULL),
(3655, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:47:08', NULL),
(3656, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:47:10', NULL),
(3657, 34, 'employee, to bro', 'employee', 'User Logout', 'Authentication', 'User logged out successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:47:24', NULL),
(3658, 33, 'Miranda, Client to', 'client', 'User Login', 'Authentication', 'User logged in successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:47:31', NULL),
(3659, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:47:33', NULL),
(3660, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:50:39', NULL),
(3661, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:51:17', NULL),
(3662, 33, 'Miranda, Client to', 'client', 'User Logout', 'Authentication', 'User logged out successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:51:20', NULL),
(3663, 34, 'employee, to bro', 'employee', 'User Login', 'Authentication', 'User logged in successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:51:28', NULL),
(3664, 34, 'employee, to bro', 'employee', 'User Logout', 'Authentication', 'User logged out successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:52:28', NULL),
(3665, 33, 'Miranda, Client to', 'client', 'User Login', 'Authentication', 'User logged in successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:52:35', NULL),
(3666, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:52:41', NULL),
(3667, 33, 'Miranda, Client to', 'client', 'User Logout', 'Authentication', 'User logged out successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:53:13', NULL),
(3668, 34, 'employee, to bro', 'employee', 'User Login', 'Authentication', 'User logged in successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:53:24', NULL),
(3669, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:53:27', NULL),
(3670, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:53:36', NULL),
(3671, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:53:37', NULL),
(3672, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:53:52', NULL),
(3673, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:55:22', NULL),
(3674, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 04:59:05', NULL),
(3675, 34, 'employee, to bro', 'employee', 'User Login', 'Authentication', 'User logged in successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:00:22', NULL),
(3676, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:00:24', NULL),
(3677, 34, 'employee, to bro', 'employee', 'User Logout', 'Authentication', 'User logged out successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:00:29', NULL),
(3678, 33, 'Miranda, Client to', 'client', 'User Login', 'Authentication', 'User logged in successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:00:38', NULL),
(3679, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:00:39', NULL),
(3680, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:01:17', NULL),
(3681, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:01:18', NULL),
(3682, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:01:20', NULL),
(3683, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:01:26', NULL),
(3684, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:01:27', NULL),
(3685, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:02:58', NULL),
(3686, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:03:04', NULL),
(3687, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:04:53', NULL),
(3688, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:05:20', NULL),
(3689, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:05:21', NULL),
(3690, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:05:30', NULL),
(3691, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:05:41', NULL),
(3692, 34, 'employee, to bro', 'employee', 'Document Rejection', 'Document Management', 'Rejected document with request ID: DOC_20251012061048_0033_1144 (Type: jointAffidavit) for client: Miranda, Client to. Reason: asd', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'warning', 'medium', '2025-10-12 05:05:41', NULL),
(3693, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:05:43', NULL),
(3694, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:05:44', NULL),
(3695, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:05:54', NULL),
(3696, 34, 'employee, to bro', 'employee', 'Document Rejection', 'Document Management', 'Rejected document with request ID: DOC_20251011180225_0033_2582 (Type: soloParent) for client: Miranda, Client to. Reason: asd', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'warning', 'medium', '2025-10-12 05:05:54', NULL),
(3697, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:05:55', NULL),
(3698, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:05:58', NULL),
(3699, 34, 'employee, to bro', 'employee', 'Document Rejection', 'Document Management', 'Rejected document with request ID: DOC_20251011173827_0033_4842 (Type: boticabLoss) for client: Miranda, Client to. Reason: sad', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'warning', 'medium', '2025-10-12 05:05:58', NULL),
(3700, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:05:59', NULL),
(3701, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:06:02', NULL),
(3702, 34, 'employee, to bro', 'employee', 'Document Rejection', 'Document Management', 'Rejected document with request ID: DOC_20251011173744_0033_1722 (Type: pwdLoss) for client: Miranda, Client to. Reason: sad', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'warning', 'medium', '2025-10-12 05:06:02', NULL),
(3703, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:06:03', NULL),
(3704, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:06:06', NULL),
(3705, 34, 'employee, to bro', 'employee', 'Document Rejection', 'Document Management', 'Rejected document with request ID: DOC_20251011173710_0033_8865 (Type: swornAffidavitMother) for client: Miranda, Client to. Reason: sda', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'warning', 'medium', '2025-10-12 05:06:06', NULL),
(3706, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:06:07', NULL),
(3707, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:06:10', NULL),
(3708, 34, 'employee, to bro', 'employee', 'Document Rejection', 'Document Management', 'Rejected document with request ID: DOC_20251011173625_0033_6493 (Type: seniorIDLoss) for client: Miranda, Client to. Reason: sda', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'warning', 'medium', '2025-10-12 05:06:10', NULL),
(3709, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:06:11', NULL),
(3710, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:06:14', NULL),
(3711, 34, 'employee, to bro', 'employee', 'Document Rejection', 'Document Management', 'Rejected document with request ID: DOC_20251011173558_0033_3634 (Type: soloParent) for client: Miranda, Client to. Reason: sda', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'warning', 'medium', '2025-10-12 05:06:14', NULL),
(3712, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:06:15', NULL),
(3713, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:06:18', NULL),
(3714, 34, 'employee, to bro', 'employee', 'Document Rejection', 'Document Management', 'Rejected document with request ID: DOC_20251011173517_0033_3179 (Type: affidavitLoss) for client: Miranda, Client to. Reason: sda', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'warning', 'medium', '2025-10-12 05:06:18', NULL),
(3715, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:06:20', NULL),
(3716, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:06:21', NULL),
(3717, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:06:53', NULL),
(3718, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:06:54', NULL),
(3719, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:06:54', NULL),
(3720, 33, 'Miranda, Client to', 'client', 'Document Submission', 'Document Generation', 'Submitted affidavitLoss document with request ID: DOC_20251012070718_0033_8955', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-12 05:07:19', NULL),
(3721, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:07:37', NULL),
(3722, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:08:33', NULL),
(3723, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:08:43', NULL),
(3724, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:08:47', NULL),
(3725, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:09:48', NULL),
(3726, 33, 'Miranda, Client to', 'client', 'Document Submission', 'Document Generation', 'Submitted soloParent document with request ID: DOC_20251012071005_0033_8302', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-12 05:10:05', NULL),
(3727, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:10:08', NULL),
(3728, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:10:10', NULL),
(3729, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:10:21', NULL),
(3730, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:12:27', NULL),
(3731, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:12:32', NULL),
(3732, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:12:33', NULL),
(3733, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:12:33', NULL),
(3734, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:13:07', NULL),
(3735, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:13:10', NULL),
(3736, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:13:14', NULL),
(3737, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:14:08', NULL),
(3738, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:16:36', NULL),
(3739, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:18:22', NULL),
(3740, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_handler', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:18:46', NULL),
(3741, 34, 'employee, to bro', 'employee', 'Document Generated', 'Document Generation', 'Generated soloParent document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-12 05:18:47', NULL),
(3742, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:19:08', NULL),
(3743, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:19:45', NULL),
(3744, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:19:50', NULL),
(3745, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:20:29', NULL),
(3746, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:20:33', NULL),
(3747, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:20:39', NULL),
(3748, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_handler', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:20:57', NULL),
(3749, 34, 'employee, to bro', 'employee', 'Document Generated', 'Document Generation', 'Generated soloParent document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-12 05:20:58', NULL),
(3750, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:23:10', NULL),
(3751, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:23:15', NULL),
(3752, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:23:17', NULL),
(3753, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:23:19', NULL),
(3754, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:23:22', NULL),
(3755, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:23:32', NULL),
(3756, 34, 'employee, to bro', 'employee', 'Document Rejection', 'Document Management', 'Rejected document with request ID: DOC_20251012071005_0033_8302 (Type: soloParent) for client: Miranda, Client to. Reason: sdasd', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'warning', 'medium', '2025-10-12 05:23:32', NULL),
(3757, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:23:34', NULL),
(3758, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:23:36', NULL),
(3759, 33, 'Miranda, Client to', 'client', 'Document Submission', 'Document Generation', 'Submitted soloParent document with request ID: DOC_20251012072358_0033_1438', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-12 05:23:58', NULL),
(3760, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:24:02', NULL),
(3761, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:24:07', NULL),
(3762, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:28:03', NULL),
(3763, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:28:05', NULL),
(3764, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:28:14', NULL),
(3765, 34, 'employee, to bro', 'employee', 'Document Rejection', 'Document Management', 'Rejected document with request ID: DOC_20251012072358_0033_1438 (Type: soloParent) for client: Miranda, Client to. Reason: zxzX', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'warning', 'medium', '2025-10-12 05:28:14', NULL),
(3766, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:28:16', NULL),
(3767, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:28:17', NULL),
(3768, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:28:19', NULL),
(3769, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:28:20', NULL),
(3770, 33, 'Miranda, Client to', 'client', 'Document Submission', 'Document Generation', 'Submitted soloParent document with request ID: DOC_20251012072841_0033_6726', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-12 05:28:41', NULL),
(3771, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:28:44', NULL),
(3772, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:28:46', NULL),
(3773, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:29:58', NULL),
(3774, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:29:59', NULL),
(3775, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:29:59', NULL),
(3776, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:30:23', NULL),
(3777, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:30:25', NULL),
(3778, 34, 'employee, to bro', 'employee', 'Document Rejection', 'Document Management', 'Rejected document with request ID: DOC_20251012072841_0033_6726 (Type: soloParent) for client: Miranda, Client to. Reason: sad', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'warning', 'medium', '2025-10-12 05:30:25', NULL),
(3779, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:30:27', NULL),
(3780, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:30:30', NULL),
(3781, 33, 'Miranda, Client to', 'client', 'Document Submission', 'Document Generation', 'Submitted soloParent document with request ID: DOC_20251012073046_0033_5320', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-12 05:30:47', NULL),
(3782, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:30:49', NULL),
(3783, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:30:51', NULL),
(3784, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:32:19', NULL);
INSERT INTO `audit_trail` (`id`, `user_id`, `user_name`, `user_type`, `action`, `module`, `description`, `ip_address`, `user_agent`, `status`, `priority`, `timestamp`, `additional_data`) VALUES
(3785, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:32:22', NULL),
(3786, 34, 'employee, to bro', 'employee', 'Document Rejection', 'Document Management', 'Rejected document with request ID: DOC_20251012073046_0033_5320 (Type: soloParent) for client: Miranda, Client to. Reason: qwewqe', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'warning', 'medium', '2025-10-12 05:32:22', NULL),
(3787, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:32:23', NULL),
(3788, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:32:26', NULL),
(3789, 33, 'Miranda, Client to', 'client', 'Document Submission', 'Document Generation', 'Submitted soloParent document with request ID: DOC_20251012073244_0033_7077', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-12 05:32:44', NULL),
(3790, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:32:48', NULL),
(3791, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:32:50', NULL),
(3792, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:33:02', NULL),
(3793, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:33:28', NULL),
(3794, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:33:31', NULL),
(3795, 34, 'employee, to bro', 'employee', 'Document Rejection', 'Document Management', 'Rejected document with request ID: DOC_20251012073244_0033_7077 (Type: soloParent) for client: Miranda, Client to. Reason: qwe', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'warning', 'medium', '2025-10-12 05:33:31', NULL),
(3796, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:33:32', NULL),
(3797, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:33:34', NULL),
(3798, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:33:35', NULL),
(3799, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_handler', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:34:10', NULL),
(3800, 34, 'employee, to bro', 'employee', 'Document Generated', 'Document Generation', 'Generated soloParent document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-12 05:34:10', NULL),
(3801, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:34:24', NULL),
(3802, 33, 'Miranda, Client to', 'client', 'Document Submission', 'Document Generation', 'Submitted soloParent document with request ID: DOC_20251012073440_0033_5326', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-12 05:34:40', NULL),
(3803, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:34:45', NULL),
(3804, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:34:47', NULL),
(3805, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:34:51', NULL),
(3806, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:45:38', NULL),
(3807, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:45:41', NULL),
(3808, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:45:45', NULL),
(3809, 34, 'employee, to bro', 'employee', 'Document Rejection', 'Document Management', 'Rejected document with request ID: DOC_20251012073440_0033_5326 (Type: soloParent) for client: Miranda, Client to. Reason: asdsa', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'warning', 'medium', '2025-10-12 05:45:45', NULL),
(3810, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:45:47', NULL),
(3811, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:45:50', NULL),
(3812, 33, 'Miranda, Client to', 'client', 'Document Submission', 'Document Generation', 'Submitted soloParent document with request ID: DOC_20251012074626_0033_4982', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-12 05:46:27', NULL),
(3813, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:46:29', NULL),
(3814, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:46:32', NULL),
(3815, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:49:01', NULL),
(3816, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:49:03', NULL),
(3817, 34, 'employee, to bro', 'employee', 'Document Rejection', 'Document Management', 'Rejected document with request ID: DOC_20251012074626_0033_4982 (Type: soloParent) for client: Miranda, Client to. Reason: sda', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'warning', 'medium', '2025-10-12 05:49:03', NULL),
(3818, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:49:05', NULL),
(3819, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:49:07', NULL),
(3820, 33, 'Miranda, Client to', 'client', 'Document Submission', 'Document Generation', 'Submitted soloParent document with request ID: DOC_20251012074927_0033_8321', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-12 05:49:27', NULL),
(3821, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:49:33', NULL),
(3822, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:49:35', NULL),
(3823, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:52:15', NULL),
(3824, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_handler', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:52:31', NULL),
(3825, 34, 'employee, to bro', 'employee', 'Document Generated', 'Document Generation', 'Generated soloParent document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-12 05:52:31', NULL),
(3826, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:52:47', NULL),
(3827, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:52:48', NULL),
(3828, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:52:51', NULL),
(3829, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:52:53', NULL),
(3830, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:53:00', NULL),
(3831, 34, 'employee, to bro', 'employee', 'Document Rejection', 'Document Management', 'Rejected document with request ID: DOC_20251012074927_0033_8321 (Type: soloParent) for client: Miranda, Client to. Reason: sda', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'warning', 'medium', '2025-10-12 05:53:00', NULL),
(3832, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:53:01', NULL),
(3833, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:53:04', NULL),
(3834, 33, 'Miranda, Client to', 'client', 'Document Submission', 'Document Generation', 'Submitted soloParent document with request ID: DOC_20251012075321_0033_8287', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-12 05:53:21', NULL),
(3835, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:53:27', NULL),
(3836, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:53:29', NULL),
(3837, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:54:38', NULL),
(3838, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:54:39', NULL),
(3839, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:54:42', NULL),
(3840, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:54:51', NULL),
(3841, 34, 'employee, to bro', 'employee', 'Document Rejection', 'Document Management', 'Rejected document with request ID: DOC_20251012075321_0033_8287 (Type: soloParent) for client: Miranda, Client to. Reason: sda', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'warning', 'medium', '2025-10-12 05:54:51', NULL),
(3842, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:54:52', NULL),
(3843, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:54:55', NULL),
(3844, 33, 'Miranda, Client to', 'client', 'Document Submission', 'Document Generation', 'Submitted soloParent document with request ID: DOC_20251012075513_0033_6307', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-12 05:55:13', NULL),
(3845, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:55:18', NULL),
(3846, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:55:22', NULL),
(3847, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:55:35', NULL),
(3848, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:55:36', NULL),
(3849, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_handler', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:55:49', NULL),
(3850, 34, 'employee, to bro', 'employee', 'Document Generated', 'Document Generation', 'Generated soloParent document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-12 05:55:49', NULL),
(3851, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:57:54', NULL),
(3852, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:57:58', NULL),
(3853, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:58:06', NULL),
(3854, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:58:27', NULL),
(3855, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:58:28', NULL),
(3856, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:58:31', NULL),
(3857, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:58:41', NULL),
(3858, 34, 'employee, to bro', 'employee', 'Document Rejection', 'Document Management', 'Rejected document with request ID: DOC_20251012075513_0033_6307 (Type: soloParent) for client: Miranda, Client to. Reason: 123', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'warning', 'medium', '2025-10-12 05:58:41', NULL),
(3859, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:58:43', NULL),
(3860, 33, 'Miranda, Client to', 'client', 'Document Submission', 'Document Generation', 'Submitted soloParent document with request ID: DOC_20251012075847_0033_7250', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-12 05:58:48', NULL),
(3861, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:58:52', NULL),
(3862, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:58:54', NULL),
(3863, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:59:30', NULL),
(3864, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:59:31', NULL),
(3865, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:59:37', NULL),
(3866, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 05:59:39', NULL),
(3867, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 06:00:37', NULL),
(3868, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 06:00:38', NULL),
(3869, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 06:00:38', NULL),
(3870, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 06:00:38', NULL),
(3871, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 06:00:39', NULL),
(3872, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 06:00:39', NULL),
(3873, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 06:00:39', NULL),
(3874, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 06:00:40', NULL),
(3875, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 06:00:42', NULL),
(3876, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 06:00:47', NULL),
(3877, 34, 'employee, to bro', 'employee', 'Document Rejection', 'Document Management', 'Rejected document with request ID: DOC_20251012075847_0033_7250 (Type: soloParent) for client: Miranda, Client to. Reason: sad', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'warning', 'medium', '2025-10-12 06:00:47', NULL),
(3878, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 06:00:48', NULL),
(3879, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 06:00:50', NULL),
(3880, 33, 'Miranda, Client to', 'client', 'Document Submission', 'Document Generation', 'Submitted soloParent document with request ID: DOC_20251012080107_0033_1707', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-12 06:01:07', NULL),
(3881, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 06:01:11', NULL),
(3882, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 06:01:13', NULL),
(3883, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 06:03:17', NULL),
(3884, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 06:03:20', NULL),
(3885, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 06:03:22', NULL),
(3886, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 06:03:28', NULL),
(3887, 34, 'employee, to bro', 'employee', 'Document Rejection', 'Document Management', 'Rejected document with request ID: DOC_20251012080107_0033_1707 (Type: soloParent) for client: Miranda, Client to. Reason: sda', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'warning', 'medium', '2025-10-12 06:03:28', NULL),
(3888, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 06:03:29', NULL),
(3889, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 06:03:31', NULL),
(3890, 33, 'Miranda, Client to', 'client', 'Document Submission', 'Document Generation', 'Submitted soloParent document with request ID: DOC_20251012080348_0033_2352', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-12 06:03:48', NULL),
(3891, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 06:03:51', NULL),
(3892, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 06:03:53', NULL),
(3893, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 06:03:59', NULL),
(3894, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 06:04:01', NULL),
(3895, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_handler', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 06:04:13', NULL),
(3896, 34, 'employee, to bro', 'employee', 'Document Generated', 'Document Generation', 'Generated soloParent document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-12 06:04:13', NULL),
(3897, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 06:04:41', NULL),
(3898, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 06:05:11', NULL),
(3899, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 06:07:45', NULL),
(3900, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 06:07:52', NULL),
(3901, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 06:08:17', NULL),
(3902, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 06:08:18', NULL),
(3903, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 06:08:22', NULL),
(3904, 34, 'employee, to bro', 'employee', 'Document Rejection', 'Document Management', 'Rejected document with request ID: DOC_20251012080348_0033_2352 (Type: soloParent) for client: Miranda, Client to. Reason: 123', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'warning', 'medium', '2025-10-12 06:08:22', NULL),
(3905, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 06:08:24', NULL),
(3906, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 06:08:26', NULL),
(3907, 33, 'Miranda, Client to', 'client', 'Document Submission', 'Document Generation', 'Submitted soloParent document with request ID: DOC_20251012080851_0033_3611', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-12 06:08:51', NULL),
(3908, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 06:08:55', NULL),
(3909, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 06:08:57', NULL),
(3910, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 06:10:08', NULL),
(3911, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 06:10:11', NULL),
(3912, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 06:10:48', NULL),
(3913, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 06:11:37', NULL),
(3914, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 06:12:09', NULL),
(3915, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 06:12:11', NULL),
(3916, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 06:12:14', NULL),
(3917, 34, 'employee, to bro', 'employee', 'Document Rejection', 'Document Management', 'Rejected document with request ID: DOC_20251012080851_0033_3611 (Type: soloParent) for client: Miranda, Client to. Reason: 213', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'warning', 'medium', '2025-10-12 06:12:14', NULL),
(3918, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 06:12:15', NULL),
(3919, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 06:12:17', NULL),
(3920, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 06:12:19', NULL),
(3921, 33, 'Miranda, Client to', 'client', 'Document Submission', 'Document Generation', 'Submitted soloParent document with request ID: DOC_20251012081239_0033_3981', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-12 06:12:39', NULL),
(3922, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 06:12:42', NULL),
(3923, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 06:12:44', NULL),
(3924, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 06:12:53', NULL),
(3925, 34, 'employee, to bro', 'employee', 'Document Rejection', 'Document Management', 'Rejected document with request ID: DOC_20251012081239_0033_3981 (Type: soloParent) for client: Miranda, Client to. Reason: qwe', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'warning', 'medium', '2025-10-12 06:12:53', NULL),
(3926, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 06:12:55', NULL),
(3927, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 06:13:26', NULL),
(3928, 33, 'Miranda, Client to', 'client', 'Document Submission', 'Document Generation', 'Submitted soloParent document with request ID: DOC_20251012081348_0033_8327', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-12 06:13:48', NULL),
(3929, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 06:13:52', NULL),
(3930, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 06:13:54', NULL),
(3931, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 06:14:48', NULL),
(3932, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 06:14:49', NULL),
(3933, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 06:14:51', NULL),
(3934, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_handler', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 06:15:09', NULL),
(3935, 34, 'employee, to bro', 'employee', 'Document Generated', 'Document Generation', 'Generated soloParent document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-12 06:15:09', NULL),
(3936, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 06:15:40', NULL),
(3937, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 06:15:41', NULL),
(3938, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 06:15:45', NULL),
(3939, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 06:16:01', NULL),
(3940, 34, 'employee, to bro', 'employee', 'Document Rejection', 'Document Management', 'Rejected document with request ID: DOC_20251012081348_0033_8327 (Type: soloParent) for client: Miranda, Client to. Reason: sad', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'warning', 'medium', '2025-10-12 06:16:01', NULL),
(3941, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 06:16:03', NULL),
(3942, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 06:16:04', NULL),
(3943, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 06:17:04', NULL),
(3944, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 06:17:07', NULL),
(3945, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 06:17:26', NULL),
(3946, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 06:18:15', NULL),
(3947, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 06:18:19', NULL),
(3948, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 06:18:27', NULL),
(3949, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 06:19:08', NULL),
(3950, 33, 'Miranda, Client to', 'client', 'Document Submission', 'Document Generation', 'Submitted soloParent document with request ID: DOC_20251012081929_0033_5588', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-12 06:19:29', NULL),
(3951, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 06:19:34', NULL),
(3952, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 06:19:38', NULL),
(3953, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 06:20:58', NULL),
(3954, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 06:21:01', NULL);
INSERT INTO `audit_trail` (`id`, `user_id`, `user_name`, `user_type`, `action`, `module`, `description`, `ip_address`, `user_agent`, `status`, `priority`, `timestamp`, `additional_data`) VALUES
(3955, 34, 'employee, to bro', 'employee', 'Document Rejection', 'Document Management', 'Rejected document with request ID: DOC_20251012081929_0033_5588 (Type: soloParent) for client: Miranda, Client to. Reason: sda', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'warning', 'medium', '2025-10-12 06:21:01', NULL),
(3956, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 06:21:02', NULL),
(3957, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 06:21:25', NULL),
(3958, 33, 'Miranda, Client to', 'client', 'Document Submission', 'Document Generation', 'Submitted soloParent document with request ID: DOC_20251012082145_0033_9992', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-12 06:21:46', NULL),
(3959, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 06:21:51', NULL),
(3960, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 06:21:53', NULL),
(3961, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 06:22:35', NULL),
(3962, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 06:22:40', NULL),
(3963, 34, 'employee, to bro', 'employee', 'Document Approval', 'Document Management', 'Approved document with request ID: DOC_20251012082145_0033_9992 (Type: soloParent) for client: Miranda, Client to', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-12 06:22:40', NULL),
(3964, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 06:22:42', NULL),
(3965, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 06:23:09', NULL),
(3966, 33, 'Miranda, Client to', 'client', 'Page Access', 'Page Access', 'Accessed page: client_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 06:23:31', NULL),
(3967, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 06:28:10', NULL),
(3968, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 06:31:18', NULL),
(3969, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 06:39:50', NULL),
(3970, 33, 'Miranda, Client to', 'client', 'User Logout', 'Authentication', 'User logged out successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 06:42:52', NULL),
(3971, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Failed Login Attempt', 'Security', 'Failed login attempt from IP: ::1 for email: leifopina25@gmail.com (Attempt 1/5)', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'warning', 'medium', '2025-10-12 06:43:06', NULL),
(3972, 0, 'System', '', 'Failed Login Attempt', 'Security', 'Failed login attempt for email: leifopina25@gmail.com (Attempt 1/4)', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'warning', 'medium', '2025-10-12 06:43:06', NULL),
(3973, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'User Login', 'Authentication', 'User logged in successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 06:43:20', NULL),
(3974, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 06:43:55', NULL),
(3975, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 06:53:12', NULL),
(3976, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 06:53:38', NULL),
(3977, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 06:56:29', NULL),
(3978, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 06:56:35', NULL),
(3979, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 08:13:54', NULL),
(3980, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 08:13:55', NULL),
(3981, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_handler', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 08:14:07', NULL),
(3982, 34, 'employee, to bro', 'employee', 'Document Generated', 'Document Generation', 'Generated affidavitLoss document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-12 08:14:07', NULL),
(3983, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 08:14:16', NULL),
(3984, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_handler', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 08:14:57', NULL),
(3985, 34, 'employee, to bro', 'employee', 'Document Generated', 'Document Generation', 'Generated seniorIDLoss document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-12 08:14:58', NULL),
(3986, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_handler', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 08:15:23', NULL),
(3987, 34, 'employee, to bro', 'employee', 'Document Generated', 'Document Generation', 'Generated soloParent document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-12 08:15:24', NULL),
(3988, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_handler', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 08:15:54', NULL),
(3989, 34, 'employee, to bro', 'employee', 'Document Generated', 'Document Generation', 'Generated swornAffidavitMother document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-12 08:15:54', NULL),
(3990, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_handler', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 08:16:10', NULL),
(3991, 34, 'employee, to bro', 'employee', 'Document Generated', 'Document Generation', 'Generated pwdLoss document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-12 08:16:10', NULL),
(3992, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_handler', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 08:16:31', NULL),
(3993, 34, 'employee, to bro', 'employee', 'Document Generated', 'Document Generation', 'Generated boticabLoss document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-12 08:16:32', NULL),
(3994, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_handler', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 08:16:58', NULL),
(3995, 34, 'employee, to bro', 'employee', 'Document Generated', 'Document Generation', 'Generated jointAffidavit document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-12 08:16:58', NULL),
(3996, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 08:19:33', NULL),
(3997, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 08:26:58', NULL),
(3998, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 08:27:05', NULL),
(3999, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 08:28:19', NULL),
(4000, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 08:28:20', NULL),
(4001, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 08:28:21', NULL),
(4002, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_usermanagement', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 08:28:26', NULL),
(4003, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_managecases', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 08:28:27', NULL),
(4004, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_managecases', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 08:30:13', NULL),
(4005, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_managecases', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 08:30:14', NULL),
(4006, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_managecases', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 08:30:15', NULL),
(4007, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 08:30:16', NULL),
(4008, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 08:30:17', NULL),
(4009, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 08:30:18', NULL),
(4010, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 08:30:20', NULL),
(4011, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 08:37:10', NULL),
(4012, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 08:37:12', NULL),
(4013, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 08:37:13', NULL),
(4014, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 08:37:14', NULL),
(4015, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_usermanagement', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 08:37:15', NULL),
(4016, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_managecases', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 08:37:16', NULL),
(4017, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_managecases', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 08:37:18', NULL),
(4018, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_clients', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 08:37:19', NULL),
(4019, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 08:37:21', NULL),
(4020, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 08:38:04', NULL),
(4021, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 08:38:06', NULL),
(4022, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_schedule', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 08:38:07', NULL),
(4023, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_clients', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 08:38:22', NULL),
(4024, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 08:38:34', NULL),
(4025, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_usermanagement', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 08:38:35', NULL),
(4026, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: add_user', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 08:39:20', NULL),
(4027, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'User Create', 'User Management', 'Created new attorney account: atty, atty to (aspifanny228@gmail.com) - Email sent successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'medium', '2025-10-12 08:40:06', NULL),
(4028, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_usermanagement', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 08:40:06', NULL),
(4029, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'Page Access', 'Page Access', 'Accessed page: admin_usermanagement', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 08:40:06', NULL),
(4030, 1, 'Opiña, Leif Laiglon Abriz', 'admin', 'User Logout', 'Authentication', 'User logged out successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 08:40:15', NULL),
(4031, 35, 'atty, atty to', 'attorney', 'User Login', 'Authentication', 'User logged in successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 08:40:24', NULL),
(4032, 35, 'atty, atty to', 'attorney', 'Page Access', 'Page Access', 'Accessed page: attorney_cases', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 08:40:27', NULL),
(4033, 35, 'atty, atty to', 'attorney', 'Page Access', 'Page Access', 'Accessed page: attorney_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 08:40:28', NULL),
(4034, 35, 'atty, atty to', 'attorney', 'Page Access', 'Page Access', 'Accessed page: attorney_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 08:46:41', NULL),
(4035, 35, 'atty, atty to', 'attorney', 'Page Access', 'Page Access', 'Accessed page: attorney_cases', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 08:46:42', NULL),
(4036, 35, 'atty, atty to', 'attorney', 'Page Access', 'Page Access', 'Accessed page: attorney_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 08:46:44', NULL),
(4037, 35, 'atty, atty to', 'attorney', 'Page Access', 'Page Access', 'Accessed page: attorney_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 08:46:49', NULL),
(4038, 35, 'atty, atty to', 'attorney', 'Page Access', 'Page Access', 'Accessed page: attorney_messages', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 08:47:50', NULL),
(4039, 35, 'atty, atty to', 'attorney', 'Page Access', 'Page Access', 'Accessed page: attorney_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 08:47:52', NULL),
(4040, 35, 'atty, atty to', 'attorney', 'User Login', 'Authentication', 'User logged in successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 09:20:53', NULL),
(4041, 35, 'atty, atty to', 'attorney', 'User Login', 'Authentication', 'User logged in successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 09:26:13', NULL),
(4042, 35, 'atty, atty to', 'attorney', 'Page Access', 'Page Access', 'Accessed page: attorney_documents', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 09:26:15', NULL),
(4043, 35, 'atty, atty to', 'attorney', 'Page Access', 'Page Access', 'Accessed page: attorney_document_handler', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 09:26:32', NULL),
(4044, 35, 'atty, atty to', 'attorney', 'Page Access', 'Page Access', 'Accessed page: attorney_document_handler', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 09:26:55', NULL),
(4045, 35, 'atty, atty to', 'attorney', 'Page Access', 'Page Access', 'Accessed page: attorney_document_handler', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 09:27:29', NULL),
(4046, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_send_files', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 09:32:01', NULL),
(4047, 34, 'employee, to bro', 'employee', 'Page Access', 'Page Access', 'Accessed page: employee_document_generation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 09:32:03', NULL),
(4048, 35, 'atty, atty to', 'attorney', 'Page Access', 'Page Access', 'Accessed page: attorney_document_handler', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 09:32:21', NULL),
(4049, 35, 'atty, atty to', 'attorney', 'Page Access', 'Page Access', 'Accessed page: attorney_document_handler', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 09:32:40', NULL),
(4050, 35, 'atty, atty to', 'attorney', 'Page Access', 'Page Access', 'Accessed page: attorney_document_handler', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 09:33:08', NULL),
(4051, 35, 'atty, atty to', 'attorney', 'Page Access', 'Page Access', 'Accessed page: attorney_document_handler', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'success', 'low', '2025-10-12 09:35:40', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `available_colors`
--

CREATE TABLE `available_colors` (
  `id` int(11) NOT NULL,
  `schedule_card_color` varchar(7) NOT NULL,
  `calendar_event_color` varchar(7) NOT NULL,
  `color_name` varchar(50) NOT NULL,
  `is_available` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `case_schedules`
--

CREATE TABLE `case_schedules` (
  `id` int(11) NOT NULL,
  `case_id` int(11) DEFAULT NULL,
  `attorney_id` int(11) DEFAULT NULL,
  `client_id` int(11) DEFAULT NULL,
  `walkin_client_name` varchar(255) DEFAULT NULL,
  `walkin_client_contact` varchar(50) DEFAULT NULL,
  `type` enum('Hearing','Appointment','Free Legal Advice') NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `date` date NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  `location` varchar(255) DEFAULT NULL,
  `created_by_employee_id` int(11) DEFAULT NULL,
  `status` varchar(50) DEFAULT 'Scheduled',
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `client_attorney_assignments`
--

CREATE TABLE `client_attorney_assignments` (
  `id` int(11) NOT NULL,
  `conversation_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `employee_id` int(11) NOT NULL,
  `attorney_id` int(11) NOT NULL,
  `assigned_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `seen_status` enum('Not Seen','Seen') DEFAULT 'Not Seen'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `client_attorney_assignments`
--

INSERT INTO `client_attorney_assignments` (`id`, `conversation_id`, `client_id`, `employee_id`, `attorney_id`, `assigned_at`, `seen_status`) VALUES
(13, 13, 33, 34, 1, '2025-10-11 15:15:08', 'Not Seen');

-- --------------------------------------------------------

--
-- Table structure for table `client_attorney_conversations`
--

CREATE TABLE `client_attorney_conversations` (
  `id` int(11) NOT NULL,
  `assignment_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `attorney_id` int(11) NOT NULL,
  `conversation_status` enum('Active','Completed','Closed') DEFAULT 'Active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `client_attorney_conversations`
--

INSERT INTO `client_attorney_conversations` (`id`, `assignment_id`, `client_id`, `attorney_id`, `conversation_status`, `created_at`, `updated_at`) VALUES
(13, 13, 33, 1, 'Active', '2025-10-11 15:15:08', '2025-10-11 15:15:08');

-- --------------------------------------------------------

--
-- Table structure for table `client_attorney_messages`
--

CREATE TABLE `client_attorney_messages` (
  `id` int(11) NOT NULL,
  `conversation_id` int(11) NOT NULL,
  `sender_id` int(11) NOT NULL,
  `sender_type` enum('client','attorney') NOT NULL,
  `message` text NOT NULL,
  `is_read` tinyint(1) DEFAULT 0,
  `sent_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_seen` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `client_document_generation`
--

CREATE TABLE `client_document_generation` (
  `id` int(11) NOT NULL,
  `request_id` varchar(100) NOT NULL,
  `client_id` int(11) NOT NULL,
  `document_type` varchar(100) NOT NULL,
  `document_data` text NOT NULL,
  `pdf_file_path` varchar(500) DEFAULT NULL,
  `pdf_filename` varchar(255) DEFAULT NULL,
  `status` enum('Pending','Approved','Rejected') DEFAULT 'Pending',
  `rejection_reason` text DEFAULT NULL,
  `submitted_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `reviewed_at` timestamp NULL DEFAULT NULL,
  `reviewed_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `client_document_generation`
--

INSERT INTO `client_document_generation` (`id`, `request_id`, `client_id`, `document_type`, `document_data`, `pdf_file_path`, `pdf_filename`, `status`, `rejection_reason`, `submitted_at`, `reviewed_at`, `reviewed_by`) VALUES
(1, 'DOC_20250101120000_0001_1234', 1, 'affidavitLoss', '{\"fullName\":\"Juan Dela Cruz\",\"completeAddress\":\"123 Main St, Cabuyao City, Laguna\",\"specifyItemLost\":\"Driver\'s License\",\"itemLost\":\"Driver\'s License\",\"itemDetails\":\"Lost while shopping at the mall\",\"dateOfNotary\":\"2025-01-01\"}', NULL, NULL, 'Rejected', 'asd', '2025-10-11 15:13:07', '2025-10-11 15:33:03', 34),
(3, 'DOC_20250101120000_0033_1234', 33, 'affidavitLoss', '{\"fullName\":\"Miranda Client\",\"completeAddress\":\"123 Main St, Cabuyao City, Laguna\",\"specifyItemLost\":\"Driver\'s License\",\"itemLost\":\"Driver\'s License\",\"itemDetails\":\"Lost while shopping at the mall\",\"dateOfNotary\":\"2025-01-01\"}', NULL, NULL, 'Rejected', 'asd', '2025-10-11 15:13:27', '2025-10-11 15:32:56', 34),
(4, 'DOC_20250101120001_0033_1235', 33, 'soloParent', '{\"fullName\":\"Miranda Client\",\"completeAddress\":\"456 Oak Ave, Cabuyao City, Laguna\",\"childrenNames\":[\"Ana Santos\",\"Pedro Santos\"],\"childrenAges\":[\"8\",\"5\"],\"yearsUnderCase\":\"3\",\"reasonSection\":\"Left the family home and abandoned us\",\"employmentStatus\":\"Employee and earning\",\"employeeAmount\":\"25000\",\"dateOfNotary\":\"2025-01-01\"}', NULL, NULL, 'Approved', NULL, '2025-10-11 15:13:27', NULL, NULL),
(5, 'DOC_20250101120002_0033_1236', 33, 'pwdLoss', '{\"fullName\":\"Miranda Client\",\"fullAddress\":\"789 Pine St, Cabuyao City, Laguna\",\"detailsOfLoss\":\"Lost wallet containing PWD ID\",\"dateOfNotary\":\"2025-01-01\"}', NULL, NULL, 'Rejected', 'asd', '2025-10-11 15:13:27', '2025-10-11 15:33:00', 34),
(6, 'DOC_20251011173037_0033_8880', 33, 'affidavitLoss', '{\"fullName\":\"Test Client\",\"completeAddress\":\"123 Test Street, Cabuyao City, Laguna\",\"specifyItemLost\":\"Driver\'s License\",\"itemLost\":\"Driver\'s License\",\"itemDetails\":\"Lost while shopping\",\"dateOfNotary\":\"2025-01-15\"}', 'C:\\xampp\\htdocs\\OCT-11-2025/uploads/documents/affidavitLoss_DOC_20251011173037_0033_8880.pdf', 'affidavitLoss_DOC_20251011173037_0033_8880.pdf', 'Rejected', 'asd', '2025-10-11 15:30:37', '2025-10-11 15:32:52', 34),
(7, 'DOC_20251011173517_0033_3179', 33, 'affidavitLoss', '{\"fullName\":\"q\",\"completeAddress\":\"q\",\"specifyItemLost\":\"q\",\"itemLost\":\"q\",\"itemDetails\":\"q\",\"dateOfNotary\":\"2025-10-11\"}', 'C:\\xampp\\htdocs\\OCT-11-2025/uploads/documents/affidavitLoss_DOC_20251011173517_0033_3179.pdf', 'affidavitLoss_DOC_20251011173517_0033_3179.pdf', 'Rejected', 'sda', '2025-10-11 15:35:18', '2025-10-12 05:06:18', 34),
(8, 'DOC_20251011173558_0033_3634', 33, 'soloParent', '{\"fullName\":\"1\",\"completeAddress\":\"1\",\"childrenNames\":[\"1\"],\"childrenAges\":[\"1\"],\"yearsUnderCase\":\"1\",\"reasonSection\":\"Left the family home and abandoned us\",\"otherReason\":\"\",\"employmentStatus\":\"Employee and earning\",\"employeeAmount\":\"111\",\"selfEmployedAmount\":\"\",\"unemployedDependent\":\"\",\"dateOfNotary\":\"2025-10-11\"}', 'C:\\xampp\\htdocs\\OCT-11-2025/uploads/documents/soloParent_DOC_20251011173558_0033_3634.pdf', 'soloParent_DOC_20251011173558_0033_3634.pdf', 'Rejected', 'sda', '2025-10-11 15:35:58', '2025-10-12 05:06:14', 34),
(9, 'DOC_20251011173625_0033_6493', 33, 'seniorIDLoss', '{\"fullName\":\"1\",\"completeAddress\":\"1\",\"relationship\":\"1\",\"seniorCitizenName\":\"1\",\"detailsOfLoss\":\"1\",\"dateOfNotary\":\"2025-10-11\"}', 'C:\\xampp\\htdocs\\OCT-11-2025/uploads/documents/seniorIDLoss_DOC_20251011173625_0033_6493.pdf', 'seniorIDLoss_DOC_20251011173625_0033_6493.pdf', 'Rejected', 'sda', '2025-10-11 15:36:25', '2025-10-12 05:06:10', 34),
(10, 'DOC_20251011173710_0033_8865', 33, 'swornAffidavitMother', '{\"fullName\":\"2\",\"completeAddress\":\"2\",\"childName\":\"12\",\"birthDate\":\"2025-10-18\",\"birthPlace\":\"2\",\"dateOfNotary\":\"2025-10-11\"}', 'C:\\xampp\\htdocs\\OCT-11-2025/uploads/documents/swornAffidavitMother_DOC_20251011173710_0033_8865.pdf', 'swornAffidavitMother_DOC_20251011173710_0033_8865.pdf', 'Rejected', 'sda', '2025-10-11 15:37:10', '2025-10-12 05:06:06', 34),
(11, 'DOC_20251011173744_0033_1722', 33, 'pwdLoss', '{\"fullName\":\"3\",\"fullAddress\":\"3\",\"detailsOfLoss\":\"3\",\"dateOfNotary\":\"2025-10-11\"}', 'C:\\xampp\\htdocs\\OCT-11-2025/uploads/documents/pwdLoss_DOC_20251011173744_0033_1722.pdf', 'pwdLoss_DOC_20251011173744_0033_1722.pdf', 'Rejected', 'sad', '2025-10-11 15:37:44', '2025-10-12 05:06:02', 34),
(12, 'DOC_20251011173827_0033_4842', 33, 'boticabLoss', '{\"fullName\":\"5\",\"fullAddress\":\"5\",\"detailsOfLoss\":\"5\",\"dateOfNotary\":\"2025-10-24\"}', 'C:\\xampp\\htdocs\\OCT-11-2025/uploads/documents/boticabLoss_DOC_20251011173827_0033_4842.pdf', 'boticabLoss_DOC_20251011173827_0033_4842.pdf', 'Rejected', 'sad', '2025-10-11 15:38:28', '2025-10-12 05:05:58', 34),
(13, 'DOC_20251011173906_0033_5163', 33, 'jointAffidavit', '{\"firstPersonName\":\"16\",\"secondPersonName\":\"7\",\"firstPersonAddress\":\"7\",\"secondPersonAddress\":\"7\",\"childName\":\"7\",\"dateOfBirth\":\"2025-10-25\",\"placeOfBirth\":\"7\",\"fatherName\":\"7\",\"motherName\":\"7\",\"childNameNumber4\":\"7\",\"dateOfNotary\":\"2025-10-11\"}', 'C:\\xampp\\htdocs\\OCT-11-2025/uploads/documents/jointAffidavit_DOC_20251011173906_0033_5163.pdf', 'jointAffidavit_DOC_20251011173906_0033_5163.pdf', 'Rejected', '234324', '2025-10-11 15:39:07', '2025-10-12 04:10:07', 34),
(14, 'DOC_20251011180043_0033_3256', 33, 'soloParent', '{\"fullName\":\"asd\",\"completeAddress\":\"asd\",\"childrenNames\":[\"asd\"],\"childrenAges\":[\"2\"],\"yearsUnderCase\":\"2\",\"reasonSection\":\"Left the family home and abandoned us\",\"otherReason\":\"\",\"employmentStatus\":\"Employee and earning\",\"employeeAmount\":\"21\",\"selfEmployedAmount\":\"\",\"unemployedDependent\":\"\",\"dateOfNotary\":\"2025-10-11\"}', 'C:\\xampp\\htdocs\\OCT-11-2025/uploads/documents/soloParent_DOC_20251011180043_0033_3256.pdf', 'soloParent_DOC_20251011180043_0033_3256.pdf', 'Rejected', 'ads', '2025-10-11 16:00:44', '2025-10-11 16:02:02', 34),
(15, 'DOC_20251011180225_0033_2582', 33, 'soloParent', '{\"fullName\":\"21\",\"completeAddress\":\"21\",\"childrenNames\":[\"21\"],\"childrenAges\":[\"21\"],\"yearsUnderCase\":\"21\",\"reasonSection\":\"Left the family home and abandoned us\",\"otherReason\":\"\",\"employmentStatus\":\"Employee and earning\",\"employeeAmount\":\"21\",\"selfEmployedAmount\":\"\",\"unemployedDependent\":\"\",\"dateOfNotary\":\"2025-10-11\"}', 'C:\\xampp\\htdocs\\OCT-11-2025/uploads/documents/soloParent_DOC_20251011180225_0033_2582.pdf', 'soloParent_DOC_20251011180225_0033_2582.pdf', 'Rejected', 'asd', '2025-10-11 16:02:25', '2025-10-12 05:05:54', 34),
(16, 'DOC_20251012061048_0033_1144', 33, 'jointAffidavit', '{\"firstPersonName\":\"1\",\"secondPersonName\":\"1\",\"firstPersonAddress\":\"1\",\"secondPersonAddress\":\"1\",\"childName\":\"1\",\"dateOfBirth\":\"2025-10-01\",\"placeOfBirth\":\"1\",\"fatherName\":\"1\",\"motherName\":\"1\",\"childNameNumber4\":\"1\",\"dateOfNotary\":\"2025-10-14\"}', 'C:\\xampp\\htdocs\\OCT-11-2025/uploads/documents/jointAffidavit_DOC_20251012061048_0033_1144.pdf', 'jointAffidavit_DOC_20251012061048_0033_1144.pdf', 'Rejected', 'asd', '2025-10-12 04:10:48', '2025-10-12 05:05:41', 34),
(17, 'DOC_20251012070718_0033_8955', 33, 'affidavitLoss', '{\"fullName\":\"qwe\",\"completeAddress\":\"qwe\",\"specifyItemLost\":\"qwe\",\"itemLost\":\"qwe\",\"itemDetails\":\"qwe\",\"dateOfNotary\":\"2025-10-14\"}', 'C:\\xampp\\htdocs\\OCT-11-2025/uploads/documents/affidavitLoss_DOC_20251012070718_0033_8955.pdf', 'affidavitLoss_DOC_20251012070718_0033_8955.pdf', 'Pending', NULL, '2025-10-12 05:07:19', NULL, NULL),
(18, 'DOC_20251012071005_0033_8302', 33, 'soloParent', '{\"fullName\":\"qwe\",\"completeAddress\":\"qwe\",\"childrenNames\":[\"qwe\"],\"childrenAges\":[\"21\"],\"yearsUnderCase\":\"2\",\"reasonSection\":\"Other reason, please state\",\"otherReason\":\"qwe\",\"employmentStatus\":\"Self-employed and earning\",\"employeeAmount\":\"\",\"selfEmployedAmount\":\"qwe\",\"unemployedDependent\":\"\",\"dateOfNotary\":\"2025-10-14\"}', 'C:\\xampp\\htdocs\\OCT-11-2025/uploads/documents/soloParent_DOC_20251012071005_0033_8302.pdf', 'soloParent_DOC_20251012071005_0033_8302.pdf', 'Rejected', 'sdasd', '2025-10-12 05:10:05', '2025-10-12 05:23:32', 34),
(19, 'DOC_20251012072358_0033_1438', 33, 'soloParent', '{\"fullName\":\"qwe\",\"completeAddress\":\"qwe\",\"childrenNames\":[\"qwe\"],\"childrenAges\":[\"1\"],\"yearsUnderCase\":\"1\",\"reasonSection\":\"Other reason, please state\",\"otherReason\":\"qwe\",\"employmentStatus\":\"Self-employed and earning\",\"employeeAmount\":\"\",\"selfEmployedAmount\":\"2123\",\"unemployedDependent\":\"\",\"dateOfNotary\":\"2025-10-14\"}', 'C:\\xampp\\htdocs\\OCT-11-2025/uploads/documents/soloParent_DOC_20251012072358_0033_1438.pdf', 'soloParent_DOC_20251012072358_0033_1438.pdf', 'Rejected', 'zxzX', '2025-10-12 05:23:58', '2025-10-12 05:28:14', 34),
(20, 'DOC_20251012072841_0033_6726', 33, 'soloParent', '{\"fullName\":\"qwe\",\"completeAddress\":\"qwe\",\"childrenNames\":[\"qwe\"],\"childrenAges\":[\"1\"],\"yearsUnderCase\":\"1\",\"reasonSection\":[\"Left the family home and abandoned us\"],\"otherReason\":\"\",\"employmentStatus\":[\"Employee and earning\"],\"employeeAmount\":\"weqe\",\"selfEmployedAmount\":\"\",\"unemployedDependent\":\"\",\"dateOfNotary\":\"2025-10-15\"}', 'C:\\xampp\\htdocs\\OCT-11-2025/uploads/documents/soloParent_DOC_20251012072841_0033_6726.pdf', 'soloParent_DOC_20251012072841_0033_6726.pdf', 'Rejected', 'sad', '2025-10-12 05:28:41', '2025-10-12 05:30:25', 34),
(21, 'DOC_20251012073046_0033_5320', 33, 'soloParent', '{\"fullName\":\"123\",\"completeAddress\":\"123\",\"childrenNames\":[\"123\"],\"childrenAges\":[\"123\"],\"yearsUnderCase\":\"123\",\"reasonSection\":[\"Left the family home and abandoned us\",\"Other reason, please state\"],\"otherReason\":\"123\",\"employmentStatus\":[\"Self-employed and earning\"],\"employeeAmount\":\"\",\"selfEmployedAmount\":\"123\",\"unemployedDependent\":\"\",\"dateOfNotary\":\"2025-10-14\"}', 'C:\\xampp\\htdocs\\OCT-11-2025/uploads/documents/soloParent_DOC_20251012073046_0033_5320.pdf', 'soloParent_DOC_20251012073046_0033_5320.pdf', 'Rejected', 'qwewqe', '2025-10-12 05:30:47', '2025-10-12 05:32:22', 34),
(22, 'DOC_20251012073244_0033_7077', 33, 'soloParent', '{\"fullName\":\"qwe\",\"completeAddress\":\"qwe\",\"childrenNames\":[\"qwe\"],\"childrenAges\":[\"123\"],\"yearsUnderCase\":\"123\",\"reasonSection\":[\"Other reason, please state\"],\"otherReason\":\"123\",\"employmentStatus\":[\"Self-employed and earning\"],\"employeeAmount\":\"\",\"selfEmployedAmount\":\"123\",\"unemployedDependent\":\"\",\"dateOfNotary\":\"2025-10-13\"}', 'C:\\xampp\\htdocs\\OCT-11-2025/uploads/documents/soloParent_DOC_20251012073244_0033_7077.pdf', 'soloParent_DOC_20251012073244_0033_7077.pdf', 'Rejected', 'qwe', '2025-10-12 05:32:44', '2025-10-12 05:33:31', 34),
(23, 'DOC_20251012073440_0033_5326', 33, 'soloParent', '{\"fullName\":\"123\",\"completeAddress\":\"123\",\"childrenNames\":[\"123\"],\"childrenAges\":[\"123\"],\"yearsUnderCase\":\"123\",\"reasonSection\":\"Other reason, please state\",\"otherReason\":\"123\",\"employmentStatus\":\"Un-employed and dependent upon\",\"employeeAmount\":\"\",\"selfEmployedAmount\":\"\",\"unemployedDependent\":\"123\",\"dateOfNotary\":\"2025-10-14\"}', 'C:\\xampp\\htdocs\\OCT-11-2025/uploads/documents/soloParent_DOC_20251012073440_0033_5326.pdf', 'soloParent_DOC_20251012073440_0033_5326.pdf', 'Rejected', 'asdsa', '2025-10-12 05:34:40', '2025-10-12 05:45:45', 34),
(24, 'DOC_20251012074626_0033_4982', 33, 'soloParent', '{\"fullName\":\"qwe\",\"completeAddress\":\"qwe\",\"childrenNames\":[\"qwe\"],\"childrenAges\":[\"123\"],\"yearsUnderCase\":\"123\",\"reasonSection\":[\"Left the family home and abandoned us\",\"Other reason, please state\"],\"otherReason\":\"123\",\"employmentStatus\":[\"Employee and earning\",\"Un-employed and dependent upon\"],\"employeeAmount\":\"123\",\"selfEmployedAmount\":\"\",\"unemployedDependent\":\"123\",\"dateOfNotary\":\"2025-10-14\"}', 'C:\\xampp\\htdocs\\OCT-11-2025/uploads/documents/soloParent_DOC_20251012074626_0033_4982.pdf', 'soloParent_DOC_20251012074626_0033_4982.pdf', 'Rejected', 'sda', '2025-10-12 05:46:27', '2025-10-12 05:49:03', 34),
(25, 'DOC_20251012074927_0033_8321', 33, 'soloParent', '{\"fullName\":\"123\",\"completeAddress\":\"123\",\"childrenNames\":[\"123\"],\"childrenAges\":[\"123\"],\"yearsUnderCase\":\"123\",\"reasonSection\":\"Other reason, please state\",\"otherReason\":\"123\",\"employmentStatus\":\"Un-employed and dependent upon\",\"employeeAmount\":\"\",\"selfEmployedAmount\":\"\",\"unemployedDependent\":\"123\",\"dateOfNotary\":\"2025-10-14\"}', 'C:\\xampp\\htdocs\\OCT-11-2025/uploads/documents/soloParent_DOC_20251012074927_0033_8321.pdf', 'soloParent_DOC_20251012074927_0033_8321.pdf', 'Rejected', 'sda', '2025-10-12 05:49:27', '2025-10-12 05:53:00', 34),
(26, 'DOC_20251012075321_0033_8287', 33, 'soloParent', '{\"fullName\":\"sda\",\"completeAddress\":\"sda\",\"childrenNames\":[\"dsa\"],\"childrenAges\":[\"123\"],\"yearsUnderCase\":\"123\",\"reasonSection\":\"Other reason, please state\",\"otherReason\":\"123\",\"employmentStatus\":\"Un-employed and dependent upon\",\"employeeAmount\":\"\",\"selfEmployedAmount\":\"\",\"unemployedDependent\":\"123\",\"dateOfNotary\":\"2025-10-13\"}', 'C:\\xampp\\htdocs\\OCT-11-2025/uploads/documents/soloParent_DOC_20251012075321_0033_8287.pdf', 'soloParent_DOC_20251012075321_0033_8287.pdf', 'Rejected', 'sda', '2025-10-12 05:53:21', '2025-10-12 05:54:51', 34),
(27, 'DOC_20251012075513_0033_6307', 33, 'soloParent', '{\"fullName\":\"123\",\"completeAddress\":\"123\",\"childrenNames\":[\"123\"],\"childrenAges\":[\"123\"],\"yearsUnderCase\":\"123\",\"reasonSection\":\"Other reason, please state\",\"otherReason\":\"123\",\"employmentStatus\":\"Un-employed and dependent upon\",\"employeeAmount\":\"\",\"selfEmployedAmount\":\"\",\"unemployedDependent\":\"123\",\"dateOfNotary\":\"2025-10-14\"}', 'C:\\xampp\\htdocs\\OCT-11-2025/uploads/documents/soloParent_DOC_20251012075513_0033_6307.pdf', 'soloParent_DOC_20251012075513_0033_6307.pdf', 'Rejected', '123', '2025-10-12 05:55:13', '2025-10-12 05:58:41', 34),
(28, 'DOC_20251012075847_0033_7250', 33, 'soloParent', '{\"fullName\":\"123\",\"completeAddress\":\"123\",\"childrenNames\":[\"123\"],\"childrenAges\":[\"123\"],\"yearsUnderCase\":\"123\",\"reasonSection\":\"Other reason, please state\",\"otherReason\":\"123\",\"employmentStatus\":\"Un-employed and dependent upon\",\"employeeAmount\":\"\",\"selfEmployedAmount\":\"\",\"unemployedDependent\":\"123\",\"dateOfNotary\":\"2025-10-22\"}', 'C:\\xampp\\htdocs\\OCT-11-2025/uploads/documents/soloParent_DOC_20251012075847_0033_7250.pdf', 'soloParent_DOC_20251012075847_0033_7250.pdf', 'Rejected', 'sad', '2025-10-12 05:58:48', '2025-10-12 06:00:47', 34),
(29, 'DOC_20251012080107_0033_1707', 33, 'soloParent', '{\"fullName\":\"123\",\"completeAddress\":\"123\",\"childrenNames\":[\"123\"],\"childrenAges\":[\"123\"],\"yearsUnderCase\":\"123\",\"reasonSection\":\"Other reason, please state\",\"otherReason\":\"123\",\"employmentStatus\":\"Un-employed and dependent upon\",\"employeeAmount\":\"\",\"selfEmployedAmount\":\"\",\"unemployedDependent\":\"123\",\"dateOfNotary\":\"2025-10-23\"}', 'C:\\xampp\\htdocs\\OCT-11-2025/uploads/documents/soloParent_DOC_20251012080107_0033_1707.pdf', 'soloParent_DOC_20251012080107_0033_1707.pdf', 'Rejected', 'sda', '2025-10-12 06:01:07', '2025-10-12 06:03:28', 34),
(30, 'DOC_20251012080348_0033_2352', 33, 'soloParent', '{\"fullName\":\"123\",\"completeAddress\":\"123\",\"childrenNames\":\"123\",\"childrenAges\":\"123\",\"yearsUnderCase\":\"123\",\"reasonSection\":\"Other reason, please state\",\"otherReason\":\"123\",\"employmentStatus\":\"Un-employed and dependent upon\",\"employeeAmount\":\"\",\"selfEmployedAmount\":\"\",\"unemployedDependent\":\"123\",\"dateOfNotary\":\"2025-10-15\"}', 'C:\\xampp\\htdocs\\OCT-11-2025/uploads/documents/soloParent_DOC_20251012080348_0033_2352.pdf', 'soloParent_DOC_20251012080348_0033_2352.pdf', 'Rejected', '123', '2025-10-12 06:03:48', '2025-10-12 06:08:22', 34),
(31, 'DOC_20251012080851_0033_3611', 33, 'soloParent', '{\"fullName\":\"123\",\"completeAddress\":\"123\",\"childrenNames\":[\"123\"],\"childrenAges\":[\"123\"],\"yearsUnderCase\":\"123\",\"reasonSection\":\"Other reason, please state\",\"otherReason\":\"123\",\"employmentStatus\":\"Un-employed and dependent upon\",\"employeeAmount\":\"\",\"selfEmployedAmount\":\"\",\"unemployedDependent\":\"123\",\"dateOfNotary\":\"2025-10-15\"}', 'C:\\xampp\\htdocs\\OCT-11-2025/uploads/documents/soloParent_DOC_20251012080851_0033_3611.pdf', 'soloParent_DOC_20251012080851_0033_3611.pdf', 'Rejected', '213', '2025-10-12 06:08:51', '2025-10-12 06:12:14', 34),
(32, 'DOC_20251012081239_0033_3981', 33, 'soloParent', '{\"fullName\":\"123\",\"completeAddress\":\"123\",\"childrenNames\":[\"123\"],\"childrenAges\":[\"123\"],\"yearsUnderCase\":\"123\",\"reasonSection\":\"Other reason, please state\",\"otherReason\":\"123\",\"employmentStatus\":\"Un-employed and dependent upon\",\"employeeAmount\":\"\",\"selfEmployedAmount\":\"\",\"unemployedDependent\":\"123\",\"dateOfNotary\":\"2025-10-13\"}', 'C:\\xampp\\htdocs\\OCT-11-2025/uploads/documents/soloParent_DOC_20251012081239_0033_3981.pdf', 'soloParent_DOC_20251012081239_0033_3981.pdf', 'Rejected', 'qwe', '2025-10-12 06:12:39', '2025-10-12 06:12:53', 34),
(33, 'DOC_20251012081348_0033_8327', 33, 'soloParent', '{\"fullName\":\"qwe\",\"completeAddress\":\"qwe\",\"childrenNames\":[\"qwe\"],\"childrenAges\":[\"1\"],\"yearsUnderCase\":\"2\",\"reasonSection\":\"Other reason, please state\",\"otherReason\":\"123\",\"employmentStatus\":\"Un-employed and dependent upon\",\"employeeAmount\":\"\",\"selfEmployedAmount\":\"\",\"unemployedDependent\":\"123\",\"dateOfNotary\":\"2025-10-22\"}', 'C:\\xampp\\htdocs\\OCT-11-2025/uploads/documents/soloParent_DOC_20251012081348_0033_8327.pdf', 'soloParent_DOC_20251012081348_0033_8327.pdf', 'Rejected', 'sad', '2025-10-12 06:13:48', '2025-10-12 06:16:01', 34),
(34, 'DOC_20251012081929_0033_5588', 33, 'soloParent', '{\"fullName\":\"123\",\"completeAddress\":\"123\",\"childrenNames\":[\"123\"],\"childrenAges\":[\"123\"],\"yearsUnderCase\":\"1\",\"reasonSection\":\"Other reason, please state\",\"otherReason\":\"123\",\"employmentStatus\":\"Un-employed and dependent upon\",\"employeeAmount\":\"\",\"selfEmployedAmount\":\"\",\"unemployedDependent\":\"123\",\"dateOfNotary\":\"2025-10-21\"}', 'C:\\xampp\\htdocs\\OCT-11-2025/uploads/documents/soloParent_DOC_20251012081929_0033_5588.pdf', 'soloParent_DOC_20251012081929_0033_5588.pdf', 'Rejected', 'sda', '2025-10-12 06:19:29', '2025-10-12 06:21:01', 34),
(35, 'DOC_20251012082145_0033_9992', 33, 'soloParent', '{\"fullName\":\"123\",\"completeAddress\":\"123\",\"childrenNames\":[\"123\"],\"childrenAges\":[\"123\"],\"yearsUnderCase\":\"123\",\"reasonSection\":\"Other reason, please state\",\"otherReason\":\"123\",\"employmentStatus\":\"Un-employed and dependent upon\",\"employeeAmount\":\"\",\"selfEmployedAmount\":\"\",\"unemployedDependent\":\"123\",\"dateOfNotary\":\"2025-10-22\"}', 'C:\\xampp\\htdocs\\OCT-11-2025/uploads/documents/soloParent_DOC_20251012082145_0033_9992.pdf', 'soloParent_DOC_20251012082145_0033_9992.pdf', 'Approved', NULL, '2025-10-12 06:21:46', '2025-10-12 06:22:40', 34);

-- --------------------------------------------------------

--
-- Table structure for table `client_employee_conversations`
--

CREATE TABLE `client_employee_conversations` (
  `id` int(11) NOT NULL,
  `request_form_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `employee_id` int(11) NOT NULL,
  `conversation_status` enum('Active','Completed','Closed') DEFAULT 'Active',
  `concern_identified` tinyint(1) DEFAULT 0,
  `concern_description` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `client_employee_conversations`
--

INSERT INTO `client_employee_conversations` (`id`, `request_form_id`, `client_id`, `employee_id`, `conversation_status`, `concern_identified`, `concern_description`, `created_at`, `updated_at`) VALUES
(13, 15, 33, 34, 'Active', 0, NULL, '2025-10-11 15:15:08', '2025-10-11 15:15:08');

-- --------------------------------------------------------

--
-- Table structure for table `client_employee_messages`
--

CREATE TABLE `client_employee_messages` (
  `id` int(11) NOT NULL,
  `conversation_id` int(11) NOT NULL,
  `sender_id` int(11) NOT NULL,
  `sender_type` enum('client','employee') NOT NULL,
  `message` text NOT NULL,
  `is_read` tinyint(1) DEFAULT 0,
  `sent_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_seen` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `client_messages`
--

CREATE TABLE `client_messages` (
  `id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `recipient_id` int(11) NOT NULL,
  `message` text NOT NULL,
  `sent_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `client_request_form`
--

CREATE TABLE `client_request_form` (
  `id` int(11) NOT NULL,
  `request_id` varchar(50) NOT NULL,
  `client_id` int(11) NOT NULL,
  `full_name` varchar(255) NOT NULL,
  `address` text NOT NULL,
  `sex` enum('Male','Female') NOT NULL,
  `valid_id_path` varchar(500) NOT NULL,
  `valid_id_filename` varchar(255) NOT NULL,
  `valid_id_front_path` varchar(500) NOT NULL,
  `valid_id_front_filename` varchar(255) NOT NULL,
  `valid_id_back_path` varchar(500) NOT NULL,
  `valid_id_back_filename` varchar(255) NOT NULL,
  `privacy_consent` tinyint(1) NOT NULL DEFAULT 0,
  `concern_description` text DEFAULT NULL,
  `legal_category` varchar(100) DEFAULT NULL,
  `urgency_level` enum('Low','Medium','High','Critical') DEFAULT 'Medium',
  `status` enum('Pending','Approved','Rejected') DEFAULT 'Pending',
  `submitted_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `reviewed_at` timestamp NULL DEFAULT NULL,
  `reviewed_by` int(11) DEFAULT NULL,
  `review_notes` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `client_request_form`
--

INSERT INTO `client_request_form` (`id`, `request_id`, `client_id`, `full_name`, `address`, `sex`, `valid_id_path`, `valid_id_filename`, `valid_id_front_path`, `valid_id_front_filename`, `valid_id_back_path`, `valid_id_back_filename`, `privacy_consent`, `concern_description`, `legal_category`, `urgency_level`, `status`, `submitted_at`, `reviewed_at`, `reviewed_by`, `review_notes`) VALUES
(15, 'REQ-20251011-0033-8073', 33, 'Miranda, Client to', 'asdas', 'Male', '', '', 'uploads/client/valid_id_front_33_1760192865.pdf', 'valid_id_front_33_1760192865.pdf', 'uploads/client/valid_id_back_33_1760192865.pdf', 'valid_id_back_33_1760192865.pdf', 1, 'asdas', NULL, 'Medium', 'Approved', '2025-10-11 14:27:45', '2025-10-11 15:15:08', 34, 'asdas');

-- --------------------------------------------------------

--
-- Table structure for table `document_requests`
--

CREATE TABLE `document_requests` (
  `id` int(11) NOT NULL,
  `case_id` int(11) NOT NULL,
  `attorney_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `due_date` date DEFAULT NULL,
  `status` enum('Requested','Submitted','Reviewed','Approved','Rejected','Cancelled') DEFAULT 'Requested',
  `attorney_comment` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `document_request_comments`
--

CREATE TABLE `document_request_comments` (
  `id` int(11) NOT NULL,
  `request_id` int(11) NOT NULL,
  `attorney_id` int(11) NOT NULL,
  `comment` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `document_request_files`
--

CREATE TABLE `document_request_files` (
  `id` int(11) NOT NULL,
  `request_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `file_path` varchar(500) NOT NULL,
  `original_name` varchar(255) NOT NULL,
  `uploaded_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `efiling_history`
--

CREATE TABLE `efiling_history` (
  `id` int(11) NOT NULL,
  `attorney_id` int(11) NOT NULL,
  `case_id` int(11) DEFAULT NULL,
  `document_category` varchar(50) DEFAULT NULL,
  `file_name` varchar(255) NOT NULL,
  `original_file_name` varchar(255) DEFAULT NULL,
  `stored_file_path` varchar(500) DEFAULT NULL,
  `receiver_email` varchar(255) NOT NULL,
  `message` text DEFAULT NULL,
  `status` enum('Sent','Failed') NOT NULL DEFAULT 'Sent',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `employee_documents`
--

CREATE TABLE `employee_documents` (
  `id` int(11) NOT NULL,
  `doc_number` int(11) NOT NULL,
  `book_number` int(11) NOT NULL,
  `document_name` varchar(255) DEFAULT NULL,
  `affidavit_type` varchar(100) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `file_size` bigint(20) DEFAULT NULL,
  `file_type` varchar(50) DEFAULT NULL,
  `file_name` varchar(255) NOT NULL,
  `file_path` varchar(255) NOT NULL,
  `category` varchar(100) NOT NULL,
  `uploaded_by` int(11) NOT NULL,
  `upload_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `employee_documents`
--

INSERT INTO `employee_documents` (`id`, `doc_number`, `book_number`, `document_name`, `affidavit_type`, `description`, `file_size`, `file_type`, `file_name`, `file_path`, `category`, `uploaded_by`, `upload_date`) VALUES
(31, 32, 10, 'sd, sd sd', 'Joint Affidavit (Two Disinterested Person)', NULL, 9046, '0', 'sd sd sd.pdf', 'uploads/employee/1760243466_0_sd sd sd.pdf', 'Notarized Documents', 34, '2025-10-11 21:31:06');

-- --------------------------------------------------------

--
-- Table structure for table `employee_document_activity`
--

CREATE TABLE `employee_document_activity` (
  `id` int(11) NOT NULL,
  `document_id` int(11) NOT NULL,
  `action` varchar(50) NOT NULL,
  `user_id` int(11) NOT NULL,
  `form_number` int(11) DEFAULT NULL,
  `file_name` varchar(255) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  `user_name` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `employee_messages`
--

CREATE TABLE `employee_messages` (
  `id` int(11) NOT NULL,
  `employee_id` int(11) NOT NULL,
  `recipient_id` int(11) NOT NULL,
  `message` text NOT NULL,
  `sent_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_read` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `employee_request_reviews`
--

CREATE TABLE `employee_request_reviews` (
  `id` int(11) NOT NULL,
  `request_form_id` int(11) NOT NULL,
  `employee_id` int(11) NOT NULL,
  `action` enum('Approved','Rejected') NOT NULL,
  `review_notes` text DEFAULT NULL,
  `reviewed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `employee_request_reviews`
--

INSERT INTO `employee_request_reviews` (`id`, `request_form_id`, `employee_id`, `action`, `review_notes`, `reviewed_at`) VALUES
(15, 15, 34, 'Approved', 'asdas', '2025-10-11 15:15:08');

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `user_type` enum('admin','attorney','client','employee') NOT NULL,
  `title` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `type` enum('info','success','warning','error') DEFAULT 'info',
  `is_read` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`id`, `user_id`, `user_type`, `title`, `message`, `type`, `is_read`, `created_at`) VALUES
(158, 33, 'client', 'Request Approved!', 'Your request has been approved! You can now start messaging with our team and your assigned attorney.', 'success', 0, '2025-10-11 15:15:08'),
(159, 1, 'attorney', 'New Client Assignment', 'You have been assigned to a new client: Miranda, Client to. You can now start communicating with them.', 'success', 0, '2025-10-11 15:15:08'),
(160, 33, 'client', 'Document Rejected', 'Your Affidavit Of Loss document (Request ID: DOC_20251011173037_0033_8880) has been rejected. Reason: asd. Please review the requirements and submit a new request if needed.', 'error', 0, '2025-10-11 15:32:52'),
(161, 33, 'client', 'Document Rejected', 'Your Affidavit Of Loss document (Request ID: DOC_20250101120000_0033_1234) has been rejected. Reason: asd. Please review the requirements and submit a new request if needed.', 'error', 0, '2025-10-11 15:32:56'),
(162, 33, 'client', 'Document Rejected', 'Your PWD ID Loss document (Request ID: DOC_20250101120002_0033_1236) has been rejected. Reason: asd. Please review the requirements and submit a new request if needed.', 'error', 0, '2025-10-11 15:33:00'),
(163, 1, 'client', 'Document Rejected', 'Your Affidavit Of Loss document (Request ID: DOC_20250101120000_0001_1234) has been rejected. Reason: asd. Please review the requirements and submit a new request if needed.', 'error', 0, '2025-10-11 15:33:03'),
(164, 33, 'client', 'Document Rejected', 'Your Solo Parent document (Request ID: DOC_20251011180043_0033_3256) has been rejected. Reason: ads. Please review the requirements and submit a new request if needed.', 'error', 0, '2025-10-11 16:02:02'),
(165, 33, 'client', 'Document Rejected', 'Your Two Disinterested Persons document (Request ID: DOC_20251011173906_0033_5163) has been rejected. Reason: 234324. Please review the requirements and submit a new request if needed.', 'error', 0, '2025-10-12 04:10:07'),
(166, 33, 'client', 'Document Rejected', 'Your Two Disinterested Persons document (Request ID: DOC_20251012061048_0033_1144) has been rejected. Reason: asd. Please review the requirements and submit a new request if needed.', 'error', 0, '2025-10-12 05:05:41'),
(167, 33, 'client', 'Document Rejected', 'Your Solo Parent document (Request ID: DOC_20251011180225_0033_2582) has been rejected. Reason: asd. Please review the requirements and submit a new request if needed.', 'error', 0, '2025-10-12 05:05:54'),
(168, 33, 'client', 'Document Rejected', 'Your Boticab Loss document (Request ID: DOC_20251011173827_0033_4842) has been rejected. Reason: sad. Please review the requirements and submit a new request if needed.', 'error', 0, '2025-10-12 05:05:58'),
(169, 33, 'client', 'Document Rejected', 'Your PWD ID Loss document (Request ID: DOC_20251011173744_0033_1722) has been rejected. Reason: sad. Please review the requirements and submit a new request if needed.', 'error', 0, '2025-10-12 05:06:02'),
(170, 33, 'client', 'Document Rejected', 'Your Sworn Affidavit Of Mother document (Request ID: DOC_20251011173710_0033_8865) has been rejected. Reason: sda. Please review the requirements and submit a new request if needed.', 'error', 0, '2025-10-12 05:06:06'),
(171, 33, 'client', 'Document Rejected', 'Your Senior ID Loss document (Request ID: DOC_20251011173625_0033_6493) has been rejected. Reason: sda. Please review the requirements and submit a new request if needed.', 'error', 0, '2025-10-12 05:06:10'),
(172, 33, 'client', 'Document Rejected', 'Your Solo Parent document (Request ID: DOC_20251011173558_0033_3634) has been rejected. Reason: sda. Please review the requirements and submit a new request if needed.', 'error', 0, '2025-10-12 05:06:14'),
(173, 33, 'client', 'Document Rejected', 'Your Affidavit Of Loss document (Request ID: DOC_20251011173517_0033_3179) has been rejected. Reason: sda. Please review the requirements and submit a new request if needed.', 'error', 0, '2025-10-12 05:06:18'),
(174, 33, 'client', 'Document Rejected', 'Your Solo Parent document (Request ID: DOC_20251012071005_0033_8302) has been rejected. Reason: sdasd. Please review the requirements and submit a new request if needed.', 'error', 0, '2025-10-12 05:23:32'),
(175, 33, 'client', 'Document Rejected', 'Your Solo Parent document (Request ID: DOC_20251012072358_0033_1438) has been rejected. Reason: zxzX. Please review the requirements and submit a new request if needed.', 'error', 0, '2025-10-12 05:28:14'),
(176, 33, 'client', 'Document Rejected', 'Your Solo Parent document (Request ID: DOC_20251012072841_0033_6726) has been rejected. Reason: sad. Please review the requirements and submit a new request if needed.', 'error', 0, '2025-10-12 05:30:25'),
(177, 33, 'client', 'Document Rejected', 'Your Solo Parent document (Request ID: DOC_20251012073046_0033_5320) has been rejected. Reason: qwewqe. Please review the requirements and submit a new request if needed.', 'error', 0, '2025-10-12 05:32:22'),
(178, 33, 'client', 'Document Rejected', 'Your Solo Parent document (Request ID: DOC_20251012073244_0033_7077) has been rejected. Reason: qwe. Please review the requirements and submit a new request if needed.', 'error', 0, '2025-10-12 05:33:31'),
(179, 33, 'client', 'Document Rejected', 'Your Solo Parent document (Request ID: DOC_20251012073440_0033_5326) has been rejected. Reason: asdsa. Please review the requirements and submit a new request if needed.', 'error', 0, '2025-10-12 05:45:45'),
(180, 33, 'client', 'Document Rejected', 'Your Solo Parent document (Request ID: DOC_20251012074626_0033_4982) has been rejected. Reason: sda. Please review the requirements and submit a new request if needed.', 'error', 0, '2025-10-12 05:49:03'),
(181, 33, 'client', 'Document Rejected', 'Your Solo Parent document (Request ID: DOC_20251012074927_0033_8321) has been rejected. Reason: sda. Please review the requirements and submit a new request if needed.', 'error', 0, '2025-10-12 05:53:00'),
(182, 33, 'client', 'Document Rejected', 'Your Solo Parent document (Request ID: DOC_20251012075321_0033_8287) has been rejected. Reason: sda. Please review the requirements and submit a new request if needed.', 'error', 0, '2025-10-12 05:54:51'),
(183, 33, 'client', 'Document Rejected', 'Your Solo Parent document (Request ID: DOC_20251012075513_0033_6307) has been rejected. Reason: 123. Please review the requirements and submit a new request if needed.', 'error', 0, '2025-10-12 05:58:41'),
(184, 33, 'client', 'Document Rejected', 'Your Solo Parent document (Request ID: DOC_20251012075847_0033_7250) has been rejected. Reason: sad. Please review the requirements and submit a new request if needed.', 'error', 0, '2025-10-12 06:00:47'),
(185, 33, 'client', 'Document Rejected', 'Your Solo Parent document (Request ID: DOC_20251012080107_0033_1707) has been rejected. Reason: sda. Please review the requirements and submit a new request if needed.', 'error', 0, '2025-10-12 06:03:28'),
(186, 33, 'client', 'Document Rejected', 'Your Solo Parent document (Request ID: DOC_20251012080348_0033_2352) has been rejected. Reason: 123. Please review the requirements and submit a new request if needed.', 'error', 0, '2025-10-12 06:08:22'),
(187, 33, 'client', 'Document Rejected', 'Your Solo Parent document (Request ID: DOC_20251012080851_0033_3611) has been rejected. Reason: 213. Please review the requirements and submit a new request if needed.', 'error', 0, '2025-10-12 06:12:14'),
(188, 33, 'client', 'Document Rejected', 'Your Solo Parent document (Request ID: DOC_20251012081239_0033_3981) has been rejected. Reason: qwe. Please review the requirements and submit a new request if needed.', 'error', 0, '2025-10-12 06:12:53'),
(189, 33, 'client', 'Document Rejected', 'Your Solo Parent document (Request ID: DOC_20251012081348_0033_8327) has been rejected. Reason: sad. Please review the requirements and submit a new request if needed.', 'error', 0, '2025-10-12 06:16:01'),
(190, 33, 'client', 'Document Rejected', 'Your Solo Parent document (Request ID: DOC_20251012081929_0033_5588) has been rejected. Reason: sda. Please review the requirements and submit a new request if needed.', 'error', 0, '2025-10-12 06:21:01'),
(191, 33, 'client', 'Document Approved', 'Your Solo Parent document (Request ID: DOC_20251012082145_0033_9992) has been approved by our legal team. You can now proceed with the next steps.', 'success', 0, '2025-10-12 06:22:40');

-- --------------------------------------------------------

--
-- Table structure for table `user_colors`
--

CREATE TABLE `user_colors` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `user_type` enum('admin','attorney','client','employee') NOT NULL,
  `schedule_card_color` varchar(7) NOT NULL COMMENT 'Hex color for schedule cards',
  `calendar_event_color` varchar(7) NOT NULL COMMENT 'Hex color for calendar events',
  `color_name` varchar(50) DEFAULT NULL COMMENT 'Human readable color name',
  `is_active` tinyint(1) DEFAULT 1 COMMENT '1 if color is in use, 0 if freed',
  `assigned_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `freed_at` timestamp NULL DEFAULT NULL COMMENT 'When color was freed due to user deletion'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_colors`
--

INSERT INTO `user_colors` (`id`, `user_id`, `user_type`, `schedule_card_color`, `calendar_event_color`, `color_name`, `is_active`, `assigned_at`, `freed_at`) VALUES
(0, 1, 'admin', '#E6B0AA', '#800000', 'Admin Maroon', 1, '2025-10-04 15:44:05', NULL),
(0, 2, 'attorney', '#ADD8E6', '#87CEEB', 'Attorney Sky Blue', 1, '2025-10-04 15:46:15', NULL),
(0, 3, 'attorney', '#90EE90', '#008000', 'Attorney Light Green', 1, '2025-10-04 15:47:36', NULL),
(0, 7, 'attorney', '#ADD8E6', '#87CEEB', 'Attorney Sky Blue', 1, '2025-10-05 06:39:26', NULL),
(0, 8, 'attorney', '#90EE90', '#008000', 'Attorney Light Green', 1, '2025-10-05 06:40:12', NULL),
(0, 12, 'attorney', '#ADD8E6', '#87CEEB', 'Attorney Sky Blue', 1, '2025-10-06 05:54:19', NULL),
(0, 13, 'attorney', '#90EE90', '#008000', 'Attorney Light Green', 1, '2025-10-06 05:55:26', NULL),
(0, 17, 'attorney', '#ADD8E6', '#87CEEB', 'Attorney Sky Blue', 1, '2025-10-07 09:47:14', NULL),
(0, 19, 'attorney', '#90EE90', '#008000', 'Attorney Light Green', 1, '2025-10-07 09:50:58', NULL),
(0, 22, 'attorney', '#ADD8E6', '#87CEEB', 'Attorney Sky Blue', 1, '2025-10-08 01:10:33', NULL),
(0, 23, 'attorney', '#90EE90', '#008000', 'Attorney Light Green', 1, '2025-10-08 01:11:25', NULL),
(0, 1, 'admin', '#E6B0AA', '#800000', 'Admin Maroon', 1, '2025-10-04 15:44:05', NULL),
(0, 2, 'attorney', '#ADD8E6', '#87CEEB', 'Attorney Sky Blue', 1, '2025-10-04 15:46:15', NULL),
(0, 3, 'attorney', '#90EE90', '#008000', 'Attorney Light Green', 1, '2025-10-04 15:47:36', NULL),
(0, 7, 'attorney', '#ADD8E6', '#87CEEB', 'Attorney Sky Blue', 1, '2025-10-05 06:39:26', NULL),
(0, 8, 'attorney', '#90EE90', '#008000', 'Attorney Light Green', 1, '2025-10-05 06:40:12', NULL),
(0, 12, 'attorney', '#ADD8E6', '#87CEEB', 'Attorney Sky Blue', 1, '2025-10-06 05:54:19', NULL),
(0, 13, 'attorney', '#90EE90', '#008000', 'Attorney Light Green', 1, '2025-10-06 05:55:26', NULL),
(0, 17, 'attorney', '#ADD8E6', '#87CEEB', 'Attorney Sky Blue', 1, '2025-10-07 09:47:14', NULL),
(0, 19, 'attorney', '#90EE90', '#008000', 'Attorney Light Green', 1, '2025-10-07 09:50:58', NULL),
(0, 22, 'attorney', '#ADD8E6', '#87CEEB', 'Attorney Sky Blue', 1, '2025-10-08 01:10:33', NULL),
(0, 23, 'attorney', '#90EE90', '#008000', 'Attorney Light Green', 1, '2025-10-08 01:11:25', NULL),
(0, 27, 'attorney', '#ADD8E6', '#87CEEB', 'Attorney Sky Blue', 1, '2025-10-10 16:21:18', NULL),
(0, 28, 'attorney', '#90EE90', '#008000', 'Attorney Light Green', 1, '2025-10-10 18:45:25', NULL),
(0, 35, 'attorney', '#ADD8E6', '#87CEEB', 'Attorney Sky Blue', 1, '2025-10-12 08:40:06', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `user_form`
--

CREATE TABLE `user_form` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `profile_image` varchar(255) DEFAULT NULL,
  `last_login` datetime DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `user_type` enum('admin','attorney','client','employee') DEFAULT 'client',
  `login_attempts` int(11) DEFAULT 0,
  `last_failed_login` timestamp NULL DEFAULT NULL,
  `account_locked` tinyint(1) DEFAULT 0,
  `lockout_until` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_form`
--

INSERT INTO `user_form` (`id`, `name`, `profile_image`, `last_login`, `email`, `phone_number`, `password`, `user_type`, `login_attempts`, `last_failed_login`, `account_locked`, `lockout_until`, `created_at`, `created_by`) VALUES
(1, 'Opiña, Leif Laiglon Abriz', 'uploads/admin/1_1759828076_093758914f59d137.jpg', '2025-10-11 23:43:20', 'leifopina25@gmail.com', '09283262333', '$2y$10$VFyQmcbe/.cdjVY7DWDxS.40nxC8.wRe7pBFX5zVoYxPHAM2DzrA2', 'admin', 0, NULL, 0, NULL, '2025-10-04 18:16:17', NULL),
(33, 'Miranda, Client to', NULL, '2025-10-11 22:00:38', 'mirandakianandrei25@gmail.com', '09876543211', '$2y$10$g1RZV/ffLnBcNnlWYYA7Uuhv61dnoymEw1YDgfq3bxPuqExiQEcm2', 'client', 0, NULL, 0, NULL, '2025-10-11 14:10:17', NULL),
(34, 'employee, to bro', NULL, '2025-10-11 22:00:22', 'nelmiranda145@gmail.com', '09876543211', '$2y$10$pwcGgQMWy/F.abdojmjoke6528uKIcYh3YdJ3z7jX7ubwocwuGd7S', 'employee', 0, NULL, 0, NULL, '2025-10-11 14:35:47', NULL),
(35, 'atty, atty to', NULL, '2025-10-12 02:26:13', 'aspifanny228@gmail.com', '09876543211', '$2y$10$GHrZMvZ5Lt8qHhcQsa/t9.wgAuWW4QFYMPCiGz1rePJeA6aLmIhMO', 'attorney', 0, NULL, 0, NULL, '2025-10-12 08:40:06', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin_messages`
--
ALTER TABLE `admin_messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `admin_id` (`admin_id`),
  ADD KEY `recipient_id` (`recipient_id`);

--
-- Indexes for table `announcements`
--
ALTER TABLE `announcements`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `attorney_cases`
--
ALTER TABLE `attorney_cases`
  ADD PRIMARY KEY (`id`),
  ADD KEY `attorney_id` (`attorney_id`),
  ADD KEY `client_id` (`client_id`);

--
-- Indexes for table `attorney_documents`
--
ALTER TABLE `attorney_documents`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `attorney_document_activity`
--
ALTER TABLE `attorney_document_activity`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `attorney_messages`
--
ALTER TABLE `attorney_messages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `audit_trail`
--
ALTER TABLE `audit_trail`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `timestamp` (`timestamp`);

--
-- Indexes for table `case_schedules`
--
ALTER TABLE `case_schedules`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `client_attorney_assignments`
--
ALTER TABLE `client_attorney_assignments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `conversation_id` (`conversation_id`),
  ADD KEY `client_id` (`client_id`),
  ADD KEY `attorney_id` (`attorney_id`),
  ADD KEY `employee_id` (`employee_id`);

--
-- Indexes for table `client_attorney_conversations`
--
ALTER TABLE `client_attorney_conversations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `assignment_id` (`assignment_id`),
  ADD KEY `client_id` (`client_id`),
  ADD KEY `attorney_id` (`attorney_id`);

--
-- Indexes for table `client_attorney_messages`
--
ALTER TABLE `client_attorney_messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `conversation_id` (`conversation_id`),
  ADD KEY `sender_id` (`sender_id`);

--
-- Indexes for table `client_document_generation`
--
ALTER TABLE `client_document_generation`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `request_id` (`request_id`),
  ADD KEY `idx_client_id` (`client_id`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_document_type` (`document_type`),
  ADD KEY `idx_submitted_at` (`submitted_at`),
  ADD KEY `reviewed_by` (`reviewed_by`);

--
-- Indexes for table `client_employee_conversations`
--
ALTER TABLE `client_employee_conversations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `request_form_id` (`request_form_id`),
  ADD KEY `client_id` (`client_id`),
  ADD KEY `employee_id` (`employee_id`);

--
-- Indexes for table `client_employee_messages`
--
ALTER TABLE `client_employee_messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `conversation_id` (`conversation_id`),
  ADD KEY `sender_id` (`sender_id`);

--
-- Indexes for table `client_messages`
--
ALTER TABLE `client_messages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `client_request_form`
--
ALTER TABLE `client_request_form`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `request_id` (`request_id`),
  ADD KEY `client_id` (`client_id`),
  ADD KEY `status` (`status`);

--
-- Indexes for table `efiling_history`
--
ALTER TABLE `efiling_history`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `employee_documents`
--
ALTER TABLE `employee_documents`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `employee_document_activity`
--
ALTER TABLE `employee_document_activity`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `employee_messages`
--
ALTER TABLE `employee_messages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `employee_request_reviews`
--
ALTER TABLE `employee_request_reviews`
  ADD PRIMARY KEY (`id`),
  ADD KEY `request_form_id` (`request_form_id`),
  ADD KEY `employee_id` (`employee_id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `is_read` (`is_read`);

--
-- Indexes for table `user_form`
--
ALTER TABLE `user_form`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin_messages`
--
ALTER TABLE `admin_messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `announcements`
--
ALTER TABLE `announcements`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `attorney_cases`
--
ALTER TABLE `attorney_cases`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `attorney_documents`
--
ALTER TABLE `attorney_documents`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `attorney_document_activity`
--
ALTER TABLE `attorney_document_activity`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `attorney_messages`
--
ALTER TABLE `attorney_messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `audit_trail`
--
ALTER TABLE `audit_trail`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4052;

--
-- AUTO_INCREMENT for table `case_schedules`
--
ALTER TABLE `case_schedules`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `client_attorney_assignments`
--
ALTER TABLE `client_attorney_assignments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `client_attorney_conversations`
--
ALTER TABLE `client_attorney_conversations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `client_attorney_messages`
--
ALTER TABLE `client_attorney_messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `client_document_generation`
--
ALTER TABLE `client_document_generation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `client_employee_conversations`
--
ALTER TABLE `client_employee_conversations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `client_employee_messages`
--
ALTER TABLE `client_employee_messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `client_messages`
--
ALTER TABLE `client_messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `client_request_form`
--
ALTER TABLE `client_request_form`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `efiling_history`
--
ALTER TABLE `efiling_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `employee_documents`
--
ALTER TABLE `employee_documents`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `employee_document_activity`
--
ALTER TABLE `employee_document_activity`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `employee_messages`
--
ALTER TABLE `employee_messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `employee_request_reviews`
--
ALTER TABLE `employee_request_reviews`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=192;

--
-- AUTO_INCREMENT for table `user_form`
--
ALTER TABLE `user_form`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `client_attorney_assignments`
--
ALTER TABLE `client_attorney_assignments`
  ADD CONSTRAINT `client_attorney_assignments_ibfk_1` FOREIGN KEY (`conversation_id`) REFERENCES `client_employee_conversations` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `client_attorney_assignments_ibfk_2` FOREIGN KEY (`client_id`) REFERENCES `user_form` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `client_attorney_assignments_ibfk_3` FOREIGN KEY (`employee_id`) REFERENCES `user_form` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `client_attorney_assignments_ibfk_4` FOREIGN KEY (`attorney_id`) REFERENCES `user_form` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `client_attorney_conversations`
--
ALTER TABLE `client_attorney_conversations`
  ADD CONSTRAINT `client_attorney_conversations_ibfk_1` FOREIGN KEY (`assignment_id`) REFERENCES `client_attorney_assignments` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `client_attorney_conversations_ibfk_2` FOREIGN KEY (`client_id`) REFERENCES `user_form` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `client_attorney_conversations_ibfk_3` FOREIGN KEY (`attorney_id`) REFERENCES `user_form` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `client_attorney_messages`
--
ALTER TABLE `client_attorney_messages`
  ADD CONSTRAINT `client_attorney_messages_ibfk_1` FOREIGN KEY (`conversation_id`) REFERENCES `client_attorney_conversations` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `client_attorney_messages_ibfk_2` FOREIGN KEY (`sender_id`) REFERENCES `user_form` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `client_document_generation`
--
ALTER TABLE `client_document_generation`
  ADD CONSTRAINT `client_document_generation_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `user_form` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `client_document_generation_ibfk_2` FOREIGN KEY (`reviewed_by`) REFERENCES `user_form` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `client_employee_conversations`
--
ALTER TABLE `client_employee_conversations`
  ADD CONSTRAINT `client_employee_conversations_ibfk_1` FOREIGN KEY (`request_form_id`) REFERENCES `client_request_form` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `client_employee_conversations_ibfk_2` FOREIGN KEY (`client_id`) REFERENCES `user_form` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `client_employee_conversations_ibfk_3` FOREIGN KEY (`employee_id`) REFERENCES `user_form` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `client_employee_messages`
--
ALTER TABLE `client_employee_messages`
  ADD CONSTRAINT `client_employee_messages_ibfk_1` FOREIGN KEY (`conversation_id`) REFERENCES `client_employee_conversations` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `client_employee_messages_ibfk_2` FOREIGN KEY (`sender_id`) REFERENCES `user_form` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `client_request_form`
--
ALTER TABLE `client_request_form`
  ADD CONSTRAINT `client_request_form_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `user_form` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `employee_request_reviews`
--
ALTER TABLE `employee_request_reviews`
  ADD CONSTRAINT `employee_request_reviews_ibfk_1` FOREIGN KEY (`request_form_id`) REFERENCES `client_request_form` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `employee_request_reviews_ibfk_2` FOREIGN KEY (`employee_id`) REFERENCES `user_form` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
