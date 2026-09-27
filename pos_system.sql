-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 27, 2026 at 01:16 AM
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
-- Database: `pos_system`
--

-- --------------------------------------------------------

--
-- Table structure for table `audit_logs`
--

CREATE TABLE `audit_logs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `user_name` varchar(255) DEFAULT NULL,
  `action` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `auditable_type` varchar(255) DEFAULT NULL,
  `auditable_id` bigint(20) UNSIGNED DEFAULT NULL,
  `old_values` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`old_values`)),
  `new_values` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`new_values`)),
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `audit_logs`
--

INSERT INTO `audit_logs` (`id`, `user_id`, `user_name`, `action`, `description`, `auditable_type`, `auditable_id`, `old_values`, `new_values`, `ip_address`, `user_agent`, `created_at`, `updated_at`) VALUES
(1, NULL, NULL, 'order.created', 'Completed order ORD-20260926-F5E0AB for ₱3.62 (cashier: Alice Cashier).', 'App\\Models\\Order', 1, NULL, '{\"total\":3.62,\"items\":2}', '127.0.0.1', 'Symfony', '2026-08-28 02:08:00', '2026-08-28 02:08:00'),
(2, NULL, NULL, 'order.created', 'Completed order ORD-20260926-03D2CA for ₱3.68 (cashier: Alice Cashier).', 'App\\Models\\Order', 2, NULL, '{\"total\":3.68,\"items\":1}', '127.0.0.1', 'Symfony', '2026-08-28 05:54:00', '2026-08-28 05:54:00'),
(3, NULL, NULL, 'order.created', 'Completed order ORD-20260926-60692D for ₱8.61 (cashier: Alice Cashier).', 'App\\Models\\Order', 3, NULL, '{\"total\":8.61,\"items\":3}', '127.0.0.1', 'Symfony', '2026-08-28 07:41:00', '2026-08-28 07:41:00'),
(4, NULL, NULL, 'order.created', 'Completed order ORD-20260926-663A49 for ₱15.41 (cashier: Alice Cashier).', 'App\\Models\\Order', 4, NULL, '{\"total\":15.41,\"items\":2}', '127.0.0.1', 'Symfony', '2026-08-28 08:27:00', '2026-08-28 08:27:00'),
(5, NULL, NULL, 'order.created', 'Completed order ORD-20260926-939B4A for ₱45.15 (cashier: Alice Cashier).', 'App\\Models\\Order', 5, NULL, '{\"total\":45.15,\"items\":5}', '127.0.0.1', 'Symfony', '2026-08-28 06:34:00', '2026-08-28 06:34:00'),
(6, NULL, NULL, 'order.created', 'Completed order ORD-20260926-31C3E6 for ₱13.44 (cashier: Bruno Cashier).', 'App\\Models\\Order', 6, NULL, '{\"total\":13.44,\"items\":3}', '127.0.0.1', 'Symfony', '2026-08-28 10:45:00', '2026-08-28 10:45:00'),
(7, NULL, NULL, 'order.created', 'Completed order ORD-20260926-E64CBB for ₱19.47 (cashier: Store Administrator).', 'App\\Models\\Order', 7, NULL, '{\"total\":19.47,\"items\":4}', '127.0.0.1', 'Symfony', '2026-08-29 10:17:00', '2026-08-29 10:17:00'),
(8, NULL, NULL, 'order.created', 'Completed order ORD-20260926-459C1A for ₱15.80 (cashier: Alice Cashier).', 'App\\Models\\Order', 8, NULL, '{\"total\":15.8,\"items\":5}', '127.0.0.1', 'Symfony', '2026-08-29 07:29:00', '2026-08-29 07:29:00'),
(9, NULL, NULL, 'order.created', 'Completed order ORD-20260926-516616 for ₱13.86 (cashier: Alice Cashier).', 'App\\Models\\Order', 9, NULL, '{\"total\":13.86,\"items\":2}', '127.0.0.1', 'Symfony', '2026-08-29 11:23:00', '2026-08-29 11:23:00'),
(10, NULL, NULL, 'order.created', 'Completed order ORD-20260926-0A99B7 for ₱2.89 (cashier: Store Administrator).', 'App\\Models\\Order', 10, NULL, '{\"total\":2.89,\"items\":2}', '127.0.0.1', 'Symfony', '2026-08-29 03:08:00', '2026-08-29 03:08:00'),
(11, NULL, NULL, 'order.created', 'Completed order ORD-20260926-CB252D for ₱14.23 (cashier: Store Administrator).', 'App\\Models\\Order', 11, NULL, '{\"total\":14.23,\"items\":3}', '127.0.0.1', 'Symfony', '2026-08-29 08:57:00', '2026-08-29 08:57:00'),
(12, NULL, NULL, 'order.created', 'Completed order ORD-20260926-5100E5 for ₱9.45 (cashier: Bruno Cashier).', 'App\\Models\\Order', 12, NULL, '{\"total\":9.45,\"items\":2}', '127.0.0.1', 'Symfony', '2026-08-30 03:11:00', '2026-08-30 03:11:00'),
(13, NULL, NULL, 'order.created', 'Completed order ORD-20260926-6F5618 for ₱5.46 (cashier: Alice Cashier).', 'App\\Models\\Order', 13, NULL, '{\"total\":5.46,\"items\":2}', '127.0.0.1', 'Symfony', '2026-08-30 03:23:00', '2026-08-30 03:23:00'),
(14, NULL, NULL, 'order.created', 'Completed order ORD-20260926-9DBD9B for ₱30.00 (cashier: Store Administrator).', 'App\\Models\\Order', 14, NULL, '{\"total\":30,\"items\":2}', '127.0.0.1', 'Symfony', '2026-08-30 07:12:00', '2026-08-30 07:12:00'),
(15, NULL, NULL, 'order.created', 'Completed order ORD-20260926-FA62BF for ₱28.77 (cashier: Store Administrator).', 'App\\Models\\Order', 15, NULL, '{\"total\":28.77,\"items\":5}', '127.0.0.1', 'Symfony', '2026-08-30 06:53:00', '2026-08-30 06:53:00'),
(16, NULL, NULL, 'order.created', 'Completed order ORD-20260926-169BC7 for ₱15.17 (cashier: Alice Cashier).', 'App\\Models\\Order', 16, NULL, '{\"total\":15.17,\"items\":2}', '127.0.0.1', 'Symfony', '2026-08-30 07:28:00', '2026-08-30 07:28:00'),
(17, NULL, NULL, 'order.created', 'Completed order ORD-20260926-FF8F87 for ₱22.84 (cashier: Bruno Cashier).', 'App\\Models\\Order', 17, NULL, '{\"total\":22.84,\"items\":5}', '127.0.0.1', 'Symfony', '2026-08-30 02:49:00', '2026-08-30 02:49:00'),
(18, NULL, NULL, 'order.created', 'Completed order ORD-20260926-BE7BF8 for ₱13.28 (cashier: Alice Cashier).', 'App\\Models\\Order', 18, NULL, '{\"total\":13.28,\"items\":3}', '127.0.0.1', 'Symfony', '2026-08-30 09:53:00', '2026-08-30 09:53:00'),
(19, NULL, NULL, 'order.created', 'Completed order ORD-20260926-64BDC9 for ₱16.43 (cashier: Alice Cashier).', 'App\\Models\\Order', 19, NULL, '{\"total\":16.43,\"items\":3}', '127.0.0.1', 'Symfony', '2026-08-30 10:39:00', '2026-08-30 10:39:00'),
(20, NULL, NULL, 'order.created', 'Completed order ORD-20260926-145B3A for ₱0.00 (cashier: Store Administrator).', 'App\\Models\\Order', 20, NULL, '{\"total\":0,\"items\":1}', '127.0.0.1', 'Symfony', '2026-08-30 03:00:00', '2026-08-30 03:00:00'),
(21, NULL, NULL, 'order.created', 'Completed order ORD-20260926-931453 for ₱13.34 (cashier: Store Administrator).', 'App\\Models\\Order', 21, NULL, '{\"total\":13.34,\"items\":3}', '127.0.0.1', 'Symfony', '2026-08-31 07:41:00', '2026-08-31 07:41:00'),
(22, NULL, NULL, 'order.created', 'Completed order ORD-20260926-670CE0 for ₱31.28 (cashier: Store Administrator).', 'App\\Models\\Order', 22, NULL, '{\"total\":31.28,\"items\":5}', '127.0.0.1', 'Symfony', '2026-08-31 08:56:00', '2026-08-31 08:56:00'),
(23, NULL, NULL, 'order.created', 'Completed order ORD-20260926-37EDA9 for ₱0.00 (cashier: Store Administrator).', 'App\\Models\\Order', 23, NULL, '{\"total\":0,\"items\":1}', '127.0.0.1', 'Symfony', '2026-08-31 05:56:00', '2026-08-31 05:56:00'),
(24, NULL, NULL, 'order.created', 'Completed order ORD-20260926-2CC057 for ₱6.93 (cashier: Alice Cashier).', 'App\\Models\\Order', 24, NULL, '{\"total\":6.93,\"items\":2}', '127.0.0.1', 'Symfony', '2026-09-01 09:41:00', '2026-09-01 09:41:00'),
(25, NULL, NULL, 'order.created', 'Completed order ORD-20260926-99724A for ₱2.42 (cashier: Alice Cashier).', 'App\\Models\\Order', 25, NULL, '{\"total\":2.42,\"items\":2}', '127.0.0.1', 'Symfony', '2026-09-01 07:56:00', '2026-09-01 07:56:00'),
(26, NULL, NULL, 'order.created', 'Completed order ORD-20260926-D85D4D for ₱0.00 (cashier: Alice Cashier).', 'App\\Models\\Order', 26, NULL, '{\"total\":0,\"items\":1}', '127.0.0.1', 'Symfony', '2026-09-01 06:55:00', '2026-09-01 06:55:00'),
(27, NULL, NULL, 'order.created', 'Completed order ORD-20260926-5838DF for ₱3.57 (cashier: Bruno Cashier).', 'App\\Models\\Order', 27, NULL, '{\"total\":3.57,\"items\":1}', '127.0.0.1', 'Symfony', '2026-09-02 05:25:00', '2026-09-02 05:25:00'),
(28, NULL, NULL, 'order.created', 'Completed order ORD-20260926-52EEDB for ₱4.52 (cashier: Store Administrator).', 'App\\Models\\Order', 28, NULL, '{\"total\":4.52,\"items\":2}', '127.0.0.1', 'Symfony', '2026-09-02 05:52:00', '2026-09-02 05:52:00'),
(29, NULL, NULL, 'order.created', 'Completed order ORD-20260926-862932 for ₱6.93 (cashier: Store Administrator).', 'App\\Models\\Order', 29, NULL, '{\"total\":6.93,\"items\":2}', '127.0.0.1', 'Symfony', '2026-09-02 11:10:00', '2026-09-02 11:10:00'),
(30, NULL, NULL, 'order.created', 'Completed order ORD-20260926-F7387B for ₱6.51 (cashier: Store Administrator).', 'App\\Models\\Order', 30, NULL, '{\"total\":6.51,\"items\":3}', '127.0.0.1', 'Symfony', '2026-09-02 08:52:00', '2026-09-02 08:52:00'),
(31, NULL, NULL, 'order.created', 'Completed order ORD-20260926-4C491D for ₱31.26 (cashier: Bruno Cashier).', 'App\\Models\\Order', 31, NULL, '{\"total\":31.26,\"items\":4}', '127.0.0.1', 'Symfony', '2026-09-02 08:32:00', '2026-09-02 08:32:00'),
(32, NULL, NULL, 'order.created', 'Completed order ORD-20260926-4E2AD3 for ₱23.52 (cashier: Alice Cashier).', 'App\\Models\\Order', 32, NULL, '{\"total\":23.52,\"items\":5}', '127.0.0.1', 'Symfony', '2026-09-03 09:57:00', '2026-09-03 09:57:00'),
(33, NULL, NULL, 'order.created', 'Completed order ORD-20260926-55041B for ₱50.82 (cashier: Alice Cashier).', 'App\\Models\\Order', 33, NULL, '{\"total\":50.82,\"items\":5}', '127.0.0.1', 'Symfony', '2026-09-03 12:05:00', '2026-09-03 12:05:00'),
(34, NULL, NULL, 'order.created', 'Completed order ORD-20260926-9459D0 for ₱2.68 (cashier: Alice Cashier).', 'App\\Models\\Order', 34, NULL, '{\"total\":2.68,\"items\":2}', '127.0.0.1', 'Symfony', '2026-09-03 10:14:00', '2026-09-03 10:14:00'),
(35, NULL, NULL, 'order.created', 'Completed order ORD-20260926-26B27A for ₱28.25 (cashier: Alice Cashier).', 'App\\Models\\Order', 35, NULL, '{\"total\":28.25,\"items\":4}', '127.0.0.1', 'Symfony', '2026-09-03 01:03:00', '2026-09-03 01:03:00'),
(36, NULL, NULL, 'order.created', 'Completed order ORD-20260926-493752 for ₱24.62 (cashier: Bruno Cashier).', 'App\\Models\\Order', 36, NULL, '{\"total\":24.62,\"items\":3}', '127.0.0.1', 'Symfony', '2026-09-03 04:20:00', '2026-09-03 04:20:00'),
(37, NULL, NULL, 'order.created', 'Completed order ORD-20260926-D898E6 for ₱23.63 (cashier: Bruno Cashier).', 'App\\Models\\Order', 37, NULL, '{\"total\":23.63,\"items\":4}', '127.0.0.1', 'Symfony', '2026-09-03 12:01:00', '2026-09-03 12:01:00'),
(38, NULL, NULL, 'order.created', 'Completed order ORD-20260926-C4D8FE for ₱0.00 (cashier: Bruno Cashier).', 'App\\Models\\Order', 38, NULL, '{\"total\":0,\"items\":1}', '127.0.0.1', 'Symfony', '2026-09-04 01:39:00', '2026-09-04 01:39:00'),
(39, NULL, NULL, 'order.created', 'Completed order ORD-20260926-DFF12C for ₱10.87 (cashier: Alice Cashier).', 'App\\Models\\Order', 39, NULL, '{\"total\":10.87,\"items\":2}', '127.0.0.1', 'Symfony', '2026-09-04 01:50:00', '2026-09-04 01:50:00'),
(40, NULL, NULL, 'order.created', 'Completed order ORD-20260926-CB22ED for ₱7.46 (cashier: Store Administrator).', 'App\\Models\\Order', 40, NULL, '{\"total\":7.46,\"items\":3}', '127.0.0.1', 'Symfony', '2026-09-05 01:18:00', '2026-09-05 01:18:00'),
(41, NULL, NULL, 'order.created', 'Completed order ORD-20260926-BF6C05 for ₱42.81 (cashier: Bruno Cashier).', 'App\\Models\\Order', 41, NULL, '{\"total\":42.81,\"items\":4}', '127.0.0.1', 'Symfony', '2026-09-05 07:19:00', '2026-09-05 07:19:00'),
(42, NULL, NULL, 'order.created', 'Completed order ORD-20260926-1EF1A4 for ₱3.73 (cashier: Bruno Cashier).', 'App\\Models\\Order', 42, NULL, '{\"total\":3.73,\"items\":1}', '127.0.0.1', 'Symfony', '2026-09-06 05:16:00', '2026-09-06 05:16:00'),
(43, NULL, NULL, 'order.created', 'Completed order ORD-20260926-9A226F for ₱25.64 (cashier: Alice Cashier).', 'App\\Models\\Order', 43, NULL, '{\"total\":25.64,\"items\":3}', '127.0.0.1', 'Symfony', '2026-09-06 09:47:00', '2026-09-06 09:47:00'),
(44, NULL, NULL, 'order.created', 'Completed order ORD-20260926-1F2AB6 for ₱8.32 (cashier: Bruno Cashier).', 'App\\Models\\Order', 44, NULL, '{\"total\":8.32,\"items\":1}', '127.0.0.1', 'Symfony', '2026-09-06 06:54:00', '2026-09-06 06:54:00'),
(45, NULL, NULL, 'order.created', 'Completed order ORD-20260926-0D98E2 for ₱2.63 (cashier: Bruno Cashier).', 'App\\Models\\Order', 45, NULL, '{\"total\":2.63,\"items\":1}', '127.0.0.1', 'Symfony', '2026-09-06 05:02:00', '2026-09-06 05:02:00'),
(46, NULL, NULL, 'order.created', 'Completed order ORD-20260926-F0EF6E for ₱11.22 (cashier: Alice Cashier).', 'App\\Models\\Order', 46, NULL, '{\"total\":11.22,\"items\":3}', '127.0.0.1', 'Symfony', '2026-09-06 09:33:00', '2026-09-06 09:33:00'),
(47, NULL, NULL, 'order.created', 'Completed order ORD-20260926-3C455A for ₱0.00 (cashier: Alice Cashier).', 'App\\Models\\Order', 47, NULL, '{\"total\":0,\"items\":1}', '127.0.0.1', 'Symfony', '2026-09-06 02:34:00', '2026-09-06 02:34:00'),
(48, NULL, NULL, 'order.created', 'Completed order ORD-20260926-F8D598 for ₱2.36 (cashier: Bruno Cashier).', 'App\\Models\\Order', 48, NULL, '{\"total\":2.36,\"items\":1}', '127.0.0.1', 'Symfony', '2026-09-06 03:32:00', '2026-09-06 03:32:00'),
(49, NULL, NULL, 'order.created', 'Completed order ORD-20260926-C69303 for ₱24.26 (cashier: Bruno Cashier).', 'App\\Models\\Order', 49, NULL, '{\"total\":24.26,\"items\":4}', '127.0.0.1', 'Symfony', '2026-09-07 03:21:00', '2026-09-07 03:21:00'),
(50, NULL, NULL, 'order.created', 'Completed order ORD-20260926-09D3F6 for ₱14.96 (cashier: Bruno Cashier).', 'App\\Models\\Order', 50, NULL, '{\"total\":14.96,\"items\":3}', '127.0.0.1', 'Symfony', '2026-09-07 05:05:00', '2026-09-07 05:05:00'),
(51, NULL, NULL, 'order.created', 'Completed order ORD-20260926-060161 for ₱22.31 (cashier: Store Administrator).', 'App\\Models\\Order', 51, NULL, '{\"total\":22.31,\"items\":3}', '127.0.0.1', 'Symfony', '2026-09-08 09:34:00', '2026-09-08 09:34:00'),
(52, NULL, NULL, 'order.created', 'Completed order ORD-20260926-5D67AB for ₱32.76 (cashier: Store Administrator).', 'App\\Models\\Order', 52, NULL, '{\"total\":32.76,\"items\":5}', '127.0.0.1', 'Symfony', '2026-09-08 05:44:00', '2026-09-08 05:44:00'),
(53, NULL, NULL, 'order.created', 'Completed order ORD-20260926-DF6822 for ₱30.23 (cashier: Bruno Cashier).', 'App\\Models\\Order', 53, NULL, '{\"total\":30.23,\"items\":3}', '127.0.0.1', 'Symfony', '2026-09-08 08:25:00', '2026-09-08 08:25:00'),
(54, NULL, NULL, 'order.created', 'Completed order ORD-20260926-6B19B2 for ₱9.37 (cashier: Bruno Cashier).', 'App\\Models\\Order', 54, NULL, '{\"total\":9.37,\"items\":2}', '127.0.0.1', 'Symfony', '2026-09-08 12:04:00', '2026-09-08 12:04:00'),
(55, NULL, NULL, 'order.created', 'Completed order ORD-20260926-87F69A for ₱0.89 (cashier: Bruno Cashier).', 'App\\Models\\Order', 55, NULL, '{\"total\":0.89,\"items\":1}', '127.0.0.1', 'Symfony', '2026-09-09 01:06:00', '2026-09-09 01:06:00'),
(56, NULL, NULL, 'order.created', 'Completed order ORD-20260926-AC6EF3 for ₱7.30 (cashier: Store Administrator).', 'App\\Models\\Order', 56, NULL, '{\"total\":7.3,\"items\":3}', '127.0.0.1', 'Symfony', '2026-09-09 06:47:00', '2026-09-09 06:47:00'),
(57, NULL, NULL, 'order.created', 'Completed order ORD-20260926-27D751 for ₱4.20 (cashier: Alice Cashier).', 'App\\Models\\Order', 57, NULL, '{\"total\":4.2,\"items\":2}', '127.0.0.1', 'Symfony', '2026-09-10 10:23:00', '2026-09-10 10:23:00'),
(58, NULL, NULL, 'order.created', 'Completed order ORD-20260926-8F4E2A for ₱16.49 (cashier: Alice Cashier).', 'App\\Models\\Order', 58, NULL, '{\"total\":16.49,\"items\":3}', '127.0.0.1', 'Symfony', '2026-09-10 04:36:00', '2026-09-10 04:36:00'),
(59, NULL, NULL, 'order.created', 'Completed order ORD-20260926-DD4A7E for ₱9.03 (cashier: Bruno Cashier).', 'App\\Models\\Order', 59, NULL, '{\"total\":9.03,\"items\":1}', '127.0.0.1', 'Symfony', '2026-09-11 09:09:00', '2026-09-11 09:09:00'),
(60, NULL, NULL, 'order.created', 'Completed order ORD-20260926-ABF033 for ₱11.66 (cashier: Alice Cashier).', 'App\\Models\\Order', 60, NULL, '{\"total\":11.66,\"items\":2}', '127.0.0.1', 'Symfony', '2026-09-11 11:56:00', '2026-09-11 11:56:00'),
(61, NULL, NULL, 'order.created', 'Completed order ORD-20260926-B6A713 for ₱20.79 (cashier: Store Administrator).', 'App\\Models\\Order', 61, NULL, '{\"total\":20.79,\"items\":5}', '127.0.0.1', 'Symfony', '2026-09-12 05:52:00', '2026-09-12 05:52:00'),
(62, NULL, NULL, 'order.created', 'Completed order ORD-20260926-E73F25 for ₱2.31 (cashier: Store Administrator).', 'App\\Models\\Order', 62, NULL, '{\"total\":2.31,\"items\":1}', '127.0.0.1', 'Symfony', '2026-09-12 06:22:00', '2026-09-12 06:22:00'),
(63, NULL, NULL, 'order.created', 'Completed order ORD-20260926-23E8D3 for ₱26.20 (cashier: Store Administrator).', 'App\\Models\\Order', 63, NULL, '{\"total\":26.2,\"items\":4}', '127.0.0.1', 'Symfony', '2026-09-13 04:09:00', '2026-09-13 04:09:00'),
(64, NULL, NULL, 'order.created', 'Completed order ORD-20260926-B96597 for ₱12.32 (cashier: Bruno Cashier).', 'App\\Models\\Order', 64, NULL, '{\"total\":12.32,\"items\":4}', '127.0.0.1', 'Symfony', '2026-09-13 10:03:00', '2026-09-13 10:03:00'),
(65, NULL, NULL, 'order.created', 'Completed order ORD-20260926-532E03 for ₱8.45 (cashier: Bruno Cashier).', 'App\\Models\\Order', 65, NULL, '{\"total\":8.45,\"items\":3}', '127.0.0.1', 'Symfony', '2026-09-14 10:07:00', '2026-09-14 10:07:00'),
(66, NULL, NULL, 'order.created', 'Completed order ORD-20260926-E4ED4D for ₱0.00 (cashier: Alice Cashier).', 'App\\Models\\Order', 66, NULL, '{\"total\":0,\"items\":1}', '127.0.0.1', 'Symfony', '2026-09-14 03:40:00', '2026-09-14 03:40:00'),
(67, NULL, NULL, 'order.created', 'Completed order ORD-20260926-ED6FB8 for ₱0.00 (cashier: Store Administrator).', 'App\\Models\\Order', 67, NULL, '{\"total\":0,\"items\":2}', '127.0.0.1', 'Symfony', '2026-09-14 06:56:00', '2026-09-14 06:56:00'),
(68, NULL, NULL, 'order.created', 'Completed order ORD-20260926-4090BC for ₱19.32 (cashier: Bruno Cashier).', 'App\\Models\\Order', 68, NULL, '{\"total\":19.32,\"items\":4}', '127.0.0.1', 'Symfony', '2026-09-15 04:39:00', '2026-09-15 04:39:00'),
(69, NULL, NULL, 'order.created', 'Completed order ORD-20260926-CAE4BF for ₱5.67 (cashier: Store Administrator).', 'App\\Models\\Order', 69, NULL, '{\"total\":5.67,\"items\":2}', '127.0.0.1', 'Symfony', '2026-09-15 01:14:00', '2026-09-15 01:14:00'),
(70, NULL, NULL, 'order.created', 'Completed order ORD-20260926-27C0D1 for ₱15.38 (cashier: Alice Cashier).', 'App\\Models\\Order', 70, NULL, '{\"total\":15.38,\"items\":2}', '127.0.0.1', 'Symfony', '2026-09-15 10:10:00', '2026-09-15 10:10:00'),
(71, NULL, NULL, 'order.created', 'Completed order ORD-20260926-610276 for ₱5.25 (cashier: Store Administrator).', 'App\\Models\\Order', 71, NULL, '{\"total\":5.25,\"items\":1}', '127.0.0.1', 'Symfony', '2026-09-15 03:14:00', '2026-09-15 03:14:00'),
(72, NULL, NULL, 'order.created', 'Completed order ORD-20260926-E8D659 for ₱16.38 (cashier: Bruno Cashier).', 'App\\Models\\Order', 72, NULL, '{\"total\":16.38,\"items\":5}', '127.0.0.1', 'Symfony', '2026-09-16 03:59:00', '2026-09-16 03:59:00'),
(73, NULL, NULL, 'order.created', 'Completed order ORD-20260926-60F8C2 for ₱12.50 (cashier: Store Administrator).', 'App\\Models\\Order', 73, NULL, '{\"total\":12.5,\"items\":3}', '127.0.0.1', 'Symfony', '2026-09-16 07:33:00', '2026-09-16 07:33:00'),
(74, NULL, NULL, 'order.created', 'Completed order ORD-20260926-EC4223 for ₱2.63 (cashier: Store Administrator).', 'App\\Models\\Order', 74, NULL, '{\"total\":2.63,\"items\":1}', '127.0.0.1', 'Symfony', '2026-09-16 07:55:00', '2026-09-16 07:55:00'),
(75, NULL, NULL, 'order.created', 'Completed order ORD-20260926-86E179 for ₱1.89 (cashier: Alice Cashier).', 'App\\Models\\Order', 75, NULL, '{\"total\":1.89,\"items\":1}', '127.0.0.1', 'Symfony', '2026-09-16 01:34:00', '2026-09-16 01:34:00'),
(76, NULL, NULL, 'order.created', 'Completed order ORD-20260926-2A6357 for ₱4.73 (cashier: Alice Cashier).', 'App\\Models\\Order', 76, NULL, '{\"total\":4.73,\"items\":2}', '127.0.0.1', 'Symfony', '2026-09-17 08:57:00', '2026-09-17 08:57:00'),
(77, NULL, NULL, 'order.created', 'Completed order ORD-20260926-68CC76 for ₱9.19 (cashier: Bruno Cashier).', 'App\\Models\\Order', 77, NULL, '{\"total\":9.19,\"items\":3}', '127.0.0.1', 'Symfony', '2026-09-17 08:42:00', '2026-09-17 08:42:00'),
(78, NULL, NULL, 'order.created', 'Completed order ORD-20260926-12F43F for ₱6.09 (cashier: Alice Cashier).', 'App\\Models\\Order', 78, NULL, '{\"total\":6.09,\"items\":1}', '127.0.0.1', 'Symfony', '2026-09-17 06:32:00', '2026-09-17 06:32:00'),
(79, NULL, NULL, 'order.created', 'Completed order ORD-20260926-100B09 for ₱0.00 (cashier: Bruno Cashier).', 'App\\Models\\Order', 79, NULL, '{\"total\":0,\"items\":1}', '127.0.0.1', 'Symfony', '2026-09-18 07:28:00', '2026-09-18 07:28:00'),
(80, NULL, NULL, 'order.created', 'Completed order ORD-20260926-5980C4 for ₱17.64 (cashier: Store Administrator).', 'App\\Models\\Order', 80, NULL, '{\"total\":17.64,\"items\":4}', '127.0.0.1', 'Symfony', '2026-09-18 10:03:00', '2026-09-18 10:03:00'),
(81, NULL, NULL, 'order.created', 'Completed order ORD-20260926-0E6C9E for ₱11.50 (cashier: Bruno Cashier).', 'App\\Models\\Order', 81, NULL, '{\"total\":11.5,\"items\":4}', '127.0.0.1', 'Symfony', '2026-09-18 03:56:00', '2026-09-18 03:56:00'),
(82, NULL, NULL, 'order.created', 'Completed order ORD-20260926-23D6B9 for ₱4.94 (cashier: Store Administrator).', 'App\\Models\\Order', 82, NULL, '{\"total\":4.94,\"items\":1}', '127.0.0.1', 'Symfony', '2026-09-19 01:24:00', '2026-09-19 01:24:00'),
(83, NULL, NULL, 'order.created', 'Completed order ORD-20260926-D7C686 for ₱15.38 (cashier: Store Administrator).', 'App\\Models\\Order', 83, NULL, '{\"total\":15.38,\"items\":4}', '127.0.0.1', 'Symfony', '2026-09-20 10:51:00', '2026-09-20 10:51:00'),
(84, NULL, NULL, 'order.created', 'Completed order ORD-20260926-2B0B62 for ₱3.57 (cashier: Store Administrator).', 'App\\Models\\Order', 84, NULL, '{\"total\":3.57,\"items\":2}', '127.0.0.1', 'Symfony', '2026-09-20 12:25:00', '2026-09-20 12:25:00'),
(85, NULL, NULL, 'order.created', 'Completed order ORD-20260926-ECF8DD for ₱21.37 (cashier: Bruno Cashier).', 'App\\Models\\Order', 85, NULL, '{\"total\":21.37,\"items\":3}', '127.0.0.1', 'Symfony', '2026-09-20 03:29:00', '2026-09-20 03:29:00'),
(86, NULL, NULL, 'order.created', 'Completed order ORD-20260926-E1153B for ₱11.97 (cashier: Alice Cashier).', 'App\\Models\\Order', 86, NULL, '{\"total\":11.97,\"items\":2}', '127.0.0.1', 'Symfony', '2026-09-20 05:41:00', '2026-09-20 05:41:00'),
(87, NULL, NULL, 'order.created', 'Completed order ORD-20260926-D34AF4 for ₱8.24 (cashier: Alice Cashier).', 'App\\Models\\Order', 87, NULL, '{\"total\":8.24,\"items\":2}', '127.0.0.1', 'Symfony', '2026-09-20 09:39:00', '2026-09-20 09:39:00'),
(88, NULL, NULL, 'order.created', 'Completed order ORD-20260926-2A3AD6 for ₱24.52 (cashier: Bruno Cashier).', 'App\\Models\\Order', 88, NULL, '{\"total\":24.52,\"items\":5}', '127.0.0.1', 'Symfony', '2026-09-20 02:53:00', '2026-09-20 02:53:00'),
(89, NULL, NULL, 'order.created', 'Completed order ORD-20260926-8CCB14 for ₱4.20 (cashier: Store Administrator).', 'App\\Models\\Order', 89, NULL, '{\"total\":4.2,\"items\":1}', '127.0.0.1', 'Symfony', '2026-09-20 06:27:00', '2026-09-20 06:27:00'),
(90, NULL, NULL, 'order.created', 'Completed order ORD-20260926-82C1C9 for ₱10.19 (cashier: Bruno Cashier).', 'App\\Models\\Order', 90, NULL, '{\"total\":10.19,\"items\":2}', '127.0.0.1', 'Symfony', '2026-09-21 07:04:00', '2026-09-21 07:04:00'),
(91, NULL, NULL, 'order.created', 'Completed order ORD-20260926-CB1DCD for ₱5.83 (cashier: Bruno Cashier).', 'App\\Models\\Order', 91, NULL, '{\"total\":5.83,\"items\":3}', '127.0.0.1', 'Symfony', '2026-09-21 04:51:00', '2026-09-21 04:51:00'),
(92, NULL, NULL, 'order.created', 'Completed order ORD-20260926-028D9A for ₱7.77 (cashier: Store Administrator).', 'App\\Models\\Order', 92, NULL, '{\"total\":7.77,\"items\":1}', '127.0.0.1', 'Symfony', '2026-09-21 06:29:00', '2026-09-21 06:29:00'),
(93, NULL, NULL, 'order.created', 'Completed order ORD-20260926-7F3B74 for ₱0.00 (cashier: Bruno Cashier).', 'App\\Models\\Order', 93, NULL, '{\"total\":0,\"items\":1}', '127.0.0.1', 'Symfony', '2026-09-22 11:03:00', '2026-09-22 11:03:00'),
(94, NULL, NULL, 'order.created', 'Completed order ORD-20260926-52A66D for ₱11.66 (cashier: Alice Cashier).', 'App\\Models\\Order', 94, NULL, '{\"total\":11.66,\"items\":3}', '127.0.0.1', 'Symfony', '2026-09-22 12:42:00', '2026-09-22 12:42:00'),
(95, NULL, NULL, 'order.created', 'Completed order ORD-20260926-A66063 for ₱6.93 (cashier: Store Administrator).', 'App\\Models\\Order', 95, NULL, '{\"total\":6.93,\"items\":2}', '127.0.0.1', 'Symfony', '2026-09-23 06:05:00', '2026-09-23 06:05:00'),
(96, NULL, NULL, 'order.created', 'Completed order ORD-20260926-297103 for ₱2.31 (cashier: Alice Cashier).', 'App\\Models\\Order', 96, NULL, '{\"total\":2.31,\"items\":2}', '127.0.0.1', 'Symfony', '2026-09-23 03:14:00', '2026-09-23 03:14:00'),
(97, NULL, NULL, 'order.created', 'Completed order ORD-20260926-884F2D for ₱11.50 (cashier: Bruno Cashier).', 'App\\Models\\Order', 97, NULL, '{\"total\":11.5,\"items\":2}', '127.0.0.1', 'Symfony', '2026-09-23 10:03:00', '2026-09-23 10:03:00'),
(98, NULL, NULL, 'order.created', 'Completed order ORD-20260926-6C1D6A for ₱21.00 (cashier: Store Administrator).', 'App\\Models\\Order', 98, NULL, '{\"total\":21,\"items\":4}', '127.0.0.1', 'Symfony', '2026-09-25 06:05:00', '2026-09-25 06:05:00'),
(99, NULL, NULL, 'order.created', 'Completed order ORD-20260926-1B7453 for ₱7.09 (cashier: Store Administrator).', 'App\\Models\\Order', 99, NULL, '{\"total\":7.09,\"items\":1}', '127.0.0.1', 'Symfony', '2026-09-26 07:37:00', '2026-09-26 07:37:00'),
(100, NULL, NULL, 'order.created', 'Completed order ORD-20260926-389313 for ₱0.00 (cashier: Alice Cashier).', 'App\\Models\\Order', 100, NULL, '{\"total\":0,\"items\":1}', '127.0.0.1', 'Symfony', '2026-09-26 05:55:00', '2026-09-26 05:55:00'),
(101, NULL, NULL, 'order.created', 'Completed order ORD-20260926-AD973A for ₱11.45 (cashier: Alice Cashier).', 'App\\Models\\Order', 101, NULL, '{\"total\":11.45,\"items\":2}', '127.0.0.1', 'Symfony', '2026-09-26 04:20:00', '2026-09-26 04:20:00'),
(102, 1, 'Store Administrator', 'login', 'Store Administrator signed in as Administrator.', NULL, NULL, NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-26 10:04:18', '2026-09-26 10:04:18'),
(103, 1, 'Store Administrator', 'product.created', 'Created product \"Chocolate Chip\".', 'App\\Models\\Product', 26, NULL, '{\"name\":\"Chocolate Chip\",\"selling_price\":\"70.00\",\"stock\":0}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-26 10:44:35', '2026-09-26 10:44:35'),
(104, 1, 'Store Administrator', 'logout', 'Store Administrator signed out.', NULL, NULL, NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-26 10:44:53', '2026-09-26 10:44:53'),
(105, 2, 'Alice Cashier', 'login', 'Alice Cashier signed in as Staff.', NULL, NULL, NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-26 10:44:58', '2026-09-26 10:44:58'),
(106, 2, 'Alice Cashier', 'order.created', 'Completed order ORD-20260926-A80CBF for ₱75.55 (cashier: Alice Cashier).', 'App\\Models\\Order', 102, NULL, '{\"total\":75.55,\"items\":2}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-26 10:45:33', '2026-09-26 10:45:33'),
(107, 2, 'Alice Cashier', 'logout', 'Alice Cashier signed out.', NULL, NULL, NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-26 10:46:03', '2026-09-26 10:46:03'),
(108, 1, 'Store Administrator', 'login', 'Store Administrator signed in as Administrator.', NULL, NULL, NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-26 10:46:08', '2026-09-26 10:46:08'),
(109, 1, 'Store Administrator', 'settings.updated', 'Store Administrator updated system settings.', NULL, NULL, '{\"store_name\":\"Demo Store\",\"store_address\":\"12 Market Street, Downtown\",\"tax_rate\":\"5\"}', '{\"store_name\":\"88 MiniMart\",\"store_address\":\"Zone 4, Bangued, Abra\",\"tax_rate\":\"1.5\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-26 10:52:12', '2026-09-26 10:52:12'),
(110, 1, 'Store Administrator', 'logout', 'Store Administrator signed out.', NULL, NULL, NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-26 10:52:19', '2026-09-26 10:52:19'),
(111, 2, 'Alice Cashier', 'login', 'Alice Cashier signed in as Staff.', NULL, NULL, NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-26 10:52:24', '2026-09-26 10:52:24'),
(112, 2, 'Alice Cashier', 'order.created', 'Completed order ORD-20260926-F289F3 for ₱284.20 (cashier: Alice Cashier).', 'App\\Models\\Order', 103, NULL, '{\"total\":284.2,\"items\":1}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-26 10:52:37', '2026-09-26 10:52:37'),
(113, 2, 'Alice Cashier', 'logout', 'Alice Cashier signed out.', NULL, NULL, NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-26 10:52:58', '2026-09-26 10:52:58'),
(114, 1, 'Store Administrator', 'login', 'Store Administrator signed in as Administrator.', NULL, NULL, NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-26 10:53:02', '2026-09-26 10:53:02'),
(115, 1, 'Store Administrator', 'product.created', 'Created product \"Colgate Plax\".', 'App\\Models\\Product', 27, NULL, '{\"name\":\"Colgate Plax\",\"selling_price\":\"42.00\",\"stock\":0}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-26 11:00:20', '2026-09-26 11:00:20'),
(116, 1, 'Store Administrator', 'logout', 'Store Administrator signed out.', NULL, NULL, NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-26 11:02:39', '2026-09-26 11:02:39'),
(117, 2, 'Alice Cashier', 'login', 'Alice Cashier signed in as Staff.', NULL, NULL, NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-26 11:02:55', '2026-09-26 11:02:55');

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cache`
--

INSERT INTO `cache` (`key`, `value`, `expiration`) VALUES
('pos-system-cache-pos.settings', 'a:9:{s:10:\"store_name\";s:11:\"88 MiniMart\";s:13:\"store_address\";s:21:\"Zone 4, Bangued, Abra\";s:11:\"store_phone\";s:11:\"+1 555 0100\";s:11:\"store_email\";s:20:\"hello@demostore.test\";s:15:\"currency_symbol\";s:3:\"₱\";s:8:\"tax_rate\";s:3:\"1.5\";s:14:\"receipt_footer\";s:78:\"Thank you for your purchase! Goods once sold are not returnable within 7 days.\";s:12:\"receipt_size\";s:4:\"80mm\";s:17:\"low_stock_default\";s:1:\"5\";}', 2105779932);

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `description`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'Beverages', 'Soft drinks, water, juice and hot drinks', 1, '2026-09-26 10:03:18', '2026-09-26 10:03:18'),
(2, 'Bakery', 'Bread, pastries and cakes baked daily', 1, '2026-09-26 10:03:18', '2026-09-26 10:03:18'),
(3, 'Dairy', 'Milk, cheese, yoghurt and butter', 1, '2026-09-26 10:03:18', '2026-09-26 10:03:18'),
(4, 'Snacks', 'Crisps, nuts, chocolate and biscuits', 1, '2026-09-26 10:03:18', '2026-09-26 10:03:18'),
(5, 'Household', 'Cleaning and kitchen supplies', 1, '2026-09-26 10:03:18', '2026-09-26 10:03:18'),
(6, 'Produce', 'Fresh fruit and vegetables, sold by weight', 1, '2026-09-26 10:03:18', '2026-09-26 10:03:18');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `inventory_movements`
--

CREATE TABLE `inventory_movements` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `batch_id` bigint(20) UNSIGNED DEFAULT NULL,
  `expiry_date` date DEFAULT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `type` enum('stock_in','stock_out','adjustment','sale','sale_cancellation','return_restock') NOT NULL,
  `quantity` int(11) NOT NULL,
  `before_stock` int(11) NOT NULL,
  `after_stock` int(11) NOT NULL,
  `reason` varchar(255) DEFAULT NULL,
  `reference_type` varchar(255) DEFAULT NULL,
  `reference_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `inventory_movements`
--

INSERT INTO `inventory_movements` (`id`, `product_id`, `batch_id`, `expiry_date`, `user_id`, `type`, `quantity`, `before_stock`, `after_stock`, `reason`, `reference_type`, `reference_id`, `created_at`, `updated_at`) VALUES
(1, 1, 1, NULL, NULL, 'adjustment', 120, 0, 120, 'Opening stock', NULL, NULL, '2026-09-26 10:03:18', '2026-09-26 10:03:18'),
(2, 2, 2, NULL, NULL, 'adjustment', 64, 0, 64, 'Opening stock', NULL, NULL, '2026-09-26 10:03:18', '2026-09-26 10:03:18'),
(3, 3, 3, '2026-10-17', NULL, 'adjustment', 40, 0, 40, 'Opening stock', NULL, NULL, '2026-09-26 10:03:18', '2026-09-26 10:03:18'),
(4, 4, 4, NULL, NULL, 'adjustment', 200, 0, 200, 'Opening stock', NULL, NULL, '2026-09-26 10:03:18', '2026-09-26 10:03:18'),
(5, 5, 5, '2027-03-25', NULL, 'adjustment', 18, 0, 18, 'Opening stock', NULL, NULL, '2026-09-26 10:03:18', '2026-09-26 10:03:18'),
(6, 6, 6, '2026-09-30', NULL, 'adjustment', 45, 0, 45, 'Opening stock', NULL, NULL, '2026-09-26 10:03:18', '2026-09-26 10:03:18'),
(7, 7, 7, '2026-10-01', NULL, 'adjustment', 30, 0, 30, 'Opening stock', NULL, NULL, '2026-09-26 10:03:18', '2026-09-26 10:03:18'),
(8, 8, 8, '2026-09-28', NULL, 'adjustment', 36, 0, 36, 'Opening stock', NULL, NULL, '2026-09-26 10:03:18', '2026-09-26 10:03:18'),
(9, 9, 9, '2026-09-29', NULL, 'adjustment', 8, 0, 8, 'Opening stock', NULL, NULL, '2026-09-26 10:03:18', '2026-09-26 10:03:18'),
(10, 10, 10, '2026-10-06', NULL, 'adjustment', 90, 0, 90, 'Opening stock', NULL, NULL, '2026-09-26 10:03:18', '2026-09-26 10:03:18'),
(11, 11, 11, '2026-10-10', NULL, 'adjustment', 26, 0, 26, 'Opening stock', NULL, NULL, '2026-09-26 10:03:18', '2026-09-26 10:03:18'),
(12, 12, 12, '2026-11-10', NULL, 'adjustment', 22, 0, 22, 'Opening stock', NULL, NULL, '2026-09-26 10:03:18', '2026-09-26 10:03:18'),
(13, 13, 13, '2026-11-25', NULL, 'adjustment', 3, 0, 3, 'Opening stock', NULL, NULL, '2026-09-26 10:03:18', '2026-09-26 10:03:18'),
(14, 14, 14, '2027-01-24', NULL, 'adjustment', 70, 0, 70, 'Opening stock', NULL, NULL, '2026-09-26 10:03:18', '2026-09-26 10:03:18'),
(15, 15, 15, '2027-02-23', NULL, 'adjustment', 40, 0, 40, 'Opening stock', NULL, NULL, '2026-09-26 10:03:18', '2026-09-26 10:03:18'),
(16, 16, 16, '2027-06-23', NULL, 'adjustment', 55, 0, 55, 'Opening stock', NULL, NULL, '2026-09-26 10:03:18', '2026-09-26 10:03:18'),
(17, 18, 17, NULL, NULL, 'adjustment', 34, 0, 34, 'Opening stock', NULL, NULL, '2026-09-26 10:03:18', '2026-09-26 10:03:18'),
(18, 19, 18, NULL, NULL, 'adjustment', 28, 0, 28, 'Opening stock', NULL, NULL, '2026-09-26 10:03:18', '2026-09-26 10:03:18'),
(19, 20, 19, NULL, NULL, 'adjustment', 16, 0, 16, 'Opening stock', NULL, NULL, '2026-09-26 10:03:18', '2026-09-26 10:03:18'),
(20, 21, 20, NULL, NULL, 'adjustment', 12, 0, 12, 'Opening stock', NULL, NULL, '2026-09-26 10:03:18', '2026-09-26 10:03:18'),
(21, 22, 21, '2026-10-02', NULL, 'adjustment', 60, 0, 60, 'Opening stock', NULL, NULL, '2026-09-26 10:03:18', '2026-09-26 10:03:18'),
(22, 23, 22, '2026-10-26', NULL, 'adjustment', 48, 0, 48, 'Opening stock', NULL, NULL, '2026-09-26 10:03:18', '2026-09-26 10:03:18'),
(23, 24, 23, '2026-10-03', NULL, 'adjustment', 24, 0, 24, 'Opening stock', NULL, NULL, '2026-09-26 10:03:18', '2026-09-26 10:03:18'),
(24, 25, 24, '2026-09-24', NULL, 'adjustment', 5, 0, 5, 'Opening stock', NULL, NULL, '2026-09-26 10:03:18', '2026-09-26 10:03:18'),
(25, 3, 3, '2026-10-17', 2, 'sale', -1, 40, 39, 'Sale ORD-20260926-F5E0AB', 'App\\Models\\Order', 1, '2026-08-28 02:08:00', '2026-08-28 02:08:00'),
(26, 8, 8, '2026-09-28', 2, 'sale', -1, 36, 35, 'Sale ORD-20260926-F5E0AB', 'App\\Models\\Order', 1, '2026-08-28 02:08:00', '2026-08-28 02:08:00'),
(27, 18, 17, NULL, 2, 'sale', -2, 34, 32, 'Sale ORD-20260926-03D2CA', 'App\\Models\\Order', 2, '2026-08-28 05:54:00', '2026-08-28 05:54:00'),
(28, 1, 1, NULL, 2, 'sale', -2, 120, 118, 'Sale ORD-20260926-60692D', 'App\\Models\\Order', 3, '2026-08-28 07:41:00', '2026-08-28 07:41:00'),
(29, 15, 15, '2027-02-23', 2, 'sale', -3, 40, 37, 'Sale ORD-20260926-60692D', 'App\\Models\\Order', 3, '2026-08-28 07:41:00', '2026-08-28 07:41:00'),
(30, 22, 21, '2026-10-02', 2, 'sale', -1, 60, 59, 'Sale ORD-20260926-60692D', 'App\\Models\\Order', 3, '2026-08-28 07:41:00', '2026-08-28 07:41:00'),
(31, 5, 5, '2027-03-25', 2, 'sale', -2, 18, 16, 'Sale ORD-20260926-663A49', 'App\\Models\\Order', 4, '2026-08-28 08:27:00', '2026-08-28 08:27:00'),
(32, 10, 10, '2026-10-06', 2, 'sale', -2, 90, 88, 'Sale ORD-20260926-663A49', 'App\\Models\\Order', 4, '2026-08-28 08:27:00', '2026-08-28 08:27:00'),
(33, 8, 8, '2026-09-28', 2, 'sale', -1, 35, 34, 'Sale ORD-20260926-939B4A', 'App\\Models\\Order', 5, '2026-08-28 06:34:00', '2026-08-28 06:34:00'),
(34, 11, 11, '2026-10-10', 2, 'sale', -3, 26, 23, 'Sale ORD-20260926-939B4A', 'App\\Models\\Order', 5, '2026-08-28 06:34:00', '2026-08-28 06:34:00'),
(35, 12, 12, '2026-11-10', 2, 'sale', -3, 22, 19, 'Sale ORD-20260926-939B4A', 'App\\Models\\Order', 5, '2026-08-28 06:34:00', '2026-08-28 06:34:00'),
(36, 19, 18, NULL, 2, 'sale', -3, 28, 25, 'Sale ORD-20260926-939B4A', 'App\\Models\\Order', 5, '2026-08-28 06:34:00', '2026-08-28 06:34:00'),
(37, 23, 22, '2026-10-26', 2, 'sale', -3, 48, 45, 'Sale ORD-20260926-939B4A', 'App\\Models\\Order', 5, '2026-08-28 06:34:00', '2026-08-28 06:34:00'),
(38, 2, 2, NULL, 3, 'sale', -1, 64, 63, 'Sale ORD-20260926-31C3E6', 'App\\Models\\Order', 6, '2026-08-28 10:45:00', '2026-08-28 10:45:00'),
(39, 12, 12, '2026-11-10', 3, 'sale', -1, 19, 18, 'Sale ORD-20260926-31C3E6', 'App\\Models\\Order', 6, '2026-08-28 10:45:00', '2026-08-28 10:45:00'),
(40, 18, 17, NULL, 3, 'sale', -2, 32, 30, 'Sale ORD-20260926-31C3E6', 'App\\Models\\Order', 6, '2026-08-28 10:45:00', '2026-08-28 10:45:00'),
(41, 1, 1, NULL, 1, 'sale', -2, 118, 116, 'Sale ORD-20260926-E64CBB', 'App\\Models\\Order', 7, '2026-08-29 10:17:00', '2026-08-29 10:17:00'),
(42, 3, 3, '2026-10-17', 1, 'sale', -2, 39, 37, 'Sale ORD-20260926-E64CBB', 'App\\Models\\Order', 7, '2026-08-29 10:17:00', '2026-08-29 10:17:00'),
(43, 5, 5, '2027-03-25', 1, 'sale', -1, 16, 15, 'Sale ORD-20260926-E64CBB', 'App\\Models\\Order', 7, '2026-08-29 10:17:00', '2026-08-29 10:17:00'),
(44, 14, 14, '2027-01-24', 1, 'sale', -3, 70, 67, 'Sale ORD-20260926-E64CBB', 'App\\Models\\Order', 7, '2026-08-29 10:17:00', '2026-08-29 10:17:00'),
(45, 1, 1, NULL, 2, 'sale', -2, 116, 114, 'Sale ORD-20260926-459C1A', 'App\\Models\\Order', 8, '2026-08-29 07:29:00', '2026-08-29 07:29:00'),
(46, 2, 2, NULL, 2, 'sale', -1, 63, 62, 'Sale ORD-20260926-459C1A', 'App\\Models\\Order', 8, '2026-08-29 07:29:00', '2026-08-29 07:29:00'),
(47, 8, 8, '2026-09-28', 2, 'sale', -3, 34, 31, 'Sale ORD-20260926-459C1A', 'App\\Models\\Order', 8, '2026-08-29 07:29:00', '2026-08-29 07:29:00'),
(48, 10, 10, '2026-10-06', 2, 'sale', -3, 88, 85, 'Sale ORD-20260926-459C1A', 'App\\Models\\Order', 8, '2026-08-29 07:29:00', '2026-08-29 07:29:00'),
(49, 14, 14, '2027-01-24', 2, 'sale', -1, 67, 66, 'Sale ORD-20260926-459C1A', 'App\\Models\\Order', 8, '2026-08-29 07:29:00', '2026-08-29 07:29:00'),
(50, 15, 15, '2027-02-23', 2, 'sale', -3, 37, 34, 'Sale ORD-20260926-516616', 'App\\Models\\Order', 9, '2026-08-29 11:23:00', '2026-08-29 11:23:00'),
(51, 23, 22, '2026-10-26', 2, 'sale', -2, 45, 43, 'Sale ORD-20260926-516616', 'App\\Models\\Order', 9, '2026-08-29 11:23:00', '2026-08-29 11:23:00'),
(52, 3, 3, '2026-10-17', 1, 'sale', -1, 37, 36, 'Sale ORD-20260926-0A99B7', 'App\\Models\\Order', 10, '2026-08-29 03:08:00', '2026-08-29 03:08:00'),
(53, 11, 11, '2026-10-10', 1, 'sale', -1, 23, 22, 'Sale ORD-20260926-0A99B7', 'App\\Models\\Order', 10, '2026-08-29 03:08:00', '2026-08-29 03:08:00'),
(54, 7, 7, '2026-10-01', 1, 'sale', -1, 30, 29, 'Sale ORD-20260926-CB252D', 'App\\Models\\Order', 11, '2026-08-29 08:57:00', '2026-08-29 08:57:00'),
(55, 8, 8, '2026-09-28', 1, 'sale', -3, 31, 28, 'Sale ORD-20260926-CB252D', 'App\\Models\\Order', 11, '2026-08-29 08:57:00', '2026-08-29 08:57:00'),
(56, 16, 16, '2027-06-23', 1, 'sale', -2, 55, 53, 'Sale ORD-20260926-CB252D', 'App\\Models\\Order', 11, '2026-08-29 08:57:00', '2026-08-29 08:57:00'),
(57, 19, 18, NULL, 3, 'sale', -2, 25, 23, 'Sale ORD-20260926-5100E5', 'App\\Models\\Order', 12, '2026-08-30 03:11:00', '2026-08-30 03:11:00'),
(58, 22, 21, '2026-10-02', 3, 'sale', -3, 59, 56, 'Sale ORD-20260926-5100E5', 'App\\Models\\Order', 12, '2026-08-30 03:11:00', '2026-08-30 03:11:00'),
(59, 10, 10, '2026-10-06', 2, 'sale', -2, 85, 83, 'Sale ORD-20260926-6F5618', 'App\\Models\\Order', 13, '2026-08-30 03:23:00', '2026-08-30 03:23:00'),
(60, 20, 19, NULL, 2, 'sale', -1, 16, 15, 'Sale ORD-20260926-6F5618', 'App\\Models\\Order', 13, '2026-08-30 03:23:00', '2026-08-30 03:23:00'),
(61, 5, 5, '2027-03-25', 1, 'sale', -3, 15, 12, 'Sale ORD-20260926-9DBD9B', 'App\\Models\\Order', 14, '2026-08-30 07:12:00', '2026-08-30 07:12:00'),
(62, 7, 7, '2026-10-01', 1, 'sale', -2, 29, 27, 'Sale ORD-20260926-9DBD9B', 'App\\Models\\Order', 14, '2026-08-30 07:12:00', '2026-08-30 07:12:00'),
(63, 1, 1, NULL, 1, 'sale', -3, 114, 111, 'Sale ORD-20260926-FA62BF', 'App\\Models\\Order', 15, '2026-08-30 06:53:00', '2026-08-30 06:53:00'),
(64, 2, 2, NULL, 1, 'sale', -3, 62, 59, 'Sale ORD-20260926-FA62BF', 'App\\Models\\Order', 15, '2026-08-30 06:53:00', '2026-08-30 06:53:00'),
(65, 12, 12, '2026-11-10', 1, 'sale', -1, 18, 17, 'Sale ORD-20260926-FA62BF', 'App\\Models\\Order', 15, '2026-08-30 06:53:00', '2026-08-30 06:53:00'),
(66, 22, 21, '2026-10-02', 1, 'sale', -1, 56, 55, 'Sale ORD-20260926-FA62BF', 'App\\Models\\Order', 15, '2026-08-30 06:53:00', '2026-08-30 06:53:00'),
(67, 23, 22, '2026-10-26', 1, 'sale', -3, 43, 40, 'Sale ORD-20260926-FA62BF', 'App\\Models\\Order', 15, '2026-08-30 06:53:00', '2026-08-30 06:53:00'),
(68, 16, 16, '2027-06-23', 2, 'sale', -3, 53, 50, 'Sale ORD-20260926-169BC7', 'App\\Models\\Order', 16, '2026-08-30 07:28:00', '2026-08-30 07:28:00'),
(69, 23, 22, '2026-10-26', 2, 'sale', -3, 40, 37, 'Sale ORD-20260926-169BC7', 'App\\Models\\Order', 16, '2026-08-30 07:28:00', '2026-08-30 07:28:00'),
(70, 1, 1, NULL, 3, 'sale', -1, 111, 110, 'Sale ORD-20260926-FF8F87', 'App\\Models\\Order', 17, '2026-08-30 02:49:00', '2026-08-30 02:49:00'),
(71, 3, 3, '2026-10-17', 3, 'sale', -2, 36, 34, 'Sale ORD-20260926-FF8F87', 'App\\Models\\Order', 17, '2026-08-30 02:49:00', '2026-08-30 02:49:00'),
(72, 8, 8, '2026-09-28', 3, 'sale', -3, 28, 25, 'Sale ORD-20260926-FF8F87', 'App\\Models\\Order', 17, '2026-08-30 02:49:00', '2026-08-30 02:49:00'),
(73, 23, 22, '2026-10-26', 3, 'sale', -1, 37, 36, 'Sale ORD-20260926-FF8F87', 'App\\Models\\Order', 17, '2026-08-30 02:49:00', '2026-08-30 02:49:00'),
(74, 24, 23, '2026-10-03', 3, 'sale', -2, 24, 22, 'Sale ORD-20260926-FF8F87', 'App\\Models\\Order', 17, '2026-08-30 02:49:00', '2026-08-30 02:49:00'),
(75, 7, 7, '2026-10-01', 2, 'sale', -2, 27, 25, 'Sale ORD-20260926-BE7BF8', 'App\\Models\\Order', 18, '2026-08-30 09:53:00', '2026-08-30 09:53:00'),
(76, 11, 11, '2026-10-10', 2, 'sale', -1, 22, 21, 'Sale ORD-20260926-BE7BF8', 'App\\Models\\Order', 18, '2026-08-30 09:53:00', '2026-08-30 09:53:00'),
(77, 15, 15, '2027-02-23', 2, 'sale', -3, 34, 31, 'Sale ORD-20260926-BE7BF8', 'App\\Models\\Order', 18, '2026-08-30 09:53:00', '2026-08-30 09:53:00'),
(78, 6, 6, '2026-09-30', 2, 'sale', -3, 45, 42, 'Sale ORD-20260926-64BDC9', 'App\\Models\\Order', 19, '2026-08-30 10:39:00', '2026-08-30 10:39:00'),
(79, 8, 8, '2026-09-28', 2, 'sale', -3, 25, 22, 'Sale ORD-20260926-64BDC9', 'App\\Models\\Order', 19, '2026-08-30 10:39:00', '2026-08-30 10:39:00'),
(80, 24, 23, '2026-10-03', 2, 'sale', -3, 22, 19, 'Sale ORD-20260926-64BDC9', 'App\\Models\\Order', 19, '2026-08-30 10:39:00', '2026-08-30 10:39:00'),
(81, 16, 16, '2027-06-23', 1, 'sale', -1, 50, 49, 'Sale ORD-20260926-145B3A', 'App\\Models\\Order', 20, '2026-08-30 03:00:00', '2026-08-30 03:00:00'),
(82, 11, 11, '2026-10-10', 1, 'sale', -3, 21, 18, 'Sale ORD-20260926-931453', 'App\\Models\\Order', 21, '2026-08-31 07:41:00', '2026-08-31 07:41:00'),
(83, 18, 17, NULL, 1, 'sale', -1, 30, 29, 'Sale ORD-20260926-931453', 'App\\Models\\Order', 21, '2026-08-31 07:41:00', '2026-08-31 07:41:00'),
(84, 23, 22, '2026-10-26', 1, 'sale', -1, 36, 35, 'Sale ORD-20260926-931453', 'App\\Models\\Order', 21, '2026-08-31 07:41:00', '2026-08-31 07:41:00'),
(85, 1, 1, NULL, 1, 'sale', -1, 110, 109, 'Sale ORD-20260926-670CE0', 'App\\Models\\Order', 22, '2026-08-31 08:56:00', '2026-08-31 08:56:00'),
(86, 5, 5, '2027-03-25', 1, 'sale', -1, 12, 11, 'Sale ORD-20260926-670CE0', 'App\\Models\\Order', 22, '2026-08-31 08:56:00', '2026-08-31 08:56:00'),
(87, 6, 6, '2026-09-30', 1, 'sale', -1, 42, 41, 'Sale ORD-20260926-670CE0', 'App\\Models\\Order', 22, '2026-08-31 08:56:00', '2026-08-31 08:56:00'),
(88, 8, 8, '2026-09-28', 1, 'sale', -2, 22, 20, 'Sale ORD-20260926-670CE0', 'App\\Models\\Order', 22, '2026-08-31 08:56:00', '2026-08-31 08:56:00'),
(89, 21, 20, NULL, 1, 'sale', -2, 12, 10, 'Sale ORD-20260926-670CE0', 'App\\Models\\Order', 22, '2026-08-31 08:56:00', '2026-08-31 08:56:00'),
(90, 16, 16, '2027-06-23', 1, 'sale', -1, 49, 48, 'Sale ORD-20260926-37EDA9', 'App\\Models\\Order', 23, '2026-08-31 05:56:00', '2026-08-31 05:56:00'),
(91, 1, 1, NULL, 2, 'sale', -2, 109, 107, 'Sale ORD-20260926-2CC057', 'App\\Models\\Order', 24, '2026-09-01 09:41:00', '2026-09-01 09:41:00'),
(92, 7, 7, '2026-10-01', 2, 'sale', -2, 25, 23, 'Sale ORD-20260926-2CC057', 'App\\Models\\Order', 24, '2026-09-01 09:41:00', '2026-09-01 09:41:00'),
(93, 2, 2, NULL, 2, 'sale', -1, 59, 58, 'Sale ORD-20260926-99724A', 'App\\Models\\Order', 25, '2026-09-01 07:56:00', '2026-09-01 07:56:00'),
(94, 20, 19, NULL, 2, 'sale', -1, 15, 14, 'Sale ORD-20260926-99724A', 'App\\Models\\Order', 25, '2026-09-01 07:56:00', '2026-09-01 07:56:00'),
(95, 11, 11, '2026-10-10', 2, 'sale', -1, 18, 17, 'Sale ORD-20260926-D85D4D', 'App\\Models\\Order', 26, '2026-09-01 06:55:00', '2026-09-01 06:55:00'),
(96, 7, 7, '2026-10-01', 3, 'sale', -3, 23, 20, 'Sale ORD-20260926-5838DF', 'App\\Models\\Order', 27, '2026-09-02 05:25:00', '2026-09-02 05:25:00'),
(97, 3, 3, '2026-10-17', 1, 'sale', -1, 34, 33, 'Sale ORD-20260926-52EEDB', 'App\\Models\\Order', 28, '2026-09-02 05:52:00', '2026-09-02 05:52:00'),
(98, 22, 21, '2026-10-02', 1, 'sale', -2, 55, 53, 'Sale ORD-20260926-52EEDB', 'App\\Models\\Order', 28, '2026-09-02 05:52:00', '2026-09-02 05:52:00'),
(99, 8, 8, '2026-09-28', 1, 'sale', -2, 20, 18, 'Sale ORD-20260926-862932', 'App\\Models\\Order', 29, '2026-09-02 11:10:00', '2026-09-02 11:10:00'),
(100, 14, 14, '2027-01-24', 1, 'sale', -2, 66, 64, 'Sale ORD-20260926-862932', 'App\\Models\\Order', 29, '2026-09-02 11:10:00', '2026-09-02 11:10:00'),
(101, 1, 1, NULL, 1, 'sale', -2, 107, 105, 'Sale ORD-20260926-F7387B', 'App\\Models\\Order', 30, '2026-09-02 08:52:00', '2026-09-02 08:52:00'),
(102, 2, 2, NULL, 1, 'sale', -1, 58, 57, 'Sale ORD-20260926-F7387B', 'App\\Models\\Order', 30, '2026-09-02 08:52:00', '2026-09-02 08:52:00'),
(103, 22, 21, '2026-10-02', 1, 'sale', -1, 53, 52, 'Sale ORD-20260926-F7387B', 'App\\Models\\Order', 30, '2026-09-02 08:52:00', '2026-09-02 08:52:00'),
(104, 1, 1, NULL, 3, 'sale', -1, 105, 104, 'Sale ORD-20260926-4C491D', 'App\\Models\\Order', 31, '2026-09-02 08:32:00', '2026-09-02 08:32:00'),
(105, 2, 2, NULL, 3, 'sale', -2, 57, 55, 'Sale ORD-20260926-4C491D', 'App\\Models\\Order', 31, '2026-09-02 08:32:00', '2026-09-02 08:32:00'),
(106, 5, 5, '2027-03-25', 3, 'sale', -3, 11, 8, 'Sale ORD-20260926-4C491D', 'App\\Models\\Order', 31, '2026-09-02 08:32:00', '2026-09-02 08:32:00'),
(107, 14, 14, '2027-01-24', 3, 'sale', -2, 64, 62, 'Sale ORD-20260926-4C491D', 'App\\Models\\Order', 31, '2026-09-02 08:32:00', '2026-09-02 08:32:00'),
(108, 7, 7, '2026-10-01', 2, 'sale', -1, 20, 19, 'Sale ORD-20260926-4E2AD3', 'App\\Models\\Order', 32, '2026-09-03 09:57:00', '2026-09-03 09:57:00'),
(109, 15, 15, '2027-02-23', 2, 'sale', -1, 31, 30, 'Sale ORD-20260926-4E2AD3', 'App\\Models\\Order', 32, '2026-09-03 09:57:00', '2026-09-03 09:57:00'),
(110, 16, 16, '2027-06-23', 2, 'sale', -2, 48, 46, 'Sale ORD-20260926-4E2AD3', 'App\\Models\\Order', 32, '2026-09-03 09:57:00', '2026-09-03 09:57:00'),
(111, 20, 19, NULL, 2, 'sale', -1, 14, 13, 'Sale ORD-20260926-4E2AD3', 'App\\Models\\Order', 32, '2026-09-03 09:57:00', '2026-09-03 09:57:00'),
(112, 23, 22, '2026-10-26', 2, 'sale', -3, 35, 32, 'Sale ORD-20260926-4E2AD3', 'App\\Models\\Order', 32, '2026-09-03 09:57:00', '2026-09-03 09:57:00'),
(113, 3, 3, '2026-10-17', 2, 'sale', -2, 33, 31, 'Sale ORD-20260926-55041B', 'App\\Models\\Order', 33, '2026-09-03 12:05:00', '2026-09-03 12:05:00'),
(114, 8, 8, '2026-09-28', 2, 'sale', -3, 18, 15, 'Sale ORD-20260926-55041B', 'App\\Models\\Order', 33, '2026-09-03 12:05:00', '2026-09-03 12:05:00'),
(115, 21, 20, NULL, 2, 'sale', -3, 10, 7, 'Sale ORD-20260926-55041B', 'App\\Models\\Order', 33, '2026-09-03 12:05:00', '2026-09-03 12:05:00'),
(116, 23, 22, '2026-10-26', 2, 'sale', -2, 32, 30, 'Sale ORD-20260926-55041B', 'App\\Models\\Order', 33, '2026-09-03 12:05:00', '2026-09-03 12:05:00'),
(117, 24, 23, '2026-10-03', 2, 'sale', -3, 19, 16, 'Sale ORD-20260926-55041B', 'App\\Models\\Order', 33, '2026-09-03 12:05:00', '2026-09-03 12:05:00'),
(118, 2, 2, NULL, 2, 'sale', -1, 55, 54, 'Sale ORD-20260926-9459D0', 'App\\Models\\Order', 34, '2026-09-03 10:14:00', '2026-09-03 10:14:00'),
(119, 9, 9, '2026-09-29', 2, 'sale', -1, 8, 7, 'Sale ORD-20260926-9459D0', 'App\\Models\\Order', 34, '2026-09-03 10:14:00', '2026-09-03 10:14:00'),
(120, 11, 11, '2026-10-10', 2, 'sale', -1, 17, 16, 'Sale ORD-20260926-26B27A', 'App\\Models\\Order', 35, '2026-09-03 01:03:00', '2026-09-03 01:03:00'),
(121, 14, 14, '2027-01-24', 2, 'sale', -3, 62, 59, 'Sale ORD-20260926-26B27A', 'App\\Models\\Order', 35, '2026-09-03 01:03:00', '2026-09-03 01:03:00'),
(122, 21, 20, NULL, 2, 'sale', -2, 7, 5, 'Sale ORD-20260926-26B27A', 'App\\Models\\Order', 35, '2026-09-03 01:03:00', '2026-09-03 01:03:00'),
(123, 22, 21, '2026-10-02', 2, 'sale', -3, 52, 49, 'Sale ORD-20260926-26B27A', 'App\\Models\\Order', 35, '2026-09-03 01:03:00', '2026-09-03 01:03:00'),
(124, 4, 4, NULL, 3, 'sale', -1, 200, 199, 'Sale ORD-20260926-493752', 'App\\Models\\Order', 36, '2026-09-03 04:20:00', '2026-09-03 04:20:00'),
(125, 14, 14, '2027-01-24', 3, 'sale', -1, 59, 58, 'Sale ORD-20260926-493752', 'App\\Models\\Order', 36, '2026-09-03 04:20:00', '2026-09-03 04:20:00'),
(126, 21, 20, NULL, 3, 'sale', -3, 5, 2, 'Sale ORD-20260926-493752', 'App\\Models\\Order', 36, '2026-09-03 04:20:00', '2026-09-03 04:20:00'),
(127, 15, 15, '2027-02-23', 3, 'sale', -1, 30, 29, 'Sale ORD-20260926-D898E6', 'App\\Models\\Order', 37, '2026-09-03 12:01:00', '2026-09-03 12:01:00'),
(128, 21, 20, NULL, 3, 'sale', -2, 2, 0, 'Sale ORD-20260926-D898E6', 'App\\Models\\Order', 37, '2026-09-03 12:01:00', '2026-09-03 12:01:00'),
(129, 22, 21, '2026-10-02', 3, 'sale', -2, 49, 47, 'Sale ORD-20260926-D898E6', 'App\\Models\\Order', 37, '2026-09-03 12:01:00', '2026-09-03 12:01:00'),
(130, 24, 23, '2026-10-03', 3, 'sale', -2, 16, 14, 'Sale ORD-20260926-D898E6', 'App\\Models\\Order', 37, '2026-09-03 12:01:00', '2026-09-03 12:01:00'),
(131, 9, 9, '2026-09-29', 3, 'sale', -3, 7, 4, 'Sale ORD-20260926-C4D8FE', 'App\\Models\\Order', 38, '2026-09-04 01:39:00', '2026-09-04 01:39:00'),
(132, 14, 14, '2027-01-24', 2, 'sale', -1, 58, 57, 'Sale ORD-20260926-DFF12C', 'App\\Models\\Order', 39, '2026-09-04 01:50:00', '2026-09-04 01:50:00'),
(133, 20, 19, NULL, 2, 'sale', -3, 13, 10, 'Sale ORD-20260926-DFF12C', 'App\\Models\\Order', 39, '2026-09-04 01:50:00', '2026-09-04 01:50:00'),
(134, 7, 7, '2026-10-01', 1, 'sale', -3, 19, 16, 'Sale ORD-20260926-CB22ED', 'App\\Models\\Order', 40, '2026-09-05 01:18:00', '2026-09-05 01:18:00'),
(135, 9, 9, '2026-09-29', 1, 'sale', -1, 4, 3, 'Sale ORD-20260926-CB22ED', 'App\\Models\\Order', 40, '2026-09-05 01:18:00', '2026-09-05 01:18:00'),
(136, 16, 16, '2027-06-23', 1, 'sale', -1, 46, 45, 'Sale ORD-20260926-CB22ED', 'App\\Models\\Order', 40, '2026-09-05 01:18:00', '2026-09-05 01:18:00'),
(137, 5, 5, '2027-03-25', 3, 'sale', -3, 8, 5, 'Sale ORD-20260926-BF6C05', 'App\\Models\\Order', 41, '2026-09-05 07:19:00', '2026-09-05 07:19:00'),
(138, 9, 9, '2026-09-29', 3, 'sale', -3, 3, 0, 'Sale ORD-20260926-BF6C05', 'App\\Models\\Order', 41, '2026-09-05 07:19:00', '2026-09-05 07:19:00'),
(139, 10, 10, '2026-10-06', 3, 'sale', -3, 83, 80, 'Sale ORD-20260926-BF6C05', 'App\\Models\\Order', 41, '2026-09-05 07:19:00', '2026-09-05 07:19:00'),
(140, 20, 19, NULL, 3, 'sale', -2, 10, 8, 'Sale ORD-20260926-BF6C05', 'App\\Models\\Order', 41, '2026-09-05 07:19:00', '2026-09-05 07:19:00'),
(141, 10, 10, '2026-10-06', 3, 'sale', -3, 80, 77, 'Sale ORD-20260926-1EF1A4', 'App\\Models\\Order', 42, '2026-09-06 05:16:00', '2026-09-06 05:16:00'),
(142, 5, 5, '2027-03-25', 2, 'sale', -3, 5, 2, 'Sale ORD-20260926-9A226F', 'App\\Models\\Order', 43, '2026-09-06 09:47:00', '2026-09-06 09:47:00'),
(143, 8, 8, '2026-09-28', 2, 'sale', -3, 15, 12, 'Sale ORD-20260926-9A226F', 'App\\Models\\Order', 43, '2026-09-06 09:47:00', '2026-09-06 09:47:00'),
(144, 15, 15, '2027-02-23', 2, 'sale', -1, 29, 28, 'Sale ORD-20260926-9A226F', 'App\\Models\\Order', 43, '2026-09-06 09:47:00', '2026-09-06 09:47:00'),
(145, 18, 17, NULL, 3, 'sale', -3, 29, 26, 'Sale ORD-20260926-1F2AB6', 'App\\Models\\Order', 44, '2026-09-06 06:54:00', '2026-09-06 06:54:00'),
(146, 12, 12, '2026-11-10', 3, 'sale', -1, 17, 16, 'Sale ORD-20260926-0D98E2', 'App\\Models\\Order', 45, '2026-09-06 05:02:00', '2026-09-06 05:02:00'),
(147, 1, 1, NULL, 2, 'sale', -3, 104, 101, 'Sale ORD-20260926-F0EF6E', 'App\\Models\\Order', 46, '2026-09-06 09:33:00', '2026-09-06 09:33:00'),
(148, 5, 5, '2027-03-25', 2, 'sale', -1, 2, 1, 'Sale ORD-20260926-F0EF6E', 'App\\Models\\Order', 46, '2026-09-06 09:33:00', '2026-09-06 09:33:00'),
(149, 24, 23, '2026-10-03', 2, 'sale', -2, 14, 12, 'Sale ORD-20260926-F0EF6E', 'App\\Models\\Order', 46, '2026-09-06 09:33:00', '2026-09-06 09:33:00'),
(150, 2, 2, NULL, 2, 'sale', -1, 54, 53, 'Sale ORD-20260926-3C455A', 'App\\Models\\Order', 47, '2026-09-06 02:34:00', '2026-09-06 02:34:00'),
(151, 11, 11, '2026-10-10', 3, 'sale', -1, 16, 15, 'Sale ORD-20260926-F8D598', 'App\\Models\\Order', 48, '2026-09-06 03:32:00', '2026-09-06 03:32:00'),
(152, 3, 3, '2026-10-17', 3, 'sale', -3, 31, 28, 'Sale ORD-20260926-C69303', 'App\\Models\\Order', 49, '2026-09-07 03:21:00', '2026-09-07 03:21:00'),
(153, 7, 7, '2026-10-01', 3, 'sale', -2, 16, 14, 'Sale ORD-20260926-C69303', 'App\\Models\\Order', 49, '2026-09-07 03:21:00', '2026-09-07 03:21:00'),
(154, 15, 15, '2027-02-23', 3, 'sale', -3, 28, 25, 'Sale ORD-20260926-C69303', 'App\\Models\\Order', 49, '2026-09-07 03:21:00', '2026-09-07 03:21:00'),
(155, 23, 22, '2026-10-26', 3, 'sale', -1, 30, 29, 'Sale ORD-20260926-C69303', 'App\\Models\\Order', 49, '2026-09-07 03:21:00', '2026-09-07 03:21:00'),
(156, 2, 2, NULL, 3, 'sale', -2, 53, 51, 'Sale ORD-20260926-09D3F6', 'App\\Models\\Order', 50, '2026-09-07 05:05:00', '2026-09-07 05:05:00'),
(157, 8, 8, '2026-09-28', 3, 'sale', -2, 12, 10, 'Sale ORD-20260926-09D3F6', 'App\\Models\\Order', 50, '2026-09-07 05:05:00', '2026-09-07 05:05:00'),
(158, 18, 17, NULL, 3, 'sale', -2, 26, 24, 'Sale ORD-20260926-09D3F6', 'App\\Models\\Order', 50, '2026-09-07 05:05:00', '2026-09-07 05:05:00'),
(159, 10, 10, '2026-10-06', 1, 'sale', -3, 77, 74, 'Sale ORD-20260926-060161', 'App\\Models\\Order', 51, '2026-09-08 09:34:00', '2026-09-08 09:34:00'),
(160, 15, 15, '2027-02-23', 1, 'sale', -2, 25, 23, 'Sale ORD-20260926-060161', 'App\\Models\\Order', 51, '2026-09-08 09:34:00', '2026-09-08 09:34:00'),
(161, 20, 19, NULL, 1, 'sale', -3, 8, 5, 'Sale ORD-20260926-060161', 'App\\Models\\Order', 51, '2026-09-08 09:34:00', '2026-09-08 09:34:00'),
(162, 10, 10, '2026-10-06', 1, 'sale', -2, 74, 72, 'Sale ORD-20260926-5D67AB', 'App\\Models\\Order', 52, '2026-09-08 05:44:00', '2026-09-08 05:44:00'),
(163, 12, 12, '2026-11-10', 1, 'sale', -2, 16, 14, 'Sale ORD-20260926-5D67AB', 'App\\Models\\Order', 52, '2026-09-08 05:44:00', '2026-09-08 05:44:00'),
(164, 16, 16, '2027-06-23', 1, 'sale', -2, 45, 43, 'Sale ORD-20260926-5D67AB', 'App\\Models\\Order', 52, '2026-09-08 05:44:00', '2026-09-08 05:44:00'),
(165, 22, 21, '2026-10-02', 1, 'sale', -3, 47, 44, 'Sale ORD-20260926-5D67AB', 'App\\Models\\Order', 52, '2026-09-08 05:44:00', '2026-09-08 05:44:00'),
(166, 23, 22, '2026-10-26', 1, 'sale', -2, 29, 27, 'Sale ORD-20260926-5D67AB', 'App\\Models\\Order', 52, '2026-09-08 05:44:00', '2026-09-08 05:44:00'),
(167, 5, 5, '2027-03-25', 3, 'sale', -1, 1, 0, 'Sale ORD-20260926-DF6822', 'App\\Models\\Order', 53, '2026-09-08 08:25:00', '2026-09-08 08:25:00'),
(168, 12, 12, '2026-11-10', 3, 'sale', -3, 14, 11, 'Sale ORD-20260926-DF6822', 'App\\Models\\Order', 53, '2026-09-08 08:25:00', '2026-09-08 08:25:00'),
(169, 24, 23, '2026-10-03', 3, 'sale', -3, 12, 9, 'Sale ORD-20260926-DF6822', 'App\\Models\\Order', 53, '2026-09-08 08:25:00', '2026-09-08 08:25:00'),
(170, 2, 2, NULL, 3, 'sale', -2, 51, 49, 'Sale ORD-20260926-6B19B2', 'App\\Models\\Order', 54, '2026-09-08 12:04:00', '2026-09-08 12:04:00'),
(171, 3, 3, '2026-10-17', 3, 'sale', -1, 28, 27, 'Sale ORD-20260926-6B19B2', 'App\\Models\\Order', 54, '2026-09-08 12:04:00', '2026-09-08 12:04:00'),
(172, 8, 8, '2026-09-28', 3, 'sale', -3, 10, 7, 'Sale ORD-20260926-87F69A', 'App\\Models\\Order', 55, '2026-09-09 01:06:00', '2026-09-09 01:06:00'),
(173, 1, 1, NULL, 1, 'sale', -2, 101, 99, 'Sale ORD-20260926-AC6EF3', 'App\\Models\\Order', 56, '2026-09-09 06:47:00', '2026-09-09 06:47:00'),
(174, 14, 14, '2027-01-24', 1, 'sale', -3, 57, 54, 'Sale ORD-20260926-AC6EF3', 'App\\Models\\Order', 56, '2026-09-09 06:47:00', '2026-09-09 06:47:00'),
(175, 22, 21, '2026-10-02', 1, 'sale', -1, 44, 43, 'Sale ORD-20260926-AC6EF3', 'App\\Models\\Order', 56, '2026-09-09 06:47:00', '2026-09-09 06:47:00'),
(176, 3, 3, '2026-10-17', 2, 'sale', -1, 27, 26, 'Sale ORD-20260926-27D751', 'App\\Models\\Order', 57, '2026-09-10 10:23:00', '2026-09-10 10:23:00'),
(177, 6, 6, '2026-09-30', 2, 'sale', -1, 41, 40, 'Sale ORD-20260926-27D751', 'App\\Models\\Order', 57, '2026-09-10 10:23:00', '2026-09-10 10:23:00'),
(178, 7, 7, '2026-10-01', 2, 'sale', -3, 14, 11, 'Sale ORD-20260926-8F4E2A', 'App\\Models\\Order', 58, '2026-09-10 04:36:00', '2026-09-10 04:36:00'),
(179, 12, 12, '2026-11-10', 2, 'sale', -1, 11, 10, 'Sale ORD-20260926-8F4E2A', 'App\\Models\\Order', 58, '2026-09-10 04:36:00', '2026-09-10 04:36:00'),
(180, 22, 21, '2026-10-02', 2, 'sale', -2, 43, 41, 'Sale ORD-20260926-8F4E2A', 'App\\Models\\Order', 58, '2026-09-10 04:36:00', '2026-09-10 04:36:00'),
(181, 23, 22, '2026-10-26', 3, 'sale', -3, 27, 24, 'Sale ORD-20260926-DD4A7E', 'App\\Models\\Order', 59, '2026-09-11 09:09:00', '2026-09-11 09:09:00'),
(182, 11, 11, '2026-10-10', 2, 'sale', -1, 15, 14, 'Sale ORD-20260926-ABF033', 'App\\Models\\Order', 60, '2026-09-11 11:56:00', '2026-09-11 11:56:00'),
(183, 16, 16, '2027-06-23', 2, 'sale', -3, 43, 40, 'Sale ORD-20260926-ABF033', 'App\\Models\\Order', 60, '2026-09-11 11:56:00', '2026-09-11 11:56:00'),
(184, 2, 2, NULL, 1, 'sale', -1, 49, 48, 'Sale ORD-20260926-B6A713', 'App\\Models\\Order', 61, '2026-09-12 05:52:00', '2026-09-12 05:52:00'),
(185, 3, 3, '2026-10-17', 1, 'sale', -1, 26, 25, 'Sale ORD-20260926-B6A713', 'App\\Models\\Order', 61, '2026-09-12 05:52:00', '2026-09-12 05:52:00'),
(186, 10, 10, '2026-10-06', 1, 'sale', -1, 72, 71, 'Sale ORD-20260926-B6A713', 'App\\Models\\Order', 61, '2026-09-12 05:52:00', '2026-09-12 05:52:00'),
(187, 18, 17, NULL, 1, 'sale', -3, 24, 21, 'Sale ORD-20260926-B6A713', 'App\\Models\\Order', 61, '2026-09-12 05:52:00', '2026-09-12 05:52:00'),
(188, 23, 22, '2026-10-26', 1, 'sale', -2, 24, 22, 'Sale ORD-20260926-B6A713', 'App\\Models\\Order', 61, '2026-09-12 05:52:00', '2026-09-12 05:52:00'),
(189, 22, 21, '2026-10-02', 1, 'sale', -3, 41, 38, 'Sale ORD-20260926-E73F25', 'App\\Models\\Order', 62, '2026-09-12 06:22:00', '2026-09-12 06:22:00'),
(190, 3, 3, '2026-10-17', 1, 'sale', -2, 25, 23, 'Sale ORD-20260926-23E8D3', 'App\\Models\\Order', 63, '2026-09-13 04:09:00', '2026-09-13 04:09:00'),
(191, 4, 4, NULL, 1, 'sale', -3, 199, 196, 'Sale ORD-20260926-23E8D3', 'App\\Models\\Order', 63, '2026-09-13 04:09:00', '2026-09-13 04:09:00'),
(192, 7, 7, '2026-10-01', 1, 'sale', -3, 11, 8, 'Sale ORD-20260926-23E8D3', 'App\\Models\\Order', 63, '2026-09-13 04:09:00', '2026-09-13 04:09:00'),
(193, 24, 23, '2026-10-03', 1, 'sale', -3, 9, 6, 'Sale ORD-20260926-23E8D3', 'App\\Models\\Order', 63, '2026-09-13 04:09:00', '2026-09-13 04:09:00'),
(194, 8, 8, '2026-09-28', 3, 'sale', -2, 7, 5, 'Sale ORD-20260926-B96597', 'App\\Models\\Order', 64, '2026-09-13 10:03:00', '2026-09-13 10:03:00'),
(195, 16, 16, '2027-06-23', 3, 'sale', -1, 40, 39, 'Sale ORD-20260926-B96597', 'App\\Models\\Order', 64, '2026-09-13 10:03:00', '2026-09-13 10:03:00'),
(196, 22, 21, '2026-10-02', 3, 'sale', -1, 38, 37, 'Sale ORD-20260926-B96597', 'App\\Models\\Order', 64, '2026-09-13 10:03:00', '2026-09-13 10:03:00'),
(197, 24, 23, '2026-10-03', 3, 'sale', -1, 6, 5, 'Sale ORD-20260926-B96597', 'App\\Models\\Order', 64, '2026-09-13 10:03:00', '2026-09-13 10:03:00'),
(198, 8, 8, '2026-09-28', 3, 'sale', -2, 5, 3, 'Sale ORD-20260926-532E03', 'App\\Models\\Order', 65, '2026-09-14 10:07:00', '2026-09-14 10:07:00'),
(199, 14, 14, '2027-01-24', 3, 'sale', -3, 54, 51, 'Sale ORD-20260926-532E03', 'App\\Models\\Order', 65, '2026-09-14 10:07:00', '2026-09-14 10:07:00'),
(200, 15, 15, '2027-02-23', 3, 'sale', -1, 23, 22, 'Sale ORD-20260926-532E03', 'App\\Models\\Order', 65, '2026-09-14 10:07:00', '2026-09-14 10:07:00'),
(201, 11, 11, '2026-10-10', 2, 'sale', -1, 14, 13, 'Sale ORD-20260926-E4ED4D', 'App\\Models\\Order', 66, '2026-09-14 03:40:00', '2026-09-14 03:40:00'),
(202, 1, 1, NULL, 1, 'sale', -1, 99, 98, 'Sale ORD-20260926-ED6FB8', 'App\\Models\\Order', 67, '2026-09-14 06:56:00', '2026-09-14 06:56:00'),
(203, 4, 4, NULL, 1, 'sale', -1, 196, 195, 'Sale ORD-20260926-ED6FB8', 'App\\Models\\Order', 67, '2026-09-14 06:56:00', '2026-09-14 06:56:00'),
(204, 2, 2, NULL, 3, 'sale', -1, 48, 47, 'Sale ORD-20260926-4090BC', 'App\\Models\\Order', 68, '2026-09-15 04:39:00', '2026-09-15 04:39:00'),
(205, 3, 3, '2026-10-17', 3, 'sale', -1, 23, 22, 'Sale ORD-20260926-4090BC', 'App\\Models\\Order', 68, '2026-09-15 04:39:00', '2026-09-15 04:39:00'),
(206, 20, 19, NULL, 3, 'sale', -1, 5, 4, 'Sale ORD-20260926-4090BC', 'App\\Models\\Order', 68, '2026-09-15 04:39:00', '2026-09-15 04:39:00'),
(207, 23, 22, '2026-10-26', 3, 'sale', -3, 22, 19, 'Sale ORD-20260926-4090BC', 'App\\Models\\Order', 68, '2026-09-15 04:39:00', '2026-09-15 04:39:00'),
(208, 16, 16, '2027-06-23', 1, 'sale', -2, 39, 37, 'Sale ORD-20260926-CAE4BF', 'App\\Models\\Order', 69, '2026-09-15 01:14:00', '2026-09-15 01:14:00'),
(209, 20, 19, NULL, 1, 'sale', -1, 4, 3, 'Sale ORD-20260926-CAE4BF', 'App\\Models\\Order', 69, '2026-09-15 01:14:00', '2026-09-15 01:14:00'),
(210, 2, 2, NULL, 2, 'sale', -3, 47, 44, 'Sale ORD-20260926-27C0D1', 'App\\Models\\Order', 70, '2026-09-15 10:10:00', '2026-09-15 10:10:00'),
(211, 18, 17, NULL, 2, 'sale', -3, 21, 18, 'Sale ORD-20260926-27C0D1', 'App\\Models\\Order', 70, '2026-09-15 10:10:00', '2026-09-15 10:10:00'),
(212, 20, 19, NULL, 1, 'sale', -2, 3, 1, 'Sale ORD-20260926-610276', 'App\\Models\\Order', 71, '2026-09-15 03:14:00', '2026-09-15 03:14:00'),
(213, 1, 1, NULL, 3, 'sale', -1, 98, 97, 'Sale ORD-20260926-E8D659', 'App\\Models\\Order', 72, '2026-09-16 03:59:00', '2026-09-16 03:59:00'),
(214, 4, 4, NULL, 3, 'sale', -3, 195, 192, 'Sale ORD-20260926-E8D659', 'App\\Models\\Order', 72, '2026-09-16 03:59:00', '2026-09-16 03:59:00'),
(215, 7, 7, '2026-10-01', 3, 'sale', -2, 8, 6, 'Sale ORD-20260926-E8D659', 'App\\Models\\Order', 72, '2026-09-16 03:59:00', '2026-09-16 03:59:00'),
(216, 8, 8, '2026-09-28', 3, 'sale', -1, 3, 2, 'Sale ORD-20260926-E8D659', 'App\\Models\\Order', 72, '2026-09-16 03:59:00', '2026-09-16 03:59:00'),
(217, 24, 23, '2026-10-03', 3, 'sale', -3, 5, 2, 'Sale ORD-20260926-E8D659', 'App\\Models\\Order', 72, '2026-09-16 03:59:00', '2026-09-16 03:59:00'),
(218, 3, 3, '2026-10-17', 1, 'sale', -2, 22, 20, 'Sale ORD-20260926-60F8C2', 'App\\Models\\Order', 73, '2026-09-16 07:33:00', '2026-09-16 07:33:00'),
(219, 6, 6, '2026-09-30', 1, 'sale', -1, 40, 39, 'Sale ORD-20260926-60F8C2', 'App\\Models\\Order', 73, '2026-09-16 07:33:00', '2026-09-16 07:33:00'),
(220, 19, 18, NULL, 1, 'sale', -1, 23, 22, 'Sale ORD-20260926-60F8C2', 'App\\Models\\Order', 73, '2026-09-16 07:33:00', '2026-09-16 07:33:00'),
(221, 20, 19, NULL, 1, 'sale', -1, 1, 0, 'Sale ORD-20260926-EC4223', 'App\\Models\\Order', 74, '2026-09-16 07:55:00', '2026-09-16 07:55:00'),
(222, 2, 2, NULL, 2, 'sale', -1, 44, 43, 'Sale ORD-20260926-86E179', 'App\\Models\\Order', 75, '2026-09-16 01:34:00', '2026-09-16 01:34:00'),
(223, 4, 4, NULL, 2, 'sale', -2, 192, 190, 'Sale ORD-20260926-2A6357', 'App\\Models\\Order', 76, '2026-09-17 08:57:00', '2026-09-17 08:57:00'),
(224, 6, 6, '2026-09-30', 2, 'sale', -2, 39, 37, 'Sale ORD-20260926-2A6357', 'App\\Models\\Order', 76, '2026-09-17 08:57:00', '2026-09-17 08:57:00'),
(225, 3, 3, '2026-10-17', 3, 'sale', -1, 20, 19, 'Sale ORD-20260926-68CC76', 'App\\Models\\Order', 77, '2026-09-17 08:42:00', '2026-09-17 08:42:00'),
(226, 12, 12, '2026-11-10', 3, 'sale', -1, 10, 9, 'Sale ORD-20260926-68CC76', 'App\\Models\\Order', 77, '2026-09-17 08:42:00', '2026-09-17 08:42:00'),
(227, 18, 17, NULL, 3, 'sale', -1, 18, 17, 'Sale ORD-20260926-68CC76', 'App\\Models\\Order', 77, '2026-09-17 08:42:00', '2026-09-17 08:42:00'),
(228, 19, 18, NULL, 2, 'sale', -2, 22, 20, 'Sale ORD-20260926-12F43F', 'App\\Models\\Order', 78, '2026-09-17 06:32:00', '2026-09-17 06:32:00'),
(229, 10, 10, '2026-10-06', 3, 'sale', -2, 71, 69, 'Sale ORD-20260926-100B09', 'App\\Models\\Order', 79, '2026-09-18 07:28:00', '2026-09-18 07:28:00'),
(230, 2, 2, NULL, 1, 'sale', -1, 43, 42, 'Sale ORD-20260926-5980C4', 'App\\Models\\Order', 80, '2026-09-18 10:03:00', '2026-09-18 10:03:00'),
(231, 3, 3, '2026-10-17', 1, 'sale', -3, 19, 16, 'Sale ORD-20260926-5980C4', 'App\\Models\\Order', 80, '2026-09-18 10:03:00', '2026-09-18 10:03:00'),
(232, 10, 10, '2026-10-06', 1, 'sale', -2, 69, 67, 'Sale ORD-20260926-5980C4', 'App\\Models\\Order', 80, '2026-09-18 10:03:00', '2026-09-18 10:03:00'),
(233, 22, 21, '2026-10-02', 1, 'sale', -2, 37, 35, 'Sale ORD-20260926-5980C4', 'App\\Models\\Order', 80, '2026-09-18 10:03:00', '2026-09-18 10:03:00'),
(234, 4, 4, NULL, 3, 'sale', -1, 190, 189, 'Sale ORD-20260926-0E6C9E', 'App\\Models\\Order', 81, '2026-09-18 03:56:00', '2026-09-18 03:56:00'),
(235, 8, 8, '2026-09-28', 3, 'sale', -2, 2, 0, 'Sale ORD-20260926-0E6C9E', 'App\\Models\\Order', 81, '2026-09-18 03:56:00', '2026-09-18 03:56:00'),
(236, 10, 10, '2026-10-06', 3, 'sale', -3, 67, 64, 'Sale ORD-20260926-0E6C9E', 'App\\Models\\Order', 81, '2026-09-18 03:56:00', '2026-09-18 03:56:00'),
(237, 18, 17, NULL, 3, 'sale', -1, 17, 16, 'Sale ORD-20260926-0E6C9E', 'App\\Models\\Order', 81, '2026-09-18 03:56:00', '2026-09-18 03:56:00'),
(238, 22, 21, '2026-10-02', 1, 'sale', -2, 35, 33, 'Sale ORD-20260926-23D6B9', 'App\\Models\\Order', 82, '2026-09-19 01:24:00', '2026-09-19 01:24:00'),
(239, 6, 6, '2026-09-30', 1, 'sale', -1, 37, 36, 'Sale ORD-20260926-D7C686', 'App\\Models\\Order', 83, '2026-09-20 10:51:00', '2026-09-20 10:51:00'),
(240, 14, 14, '2027-01-24', 1, 'sale', -2, 51, 49, 'Sale ORD-20260926-D7C686', 'App\\Models\\Order', 83, '2026-09-20 10:51:00', '2026-09-20 10:51:00'),
(241, 15, 15, '2027-02-23', 1, 'sale', -2, 22, 20, 'Sale ORD-20260926-D7C686', 'App\\Models\\Order', 83, '2026-09-20 10:51:00', '2026-09-20 10:51:00'),
(242, 18, 17, NULL, 1, 'sale', -3, 16, 13, 'Sale ORD-20260926-D7C686', 'App\\Models\\Order', 83, '2026-09-20 10:51:00', '2026-09-20 10:51:00'),
(243, 6, 6, '2026-09-30', 1, 'sale', -2, 36, 34, 'Sale ORD-20260926-2B0B62', 'App\\Models\\Order', 84, '2026-09-20 12:25:00', '2026-09-20 12:25:00'),
(244, 19, 18, NULL, 1, 'sale', -1, 20, 19, 'Sale ORD-20260926-2B0B62', 'App\\Models\\Order', 84, '2026-09-20 12:25:00', '2026-09-20 12:25:00'),
(245, 14, 14, '2027-01-24', 3, 'sale', -3, 49, 46, 'Sale ORD-20260926-ECF8DD', 'App\\Models\\Order', 85, '2026-09-20 03:29:00', '2026-09-20 03:29:00'),
(246, 19, 18, NULL, 3, 'sale', -3, 19, 16, 'Sale ORD-20260926-ECF8DD', 'App\\Models\\Order', 85, '2026-09-20 03:29:00', '2026-09-20 03:29:00'),
(247, 23, 22, '2026-10-26', 3, 'sale', -3, 19, 16, 'Sale ORD-20260926-ECF8DD', 'App\\Models\\Order', 85, '2026-09-20 03:29:00', '2026-09-20 03:29:00'),
(248, 11, 11, '2026-10-10', 2, 'sale', -2, 13, 11, 'Sale ORD-20260926-E1153B', 'App\\Models\\Order', 86, '2026-09-20 05:41:00', '2026-09-20 05:41:00'),
(249, 16, 16, '2027-06-23', 2, 'sale', -2, 37, 35, 'Sale ORD-20260926-E1153B', 'App\\Models\\Order', 86, '2026-09-20 05:41:00', '2026-09-20 05:41:00'),
(250, 15, 15, '2027-02-23', 2, 'sale', -1, 20, 19, 'Sale ORD-20260926-D34AF4', 'App\\Models\\Order', 87, '2026-09-20 09:39:00', '2026-09-20 09:39:00'),
(251, 18, 17, NULL, 2, 'sale', -3, 13, 10, 'Sale ORD-20260926-D34AF4', 'App\\Models\\Order', 87, '2026-09-20 09:39:00', '2026-09-20 09:39:00'),
(252, 2, 2, NULL, 3, 'sale', -1, 42, 41, 'Sale ORD-20260926-2A3AD6', 'App\\Models\\Order', 88, '2026-09-20 02:53:00', '2026-09-20 02:53:00'),
(253, 4, 4, NULL, 3, 'sale', -1, 189, 188, 'Sale ORD-20260926-2A3AD6', 'App\\Models\\Order', 88, '2026-09-20 02:53:00', '2026-09-20 02:53:00'),
(254, 7, 7, '2026-10-01', 3, 'sale', -3, 6, 3, 'Sale ORD-20260926-2A3AD6', 'App\\Models\\Order', 88, '2026-09-20 02:53:00', '2026-09-20 02:53:00'),
(255, 19, 18, NULL, 3, 'sale', -2, 16, 14, 'Sale ORD-20260926-2A3AD6', 'App\\Models\\Order', 88, '2026-09-20 02:53:00', '2026-09-20 02:53:00'),
(256, 23, 22, '2026-10-26', 3, 'sale', -3, 16, 13, 'Sale ORD-20260926-2A3AD6', 'App\\Models\\Order', 88, '2026-09-20 02:53:00', '2026-09-20 02:53:00'),
(257, 6, 6, '2026-09-30', 1, 'sale', -2, 34, 32, 'Sale ORD-20260926-8CCB14', 'App\\Models\\Order', 89, '2026-09-20 06:27:00', '2026-09-20 06:27:00'),
(258, 12, 12, '2026-11-10', 3, 'sale', -2, 9, 7, 'Sale ORD-20260926-82C1C9', 'App\\Models\\Order', 90, '2026-09-21 07:04:00', '2026-09-21 07:04:00'),
(259, 14, 14, '2027-01-24', 3, 'sale', -2, 46, 44, 'Sale ORD-20260926-82C1C9', 'App\\Models\\Order', 90, '2026-09-21 07:04:00', '2026-09-21 07:04:00'),
(260, 4, 4, NULL, 3, 'sale', -2, 188, 186, 'Sale ORD-20260926-CB1DCD', 'App\\Models\\Order', 91, '2026-09-21 04:51:00', '2026-09-21 04:51:00'),
(261, 10, 10, '2026-10-06', 3, 'sale', -1, 64, 63, 'Sale ORD-20260926-CB1DCD', 'App\\Models\\Order', 91, '2026-09-21 04:51:00', '2026-09-21 04:51:00'),
(262, 23, 22, '2026-10-26', 3, 'sale', -1, 13, 12, 'Sale ORD-20260926-CB1DCD', 'App\\Models\\Order', 91, '2026-09-21 04:51:00', '2026-09-21 04:51:00'),
(263, 7, 7, '2026-10-01', 1, 'sale', -3, 3, 0, 'Sale ORD-20260926-028D9A', 'App\\Models\\Order', 92, '2026-09-21 06:29:00', '2026-09-21 06:29:00'),
(264, 23, 22, '2026-10-26', 3, 'sale', -2, 12, 10, 'Sale ORD-20260926-7F3B74', 'App\\Models\\Order', 93, '2026-09-22 11:03:00', '2026-09-22 11:03:00'),
(265, 15, 15, '2027-02-23', 2, 'sale', -2, 19, 17, 'Sale ORD-20260926-52A66D', 'App\\Models\\Order', 94, '2026-09-22 12:42:00', '2026-09-22 12:42:00'),
(266, 18, 17, NULL, 2, 'sale', -2, 10, 8, 'Sale ORD-20260926-52A66D', 'App\\Models\\Order', 94, '2026-09-22 12:42:00', '2026-09-22 12:42:00'),
(267, 22, 21, '2026-10-02', 2, 'sale', -1, 33, 32, 'Sale ORD-20260926-52A66D', 'App\\Models\\Order', 94, '2026-09-22 12:42:00', '2026-09-22 12:42:00'),
(268, 2, 2, NULL, 1, 'sale', -3, 41, 38, 'Sale ORD-20260926-A66063', 'App\\Models\\Order', 95, '2026-09-23 06:05:00', '2026-09-23 06:05:00'),
(269, 23, 22, '2026-10-26', 1, 'sale', -1, 10, 9, 'Sale ORD-20260926-A66063', 'App\\Models\\Order', 95, '2026-09-23 06:05:00', '2026-09-23 06:05:00'),
(270, 11, 11, '2026-10-10', 2, 'sale', -1, 11, 10, 'Sale ORD-20260926-297103', 'App\\Models\\Order', 96, '2026-09-23 03:14:00', '2026-09-23 03:14:00'),
(271, 16, 16, '2027-06-23', 2, 'sale', -1, 35, 34, 'Sale ORD-20260926-297103', 'App\\Models\\Order', 96, '2026-09-23 03:14:00', '2026-09-23 03:14:00'),
(272, 2, 2, NULL, 3, 'sale', -3, 38, 35, 'Sale ORD-20260926-884F2D', 'App\\Models\\Order', 97, '2026-09-23 10:03:00', '2026-09-23 10:03:00'),
(273, 14, 14, '2027-01-24', 3, 'sale', -3, 44, 41, 'Sale ORD-20260926-884F2D', 'App\\Models\\Order', 97, '2026-09-23 10:03:00', '2026-09-23 10:03:00'),
(274, 1, 1, NULL, 1, 'sale', -3, 97, 94, 'Sale ORD-20260926-6C1D6A', 'App\\Models\\Order', 98, '2026-09-25 06:05:00', '2026-09-25 06:05:00'),
(275, 2, 2, NULL, 1, 'sale', -3, 35, 32, 'Sale ORD-20260926-6C1D6A', 'App\\Models\\Order', 98, '2026-09-25 06:05:00', '2026-09-25 06:05:00'),
(276, 16, 16, '2027-06-23', 1, 'sale', -2, 34, 32, 'Sale ORD-20260926-6C1D6A', 'App\\Models\\Order', 98, '2026-09-25 06:05:00', '2026-09-25 06:05:00'),
(277, 23, 22, '2026-10-26', 1, 'sale', -1, 9, 8, 'Sale ORD-20260926-6C1D6A', 'App\\Models\\Order', 98, '2026-09-25 06:05:00', '2026-09-25 06:05:00'),
(278, 11, 11, '2026-10-10', 1, 'sale', -3, 10, 7, 'Sale ORD-20260926-1B7453', 'App\\Models\\Order', 99, '2026-09-26 07:37:00', '2026-09-26 07:37:00'),
(279, 2, 2, NULL, 2, 'sale', -1, 32, 31, 'Sale ORD-20260926-389313', 'App\\Models\\Order', 100, '2026-09-26 05:55:00', '2026-09-26 05:55:00'),
(280, 2, 2, NULL, 2, 'sale', -3, 31, 28, 'Sale ORD-20260926-AD973A', 'App\\Models\\Order', 101, '2026-09-26 04:20:00', '2026-09-26 04:20:00'),
(281, 12, 12, '2026-11-10', 2, 'sale', -1, 7, 6, 'Sale ORD-20260926-AD973A', 'App\\Models\\Order', 101, '2026-09-26 04:20:00', '2026-09-26 04:20:00'),
(282, 5, 25, NULL, NULL, 'adjustment', 18, 0, 18, 'Restock after demo sales', NULL, NULL, '2026-09-26 10:03:24', '2026-09-26 10:03:24'),
(283, 7, 26, NULL, NULL, 'adjustment', 30, 0, 30, 'Restock after demo sales', NULL, NULL, '2026-09-26 10:03:24', '2026-09-26 10:03:24'),
(284, 8, 27, NULL, NULL, 'adjustment', 36, 0, 36, 'Restock after demo sales', NULL, NULL, '2026-09-26 10:03:24', '2026-09-26 10:03:24'),
(285, 9, 28, NULL, NULL, 'adjustment', 30, 0, 30, 'Restock after demo sales', NULL, NULL, '2026-09-26 10:03:24', '2026-09-26 10:03:24'),
(286, 17, 29, NULL, NULL, 'adjustment', 30, 0, 30, 'Restock after demo sales', NULL, NULL, '2026-09-26 10:03:24', '2026-09-26 10:03:24'),
(287, 20, 19, NULL, NULL, 'adjustment', 18, 0, 18, 'Restock after demo sales', NULL, NULL, '2026-09-26 10:03:24', '2026-09-26 10:03:24'),
(288, 21, 20, NULL, NULL, 'adjustment', 15, 0, 15, 'Restock after demo sales', NULL, NULL, '2026-09-26 10:03:24', '2026-09-26 10:03:24'),
(289, 12, 12, '2026-11-10', NULL, 'adjustment', 1, 6, 7, 'Stock count correction', NULL, NULL, '2026-09-26 10:03:24', '2026-09-26 10:03:24'),
(290, 26, 30, '2027-05-04', 1, 'stock_in', 65, 0, 65, 'Opening stock', NULL, NULL, '2026-09-26 10:44:35', '2026-09-26 10:44:35'),
(291, 8, 27, NULL, 2, 'sale', -1, 36, 35, 'Sale ORD-20260926-A80CBF', 'App\\Models\\Order', 102, '2026-09-26 10:45:33', '2026-09-26 10:45:33'),
(292, 26, 30, '2027-05-04', 2, 'sale', -1, 65, 64, 'Sale ORD-20260926-A80CBF', 'App\\Models\\Order', 102, '2026-09-26 10:45:33', '2026-09-26 10:45:33'),
(293, 26, 30, '2027-05-04', 2, 'sale', -4, 64, 60, 'Sale ORD-20260926-F289F3', 'App\\Models\\Order', 103, '2026-09-26 10:52:37', '2026-09-26 10:52:37'),
(294, 27, 31, '2026-10-09', 1, 'stock_in', 10, 0, 10, 'Opening stock', NULL, NULL, '2026-09-26 11:00:20', '2026-09-26 11:00:20');

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2026_01_01_000100_create_categories_table', 1),
(5, '2026_01_01_000200_create_products_table', 1),
(6, '2026_01_01_000300_create_inventory_movements_table', 1),
(7, '2026_01_01_000400_create_orders_table', 1),
(8, '2026_01_01_000401_create_order_items_table', 1),
(9, '2026_01_01_000402_create_refunds_table', 1),
(10, '2026_01_01_000500_create_settings_and_audit_logs_tables', 1),
(11, '2026_01_01_000600_add_unit_cost_to_order_items_table', 1),
(12, '2026_01_01_000700_drop_sku_and_barcode_columns', 1),
(13, '2026_01_01_000800_add_image_to_products_table', 1),
(14, '2026_01_01_000900_create_product_batches_table', 1),
(15, '2026_01_01_000901_add_batch_tracking_to_inventory_movements', 1),
(16, '2026_01_01_000902_create_order_item_batches_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `order_number` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `status` enum('completed','partially_refunded','refunded','cancelled') NOT NULL DEFAULT 'completed',
  `subtotal` decimal(14,2) NOT NULL DEFAULT 0.00,
  `discount_type` enum('fixed','percentage') NOT NULL DEFAULT 'fixed',
  `discount_value` decimal(14,2) NOT NULL DEFAULT 0.00,
  `discount_amount` decimal(14,2) NOT NULL DEFAULT 0.00,
  `tax_rate` decimal(6,2) NOT NULL DEFAULT 0.00,
  `tax_amount` decimal(14,2) NOT NULL DEFAULT 0.00,
  `total` decimal(14,2) NOT NULL DEFAULT 0.00,
  `refunded_amount` decimal(14,2) NOT NULL DEFAULT 0.00,
  `paid_amount` decimal(14,2) NOT NULL DEFAULT 0.00,
  `change_amount` decimal(14,2) NOT NULL DEFAULT 0.00,
  `payment_method` enum('cash','card','mobile','other') NOT NULL DEFAULT 'cash',
  `customer_note` varchar(255) DEFAULT NULL,
  `cancelled_at` timestamp NULL DEFAULT NULL,
  `cancel_reason` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `order_number`, `user_id`, `status`, `subtotal`, `discount_type`, `discount_value`, `discount_amount`, `tax_rate`, `tax_amount`, `total`, `refunded_amount`, `paid_amount`, `change_amount`, `payment_method`, `customer_note`, `cancelled_at`, `cancel_reason`, `created_at`, `updated_at`) VALUES
(1, 'ORD-20260926-F5E0AB', 2, 'completed', 5.45, 'fixed', 2.00, 2.00, 5.00, 0.17, 3.62, 0.00, 0.00, 0.00, 'cash', NULL, NULL, NULL, '2026-08-28 02:08:00', '2026-08-28 02:08:00'),
(2, 'ORD-20260926-03D2CA', 2, 'completed', 5.50, 'fixed', 2.00, 2.00, 5.00, 0.18, 3.68, 0.00, 0.00, 0.00, 'card', NULL, NULL, NULL, '2026-08-28 05:54:00', '2026-08-28 05:54:00'),
(3, 'ORD-20260926-60692D', 2, 'completed', 13.20, 'fixed', 5.00, 5.00, 5.00, 0.41, 8.61, 0.00, 0.00, 0.00, 'cash', NULL, NULL, NULL, '2026-08-28 07:41:00', '2026-08-28 07:41:00'),
(4, 'ORD-20260926-663A49', 2, 'completed', 19.68, 'fixed', 5.00, 5.00, 5.00, 0.73, 15.41, 0.00, 0.00, 0.00, 'card', NULL, NULL, NULL, '2026-08-28 08:27:00', '2026-08-28 08:27:00'),
(5, 'ORD-20260926-939B4A', 2, 'completed', 48.00, 'fixed', 5.00, 5.00, 5.00, 2.15, 45.15, 0.00, 0.00, 0.00, 'mobile', NULL, NULL, NULL, '2026-08-28 06:34:00', '2026-08-28 06:34:00'),
(6, 'ORD-20260926-31C3E6', 3, 'completed', 13.80, 'fixed', 1.00, 1.00, 5.00, 0.64, 13.44, 0.00, 0.00, 0.00, 'mobile', NULL, NULL, NULL, '2026-08-28 10:45:00', '2026-08-28 10:45:00'),
(7, 'ORD-20260926-E64CBB', 1, 'completed', 23.54, 'fixed', 5.00, 5.00, 5.00, 0.93, 19.47, 0.00, 0.00, 0.00, 'cash', NULL, NULL, NULL, '2026-08-29 10:17:00', '2026-08-29 10:17:00'),
(8, 'ORD-20260926-459C1A', 2, 'completed', 19.05, 'fixed', 4.00, 4.00, 5.00, 0.75, 15.80, 0.00, 0.00, 0.00, 'cash', NULL, NULL, NULL, '2026-08-29 07:29:00', '2026-08-29 07:29:00'),
(9, 'ORD-20260926-516616', 2, 'completed', 14.20, 'fixed', 1.00, 1.00, 5.00, 0.66, 13.86, 0.00, 0.00, 0.00, 'card', NULL, NULL, NULL, '2026-08-29 11:23:00', '2026-08-29 11:23:00'),
(10, 'ORD-20260926-0A99B7', 1, 'completed', 6.75, 'fixed', 4.00, 4.00, 5.00, 0.14, 2.89, 0.00, 0.00, 0.00, 'card', NULL, NULL, NULL, '2026-08-29 03:08:00', '2026-08-29 03:08:00'),
(11, 'ORD-20260926-CB252D', 1, 'completed', 14.55, 'fixed', 1.00, 1.00, 5.00, 0.68, 14.23, 0.00, 0.00, 0.00, 'cash', NULL, NULL, NULL, '2026-08-29 08:57:00', '2026-08-29 08:57:00'),
(12, 'ORD-20260926-5100E5', 3, 'completed', 14.00, 'fixed', 5.00, 5.00, 5.00, 0.45, 9.45, 0.00, 0.00, 0.00, 'cash', NULL, NULL, NULL, '2026-08-30 03:11:00', '2026-08-30 03:11:00'),
(13, 'ORD-20260926-6F5618', 2, 'completed', 8.20, 'fixed', 3.00, 3.00, 5.00, 0.26, 5.46, 0.00, 0.00, 0.00, 'cash', NULL, NULL, NULL, '2026-08-30 03:23:00', '2026-08-30 03:23:00'),
(14, 'ORD-20260926-9DBD9B', 1, 'completed', 29.57, 'fixed', 1.00, 1.00, 5.00, 1.43, 30.00, 0.00, 0.00, 0.00, 'card', NULL, NULL, NULL, '2026-08-30 07:12:00', '2026-08-30 07:12:00'),
(15, 'ORD-20260926-FA62BF', 1, 'completed', 30.40, 'fixed', 3.00, 3.00, 5.00, 1.37, 28.77, 0.00, 0.00, 0.00, 'card', NULL, NULL, NULL, '2026-08-30 06:53:00', '2026-08-30 06:53:00'),
(16, 'ORD-20260926-169BC7', 2, 'completed', 18.45, 'fixed', 4.00, 4.00, 5.00, 0.72, 15.17, 0.00, 0.00, 0.00, 'mobile', NULL, NULL, NULL, '2026-08-30 07:28:00', '2026-08-30 07:28:00'),
(17, 'ORD-20260926-FF8F87', 3, 'completed', 23.75, 'fixed', 2.00, 2.00, 5.00, 1.09, 22.84, 0.00, 0.00, 0.00, 'card', NULL, NULL, NULL, '2026-08-30 02:49:00', '2026-08-30 02:49:00'),
(18, 'ORD-20260926-BE7BF8', 2, 'completed', 16.65, 'fixed', 4.00, 4.00, 5.00, 0.63, 13.28, 0.00, 0.00, 0.00, 'card', NULL, NULL, NULL, '2026-08-30 09:53:00', '2026-08-30 09:53:00'),
(19, 'ORD-20260926-64BDC9', 2, 'completed', 22.65, 'fixed', 7.00, 7.00, 5.00, 0.78, 16.43, 0.00, 0.00, 0.00, 'cash', NULL, NULL, NULL, '2026-08-30 10:39:00', '2026-08-30 10:39:00'),
(20, 'ORD-20260926-145B3A', 1, 'completed', 2.95, 'fixed', 3.00, 2.95, 5.00, 0.00, 0.00, 0.00, 0.00, 0.00, 'cash', NULL, NULL, NULL, '2026-08-30 03:00:00', '2026-08-30 03:00:00'),
(21, 'ORD-20260926-931453', 1, 'completed', 15.70, 'fixed', 3.00, 3.00, 5.00, 0.64, 13.34, 0.00, 0.00, 0.00, 'mobile', NULL, NULL, NULL, '2026-08-31 07:41:00', '2026-08-31 07:41:00'),
(22, 'ORD-20260926-670CE0', 1, 'completed', 31.79, 'fixed', 2.00, 2.00, 5.00, 1.49, 31.28, 0.00, 0.00, 0.00, 'cash', NULL, NULL, NULL, '2026-08-31 08:56:00', '2026-08-31 08:56:00'),
(23, 'ORD-20260926-37EDA9', 1, 'completed', 2.95, 'fixed', 4.00, 2.95, 5.00, 0.00, 0.00, 0.00, 0.00, 0.00, 'cash', NULL, NULL, NULL, '2026-08-31 05:56:00', '2026-08-31 05:56:00'),
(24, 'ORD-20260926-2CC057', 2, 'completed', 8.60, 'fixed', 2.00, 2.00, 5.00, 0.33, 6.93, 0.00, 0.00, 0.00, 'cash', NULL, NULL, NULL, '2026-09-01 09:41:00', '2026-09-01 09:41:00'),
(25, 'ORD-20260926-99724A', 2, 'completed', 7.30, 'fixed', 5.00, 5.00, 5.00, 0.12, 2.42, 0.00, 0.00, 0.00, 'mobile', NULL, NULL, NULL, '2026-09-01 07:56:00', '2026-09-01 07:56:00'),
(26, 'ORD-20260926-D85D4D', 2, 'completed', 3.25, 'fixed', 5.00, 3.25, 5.00, 0.00, 0.00, 0.00, 0.00, 0.00, 'cash', NULL, NULL, NULL, '2026-09-01 06:55:00', '2026-09-01 06:55:00'),
(27, 'ORD-20260926-5838DF', 3, 'completed', 8.40, 'fixed', 5.00, 5.00, 5.00, 0.17, 3.57, 0.00, 0.00, 0.00, 'cash', NULL, NULL, NULL, '2026-09-02 05:25:00', '2026-09-02 05:25:00'),
(28, 'ORD-20260926-52EEDB', 1, 'completed', 8.30, 'fixed', 4.00, 4.00, 5.00, 0.22, 4.52, 0.00, 0.00, 0.00, 'cash', NULL, NULL, NULL, '2026-09-02 05:52:00', '2026-09-02 05:52:00'),
(29, 'ORD-20260926-862932', 1, 'completed', 7.60, 'fixed', 1.00, 1.00, 5.00, 0.33, 6.93, 0.00, 0.00, 0.00, 'cash', NULL, NULL, NULL, '2026-09-02 11:10:00', '2026-09-02 11:10:00'),
(30, 'ORD-20260926-F7387B', 1, 'completed', 8.20, 'fixed', 2.00, 2.00, 5.00, 0.31, 6.51, 0.00, 0.00, 0.00, 'card', NULL, NULL, NULL, '2026-09-02 08:52:00', '2026-09-02 08:52:00'),
(31, 'ORD-20260926-4C491D', 3, 'completed', 34.77, 'fixed', 5.00, 5.00, 5.00, 1.49, 31.26, 0.00, 0.00, 0.00, 'cash', NULL, NULL, NULL, '2026-09-02 08:32:00', '2026-09-02 08:32:00'),
(32, 'ORD-20260926-4E2AD3', 2, 'completed', 25.40, 'fixed', 3.00, 3.00, 5.00, 1.12, 23.52, 0.00, 0.00, 0.00, 'card', NULL, NULL, NULL, '2026-09-03 09:57:00', '2026-09-03 09:57:00'),
(33, 'ORD-20260926-55041B', 2, 'completed', 52.40, 'fixed', 4.00, 4.00, 5.00, 2.42, 50.82, 0.00, 0.00, 0.00, 'cash', NULL, NULL, NULL, '2026-09-03 12:05:00', '2026-09-03 12:05:00'),
(34, 'ORD-20260926-9459D0', 2, 'completed', 4.55, 'fixed', 2.00, 2.00, 5.00, 0.13, 2.68, 0.00, 0.00, 0.00, 'card', NULL, NULL, NULL, '2026-09-03 10:14:00', '2026-09-03 10:14:00'),
(35, 'ORD-20260926-26B27A', 2, 'completed', 31.90, 'fixed', 5.00, 5.00, 5.00, 1.35, 28.25, 0.00, 0.00, 0.00, 'cash', NULL, NULL, NULL, '2026-09-03 01:03:00', '2026-09-03 01:03:00'),
(36, 'ORD-20260926-493752', 3, 'completed', 26.45, 'fixed', 3.00, 3.00, 5.00, 1.17, 24.62, 0.00, 0.00, 0.00, 'card', NULL, NULL, NULL, '2026-09-03 04:20:00', '2026-09-03 04:20:00'),
(37, 'ORD-20260926-D898E6', 3, 'completed', 29.50, 'fixed', 7.00, 7.00, 5.00, 1.13, 23.63, 0.00, 0.00, 0.00, 'cash', NULL, NULL, NULL, '2026-09-03 12:01:00', '2026-09-03 12:01:00'),
(38, 'ORD-20260926-C4D8FE', 3, 'completed', 5.25, 'fixed', 8.00, 5.25, 5.00, 0.00, 0.00, 0.00, 0.00, 0.00, 'cash', NULL, NULL, NULL, '2026-09-04 01:39:00', '2026-09-04 01:39:00'),
(39, 'ORD-20260926-DFF12C', 2, 'completed', 15.35, 'fixed', 5.00, 5.00, 5.00, 0.52, 10.87, 0.00, 0.00, 0.00, 'card', NULL, NULL, NULL, '2026-09-04 01:50:00', '2026-09-04 01:50:00'),
(40, 'ORD-20260926-CB22ED', 1, 'completed', 13.10, 'fixed', 6.00, 6.00, 5.00, 0.36, 7.46, 0.00, 0.00, 0.00, 'card', NULL, NULL, NULL, '2026-09-05 01:18:00', '2026-09-05 01:18:00'),
(41, 'ORD-20260926-BF6C05', 3, 'completed', 43.77, 'fixed', 3.00, 3.00, 5.00, 2.04, 42.81, 0.00, 0.00, 0.00, 'cash', NULL, NULL, NULL, '2026-09-05 07:19:00', '2026-09-05 07:19:00'),
(42, 'ORD-20260926-1EF1A4', 3, 'completed', 5.55, 'fixed', 2.00, 2.00, 5.00, 0.18, 3.73, 0.00, 0.00, 0.00, 'cash', NULL, NULL, NULL, '2026-09-06 05:16:00', '2026-09-06 05:16:00'),
(43, 'ORD-20260926-9A226F', 2, 'completed', 32.42, 'fixed', 8.00, 8.00, 5.00, 1.22, 25.64, 0.00, 0.00, 0.00, 'cash', NULL, NULL, NULL, '2026-09-06 09:47:00', '2026-09-06 09:47:00'),
(44, 'ORD-20260926-1F2AB6', 3, 'completed', 8.25, 'percentage', 4.00, 0.33, 5.00, 0.40, 8.32, 0.00, 0.00, 0.00, 'mobile', NULL, NULL, NULL, '2026-09-06 06:54:00', '2026-09-06 06:54:00'),
(45, 'ORD-20260926-0D98E2', 3, 'completed', 5.50, 'fixed', 3.00, 3.00, 5.00, 0.13, 2.63, 0.00, 0.00, 0.00, 'card', NULL, NULL, NULL, '2026-09-06 05:02:00', '2026-09-06 05:02:00'),
(46, 'ORD-20260926-F0EF6E', 2, 'completed', 18.69, 'fixed', 8.00, 8.00, 5.00, 0.53, 11.22, 0.00, 0.00, 0.00, 'mobile', NULL, NULL, NULL, '2026-09-06 09:33:00', '2026-09-06 09:33:00'),
(47, 'ORD-20260926-3C455A', 2, 'completed', 2.80, 'fixed', 4.00, 2.80, 5.00, 0.00, 0.00, 0.00, 0.00, 0.00, 'mobile', NULL, NULL, NULL, '2026-09-06 02:34:00', '2026-09-06 02:34:00'),
(48, 'ORD-20260926-F8D598', 3, 'completed', 3.25, 'fixed', 1.00, 1.00, 5.00, 0.11, 2.36, 0.00, 0.00, 0.00, 'card', NULL, NULL, NULL, '2026-09-06 03:32:00', '2026-09-06 03:32:00'),
(49, 'ORD-20260926-C69303', 3, 'completed', 27.10, 'fixed', 4.00, 4.00, 5.00, 1.16, 24.26, 0.00, 0.00, 0.00, 'mobile', NULL, NULL, NULL, '2026-09-07 03:21:00', '2026-09-07 03:21:00'),
(50, 'ORD-20260926-09D3F6', 3, 'completed', 15.00, 'percentage', 5.00, 0.75, 5.00, 0.71, 14.96, 0.00, 0.00, 0.00, 'card', NULL, NULL, NULL, '2026-09-07 05:05:00', '2026-09-07 05:05:00'),
(51, 'ORD-20260926-060161', 1, 'completed', 24.25, 'fixed', 3.00, 3.00, 5.00, 1.06, 22.31, 0.00, 0.00, 0.00, 'cash', NULL, NULL, NULL, '2026-09-08 09:34:00', '2026-09-08 09:34:00'),
(52, 'ORD-20260926-5D67AB', 1, 'completed', 34.20, 'fixed', 3.00, 3.00, 5.00, 1.56, 32.76, 0.00, 0.00, 0.00, 'cash', NULL, NULL, NULL, '2026-09-08 05:44:00', '2026-09-08 05:44:00'),
(53, 'ORD-20260926-DF6822', 3, 'completed', 33.79, 'fixed', 5.00, 5.00, 5.00, 1.44, 30.23, 0.00, 0.00, 0.00, 'card', NULL, NULL, NULL, '2026-09-08 08:25:00', '2026-09-08 08:25:00'),
(54, 'ORD-20260926-6B19B2', 3, 'completed', 9.10, 'percentage', 2.00, 0.18, 5.00, 0.45, 9.37, 0.00, 0.00, 0.00, 'card', NULL, NULL, NULL, '2026-09-08 12:04:00', '2026-09-08 12:04:00'),
(55, 'ORD-20260926-87F69A', 3, 'completed', 5.85, 'fixed', 5.00, 5.00, 5.00, 0.04, 0.89, 0.00, 0.00, 0.00, 'cash', NULL, NULL, NULL, '2026-09-09 01:06:00', '2026-09-09 01:06:00'),
(56, 'ORD-20260926-AC6EF3', 1, 'completed', 10.95, 'fixed', 4.00, 4.00, 5.00, 0.35, 7.30, 0.00, 0.00, 0.00, 'cash', NULL, NULL, NULL, '2026-09-09 06:47:00', '2026-09-09 06:47:00'),
(57, 'ORD-20260926-27D751', 2, 'completed', 6.00, 'fixed', 2.00, 2.00, 5.00, 0.20, 4.20, 0.00, 0.00, 0.00, 'cash', NULL, NULL, NULL, '2026-09-10 10:23:00', '2026-09-10 10:23:00'),
(58, 'ORD-20260926-8F4E2A', 2, 'completed', 18.70, 'fixed', 3.00, 3.00, 5.00, 0.79, 16.49, 0.00, 0.00, 0.00, 'mobile', NULL, NULL, NULL, '2026-09-10 04:36:00', '2026-09-10 04:36:00'),
(59, 'ORD-20260926-DD4A7E', 3, 'completed', 9.60, 'fixed', 1.00, 1.00, 5.00, 0.43, 9.03, 0.00, 0.00, 0.00, 'card', NULL, NULL, NULL, '2026-09-11 09:09:00', '2026-09-11 09:09:00'),
(60, 'ORD-20260926-ABF033', 2, 'completed', 12.10, 'fixed', 1.00, 1.00, 5.00, 0.56, 11.66, 0.00, 0.00, 0.00, 'cash', NULL, NULL, NULL, '2026-09-11 11:56:00', '2026-09-11 11:56:00'),
(61, 'ORD-20260926-B6A713', 1, 'completed', 22.80, 'fixed', 3.00, 3.00, 5.00, 0.99, 20.79, 0.00, 0.00, 0.00, 'card', NULL, NULL, NULL, '2026-09-12 05:52:00', '2026-09-12 05:52:00'),
(62, 'ORD-20260926-E73F25', 1, 'completed', 7.20, 'fixed', 5.00, 5.00, 5.00, 0.11, 2.31, 0.00, 0.00, 0.00, 'card', NULL, NULL, NULL, '2026-09-12 06:22:00', '2026-09-12 06:22:00'),
(63, 'ORD-20260926-23E8D3', 1, 'completed', 26.95, 'fixed', 2.00, 2.00, 5.00, 1.25, 26.20, 0.00, 0.00, 0.00, 'cash', NULL, NULL, NULL, '2026-09-13 04:09:00', '2026-09-13 04:09:00'),
(64, 'ORD-20260926-B96597', 3, 'completed', 12.35, 'percentage', 5.00, 0.62, 5.00, 0.59, 12.32, 0.00, 0.00, 0.00, 'card', NULL, NULL, NULL, '2026-09-13 10:03:00', '2026-09-13 10:03:00'),
(65, 'ORD-20260926-532E03', 3, 'completed', 12.05, 'fixed', 4.00, 4.00, 5.00, 0.40, 8.45, 0.00, 0.00, 0.00, 'card', NULL, NULL, NULL, '2026-09-14 10:07:00', '2026-09-14 10:07:00'),
(66, 'ORD-20260926-E4ED4D', 2, 'completed', 3.25, 'fixed', 5.00, 3.25, 5.00, 0.00, 0.00, 0.00, 0.00, 0.00, 'card', NULL, NULL, NULL, '2026-09-14 03:40:00', '2026-09-14 03:40:00'),
(67, 'ORD-20260926-ED6FB8', 1, 'completed', 2.25, 'fixed', 4.00, 2.25, 5.00, 0.00, 0.00, 0.00, 0.00, 0.00, 'mobile', NULL, NULL, NULL, '2026-09-14 06:56:00', '2026-09-14 06:56:00'),
(68, 'ORD-20260926-4090BC', 3, 'completed', 20.40, 'fixed', 2.00, 2.00, 5.00, 0.92, 19.32, 0.00, 0.00, 0.00, 'card', NULL, NULL, NULL, '2026-09-15 04:39:00', '2026-09-15 04:39:00'),
(69, 'ORD-20260926-CAE4BF', 1, 'completed', 10.40, 'fixed', 5.00, 5.00, 5.00, 0.27, 5.67, 0.00, 0.00, 0.00, 'card', NULL, NULL, NULL, '2026-09-15 01:14:00', '2026-09-15 01:14:00'),
(70, 'ORD-20260926-27C0D1', 2, 'completed', 16.65, 'fixed', 2.00, 2.00, 5.00, 0.73, 15.38, 0.00, 0.00, 0.00, 'card', NULL, NULL, NULL, '2026-09-15 10:10:00', '2026-09-15 10:10:00'),
(71, 'ORD-20260926-610276', 1, 'completed', 9.00, 'fixed', 4.00, 4.00, 5.00, 0.25, 5.25, 0.00, 0.00, 0.00, 'mobile', NULL, NULL, NULL, '2026-09-15 03:14:00', '2026-09-15 03:14:00'),
(72, 'ORD-20260926-E8D659', 3, 'completed', 20.60, 'fixed', 5.00, 5.00, 5.00, 0.78, 16.38, 0.00, 0.00, 0.00, 'card', NULL, NULL, NULL, '2026-09-16 03:59:00', '2026-09-16 03:59:00'),
(73, 'ORD-20260926-60F8C2', 1, 'completed', 12.90, 'fixed', 1.00, 1.00, 5.00, 0.60, 12.50, 0.00, 0.00, 0.00, 'mobile', NULL, NULL, NULL, '2026-09-16 07:33:00', '2026-09-16 07:33:00'),
(74, 'ORD-20260926-EC4223', 1, 'completed', 4.50, 'fixed', 2.00, 2.00, 5.00, 0.13, 2.63, 0.00, 0.00, 0.00, 'card', NULL, NULL, NULL, '2026-09-16 07:55:00', '2026-09-16 07:55:00'),
(75, 'ORD-20260926-86E179', 2, 'completed', 2.80, 'fixed', 1.00, 1.00, 5.00, 0.09, 1.89, 0.00, 0.00, 0.00, 'mobile', NULL, NULL, NULL, '2026-09-16 01:34:00', '2026-09-16 01:34:00'),
(76, 'ORD-20260926-2A6357', 2, 'completed', 6.50, 'fixed', 2.00, 2.00, 5.00, 0.23, 4.73, 0.00, 0.00, 0.00, 'card', NULL, NULL, NULL, '2026-09-17 08:57:00', '2026-09-17 08:57:00'),
(77, 'ORD-20260926-68CC76', 3, 'completed', 11.75, 'fixed', 3.00, 3.00, 5.00, 0.44, 9.19, 0.00, 0.00, 0.00, 'card', NULL, NULL, NULL, '2026-09-17 08:42:00', '2026-09-17 08:42:00'),
(78, 'ORD-20260926-12F43F', 2, 'completed', 6.80, 'fixed', 1.00, 1.00, 5.00, 0.29, 6.09, 0.00, 0.00, 0.00, 'card', NULL, NULL, NULL, '2026-09-17 06:32:00', '2026-09-17 06:32:00'),
(79, 'ORD-20260926-100B09', 3, 'completed', 3.70, 'fixed', 4.00, 3.70, 5.00, 0.00, 0.00, 0.00, 0.00, 0.00, 'mobile', NULL, NULL, NULL, '2026-09-18 07:28:00', '2026-09-18 07:28:00'),
(80, 'ORD-20260926-5980C4', 1, 'completed', 21.80, 'fixed', 5.00, 5.00, 5.00, 0.84, 17.64, 0.00, 0.00, 0.00, 'cash', NULL, NULL, NULL, '2026-09-18 10:03:00', '2026-09-18 10:03:00'),
(81, 'ORD-20260926-0E6C9E', 3, 'completed', 12.95, 'fixed', 2.00, 2.00, 5.00, 0.55, 11.50, 0.00, 0.00, 0.00, 'card', NULL, NULL, NULL, '2026-09-18 03:56:00', '2026-09-18 03:56:00'),
(82, 'ORD-20260926-23D6B9', 1, 'completed', 4.80, 'percentage', 2.00, 0.10, 5.00, 0.24, 4.94, 0.00, 0.00, 0.00, 'cash', NULL, NULL, NULL, '2026-09-19 01:24:00', '2026-09-19 01:24:00'),
(83, 'ORD-20260926-D7C686', 1, 'completed', 19.65, 'fixed', 5.00, 5.00, 5.00, 0.73, 15.38, 0.00, 0.00, 0.00, 'cash', NULL, NULL, NULL, '2026-09-20 10:51:00', '2026-09-20 10:51:00'),
(84, 'ORD-20260926-2B0B62', 1, 'completed', 8.40, 'fixed', 5.00, 5.00, 5.00, 0.17, 3.57, 0.00, 0.00, 0.00, 'mobile', NULL, NULL, NULL, '2026-09-20 12:25:00', '2026-09-20 12:25:00'),
(85, 'ORD-20260926-ECF8DD', 3, 'completed', 25.35, 'fixed', 5.00, 5.00, 5.00, 1.02, 21.37, 0.00, 0.00, 0.00, 'card', NULL, NULL, NULL, '2026-09-20 03:29:00', '2026-09-20 03:29:00'),
(86, 'ORD-20260926-E1153B', 2, 'completed', 12.40, 'fixed', 1.00, 1.00, 5.00, 0.57, 11.97, 0.00, 0.00, 0.00, 'card', NULL, NULL, NULL, '2026-09-20 05:41:00', '2026-09-20 05:41:00'),
(87, 'ORD-20260926-D34AF4', 2, 'completed', 10.85, 'fixed', 3.00, 3.00, 5.00, 0.39, 8.24, 0.00, 0.00, 0.00, 'card', NULL, NULL, NULL, '2026-09-20 09:39:00', '2026-09-20 09:39:00'),
(88, 'ORD-20260926-2A3AD6', 3, 'completed', 28.35, 'fixed', 5.00, 5.00, 5.00, 1.17, 24.52, 0.00, 0.00, 0.00, 'cash', NULL, NULL, NULL, '2026-09-20 02:53:00', '2026-09-20 02:53:00'),
(89, 'ORD-20260926-8CCB14', 1, 'completed', 5.00, 'fixed', 1.00, 1.00, 5.00, 0.20, 4.20, 0.00, 0.00, 0.00, 'mobile', NULL, NULL, NULL, '2026-09-20 06:27:00', '2026-09-20 06:27:00'),
(90, 'ORD-20260926-82C1C9', 3, 'completed', 14.70, 'fixed', 5.00, 5.00, 5.00, 0.49, 10.19, 0.00, 0.00, 0.00, 'card', NULL, NULL, NULL, '2026-09-21 07:04:00', '2026-09-21 07:04:00'),
(91, 'ORD-20260926-CB1DCD', 3, 'completed', 6.55, 'fixed', 1.00, 1.00, 5.00, 0.28, 5.83, 0.00, 0.00, 0.00, 'cash', NULL, NULL, NULL, '2026-09-21 04:51:00', '2026-09-21 04:51:00'),
(92, 'ORD-20260926-028D9A', 1, 'completed', 8.40, 'fixed', 1.00, 1.00, 5.00, 0.37, 7.77, 0.00, 0.00, 0.00, 'mobile', NULL, NULL, NULL, '2026-09-21 06:29:00', '2026-09-21 06:29:00'),
(93, 'ORD-20260926-7F3B74', 3, 'completed', 6.40, 'fixed', 7.00, 6.40, 5.00, 0.00, 0.00, 0.00, 0.00, 0.00, 'mobile', NULL, NULL, NULL, '2026-09-22 11:03:00', '2026-09-22 11:03:00'),
(94, 'ORD-20260926-52A66D', 2, 'completed', 13.10, 'fixed', 2.00, 2.00, 5.00, 0.56, 11.66, 0.00, 0.00, 0.00, 'card', NULL, NULL, NULL, '2026-09-22 12:42:00', '2026-09-22 12:42:00'),
(95, 'ORD-20260926-A66063', 1, 'completed', 11.60, 'fixed', 5.00, 5.00, 5.00, 0.33, 6.93, 0.00, 0.00, 0.00, 'mobile', NULL, NULL, NULL, '2026-09-23 06:05:00', '2026-09-23 06:05:00'),
(96, 'ORD-20260926-297103', 2, 'completed', 6.20, 'fixed', 4.00, 4.00, 5.00, 0.11, 2.31, 0.00, 0.00, 0.00, 'card', NULL, NULL, NULL, '2026-09-23 03:14:00', '2026-09-23 03:14:00'),
(97, 'ORD-20260926-884F2D', 3, 'completed', 13.95, 'fixed', 3.00, 3.00, 5.00, 0.55, 11.50, 0.00, 0.00, 0.00, 'card', NULL, NULL, NULL, '2026-09-23 10:03:00', '2026-09-23 10:03:00'),
(98, 'ORD-20260926-6C1D6A', 1, 'completed', 22.00, 'fixed', 2.00, 2.00, 5.00, 1.00, 21.00, 0.00, 0.00, 0.00, 'card', NULL, NULL, NULL, '2026-09-25 06:05:00', '2026-09-25 06:05:00'),
(99, 'ORD-20260926-1B7453', 1, 'completed', 9.75, 'fixed', 3.00, 3.00, 5.00, 0.34, 7.09, 0.00, 0.00, 0.00, 'card', NULL, NULL, NULL, '2026-09-26 07:37:00', '2026-09-26 07:37:00'),
(100, 'ORD-20260926-389313', 2, 'completed', 2.80, 'fixed', 3.00, 2.80, 5.00, 0.00, 0.00, 0.00, 0.00, 0.00, 'cash', NULL, NULL, NULL, '2026-09-26 05:55:00', '2026-09-26 05:55:00'),
(101, 'ORD-20260926-AD973A', 2, 'completed', 13.90, 'fixed', 3.00, 3.00, 5.00, 0.55, 11.45, 0.00, 0.00, 0.00, 'card', NULL, NULL, NULL, '2026-09-26 04:20:00', '2026-09-26 04:20:00'),
(102, 'ORD-20260926-A80CBF', 2, 'completed', 71.95, 'fixed', 0.00, 0.00, 5.00, 3.60, 75.55, 0.00, 80.00, 4.45, 'cash', NULL, NULL, NULL, '2026-09-26 10:45:33', '2026-09-26 10:45:33'),
(103, 'ORD-20260926-F289F3', 2, 'completed', 280.00, 'fixed', 0.00, 0.00, 1.50, 4.20, 284.20, 0.00, 284.20, 0.00, 'cash', NULL, NULL, NULL, '2026-09-26 10:52:37', '2026-09-26 10:52:37');

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED DEFAULT NULL,
  `product_name` varchar(255) NOT NULL,
  `unit_price` decimal(12,2) NOT NULL,
  `unit_cost` decimal(12,2) DEFAULT NULL,
  `quantity` int(10) UNSIGNED NOT NULL,
  `refunded_quantity` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `discount_amount` decimal(12,2) NOT NULL DEFAULT 0.00,
  `line_total` decimal(14,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`id`, `order_id`, `product_id`, `product_name`, `unit_price`, `unit_cost`, `quantity`, `refunded_quantity`, `discount_amount`, `line_total`, `created_at`, `updated_at`) VALUES
(1, 1, 3, 'Orange Juice 1L', 3.50, 1.90, 1, 0, 0.00, 3.50, '2026-08-28 02:08:00', '2026-08-28 02:08:00'),
(2, 1, 8, 'Butter Croissant', 1.95, 0.80, 1, 0, 0.00, 1.95, '2026-08-28 02:08:00', '2026-08-28 02:08:00'),
(3, 2, 18, 'Dish Soap 500ml', 2.75, 1.20, 2, 0, 0.00, 5.50, '2026-08-28 05:54:00', '2026-08-28 05:54:00'),
(4, 3, 1, 'Cola 500ml Can', 1.50, 0.65, 2, 0, 0.00, 3.00, '2026-08-28 07:41:00', '2026-08-28 07:41:00'),
(5, 3, 15, 'Roasted Peanuts 200g', 2.60, 1.10, 3, 0, 0.00, 7.80, '2026-08-28 07:41:00', '2026-08-28 07:41:00'),
(6, 3, 22, 'Bananas 1kg', 2.40, 1.10, 1, 0, 0.00, 2.40, '2026-08-28 07:41:00', '2026-08-28 07:41:00'),
(7, 4, 5, 'Ground Coffee 250g', 7.99, 4.20, 2, 0, 0.00, 15.98, '2026-08-28 08:27:00', '2026-08-28 08:27:00'),
(8, 4, 10, 'Whole Milk 1L', 1.85, 0.95, 2, 0, 0.00, 3.70, '2026-08-28 08:27:00', '2026-08-28 08:27:00'),
(9, 5, 8, 'Butter Croissant', 1.95, 0.80, 1, 0, 0.00, 1.95, '2026-08-28 06:34:00', '2026-08-28 06:34:00'),
(10, 5, 11, 'Greek Yoghurt 500g', 3.25, 1.60, 3, 0, 0.00, 9.75, '2026-08-28 06:34:00', '2026-08-28 06:34:00'),
(11, 5, 12, 'Cheddar Cheese 250g', 5.50, 2.80, 3, 0, 0.00, 16.50, '2026-08-28 06:34:00', '2026-08-28 06:34:00'),
(12, 5, 19, 'Kitchen Roll (2 rolls)', 3.40, 1.55, 3, 0, 0.00, 10.20, '2026-08-28 06:34:00', '2026-08-28 06:34:00'),
(13, 5, 23, 'Red Apples 1kg', 3.20, 1.60, 3, 0, 0.00, 9.60, '2026-08-28 06:34:00', '2026-08-28 06:34:00'),
(14, 6, 2, 'Cola 1.5L Bottle', 2.80, 1.40, 1, 0, 0.00, 2.80, '2026-08-28 10:45:00', '2026-08-28 10:45:00'),
(15, 6, 12, 'Cheddar Cheese 250g', 5.50, 2.80, 1, 0, 0.00, 5.50, '2026-08-28 10:45:00', '2026-08-28 10:45:00'),
(16, 6, 18, 'Dish Soap 500ml', 2.75, 1.20, 2, 0, 0.00, 5.50, '2026-08-28 10:45:00', '2026-08-28 10:45:00'),
(17, 7, 1, 'Cola 500ml Can', 1.50, 0.65, 2, 0, 0.00, 3.00, '2026-08-29 10:17:00', '2026-08-29 10:17:00'),
(18, 7, 3, 'Orange Juice 1L', 3.50, 1.90, 2, 0, 0.00, 7.00, '2026-08-29 10:17:00', '2026-08-29 10:17:00'),
(19, 7, 5, 'Ground Coffee 250g', 7.99, 4.20, 1, 0, 0.00, 7.99, '2026-08-29 10:17:00', '2026-08-29 10:17:00'),
(20, 7, 14, 'Salted Crisps 150g', 1.85, 0.75, 3, 0, 0.00, 5.55, '2026-08-29 10:17:00', '2026-08-29 10:17:00'),
(21, 8, 1, 'Cola 500ml Can', 1.50, 0.65, 2, 0, 0.00, 3.00, '2026-08-29 07:29:00', '2026-08-29 07:29:00'),
(22, 8, 2, 'Cola 1.5L Bottle', 2.80, 1.40, 1, 0, 0.00, 2.80, '2026-08-29 07:29:00', '2026-08-29 07:29:00'),
(23, 8, 8, 'Butter Croissant', 1.95, 0.80, 3, 0, 0.00, 5.85, '2026-08-29 07:29:00', '2026-08-29 07:29:00'),
(24, 8, 10, 'Whole Milk 1L', 1.85, 0.95, 3, 0, 0.00, 5.55, '2026-08-29 07:29:00', '2026-08-29 07:29:00'),
(25, 8, 14, 'Salted Crisps 150g', 1.85, 0.75, 1, 0, 0.00, 1.85, '2026-08-29 07:29:00', '2026-08-29 07:29:00'),
(26, 9, 15, 'Roasted Peanuts 200g', 2.60, 1.10, 3, 0, 0.00, 7.80, '2026-08-29 11:23:00', '2026-08-29 11:23:00'),
(27, 9, 23, 'Red Apples 1kg', 3.20, 1.60, 2, 0, 0.00, 6.40, '2026-08-29 11:23:00', '2026-08-29 11:23:00'),
(28, 10, 3, 'Orange Juice 1L', 3.50, 1.90, 1, 0, 0.00, 3.50, '2026-08-29 03:08:00', '2026-08-29 03:08:00'),
(29, 10, 11, 'Greek Yoghurt 500g', 3.25, 1.60, 1, 0, 0.00, 3.25, '2026-08-29 03:08:00', '2026-08-29 03:08:00'),
(30, 11, 7, 'Wholemeal Loaf', 2.80, 1.25, 1, 0, 0.00, 2.80, '2026-08-29 08:57:00', '2026-08-29 08:57:00'),
(31, 11, 8, 'Butter Croissant', 1.95, 0.80, 3, 0, 0.00, 5.85, '2026-08-29 08:57:00', '2026-08-29 08:57:00'),
(32, 11, 16, 'Milk Chocolate Bar 100g', 2.95, 1.35, 2, 0, 0.00, 5.90, '2026-08-29 08:57:00', '2026-08-29 08:57:00'),
(33, 12, 19, 'Kitchen Roll (2 rolls)', 3.40, 1.55, 2, 0, 0.00, 6.80, '2026-08-30 03:11:00', '2026-08-30 03:11:00'),
(34, 12, 22, 'Bananas 1kg', 2.40, 1.10, 3, 0, 0.00, 7.20, '2026-08-30 03:11:00', '2026-08-30 03:11:00'),
(35, 13, 10, 'Whole Milk 1L', 1.85, 0.95, 2, 0, 0.00, 3.70, '2026-08-30 03:23:00', '2026-08-30 03:23:00'),
(36, 13, 20, 'Bin Liners 30ct', 4.50, 2.00, 1, 0, 0.00, 4.50, '2026-08-30 03:23:00', '2026-08-30 03:23:00'),
(37, 14, 5, 'Ground Coffee 250g', 7.99, 4.20, 3, 0, 0.00, 23.97, '2026-08-30 07:12:00', '2026-08-30 07:12:00'),
(38, 14, 7, 'Wholemeal Loaf', 2.80, 1.25, 2, 0, 0.00, 5.60, '2026-08-30 07:12:00', '2026-08-30 07:12:00'),
(39, 15, 1, 'Cola 500ml Can', 1.50, 0.65, 3, 0, 0.00, 4.50, '2026-08-30 06:53:00', '2026-08-30 06:53:00'),
(40, 15, 2, 'Cola 1.5L Bottle', 2.80, 1.40, 3, 0, 0.00, 8.40, '2026-08-30 06:53:00', '2026-08-30 06:53:00'),
(41, 15, 12, 'Cheddar Cheese 250g', 5.50, 2.80, 1, 0, 0.00, 5.50, '2026-08-30 06:53:00', '2026-08-30 06:53:00'),
(42, 15, 22, 'Bananas 1kg', 2.40, 1.10, 1, 0, 0.00, 2.40, '2026-08-30 06:53:00', '2026-08-30 06:53:00'),
(43, 15, 23, 'Red Apples 1kg', 3.20, 1.60, 3, 0, 0.00, 9.60, '2026-08-30 06:53:00', '2026-08-30 06:53:00'),
(44, 16, 16, 'Milk Chocolate Bar 100g', 2.95, 1.35, 3, 0, 0.00, 8.85, '2026-08-30 07:28:00', '2026-08-30 07:28:00'),
(45, 16, 23, 'Red Apples 1kg', 3.20, 1.60, 3, 0, 0.00, 9.60, '2026-08-30 07:28:00', '2026-08-30 07:28:00'),
(46, 17, 1, 'Cola 500ml Can', 1.50, 0.65, 1, 0, 0.00, 1.50, '2026-08-30 02:49:00', '2026-08-30 02:49:00'),
(47, 17, 3, 'Orange Juice 1L', 3.50, 1.90, 2, 0, 0.00, 7.00, '2026-08-30 02:49:00', '2026-08-30 02:49:00'),
(48, 17, 8, 'Butter Croissant', 1.95, 0.80, 3, 0, 0.00, 5.85, '2026-08-30 02:49:00', '2026-08-30 02:49:00'),
(49, 17, 23, 'Red Apples 1kg', 3.20, 1.60, 1, 0, 0.00, 3.20, '2026-08-30 02:49:00', '2026-08-30 02:49:00'),
(50, 17, 24, 'Tomatoes 1kg', 3.10, 1.40, 2, 0, 0.00, 6.20, '2026-08-30 02:49:00', '2026-08-30 02:49:00'),
(51, 18, 7, 'Wholemeal Loaf', 2.80, 1.25, 2, 0, 0.00, 5.60, '2026-08-30 09:53:00', '2026-08-30 09:53:00'),
(52, 18, 11, 'Greek Yoghurt 500g', 3.25, 1.60, 1, 0, 0.00, 3.25, '2026-08-30 09:53:00', '2026-08-30 09:53:00'),
(53, 18, 15, 'Roasted Peanuts 200g', 2.60, 1.10, 3, 0, 0.00, 7.80, '2026-08-30 09:53:00', '2026-08-30 09:53:00'),
(54, 19, 6, 'White Sandwich Loaf', 2.50, 1.10, 3, 0, 0.00, 7.50, '2026-08-30 10:39:00', '2026-08-30 10:39:00'),
(55, 19, 8, 'Butter Croissant', 1.95, 0.80, 3, 0, 0.00, 5.85, '2026-08-30 10:39:00', '2026-08-30 10:39:00'),
(56, 19, 24, 'Tomatoes 1kg', 3.10, 1.40, 3, 0, 0.00, 9.30, '2026-08-30 10:39:00', '2026-08-30 10:39:00'),
(57, 20, 16, 'Milk Chocolate Bar 100g', 2.95, 1.35, 1, 0, 0.00, 2.95, '2026-08-30 03:00:00', '2026-08-30 03:00:00'),
(58, 21, 11, 'Greek Yoghurt 500g', 3.25, 1.60, 3, 0, 0.00, 9.75, '2026-08-31 07:41:00', '2026-08-31 07:41:00'),
(59, 21, 18, 'Dish Soap 500ml', 2.75, 1.20, 1, 0, 0.00, 2.75, '2026-08-31 07:41:00', '2026-08-31 07:41:00'),
(60, 21, 23, 'Red Apples 1kg', 3.20, 1.60, 1, 0, 0.00, 3.20, '2026-08-31 07:41:00', '2026-08-31 07:41:00'),
(61, 22, 1, 'Cola 500ml Can', 1.50, 0.65, 1, 0, 0.00, 1.50, '2026-08-31 08:56:00', '2026-08-31 08:56:00'),
(62, 22, 5, 'Ground Coffee 250g', 7.99, 4.20, 1, 0, 0.00, 7.99, '2026-08-31 08:56:00', '2026-08-31 08:56:00'),
(63, 22, 6, 'White Sandwich Loaf', 2.50, 1.10, 1, 0, 0.00, 2.50, '2026-08-31 08:56:00', '2026-08-31 08:56:00'),
(64, 22, 8, 'Butter Croissant', 1.95, 0.80, 2, 0, 0.00, 3.90, '2026-08-31 08:56:00', '2026-08-31 08:56:00'),
(65, 22, 21, 'Laundry Powder 1kg', 7.95, 4.10, 2, 0, 0.00, 15.90, '2026-08-31 08:56:00', '2026-08-31 08:56:00'),
(66, 23, 16, 'Milk Chocolate Bar 100g', 2.95, 1.35, 1, 0, 0.00, 2.95, '2026-08-31 05:56:00', '2026-08-31 05:56:00'),
(67, 24, 1, 'Cola 500ml Can', 1.50, 0.65, 2, 0, 0.00, 3.00, '2026-09-01 09:41:00', '2026-09-01 09:41:00'),
(68, 24, 7, 'Wholemeal Loaf', 2.80, 1.25, 2, 0, 0.00, 5.60, '2026-09-01 09:41:00', '2026-09-01 09:41:00'),
(69, 25, 2, 'Cola 1.5L Bottle', 2.80, 1.40, 1, 0, 0.00, 2.80, '2026-09-01 07:56:00', '2026-09-01 07:56:00'),
(70, 25, 20, 'Bin Liners 30ct', 4.50, 2.00, 1, 0, 0.00, 4.50, '2026-09-01 07:56:00', '2026-09-01 07:56:00'),
(71, 26, 11, 'Greek Yoghurt 500g', 3.25, 1.60, 1, 0, 0.00, 3.25, '2026-09-01 06:55:00', '2026-09-01 06:55:00'),
(72, 27, 7, 'Wholemeal Loaf', 2.80, 1.25, 3, 0, 0.00, 8.40, '2026-09-02 05:25:00', '2026-09-02 05:25:00'),
(73, 28, 3, 'Orange Juice 1L', 3.50, 1.90, 1, 0, 0.00, 3.50, '2026-09-02 05:52:00', '2026-09-02 05:52:00'),
(74, 28, 22, 'Bananas 1kg', 2.40, 1.10, 2, 0, 0.00, 4.80, '2026-09-02 05:52:00', '2026-09-02 05:52:00'),
(75, 29, 8, 'Butter Croissant', 1.95, 0.80, 2, 0, 0.00, 3.90, '2026-09-02 11:10:00', '2026-09-02 11:10:00'),
(76, 29, 14, 'Salted Crisps 150g', 1.85, 0.75, 2, 0, 0.00, 3.70, '2026-09-02 11:10:00', '2026-09-02 11:10:00'),
(77, 30, 1, 'Cola 500ml Can', 1.50, 0.65, 2, 0, 0.00, 3.00, '2026-09-02 08:52:00', '2026-09-02 08:52:00'),
(78, 30, 2, 'Cola 1.5L Bottle', 2.80, 1.40, 1, 0, 0.00, 2.80, '2026-09-02 08:52:00', '2026-09-02 08:52:00'),
(79, 30, 22, 'Bananas 1kg', 2.40, 1.10, 1, 0, 0.00, 2.40, '2026-09-02 08:52:00', '2026-09-02 08:52:00'),
(80, 31, 1, 'Cola 500ml Can', 1.50, 0.65, 1, 0, 0.00, 1.50, '2026-09-02 08:32:00', '2026-09-02 08:32:00'),
(81, 31, 2, 'Cola 1.5L Bottle', 2.80, 1.40, 2, 0, 0.00, 5.60, '2026-09-02 08:32:00', '2026-09-02 08:32:00'),
(82, 31, 5, 'Ground Coffee 250g', 7.99, 4.20, 3, 0, 0.00, 23.97, '2026-09-02 08:32:00', '2026-09-02 08:32:00'),
(83, 31, 14, 'Salted Crisps 150g', 1.85, 0.75, 2, 0, 0.00, 3.70, '2026-09-02 08:32:00', '2026-09-02 08:32:00'),
(84, 32, 7, 'Wholemeal Loaf', 2.80, 1.25, 1, 0, 0.00, 2.80, '2026-09-03 09:57:00', '2026-09-03 09:57:00'),
(85, 32, 15, 'Roasted Peanuts 200g', 2.60, 1.10, 1, 0, 0.00, 2.60, '2026-09-03 09:57:00', '2026-09-03 09:57:00'),
(86, 32, 16, 'Milk Chocolate Bar 100g', 2.95, 1.35, 2, 0, 0.00, 5.90, '2026-09-03 09:57:00', '2026-09-03 09:57:00'),
(87, 32, 20, 'Bin Liners 30ct', 4.50, 2.00, 1, 0, 0.00, 4.50, '2026-09-03 09:57:00', '2026-09-03 09:57:00'),
(88, 32, 23, 'Red Apples 1kg', 3.20, 1.60, 3, 0, 0.00, 9.60, '2026-09-03 09:57:00', '2026-09-03 09:57:00'),
(89, 33, 3, 'Orange Juice 1L', 3.50, 1.90, 2, 0, 0.00, 7.00, '2026-09-03 12:05:00', '2026-09-03 12:05:00'),
(90, 33, 8, 'Butter Croissant', 1.95, 0.80, 3, 0, 0.00, 5.85, '2026-09-03 12:05:00', '2026-09-03 12:05:00'),
(91, 33, 21, 'Laundry Powder 1kg', 7.95, 4.10, 3, 0, 0.00, 23.85, '2026-09-03 12:05:00', '2026-09-03 12:05:00'),
(92, 33, 23, 'Red Apples 1kg', 3.20, 1.60, 2, 0, 0.00, 6.40, '2026-09-03 12:05:00', '2026-09-03 12:05:00'),
(93, 33, 24, 'Tomatoes 1kg', 3.10, 1.40, 3, 0, 0.00, 9.30, '2026-09-03 12:05:00', '2026-09-03 12:05:00'),
(94, 34, 2, 'Cola 1.5L Bottle', 2.80, 1.40, 1, 0, 0.00, 2.80, '2026-09-03 10:14:00', '2026-09-03 10:14:00'),
(95, 34, 9, 'Chocolate Muffin', 1.75, 0.70, 1, 0, 0.00, 1.75, '2026-09-03 10:14:00', '2026-09-03 10:14:00'),
(96, 35, 11, 'Greek Yoghurt 500g', 3.25, 1.60, 1, 0, 0.00, 3.25, '2026-09-03 01:03:00', '2026-09-03 01:03:00'),
(97, 35, 14, 'Salted Crisps 150g', 1.85, 0.75, 3, 0, 0.00, 5.55, '2026-09-03 01:03:00', '2026-09-03 01:03:00'),
(98, 35, 21, 'Laundry Powder 1kg', 7.95, 4.10, 2, 0, 0.00, 15.90, '2026-09-03 01:03:00', '2026-09-03 01:03:00'),
(99, 35, 22, 'Bananas 1kg', 2.40, 1.10, 3, 0, 0.00, 7.20, '2026-09-03 01:03:00', '2026-09-03 01:03:00'),
(100, 36, 4, 'Mineral Water 500ml', 0.75, 0.20, 1, 0, 0.00, 0.75, '2026-09-03 04:20:00', '2026-09-03 04:20:00'),
(101, 36, 14, 'Salted Crisps 150g', 1.85, 0.75, 1, 0, 0.00, 1.85, '2026-09-03 04:20:00', '2026-09-03 04:20:00'),
(102, 36, 21, 'Laundry Powder 1kg', 7.95, 4.10, 3, 0, 0.00, 23.85, '2026-09-03 04:20:00', '2026-09-03 04:20:00'),
(103, 37, 15, 'Roasted Peanuts 200g', 2.60, 1.10, 1, 0, 0.00, 2.60, '2026-09-03 12:01:00', '2026-09-03 12:01:00'),
(104, 37, 21, 'Laundry Powder 1kg', 7.95, 4.10, 2, 0, 0.00, 15.90, '2026-09-03 12:01:00', '2026-09-03 12:01:00'),
(105, 37, 22, 'Bananas 1kg', 2.40, 1.10, 2, 0, 0.00, 4.80, '2026-09-03 12:01:00', '2026-09-03 12:01:00'),
(106, 37, 24, 'Tomatoes 1kg', 3.10, 1.40, 2, 0, 0.00, 6.20, '2026-09-03 12:01:00', '2026-09-03 12:01:00'),
(107, 38, 9, 'Chocolate Muffin', 1.75, 0.70, 3, 0, 0.00, 5.25, '2026-09-04 01:39:00', '2026-09-04 01:39:00'),
(108, 39, 14, 'Salted Crisps 150g', 1.85, 0.75, 1, 0, 0.00, 1.85, '2026-09-04 01:50:00', '2026-09-04 01:50:00'),
(109, 39, 20, 'Bin Liners 30ct', 4.50, 2.00, 3, 0, 0.00, 13.50, '2026-09-04 01:50:00', '2026-09-04 01:50:00'),
(110, 40, 7, 'Wholemeal Loaf', 2.80, 1.25, 3, 0, 0.00, 8.40, '2026-09-05 01:18:00', '2026-09-05 01:18:00'),
(111, 40, 9, 'Chocolate Muffin', 1.75, 0.70, 1, 0, 0.00, 1.75, '2026-09-05 01:18:00', '2026-09-05 01:18:00'),
(112, 40, 16, 'Milk Chocolate Bar 100g', 2.95, 1.35, 1, 0, 0.00, 2.95, '2026-09-05 01:18:00', '2026-09-05 01:18:00'),
(113, 41, 5, 'Ground Coffee 250g', 7.99, 4.20, 3, 0, 0.00, 23.97, '2026-09-05 07:19:00', '2026-09-05 07:19:00'),
(114, 41, 9, 'Chocolate Muffin', 1.75, 0.70, 3, 0, 0.00, 5.25, '2026-09-05 07:19:00', '2026-09-05 07:19:00'),
(115, 41, 10, 'Whole Milk 1L', 1.85, 0.95, 3, 0, 0.00, 5.55, '2026-09-05 07:19:00', '2026-09-05 07:19:00'),
(116, 41, 20, 'Bin Liners 30ct', 4.50, 2.00, 2, 0, 0.00, 9.00, '2026-09-05 07:19:00', '2026-09-05 07:19:00'),
(117, 42, 10, 'Whole Milk 1L', 1.85, 0.95, 3, 0, 0.00, 5.55, '2026-09-06 05:16:00', '2026-09-06 05:16:00'),
(118, 43, 5, 'Ground Coffee 250g', 7.99, 4.20, 3, 0, 0.00, 23.97, '2026-09-06 09:47:00', '2026-09-06 09:47:00'),
(119, 43, 8, 'Butter Croissant', 1.95, 0.80, 3, 0, 0.00, 5.85, '2026-09-06 09:47:00', '2026-09-06 09:47:00'),
(120, 43, 15, 'Roasted Peanuts 200g', 2.60, 1.10, 1, 0, 0.00, 2.60, '2026-09-06 09:47:00', '2026-09-06 09:47:00'),
(121, 44, 18, 'Dish Soap 500ml', 2.75, 1.20, 3, 0, 0.00, 8.25, '2026-09-06 06:54:00', '2026-09-06 06:54:00'),
(122, 45, 12, 'Cheddar Cheese 250g', 5.50, 2.80, 1, 0, 0.00, 5.50, '2026-09-06 05:02:00', '2026-09-06 05:02:00'),
(123, 46, 1, 'Cola 500ml Can', 1.50, 0.65, 3, 0, 0.00, 4.50, '2026-09-06 09:33:00', '2026-09-06 09:33:00'),
(124, 46, 5, 'Ground Coffee 250g', 7.99, 4.20, 1, 0, 0.00, 7.99, '2026-09-06 09:33:00', '2026-09-06 09:33:00'),
(125, 46, 24, 'Tomatoes 1kg', 3.10, 1.40, 2, 0, 0.00, 6.20, '2026-09-06 09:33:00', '2026-09-06 09:33:00'),
(126, 47, 2, 'Cola 1.5L Bottle', 2.80, 1.40, 1, 0, 0.00, 2.80, '2026-09-06 02:34:00', '2026-09-06 02:34:00'),
(127, 48, 11, 'Greek Yoghurt 500g', 3.25, 1.60, 1, 0, 0.00, 3.25, '2026-09-06 03:32:00', '2026-09-06 03:32:00'),
(128, 49, 3, 'Orange Juice 1L', 3.50, 1.90, 3, 0, 0.00, 10.50, '2026-09-07 03:21:00', '2026-09-07 03:21:00'),
(129, 49, 7, 'Wholemeal Loaf', 2.80, 1.25, 2, 0, 0.00, 5.60, '2026-09-07 03:21:00', '2026-09-07 03:21:00'),
(130, 49, 15, 'Roasted Peanuts 200g', 2.60, 1.10, 3, 0, 0.00, 7.80, '2026-09-07 03:21:00', '2026-09-07 03:21:00'),
(131, 49, 23, 'Red Apples 1kg', 3.20, 1.60, 1, 0, 0.00, 3.20, '2026-09-07 03:21:00', '2026-09-07 03:21:00'),
(132, 50, 2, 'Cola 1.5L Bottle', 2.80, 1.40, 2, 0, 0.00, 5.60, '2026-09-07 05:05:00', '2026-09-07 05:05:00'),
(133, 50, 8, 'Butter Croissant', 1.95, 0.80, 2, 0, 0.00, 3.90, '2026-09-07 05:05:00', '2026-09-07 05:05:00'),
(134, 50, 18, 'Dish Soap 500ml', 2.75, 1.20, 2, 0, 0.00, 5.50, '2026-09-07 05:05:00', '2026-09-07 05:05:00'),
(135, 51, 10, 'Whole Milk 1L', 1.85, 0.95, 3, 0, 0.00, 5.55, '2026-09-08 09:34:00', '2026-09-08 09:34:00'),
(136, 51, 15, 'Roasted Peanuts 200g', 2.60, 1.10, 2, 0, 0.00, 5.20, '2026-09-08 09:34:00', '2026-09-08 09:34:00'),
(137, 51, 20, 'Bin Liners 30ct', 4.50, 2.00, 3, 0, 0.00, 13.50, '2026-09-08 09:34:00', '2026-09-08 09:34:00'),
(138, 52, 10, 'Whole Milk 1L', 1.85, 0.95, 2, 0, 0.00, 3.70, '2026-09-08 05:44:00', '2026-09-08 05:44:00'),
(139, 52, 12, 'Cheddar Cheese 250g', 5.50, 2.80, 2, 0, 0.00, 11.00, '2026-09-08 05:44:00', '2026-09-08 05:44:00'),
(140, 52, 16, 'Milk Chocolate Bar 100g', 2.95, 1.35, 2, 0, 0.00, 5.90, '2026-09-08 05:44:00', '2026-09-08 05:44:00'),
(141, 52, 22, 'Bananas 1kg', 2.40, 1.10, 3, 0, 0.00, 7.20, '2026-09-08 05:44:00', '2026-09-08 05:44:00'),
(142, 52, 23, 'Red Apples 1kg', 3.20, 1.60, 2, 0, 0.00, 6.40, '2026-09-08 05:44:00', '2026-09-08 05:44:00'),
(143, 53, 5, 'Ground Coffee 250g', 7.99, 4.20, 1, 0, 0.00, 7.99, '2026-09-08 08:25:00', '2026-09-08 08:25:00'),
(144, 53, 12, 'Cheddar Cheese 250g', 5.50, 2.80, 3, 0, 0.00, 16.50, '2026-09-08 08:25:00', '2026-09-08 08:25:00'),
(145, 53, 24, 'Tomatoes 1kg', 3.10, 1.40, 3, 0, 0.00, 9.30, '2026-09-08 08:25:00', '2026-09-08 08:25:00'),
(146, 54, 2, 'Cola 1.5L Bottle', 2.80, 1.40, 2, 0, 0.00, 5.60, '2026-09-08 12:04:00', '2026-09-08 12:04:00'),
(147, 54, 3, 'Orange Juice 1L', 3.50, 1.90, 1, 0, 0.00, 3.50, '2026-09-08 12:04:00', '2026-09-08 12:04:00'),
(148, 55, 8, 'Butter Croissant', 1.95, 0.80, 3, 0, 0.00, 5.85, '2026-09-09 01:06:00', '2026-09-09 01:06:00'),
(149, 56, 1, 'Cola 500ml Can', 1.50, 0.65, 2, 0, 0.00, 3.00, '2026-09-09 06:47:00', '2026-09-09 06:47:00'),
(150, 56, 14, 'Salted Crisps 150g', 1.85, 0.75, 3, 0, 0.00, 5.55, '2026-09-09 06:47:00', '2026-09-09 06:47:00'),
(151, 56, 22, 'Bananas 1kg', 2.40, 1.10, 1, 0, 0.00, 2.40, '2026-09-09 06:47:00', '2026-09-09 06:47:00'),
(152, 57, 3, 'Orange Juice 1L', 3.50, 1.90, 1, 0, 0.00, 3.50, '2026-09-10 10:23:00', '2026-09-10 10:23:00'),
(153, 57, 6, 'White Sandwich Loaf', 2.50, 1.10, 1, 0, 0.00, 2.50, '2026-09-10 10:23:00', '2026-09-10 10:23:00'),
(154, 58, 7, 'Wholemeal Loaf', 2.80, 1.25, 3, 0, 0.00, 8.40, '2026-09-10 04:36:00', '2026-09-10 04:36:00'),
(155, 58, 12, 'Cheddar Cheese 250g', 5.50, 2.80, 1, 0, 0.00, 5.50, '2026-09-10 04:36:00', '2026-09-10 04:36:00'),
(156, 58, 22, 'Bananas 1kg', 2.40, 1.10, 2, 0, 0.00, 4.80, '2026-09-10 04:36:00', '2026-09-10 04:36:00'),
(157, 59, 23, 'Red Apples 1kg', 3.20, 1.60, 3, 0, 0.00, 9.60, '2026-09-11 09:09:00', '2026-09-11 09:09:00'),
(158, 60, 11, 'Greek Yoghurt 500g', 3.25, 1.60, 1, 0, 0.00, 3.25, '2026-09-11 11:56:00', '2026-09-11 11:56:00'),
(159, 60, 16, 'Milk Chocolate Bar 100g', 2.95, 1.35, 3, 0, 0.00, 8.85, '2026-09-11 11:56:00', '2026-09-11 11:56:00'),
(160, 61, 2, 'Cola 1.5L Bottle', 2.80, 1.40, 1, 0, 0.00, 2.80, '2026-09-12 05:52:00', '2026-09-12 05:52:00'),
(161, 61, 3, 'Orange Juice 1L', 3.50, 1.90, 1, 0, 0.00, 3.50, '2026-09-12 05:52:00', '2026-09-12 05:52:00'),
(162, 61, 10, 'Whole Milk 1L', 1.85, 0.95, 1, 0, 0.00, 1.85, '2026-09-12 05:52:00', '2026-09-12 05:52:00'),
(163, 61, 18, 'Dish Soap 500ml', 2.75, 1.20, 3, 0, 0.00, 8.25, '2026-09-12 05:52:00', '2026-09-12 05:52:00'),
(164, 61, 23, 'Red Apples 1kg', 3.20, 1.60, 2, 0, 0.00, 6.40, '2026-09-12 05:52:00', '2026-09-12 05:52:00'),
(165, 62, 22, 'Bananas 1kg', 2.40, 1.10, 3, 0, 0.00, 7.20, '2026-09-12 06:22:00', '2026-09-12 06:22:00'),
(166, 63, 3, 'Orange Juice 1L', 3.50, 1.90, 2, 0, 0.00, 7.00, '2026-09-13 04:09:00', '2026-09-13 04:09:00'),
(167, 63, 4, 'Mineral Water 500ml', 0.75, 0.20, 3, 0, 0.00, 2.25, '2026-09-13 04:09:00', '2026-09-13 04:09:00'),
(168, 63, 7, 'Wholemeal Loaf', 2.80, 1.25, 3, 0, 0.00, 8.40, '2026-09-13 04:09:00', '2026-09-13 04:09:00'),
(169, 63, 24, 'Tomatoes 1kg', 3.10, 1.40, 3, 0, 0.00, 9.30, '2026-09-13 04:09:00', '2026-09-13 04:09:00'),
(170, 64, 8, 'Butter Croissant', 1.95, 0.80, 2, 0, 0.00, 3.90, '2026-09-13 10:03:00', '2026-09-13 10:03:00'),
(171, 64, 16, 'Milk Chocolate Bar 100g', 2.95, 1.35, 1, 0, 0.00, 2.95, '2026-09-13 10:03:00', '2026-09-13 10:03:00'),
(172, 64, 22, 'Bananas 1kg', 2.40, 1.10, 1, 0, 0.00, 2.40, '2026-09-13 10:03:00', '2026-09-13 10:03:00'),
(173, 64, 24, 'Tomatoes 1kg', 3.10, 1.40, 1, 0, 0.00, 3.10, '2026-09-13 10:03:00', '2026-09-13 10:03:00'),
(174, 65, 8, 'Butter Croissant', 1.95, 0.80, 2, 0, 0.00, 3.90, '2026-09-14 10:07:00', '2026-09-14 10:07:00'),
(175, 65, 14, 'Salted Crisps 150g', 1.85, 0.75, 3, 0, 0.00, 5.55, '2026-09-14 10:07:00', '2026-09-14 10:07:00'),
(176, 65, 15, 'Roasted Peanuts 200g', 2.60, 1.10, 1, 0, 0.00, 2.60, '2026-09-14 10:07:00', '2026-09-14 10:07:00'),
(177, 66, 11, 'Greek Yoghurt 500g', 3.25, 1.60, 1, 0, 0.00, 3.25, '2026-09-14 03:40:00', '2026-09-14 03:40:00'),
(178, 67, 1, 'Cola 500ml Can', 1.50, 0.65, 1, 0, 0.00, 1.50, '2026-09-14 06:56:00', '2026-09-14 06:56:00'),
(179, 67, 4, 'Mineral Water 500ml', 0.75, 0.20, 1, 0, 0.00, 0.75, '2026-09-14 06:56:00', '2026-09-14 06:56:00'),
(180, 68, 2, 'Cola 1.5L Bottle', 2.80, 1.40, 1, 0, 0.00, 2.80, '2026-09-15 04:39:00', '2026-09-15 04:39:00'),
(181, 68, 3, 'Orange Juice 1L', 3.50, 1.90, 1, 0, 0.00, 3.50, '2026-09-15 04:39:00', '2026-09-15 04:39:00'),
(182, 68, 20, 'Bin Liners 30ct', 4.50, 2.00, 1, 0, 0.00, 4.50, '2026-09-15 04:39:00', '2026-09-15 04:39:00'),
(183, 68, 23, 'Red Apples 1kg', 3.20, 1.60, 3, 0, 0.00, 9.60, '2026-09-15 04:39:00', '2026-09-15 04:39:00'),
(184, 69, 16, 'Milk Chocolate Bar 100g', 2.95, 1.35, 2, 0, 0.00, 5.90, '2026-09-15 01:14:00', '2026-09-15 01:14:00'),
(185, 69, 20, 'Bin Liners 30ct', 4.50, 2.00, 1, 0, 0.00, 4.50, '2026-09-15 01:14:00', '2026-09-15 01:14:00'),
(186, 70, 2, 'Cola 1.5L Bottle', 2.80, 1.40, 3, 0, 0.00, 8.40, '2026-09-15 10:10:00', '2026-09-15 10:10:00'),
(187, 70, 18, 'Dish Soap 500ml', 2.75, 1.20, 3, 0, 0.00, 8.25, '2026-09-15 10:10:00', '2026-09-15 10:10:00'),
(188, 71, 20, 'Bin Liners 30ct', 4.50, 2.00, 2, 0, 0.00, 9.00, '2026-09-15 03:14:00', '2026-09-15 03:14:00'),
(189, 72, 1, 'Cola 500ml Can', 1.50, 0.65, 1, 0, 0.00, 1.50, '2026-09-16 03:59:00', '2026-09-16 03:59:00'),
(190, 72, 4, 'Mineral Water 500ml', 0.75, 0.20, 3, 0, 0.00, 2.25, '2026-09-16 03:59:00', '2026-09-16 03:59:00'),
(191, 72, 7, 'Wholemeal Loaf', 2.80, 1.25, 2, 0, 0.00, 5.60, '2026-09-16 03:59:00', '2026-09-16 03:59:00'),
(192, 72, 8, 'Butter Croissant', 1.95, 0.80, 1, 0, 0.00, 1.95, '2026-09-16 03:59:00', '2026-09-16 03:59:00'),
(193, 72, 24, 'Tomatoes 1kg', 3.10, 1.40, 3, 0, 0.00, 9.30, '2026-09-16 03:59:00', '2026-09-16 03:59:00'),
(194, 73, 3, 'Orange Juice 1L', 3.50, 1.90, 2, 0, 0.00, 7.00, '2026-09-16 07:33:00', '2026-09-16 07:33:00'),
(195, 73, 6, 'White Sandwich Loaf', 2.50, 1.10, 1, 0, 0.00, 2.50, '2026-09-16 07:33:00', '2026-09-16 07:33:00'),
(196, 73, 19, 'Kitchen Roll (2 rolls)', 3.40, 1.55, 1, 0, 0.00, 3.40, '2026-09-16 07:33:00', '2026-09-16 07:33:00'),
(197, 74, 20, 'Bin Liners 30ct', 4.50, 2.00, 1, 0, 0.00, 4.50, '2026-09-16 07:55:00', '2026-09-16 07:55:00'),
(198, 75, 2, 'Cola 1.5L Bottle', 2.80, 1.40, 1, 0, 0.00, 2.80, '2026-09-16 01:34:00', '2026-09-16 01:34:00'),
(199, 76, 4, 'Mineral Water 500ml', 0.75, 0.20, 2, 0, 0.00, 1.50, '2026-09-17 08:57:00', '2026-09-17 08:57:00'),
(200, 76, 6, 'White Sandwich Loaf', 2.50, 1.10, 2, 0, 0.00, 5.00, '2026-09-17 08:57:00', '2026-09-17 08:57:00'),
(201, 77, 3, 'Orange Juice 1L', 3.50, 1.90, 1, 0, 0.00, 3.50, '2026-09-17 08:42:00', '2026-09-17 08:42:00'),
(202, 77, 12, 'Cheddar Cheese 250g', 5.50, 2.80, 1, 0, 0.00, 5.50, '2026-09-17 08:42:00', '2026-09-17 08:42:00'),
(203, 77, 18, 'Dish Soap 500ml', 2.75, 1.20, 1, 0, 0.00, 2.75, '2026-09-17 08:42:00', '2026-09-17 08:42:00'),
(204, 78, 19, 'Kitchen Roll (2 rolls)', 3.40, 1.55, 2, 0, 0.00, 6.80, '2026-09-17 06:32:00', '2026-09-17 06:32:00'),
(205, 79, 10, 'Whole Milk 1L', 1.85, 0.95, 2, 0, 0.00, 3.70, '2026-09-18 07:28:00', '2026-09-18 07:28:00'),
(206, 80, 2, 'Cola 1.5L Bottle', 2.80, 1.40, 1, 0, 0.00, 2.80, '2026-09-18 10:03:00', '2026-09-18 10:03:00'),
(207, 80, 3, 'Orange Juice 1L', 3.50, 1.90, 3, 0, 0.00, 10.50, '2026-09-18 10:03:00', '2026-09-18 10:03:00'),
(208, 80, 10, 'Whole Milk 1L', 1.85, 0.95, 2, 0, 0.00, 3.70, '2026-09-18 10:03:00', '2026-09-18 10:03:00'),
(209, 80, 22, 'Bananas 1kg', 2.40, 1.10, 2, 0, 0.00, 4.80, '2026-09-18 10:03:00', '2026-09-18 10:03:00'),
(210, 81, 4, 'Mineral Water 500ml', 0.75, 0.20, 1, 0, 0.00, 0.75, '2026-09-18 03:56:00', '2026-09-18 03:56:00'),
(211, 81, 8, 'Butter Croissant', 1.95, 0.80, 2, 0, 0.00, 3.90, '2026-09-18 03:56:00', '2026-09-18 03:56:00'),
(212, 81, 10, 'Whole Milk 1L', 1.85, 0.95, 3, 0, 0.00, 5.55, '2026-09-18 03:56:00', '2026-09-18 03:56:00'),
(213, 81, 18, 'Dish Soap 500ml', 2.75, 1.20, 1, 0, 0.00, 2.75, '2026-09-18 03:56:00', '2026-09-18 03:56:00'),
(214, 82, 22, 'Bananas 1kg', 2.40, 1.10, 2, 0, 0.00, 4.80, '2026-09-19 01:24:00', '2026-09-19 01:24:00'),
(215, 83, 6, 'White Sandwich Loaf', 2.50, 1.10, 1, 0, 0.00, 2.50, '2026-09-20 10:51:00', '2026-09-20 10:51:00'),
(216, 83, 14, 'Salted Crisps 150g', 1.85, 0.75, 2, 0, 0.00, 3.70, '2026-09-20 10:51:00', '2026-09-20 10:51:00'),
(217, 83, 15, 'Roasted Peanuts 200g', 2.60, 1.10, 2, 0, 0.00, 5.20, '2026-09-20 10:51:00', '2026-09-20 10:51:00'),
(218, 83, 18, 'Dish Soap 500ml', 2.75, 1.20, 3, 0, 0.00, 8.25, '2026-09-20 10:51:00', '2026-09-20 10:51:00'),
(219, 84, 6, 'White Sandwich Loaf', 2.50, 1.10, 2, 0, 0.00, 5.00, '2026-09-20 12:25:00', '2026-09-20 12:25:00'),
(220, 84, 19, 'Kitchen Roll (2 rolls)', 3.40, 1.55, 1, 0, 0.00, 3.40, '2026-09-20 12:25:00', '2026-09-20 12:25:00'),
(221, 85, 14, 'Salted Crisps 150g', 1.85, 0.75, 3, 0, 0.00, 5.55, '2026-09-20 03:29:00', '2026-09-20 03:29:00'),
(222, 85, 19, 'Kitchen Roll (2 rolls)', 3.40, 1.55, 3, 0, 0.00, 10.20, '2026-09-20 03:29:00', '2026-09-20 03:29:00'),
(223, 85, 23, 'Red Apples 1kg', 3.20, 1.60, 3, 0, 0.00, 9.60, '2026-09-20 03:29:00', '2026-09-20 03:29:00'),
(224, 86, 11, 'Greek Yoghurt 500g', 3.25, 1.60, 2, 0, 0.00, 6.50, '2026-09-20 05:41:00', '2026-09-20 05:41:00'),
(225, 86, 16, 'Milk Chocolate Bar 100g', 2.95, 1.35, 2, 0, 0.00, 5.90, '2026-09-20 05:41:00', '2026-09-20 05:41:00'),
(226, 87, 15, 'Roasted Peanuts 200g', 2.60, 1.10, 1, 0, 0.00, 2.60, '2026-09-20 09:39:00', '2026-09-20 09:39:00'),
(227, 87, 18, 'Dish Soap 500ml', 2.75, 1.20, 3, 0, 0.00, 8.25, '2026-09-20 09:39:00', '2026-09-20 09:39:00'),
(228, 88, 2, 'Cola 1.5L Bottle', 2.80, 1.40, 1, 0, 0.00, 2.80, '2026-09-20 02:53:00', '2026-09-20 02:53:00'),
(229, 88, 4, 'Mineral Water 500ml', 0.75, 0.20, 1, 0, 0.00, 0.75, '2026-09-20 02:53:00', '2026-09-20 02:53:00'),
(230, 88, 7, 'Wholemeal Loaf', 2.80, 1.25, 3, 0, 0.00, 8.40, '2026-09-20 02:53:00', '2026-09-20 02:53:00'),
(231, 88, 19, 'Kitchen Roll (2 rolls)', 3.40, 1.55, 2, 0, 0.00, 6.80, '2026-09-20 02:53:00', '2026-09-20 02:53:00'),
(232, 88, 23, 'Red Apples 1kg', 3.20, 1.60, 3, 0, 0.00, 9.60, '2026-09-20 02:53:00', '2026-09-20 02:53:00'),
(233, 89, 6, 'White Sandwich Loaf', 2.50, 1.10, 2, 0, 0.00, 5.00, '2026-09-20 06:27:00', '2026-09-20 06:27:00'),
(234, 90, 12, 'Cheddar Cheese 250g', 5.50, 2.80, 2, 0, 0.00, 11.00, '2026-09-21 07:04:00', '2026-09-21 07:04:00'),
(235, 90, 14, 'Salted Crisps 150g', 1.85, 0.75, 2, 0, 0.00, 3.70, '2026-09-21 07:04:00', '2026-09-21 07:04:00'),
(236, 91, 4, 'Mineral Water 500ml', 0.75, 0.20, 2, 0, 0.00, 1.50, '2026-09-21 04:51:00', '2026-09-21 04:51:00'),
(237, 91, 10, 'Whole Milk 1L', 1.85, 0.95, 1, 0, 0.00, 1.85, '2026-09-21 04:51:00', '2026-09-21 04:51:00'),
(238, 91, 23, 'Red Apples 1kg', 3.20, 1.60, 1, 0, 0.00, 3.20, '2026-09-21 04:51:00', '2026-09-21 04:51:00'),
(239, 92, 7, 'Wholemeal Loaf', 2.80, 1.25, 3, 0, 0.00, 8.40, '2026-09-21 06:29:00', '2026-09-21 06:29:00'),
(240, 93, 23, 'Red Apples 1kg', 3.20, 1.60, 2, 0, 0.00, 6.40, '2026-09-22 11:03:00', '2026-09-22 11:03:00'),
(241, 94, 15, 'Roasted Peanuts 200g', 2.60, 1.10, 2, 0, 0.00, 5.20, '2026-09-22 12:42:00', '2026-09-22 12:42:00'),
(242, 94, 18, 'Dish Soap 500ml', 2.75, 1.20, 2, 0, 0.00, 5.50, '2026-09-22 12:42:00', '2026-09-22 12:42:00'),
(243, 94, 22, 'Bananas 1kg', 2.40, 1.10, 1, 0, 0.00, 2.40, '2026-09-22 12:42:00', '2026-09-22 12:42:00'),
(244, 95, 2, 'Cola 1.5L Bottle', 2.80, 1.40, 3, 0, 0.00, 8.40, '2026-09-23 06:05:00', '2026-09-23 06:05:00'),
(245, 95, 23, 'Red Apples 1kg', 3.20, 1.60, 1, 0, 0.00, 3.20, '2026-09-23 06:05:00', '2026-09-23 06:05:00'),
(246, 96, 11, 'Greek Yoghurt 500g', 3.25, 1.60, 1, 0, 0.00, 3.25, '2026-09-23 03:14:00', '2026-09-23 03:14:00'),
(247, 96, 16, 'Milk Chocolate Bar 100g', 2.95, 1.35, 1, 0, 0.00, 2.95, '2026-09-23 03:14:00', '2026-09-23 03:14:00'),
(248, 97, 2, 'Cola 1.5L Bottle', 2.80, 1.40, 3, 0, 0.00, 8.40, '2026-09-23 10:03:00', '2026-09-23 10:03:00'),
(249, 97, 14, 'Salted Crisps 150g', 1.85, 0.75, 3, 0, 0.00, 5.55, '2026-09-23 10:03:00', '2026-09-23 10:03:00'),
(250, 98, 1, 'Cola 500ml Can', 1.50, 0.65, 3, 0, 0.00, 4.50, '2026-09-25 06:05:00', '2026-09-25 06:05:00'),
(251, 98, 2, 'Cola 1.5L Bottle', 2.80, 1.40, 3, 0, 0.00, 8.40, '2026-09-25 06:05:00', '2026-09-25 06:05:00'),
(252, 98, 16, 'Milk Chocolate Bar 100g', 2.95, 1.35, 2, 0, 0.00, 5.90, '2026-09-25 06:05:00', '2026-09-25 06:05:00'),
(253, 98, 23, 'Red Apples 1kg', 3.20, 1.60, 1, 0, 0.00, 3.20, '2026-09-25 06:05:00', '2026-09-25 06:05:00'),
(254, 99, 11, 'Greek Yoghurt 500g', 3.25, 1.60, 3, 0, 0.00, 9.75, '2026-09-26 07:37:00', '2026-09-26 07:37:00'),
(255, 100, 2, 'Cola 1.5L Bottle', 2.80, 1.40, 1, 0, 0.00, 2.80, '2026-09-26 05:55:00', '2026-09-26 05:55:00'),
(256, 101, 2, 'Cola 1.5L Bottle', 2.80, 1.40, 3, 0, 0.00, 8.40, '2026-09-26 04:20:00', '2026-09-26 04:20:00'),
(257, 101, 12, 'Cheddar Cheese 250g', 5.50, 2.80, 1, 0, 0.00, 5.50, '2026-09-26 04:20:00', '2026-09-26 04:20:00'),
(258, 102, 8, 'Butter Croissant', 1.95, 0.80, 1, 0, 0.00, 1.95, '2026-09-26 10:45:33', '2026-09-26 10:45:33'),
(259, 102, 26, 'Chocolate Chip', 70.00, 55.00, 1, 0, 0.00, 70.00, '2026-09-26 10:45:33', '2026-09-26 10:45:33'),
(260, 103, 26, 'Chocolate Chip', 70.00, 55.00, 4, 0, 0.00, 280.00, '2026-09-26 10:52:37', '2026-09-26 10:52:37');

-- --------------------------------------------------------

--
-- Table structure for table `order_item_batches`
--

CREATE TABLE `order_item_batches` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `order_item_id` bigint(20) UNSIGNED NOT NULL,
  `batch_id` bigint(20) UNSIGNED DEFAULT NULL,
  `quantity` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `order_item_batches`
--

INSERT INTO `order_item_batches` (`id`, `order_item_id`, `batch_id`, `quantity`, `created_at`, `updated_at`) VALUES
(1, 1, 3, 1, '2026-09-26 10:03:18', '2026-09-26 10:03:18'),
(2, 2, 8, 1, '2026-09-26 10:03:18', '2026-09-26 10:03:18'),
(3, 3, 17, 2, '2026-09-26 10:03:18', '2026-09-26 10:03:18'),
(4, 4, 1, 2, '2026-09-26 10:03:18', '2026-09-26 10:03:18'),
(5, 5, 15, 3, '2026-09-26 10:03:18', '2026-09-26 10:03:18'),
(6, 6, 21, 1, '2026-09-26 10:03:18', '2026-09-26 10:03:18'),
(7, 7, 5, 2, '2026-09-26 10:03:18', '2026-09-26 10:03:18'),
(8, 8, 10, 2, '2026-09-26 10:03:18', '2026-09-26 10:03:18'),
(9, 9, 8, 1, '2026-09-26 10:03:18', '2026-09-26 10:03:18'),
(10, 10, 11, 3, '2026-09-26 10:03:18', '2026-09-26 10:03:18'),
(11, 11, 12, 3, '2026-09-26 10:03:18', '2026-09-26 10:03:18'),
(12, 12, 18, 3, '2026-09-26 10:03:18', '2026-09-26 10:03:18'),
(13, 13, 22, 3, '2026-09-26 10:03:18', '2026-09-26 10:03:18'),
(14, 14, 2, 1, '2026-09-26 10:03:18', '2026-09-26 10:03:18'),
(15, 15, 12, 1, '2026-09-26 10:03:18', '2026-09-26 10:03:18'),
(16, 16, 17, 2, '2026-09-26 10:03:18', '2026-09-26 10:03:18'),
(17, 17, 1, 2, '2026-09-26 10:03:18', '2026-09-26 10:03:18'),
(18, 18, 3, 2, '2026-09-26 10:03:18', '2026-09-26 10:03:18'),
(19, 19, 5, 1, '2026-09-26 10:03:18', '2026-09-26 10:03:18'),
(20, 20, 14, 3, '2026-09-26 10:03:18', '2026-09-26 10:03:18'),
(21, 21, 1, 2, '2026-09-26 10:03:19', '2026-09-26 10:03:19'),
(22, 22, 2, 1, '2026-09-26 10:03:19', '2026-09-26 10:03:19'),
(23, 23, 8, 3, '2026-09-26 10:03:19', '2026-09-26 10:03:19'),
(24, 24, 10, 3, '2026-09-26 10:03:19', '2026-09-26 10:03:19'),
(25, 25, 14, 1, '2026-09-26 10:03:19', '2026-09-26 10:03:19'),
(26, 26, 15, 3, '2026-09-26 10:03:19', '2026-09-26 10:03:19'),
(27, 27, 22, 2, '2026-09-26 10:03:19', '2026-09-26 10:03:19'),
(28, 28, 3, 1, '2026-09-26 10:03:19', '2026-09-26 10:03:19'),
(29, 29, 11, 1, '2026-09-26 10:03:19', '2026-09-26 10:03:19'),
(30, 30, 7, 1, '2026-09-26 10:03:19', '2026-09-26 10:03:19'),
(31, 31, 8, 3, '2026-09-26 10:03:19', '2026-09-26 10:03:19'),
(32, 32, 16, 2, '2026-09-26 10:03:19', '2026-09-26 10:03:19'),
(33, 33, 18, 2, '2026-09-26 10:03:19', '2026-09-26 10:03:19'),
(34, 34, 21, 3, '2026-09-26 10:03:19', '2026-09-26 10:03:19'),
(35, 35, 10, 2, '2026-09-26 10:03:19', '2026-09-26 10:03:19'),
(36, 36, 19, 1, '2026-09-26 10:03:19', '2026-09-26 10:03:19'),
(37, 37, 5, 3, '2026-09-26 10:03:19', '2026-09-26 10:03:19'),
(38, 38, 7, 2, '2026-09-26 10:03:19', '2026-09-26 10:03:19'),
(39, 39, 1, 3, '2026-09-26 10:03:19', '2026-09-26 10:03:19'),
(40, 40, 2, 3, '2026-09-26 10:03:19', '2026-09-26 10:03:19'),
(41, 41, 12, 1, '2026-09-26 10:03:19', '2026-09-26 10:03:19'),
(42, 42, 21, 1, '2026-09-26 10:03:19', '2026-09-26 10:03:19'),
(43, 43, 22, 3, '2026-09-26 10:03:19', '2026-09-26 10:03:19'),
(44, 44, 16, 3, '2026-09-26 10:03:19', '2026-09-26 10:03:19'),
(45, 45, 22, 3, '2026-09-26 10:03:19', '2026-09-26 10:03:19'),
(46, 46, 1, 1, '2026-09-26 10:03:19', '2026-09-26 10:03:19'),
(47, 47, 3, 2, '2026-09-26 10:03:19', '2026-09-26 10:03:19'),
(48, 48, 8, 3, '2026-09-26 10:03:19', '2026-09-26 10:03:19'),
(49, 49, 22, 1, '2026-09-26 10:03:19', '2026-09-26 10:03:19'),
(50, 50, 23, 2, '2026-09-26 10:03:19', '2026-09-26 10:03:19'),
(51, 51, 7, 2, '2026-09-26 10:03:19', '2026-09-26 10:03:19'),
(52, 52, 11, 1, '2026-09-26 10:03:19', '2026-09-26 10:03:19'),
(53, 53, 15, 3, '2026-09-26 10:03:19', '2026-09-26 10:03:19'),
(54, 54, 6, 3, '2026-09-26 10:03:19', '2026-09-26 10:03:19'),
(55, 55, 8, 3, '2026-09-26 10:03:19', '2026-09-26 10:03:19'),
(56, 56, 23, 3, '2026-09-26 10:03:19', '2026-09-26 10:03:19'),
(57, 57, 16, 1, '2026-09-26 10:03:19', '2026-09-26 10:03:19'),
(58, 58, 11, 3, '2026-09-26 10:03:19', '2026-09-26 10:03:19'),
(59, 59, 17, 1, '2026-09-26 10:03:19', '2026-09-26 10:03:19'),
(60, 60, 22, 1, '2026-09-26 10:03:19', '2026-09-26 10:03:19'),
(61, 61, 1, 1, '2026-09-26 10:03:19', '2026-09-26 10:03:19'),
(62, 62, 5, 1, '2026-09-26 10:03:19', '2026-09-26 10:03:19'),
(63, 63, 6, 1, '2026-09-26 10:03:19', '2026-09-26 10:03:19'),
(64, 64, 8, 2, '2026-09-26 10:03:19', '2026-09-26 10:03:19'),
(65, 65, 20, 2, '2026-09-26 10:03:19', '2026-09-26 10:03:19'),
(66, 66, 16, 1, '2026-09-26 10:03:19', '2026-09-26 10:03:19'),
(67, 67, 1, 2, '2026-09-26 10:03:19', '2026-09-26 10:03:19'),
(68, 68, 7, 2, '2026-09-26 10:03:19', '2026-09-26 10:03:19'),
(69, 69, 2, 1, '2026-09-26 10:03:20', '2026-09-26 10:03:20'),
(70, 70, 19, 1, '2026-09-26 10:03:20', '2026-09-26 10:03:20'),
(71, 71, 11, 1, '2026-09-26 10:03:20', '2026-09-26 10:03:20'),
(72, 72, 7, 3, '2026-09-26 10:03:20', '2026-09-26 10:03:20'),
(73, 73, 3, 1, '2026-09-26 10:03:20', '2026-09-26 10:03:20'),
(74, 74, 21, 2, '2026-09-26 10:03:20', '2026-09-26 10:03:20'),
(75, 75, 8, 2, '2026-09-26 10:03:20', '2026-09-26 10:03:20'),
(76, 76, 14, 2, '2026-09-26 10:03:20', '2026-09-26 10:03:20'),
(77, 77, 1, 2, '2026-09-26 10:03:20', '2026-09-26 10:03:20'),
(78, 78, 2, 1, '2026-09-26 10:03:20', '2026-09-26 10:03:20'),
(79, 79, 21, 1, '2026-09-26 10:03:20', '2026-09-26 10:03:20'),
(80, 80, 1, 1, '2026-09-26 10:03:20', '2026-09-26 10:03:20'),
(81, 81, 2, 2, '2026-09-26 10:03:20', '2026-09-26 10:03:20'),
(82, 82, 5, 3, '2026-09-26 10:03:20', '2026-09-26 10:03:20'),
(83, 83, 14, 2, '2026-09-26 10:03:20', '2026-09-26 10:03:20'),
(84, 84, 7, 1, '2026-09-26 10:03:20', '2026-09-26 10:03:20'),
(85, 85, 15, 1, '2026-09-26 10:03:20', '2026-09-26 10:03:20'),
(86, 86, 16, 2, '2026-09-26 10:03:20', '2026-09-26 10:03:20'),
(87, 87, 19, 1, '2026-09-26 10:03:20', '2026-09-26 10:03:20'),
(88, 88, 22, 3, '2026-09-26 10:03:20', '2026-09-26 10:03:20'),
(89, 89, 3, 2, '2026-09-26 10:03:20', '2026-09-26 10:03:20'),
(90, 90, 8, 3, '2026-09-26 10:03:20', '2026-09-26 10:03:20'),
(91, 91, 20, 3, '2026-09-26 10:03:20', '2026-09-26 10:03:20'),
(92, 92, 22, 2, '2026-09-26 10:03:20', '2026-09-26 10:03:20'),
(93, 93, 23, 3, '2026-09-26 10:03:20', '2026-09-26 10:03:20'),
(94, 94, 2, 1, '2026-09-26 10:03:20', '2026-09-26 10:03:20'),
(95, 95, 9, 1, '2026-09-26 10:03:20', '2026-09-26 10:03:20'),
(96, 96, 11, 1, '2026-09-26 10:03:20', '2026-09-26 10:03:20'),
(97, 97, 14, 3, '2026-09-26 10:03:20', '2026-09-26 10:03:20'),
(98, 98, 20, 2, '2026-09-26 10:03:20', '2026-09-26 10:03:20'),
(99, 99, 21, 3, '2026-09-26 10:03:20', '2026-09-26 10:03:20'),
(100, 100, 4, 1, '2026-09-26 10:03:20', '2026-09-26 10:03:20'),
(101, 101, 14, 1, '2026-09-26 10:03:20', '2026-09-26 10:03:20'),
(102, 102, 20, 3, '2026-09-26 10:03:20', '2026-09-26 10:03:20'),
(103, 103, 15, 1, '2026-09-26 10:03:20', '2026-09-26 10:03:20'),
(104, 104, 20, 2, '2026-09-26 10:03:20', '2026-09-26 10:03:20'),
(105, 105, 21, 2, '2026-09-26 10:03:20', '2026-09-26 10:03:20'),
(106, 106, 23, 2, '2026-09-26 10:03:20', '2026-09-26 10:03:20'),
(107, 107, 9, 3, '2026-09-26 10:03:20', '2026-09-26 10:03:20'),
(108, 108, 14, 1, '2026-09-26 10:03:20', '2026-09-26 10:03:20'),
(109, 109, 19, 3, '2026-09-26 10:03:20', '2026-09-26 10:03:20'),
(110, 110, 7, 3, '2026-09-26 10:03:20', '2026-09-26 10:03:20'),
(111, 111, 9, 1, '2026-09-26 10:03:20', '2026-09-26 10:03:20'),
(112, 112, 16, 1, '2026-09-26 10:03:20', '2026-09-26 10:03:20'),
(113, 113, 5, 3, '2026-09-26 10:03:21', '2026-09-26 10:03:21'),
(114, 114, 9, 3, '2026-09-26 10:03:21', '2026-09-26 10:03:21'),
(115, 115, 10, 3, '2026-09-26 10:03:21', '2026-09-26 10:03:21'),
(116, 116, 19, 2, '2026-09-26 10:03:21', '2026-09-26 10:03:21'),
(117, 117, 10, 3, '2026-09-26 10:03:21', '2026-09-26 10:03:21'),
(118, 118, 5, 3, '2026-09-26 10:03:21', '2026-09-26 10:03:21'),
(119, 119, 8, 3, '2026-09-26 10:03:21', '2026-09-26 10:03:21'),
(120, 120, 15, 1, '2026-09-26 10:03:21', '2026-09-26 10:03:21'),
(121, 121, 17, 3, '2026-09-26 10:03:21', '2026-09-26 10:03:21'),
(122, 122, 12, 1, '2026-09-26 10:03:21', '2026-09-26 10:03:21'),
(123, 123, 1, 3, '2026-09-26 10:03:21', '2026-09-26 10:03:21'),
(124, 124, 5, 1, '2026-09-26 10:03:21', '2026-09-26 10:03:21'),
(125, 125, 23, 2, '2026-09-26 10:03:21', '2026-09-26 10:03:21'),
(126, 126, 2, 1, '2026-09-26 10:03:21', '2026-09-26 10:03:21'),
(127, 127, 11, 1, '2026-09-26 10:03:21', '2026-09-26 10:03:21'),
(128, 128, 3, 3, '2026-09-26 10:03:21', '2026-09-26 10:03:21'),
(129, 129, 7, 2, '2026-09-26 10:03:21', '2026-09-26 10:03:21'),
(130, 130, 15, 3, '2026-09-26 10:03:21', '2026-09-26 10:03:21'),
(131, 131, 22, 1, '2026-09-26 10:03:21', '2026-09-26 10:03:21'),
(132, 132, 2, 2, '2026-09-26 10:03:21', '2026-09-26 10:03:21'),
(133, 133, 8, 2, '2026-09-26 10:03:21', '2026-09-26 10:03:21'),
(134, 134, 17, 2, '2026-09-26 10:03:21', '2026-09-26 10:03:21'),
(135, 135, 10, 3, '2026-09-26 10:03:21', '2026-09-26 10:03:21'),
(136, 136, 15, 2, '2026-09-26 10:03:21', '2026-09-26 10:03:21'),
(137, 137, 19, 3, '2026-09-26 10:03:21', '2026-09-26 10:03:21'),
(138, 138, 10, 2, '2026-09-26 10:03:21', '2026-09-26 10:03:21'),
(139, 139, 12, 2, '2026-09-26 10:03:21', '2026-09-26 10:03:21'),
(140, 140, 16, 2, '2026-09-26 10:03:21', '2026-09-26 10:03:21'),
(141, 141, 21, 3, '2026-09-26 10:03:21', '2026-09-26 10:03:21'),
(142, 142, 22, 2, '2026-09-26 10:03:21', '2026-09-26 10:03:21'),
(143, 143, 5, 1, '2026-09-26 10:03:21', '2026-09-26 10:03:21'),
(144, 144, 12, 3, '2026-09-26 10:03:21', '2026-09-26 10:03:21'),
(145, 145, 23, 3, '2026-09-26 10:03:21', '2026-09-26 10:03:21'),
(146, 146, 2, 2, '2026-09-26 10:03:21', '2026-09-26 10:03:21'),
(147, 147, 3, 1, '2026-09-26 10:03:21', '2026-09-26 10:03:21'),
(148, 148, 8, 3, '2026-09-26 10:03:21', '2026-09-26 10:03:21'),
(149, 149, 1, 2, '2026-09-26 10:03:21', '2026-09-26 10:03:21'),
(150, 150, 14, 3, '2026-09-26 10:03:21', '2026-09-26 10:03:21'),
(151, 151, 21, 1, '2026-09-26 10:03:21', '2026-09-26 10:03:21'),
(152, 152, 3, 1, '2026-09-26 10:03:21', '2026-09-26 10:03:21'),
(153, 153, 6, 1, '2026-09-26 10:03:21', '2026-09-26 10:03:21'),
(154, 154, 7, 3, '2026-09-26 10:03:21', '2026-09-26 10:03:21'),
(155, 155, 12, 1, '2026-09-26 10:03:22', '2026-09-26 10:03:22'),
(156, 156, 21, 2, '2026-09-26 10:03:22', '2026-09-26 10:03:22'),
(157, 157, 22, 3, '2026-09-26 10:03:22', '2026-09-26 10:03:22'),
(158, 158, 11, 1, '2026-09-26 10:03:22', '2026-09-26 10:03:22'),
(159, 159, 16, 3, '2026-09-26 10:03:22', '2026-09-26 10:03:22'),
(160, 160, 2, 1, '2026-09-26 10:03:22', '2026-09-26 10:03:22'),
(161, 161, 3, 1, '2026-09-26 10:03:22', '2026-09-26 10:03:22'),
(162, 162, 10, 1, '2026-09-26 10:03:22', '2026-09-26 10:03:22'),
(163, 163, 17, 3, '2026-09-26 10:03:22', '2026-09-26 10:03:22'),
(164, 164, 22, 2, '2026-09-26 10:03:22', '2026-09-26 10:03:22'),
(165, 165, 21, 3, '2026-09-26 10:03:22', '2026-09-26 10:03:22'),
(166, 166, 3, 2, '2026-09-26 10:03:22', '2026-09-26 10:03:22'),
(167, 167, 4, 3, '2026-09-26 10:03:22', '2026-09-26 10:03:22'),
(168, 168, 7, 3, '2026-09-26 10:03:22', '2026-09-26 10:03:22'),
(169, 169, 23, 3, '2026-09-26 10:03:22', '2026-09-26 10:03:22'),
(170, 170, 8, 2, '2026-09-26 10:03:22', '2026-09-26 10:03:22'),
(171, 171, 16, 1, '2026-09-26 10:03:22', '2026-09-26 10:03:22'),
(172, 172, 21, 1, '2026-09-26 10:03:22', '2026-09-26 10:03:22'),
(173, 173, 23, 1, '2026-09-26 10:03:22', '2026-09-26 10:03:22'),
(174, 174, 8, 2, '2026-09-26 10:03:22', '2026-09-26 10:03:22'),
(175, 175, 14, 3, '2026-09-26 10:03:22', '2026-09-26 10:03:22'),
(176, 176, 15, 1, '2026-09-26 10:03:22', '2026-09-26 10:03:22'),
(177, 177, 11, 1, '2026-09-26 10:03:22', '2026-09-26 10:03:22'),
(178, 178, 1, 1, '2026-09-26 10:03:22', '2026-09-26 10:03:22'),
(179, 179, 4, 1, '2026-09-26 10:03:22', '2026-09-26 10:03:22'),
(180, 180, 2, 1, '2026-09-26 10:03:22', '2026-09-26 10:03:22'),
(181, 181, 3, 1, '2026-09-26 10:03:22', '2026-09-26 10:03:22'),
(182, 182, 19, 1, '2026-09-26 10:03:22', '2026-09-26 10:03:22'),
(183, 183, 22, 3, '2026-09-26 10:03:22', '2026-09-26 10:03:22'),
(184, 184, 16, 2, '2026-09-26 10:03:22', '2026-09-26 10:03:22'),
(185, 185, 19, 1, '2026-09-26 10:03:22', '2026-09-26 10:03:22'),
(186, 186, 2, 3, '2026-09-26 10:03:22', '2026-09-26 10:03:22'),
(187, 187, 17, 3, '2026-09-26 10:03:22', '2026-09-26 10:03:22'),
(188, 188, 19, 2, '2026-09-26 10:03:22', '2026-09-26 10:03:22'),
(189, 189, 1, 1, '2026-09-26 10:03:22', '2026-09-26 10:03:22'),
(190, 190, 4, 3, '2026-09-26 10:03:22', '2026-09-26 10:03:22'),
(191, 191, 7, 2, '2026-09-26 10:03:22', '2026-09-26 10:03:22'),
(192, 192, 8, 1, '2026-09-26 10:03:22', '2026-09-26 10:03:22'),
(193, 193, 23, 3, '2026-09-26 10:03:22', '2026-09-26 10:03:22'),
(194, 194, 3, 2, '2026-09-26 10:03:22', '2026-09-26 10:03:22'),
(195, 195, 6, 1, '2026-09-26 10:03:22', '2026-09-26 10:03:22'),
(196, 196, 18, 1, '2026-09-26 10:03:22', '2026-09-26 10:03:22'),
(197, 197, 19, 1, '2026-09-26 10:03:23', '2026-09-26 10:03:23'),
(198, 198, 2, 1, '2026-09-26 10:03:23', '2026-09-26 10:03:23'),
(199, 199, 4, 2, '2026-09-26 10:03:23', '2026-09-26 10:03:23'),
(200, 200, 6, 2, '2026-09-26 10:03:23', '2026-09-26 10:03:23'),
(201, 201, 3, 1, '2026-09-26 10:03:23', '2026-09-26 10:03:23'),
(202, 202, 12, 1, '2026-09-26 10:03:23', '2026-09-26 10:03:23'),
(203, 203, 17, 1, '2026-09-26 10:03:23', '2026-09-26 10:03:23'),
(204, 204, 18, 2, '2026-09-26 10:03:23', '2026-09-26 10:03:23'),
(205, 205, 10, 2, '2026-09-26 10:03:23', '2026-09-26 10:03:23'),
(206, 206, 2, 1, '2026-09-26 10:03:23', '2026-09-26 10:03:23'),
(207, 207, 3, 3, '2026-09-26 10:03:23', '2026-09-26 10:03:23'),
(208, 208, 10, 2, '2026-09-26 10:03:23', '2026-09-26 10:03:23'),
(209, 209, 21, 2, '2026-09-26 10:03:23', '2026-09-26 10:03:23'),
(210, 210, 4, 1, '2026-09-26 10:03:23', '2026-09-26 10:03:23'),
(211, 211, 8, 2, '2026-09-26 10:03:23', '2026-09-26 10:03:23'),
(212, 212, 10, 3, '2026-09-26 10:03:23', '2026-09-26 10:03:23'),
(213, 213, 17, 1, '2026-09-26 10:03:23', '2026-09-26 10:03:23'),
(214, 214, 21, 2, '2026-09-26 10:03:23', '2026-09-26 10:03:23'),
(215, 215, 6, 1, '2026-09-26 10:03:23', '2026-09-26 10:03:23'),
(216, 216, 14, 2, '2026-09-26 10:03:23', '2026-09-26 10:03:23'),
(217, 217, 15, 2, '2026-09-26 10:03:23', '2026-09-26 10:03:23'),
(218, 218, 17, 3, '2026-09-26 10:03:23', '2026-09-26 10:03:23'),
(219, 219, 6, 2, '2026-09-26 10:03:23', '2026-09-26 10:03:23'),
(220, 220, 18, 1, '2026-09-26 10:03:23', '2026-09-26 10:03:23'),
(221, 221, 14, 3, '2026-09-26 10:03:23', '2026-09-26 10:03:23'),
(222, 222, 18, 3, '2026-09-26 10:03:23', '2026-09-26 10:03:23'),
(223, 223, 22, 3, '2026-09-26 10:03:23', '2026-09-26 10:03:23'),
(224, 224, 11, 2, '2026-09-26 10:03:23', '2026-09-26 10:03:23'),
(225, 225, 16, 2, '2026-09-26 10:03:23', '2026-09-26 10:03:23'),
(226, 226, 15, 1, '2026-09-26 10:03:23', '2026-09-26 10:03:23'),
(227, 227, 17, 3, '2026-09-26 10:03:23', '2026-09-26 10:03:23'),
(228, 228, 2, 1, '2026-09-26 10:03:23', '2026-09-26 10:03:23'),
(229, 229, 4, 1, '2026-09-26 10:03:23', '2026-09-26 10:03:23'),
(230, 230, 7, 3, '2026-09-26 10:03:23', '2026-09-26 10:03:23'),
(231, 231, 18, 2, '2026-09-26 10:03:23', '2026-09-26 10:03:23'),
(232, 232, 22, 3, '2026-09-26 10:03:23', '2026-09-26 10:03:23'),
(233, 233, 6, 2, '2026-09-26 10:03:23', '2026-09-26 10:03:23'),
(234, 234, 12, 2, '2026-09-26 10:03:24', '2026-09-26 10:03:24'),
(235, 235, 14, 2, '2026-09-26 10:03:24', '2026-09-26 10:03:24'),
(236, 236, 4, 2, '2026-09-26 10:03:24', '2026-09-26 10:03:24'),
(237, 237, 10, 1, '2026-09-26 10:03:24', '2026-09-26 10:03:24'),
(238, 238, 22, 1, '2026-09-26 10:03:24', '2026-09-26 10:03:24'),
(239, 239, 7, 3, '2026-09-26 10:03:24', '2026-09-26 10:03:24'),
(240, 240, 22, 2, '2026-09-26 10:03:24', '2026-09-26 10:03:24'),
(241, 241, 15, 2, '2026-09-26 10:03:24', '2026-09-26 10:03:24'),
(242, 242, 17, 2, '2026-09-26 10:03:24', '2026-09-26 10:03:24'),
(243, 243, 21, 1, '2026-09-26 10:03:24', '2026-09-26 10:03:24'),
(244, 244, 2, 3, '2026-09-26 10:03:24', '2026-09-26 10:03:24'),
(245, 245, 22, 1, '2026-09-26 10:03:24', '2026-09-26 10:03:24'),
(246, 246, 11, 1, '2026-09-26 10:03:24', '2026-09-26 10:03:24'),
(247, 247, 16, 1, '2026-09-26 10:03:24', '2026-09-26 10:03:24'),
(248, 248, 2, 3, '2026-09-26 10:03:24', '2026-09-26 10:03:24'),
(249, 249, 14, 3, '2026-09-26 10:03:24', '2026-09-26 10:03:24'),
(250, 250, 1, 3, '2026-09-26 10:03:24', '2026-09-26 10:03:24'),
(251, 251, 2, 3, '2026-09-26 10:03:24', '2026-09-26 10:03:24'),
(252, 252, 16, 2, '2026-09-26 10:03:24', '2026-09-26 10:03:24'),
(253, 253, 22, 1, '2026-09-26 10:03:24', '2026-09-26 10:03:24'),
(254, 254, 11, 3, '2026-09-26 10:03:24', '2026-09-26 10:03:24'),
(255, 255, 2, 1, '2026-09-26 10:03:24', '2026-09-26 10:03:24'),
(256, 256, 2, 3, '2026-09-26 10:03:24', '2026-09-26 10:03:24'),
(257, 257, 12, 1, '2026-09-26 10:03:24', '2026-09-26 10:03:24'),
(258, 258, 27, 1, '2026-09-26 10:45:33', '2026-09-26 10:45:33'),
(259, 259, 30, 1, '2026-09-26 10:45:33', '2026-09-26 10:45:33'),
(260, 260, 30, 4, '2026-09-26 10:52:37', '2026-09-26 10:52:37');

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `category_id` bigint(20) UNSIGNED DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `image_path` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `cost_price` decimal(12,2) NOT NULL DEFAULT 0.00,
  `selling_price` decimal(12,2) NOT NULL,
  `stock` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `low_stock_threshold` int(10) UNSIGNED NOT NULL DEFAULT 5,
  `unit` varchar(20) NOT NULL DEFAULT 'pcs',
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `category_id`, `name`, `image_path`, `description`, `cost_price`, `selling_price`, `stock`, `low_stock_threshold`, `unit`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 1, 'Cola 500ml Can', NULL, NULL, 0.65, 1.50, 94, 24, 'pcs', 1, '2026-09-26 10:03:18', '2026-09-26 10:03:24'),
(2, 1, 'Cola 1.5L Bottle', NULL, NULL, 1.40, 2.80, 28, 12, 'pcs', 1, '2026-09-26 10:03:18', '2026-09-26 10:03:24'),
(3, 1, 'Orange Juice 1L', NULL, NULL, 1.90, 3.50, 16, 10, 'pcs', 1, '2026-09-26 10:03:18', '2026-09-26 10:03:23'),
(4, 1, 'Mineral Water 500ml', NULL, NULL, 0.20, 0.75, 186, 48, 'pcs', 1, '2026-09-26 10:03:18', '2026-09-26 10:03:24'),
(5, 1, 'Ground Coffee 250g', NULL, NULL, 4.20, 7.99, 18, 6, 'pcs', 1, '2026-09-26 10:03:18', '2026-09-26 10:03:24'),
(6, 2, 'White Sandwich Loaf', NULL, NULL, 1.10, 2.50, 32, 10, 'pcs', 1, '2026-09-26 10:03:18', '2026-09-26 10:03:23'),
(7, 2, 'Wholemeal Loaf', NULL, NULL, 1.25, 2.80, 30, 10, 'pcs', 1, '2026-09-26 10:03:18', '2026-09-26 10:03:24'),
(8, 2, 'Butter Croissant', NULL, NULL, 0.80, 1.95, 35, 12, 'pcs', 1, '2026-09-26 10:03:18', '2026-09-26 10:45:33'),
(9, 2, 'Chocolate Muffin', NULL, NULL, 0.70, 1.75, 30, 10, 'pcs', 1, '2026-09-26 10:03:18', '2026-09-26 10:03:24'),
(10, 3, 'Whole Milk 1L', NULL, NULL, 0.95, 1.85, 63, 24, 'pcs', 1, '2026-09-26 10:03:18', '2026-09-26 10:03:24'),
(11, 3, 'Greek Yoghurt 500g', NULL, NULL, 1.60, 3.25, 7, 8, 'pcs', 1, '2026-09-26 10:03:18', '2026-09-26 10:03:24'),
(12, 3, 'Cheddar Cheese 250g', NULL, NULL, 2.80, 5.50, 7, 8, 'pcs', 1, '2026-09-26 10:03:18', '2026-09-26 10:03:24'),
(13, 3, 'Salted Butter 250g', NULL, NULL, 2.10, 4.25, 3, 6, 'pcs', 1, '2026-09-26 10:03:18', '2026-09-26 10:03:18'),
(14, 4, 'Salted Crisps 150g', NULL, NULL, 0.75, 1.85, 41, 18, 'pcs', 1, '2026-09-26 10:03:18', '2026-09-26 10:03:24'),
(15, 4, 'Roasted Peanuts 200g', NULL, NULL, 1.10, 2.60, 17, 10, 'pcs', 1, '2026-09-26 10:03:18', '2026-09-26 10:03:24'),
(16, 4, 'Milk Chocolate Bar 100g', NULL, NULL, 1.35, 2.95, 32, 15, 'pcs', 1, '2026-09-26 10:03:18', '2026-09-26 10:03:24'),
(17, 4, 'Digestive Biscuits 300g', NULL, NULL, 0.90, 2.20, 30, 10, 'pcs', 1, '2026-09-26 10:03:18', '2026-09-26 10:03:24'),
(18, 5, 'Dish Soap 500ml', NULL, NULL, 1.20, 2.75, 8, 8, 'pcs', 1, '2026-09-26 10:03:18', '2026-09-26 10:03:24'),
(19, 5, 'Kitchen Roll (2 rolls)', NULL, NULL, 1.55, 3.40, 14, 8, 'pcs', 1, '2026-09-26 10:03:18', '2026-09-26 10:03:23'),
(20, 5, 'Bin Liners 30ct', NULL, NULL, 2.00, 4.50, 18, 6, 'pcs', 1, '2026-09-26 10:03:18', '2026-09-26 10:03:24'),
(21, 5, 'Laundry Powder 1kg', NULL, NULL, 4.10, 7.95, 15, 5, 'pcs', 1, '2026-09-26 10:03:18', '2026-09-26 10:03:24'),
(22, 6, 'Bananas 1kg', NULL, NULL, 1.10, 2.40, 32, 15, 'kg', 1, '2026-09-26 10:03:18', '2026-09-26 10:03:24'),
(23, 6, 'Red Apples 1kg', NULL, NULL, 1.60, 3.20, 8, 12, 'kg', 1, '2026-09-26 10:03:18', '2026-09-26 10:03:24'),
(24, 6, 'Tomatoes 1kg', NULL, NULL, 1.40, 3.10, 2, 10, 'kg', 1, '2026-09-26 10:03:18', '2026-09-26 10:03:22'),
(25, 6, 'Baby Spinach 200g', NULL, NULL, 1.25, 2.90, 5, 8, 'pcs', 1, '2026-09-26 10:03:18', '2026-09-26 10:03:18'),
(26, 2, 'Chocolate Chip', 'products/chocolate-chip-0n90vj.jpg', 'chocolate chips made from real cocoa butter', 55.00, 70.00, 60, 5, 'pcs', 1, '2026-09-26 10:44:35', '2026-09-26 10:52:37'),
(27, 5, 'Colgate Plax', NULL, NULL, 35.00, 42.00, 10, 5, 'pcs', 1, '2026-09-26 11:00:20', '2026-09-26 11:00:20');

-- --------------------------------------------------------

--
-- Table structure for table `product_batches`
--

CREATE TABLE `product_batches` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `batch_no` varchar(255) DEFAULT NULL,
  `expiry_date` date DEFAULT NULL,
  `quantity` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `notes` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_batches`
--

INSERT INTO `product_batches` (`id`, `product_id`, `batch_no`, `expiry_date`, `quantity`, `notes`, `created_at`, `updated_at`) VALUES
(1, 1, NULL, NULL, 94, NULL, '2026-09-26 10:03:18', '2026-09-26 10:03:24'),
(2, 2, NULL, NULL, 28, NULL, '2026-09-26 10:03:18', '2026-09-26 10:03:24'),
(3, 3, NULL, '2026-10-17', 16, NULL, '2026-09-26 10:03:18', '2026-09-26 10:03:23'),
(4, 4, NULL, NULL, 186, NULL, '2026-09-26 10:03:18', '2026-09-26 10:03:24'),
(5, 5, NULL, '2027-03-25', 0, NULL, '2026-09-26 10:03:18', '2026-09-26 10:03:21'),
(6, 6, NULL, '2026-09-30', 32, NULL, '2026-09-26 10:03:18', '2026-09-26 10:03:23'),
(7, 7, NULL, '2026-10-01', 0, NULL, '2026-09-26 10:03:18', '2026-09-26 10:03:24'),
(8, 8, NULL, '2026-09-28', 0, NULL, '2026-09-26 10:03:18', '2026-09-26 10:03:23'),
(9, 9, NULL, '2026-09-29', 0, NULL, '2026-09-26 10:03:18', '2026-09-26 10:03:21'),
(10, 10, NULL, '2026-10-06', 63, NULL, '2026-09-26 10:03:18', '2026-09-26 10:03:24'),
(11, 11, NULL, '2026-10-10', 7, NULL, '2026-09-26 10:03:18', '2026-09-26 10:03:24'),
(12, 12, NULL, '2026-11-10', 7, NULL, '2026-09-26 10:03:18', '2026-09-26 10:03:24'),
(13, 13, NULL, '2026-11-25', 3, NULL, '2026-09-26 10:03:18', '2026-09-26 10:03:18'),
(14, 14, NULL, '2027-01-24', 41, NULL, '2026-09-26 10:03:18', '2026-09-26 10:03:24'),
(15, 15, NULL, '2027-02-23', 17, NULL, '2026-09-26 10:03:18', '2026-09-26 10:03:24'),
(16, 16, NULL, '2027-06-23', 32, NULL, '2026-09-26 10:03:18', '2026-09-26 10:03:24'),
(17, 18, NULL, NULL, 8, NULL, '2026-09-26 10:03:18', '2026-09-26 10:03:24'),
(18, 19, NULL, NULL, 14, NULL, '2026-09-26 10:03:18', '2026-09-26 10:03:23'),
(19, 20, NULL, NULL, 18, NULL, '2026-09-26 10:03:18', '2026-09-26 10:03:24'),
(20, 21, NULL, NULL, 15, NULL, '2026-09-26 10:03:18', '2026-09-26 10:03:24'),
(21, 22, NULL, '2026-10-02', 32, NULL, '2026-09-26 10:03:18', '2026-09-26 10:03:24'),
(22, 23, NULL, '2026-10-26', 8, NULL, '2026-09-26 10:03:18', '2026-09-26 10:03:24'),
(23, 24, NULL, '2026-10-03', 2, NULL, '2026-09-26 10:03:18', '2026-09-26 10:03:22'),
(24, 25, NULL, '2026-09-24', 5, NULL, '2026-09-26 10:03:18', '2026-09-26 10:03:18'),
(25, 5, NULL, NULL, 18, NULL, '2026-09-26 10:03:24', '2026-09-26 10:03:24'),
(26, 7, NULL, NULL, 30, NULL, '2026-09-26 10:03:24', '2026-09-26 10:03:24'),
(27, 8, NULL, NULL, 35, NULL, '2026-09-26 10:03:24', '2026-09-26 10:45:33'),
(28, 9, NULL, NULL, 30, NULL, '2026-09-26 10:03:24', '2026-09-26 10:03:24'),
(29, 17, NULL, NULL, 30, NULL, '2026-09-26 10:03:24', '2026-09-26 10:03:24'),
(30, 26, NULL, '2027-05-04', 60, NULL, '2026-09-26 10:44:35', '2026-09-26 10:52:37'),
(31, 27, NULL, '2026-10-09', 10, NULL, '2026-09-26 11:00:20', '2026-09-26 11:00:20');

-- --------------------------------------------------------

--
-- Table structure for table `refunds`
--

CREATE TABLE `refunds` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `refund_number` varchar(255) NOT NULL,
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `status` enum('completed') NOT NULL DEFAULT 'completed',
  `amount` decimal(14,2) NOT NULL,
  `method` enum('cash','card','mobile','other') NOT NULL DEFAULT 'cash',
  `reason` varchar(255) NOT NULL,
  `note` text DEFAULT NULL,
  `refunded_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `refund_items`
--

CREATE TABLE `refund_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `refund_id` bigint(20) UNSIGNED NOT NULL,
  `order_item_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED DEFAULT NULL,
  `product_name` varchar(255) NOT NULL,
  `quantity` int(10) UNSIGNED NOT NULL,
  `unit_price` decimal(12,2) NOT NULL,
  `amount` decimal(14,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('cyygTTfNK9grMoQD7O9bwB2RUsPbjvQ7dAszXO4U', 2, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoidFZBdXk1NjRJREFsQVZrN3pqTG9UR042Y2tYR01SR0xkUVNIVFJ6cCI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJuZXciO2E6MDp7fXM6Mzoib2xkIjthOjA6e319czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjU6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9wb3MiO3M6NToicm91dGUiO3M6OToicG9zLmluZGV4Ijt9czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6Mjt9', 1790420575),
('ovAGFlxGhH8EtK5ywQ67OUkcb5leerWwNaTBIUa8', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiV1ZWUkIwbTlZZ3htZVhkV0gzWGJ1VERKYURUa2g4MXVrRVdqa3lsVCI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozNzoiaHR0cDovLzEyNy4wLjAuMTo4MDAwL2FkbWluL2Rhc2hib2FyZCI7fXM6OToiX3ByZXZpb3VzIjthOjI6e3M6MzoidXJsIjtzOjI3OiJodHRwOi8vMTI3LjAuMC4xOjgwMDAvbG9naW4iO3M6NToicm91dGUiO3M6NToibG9naW4iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1790420256);

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `key` varchar(255) NOT NULL,
  `value` text DEFAULT NULL,
  `type` varchar(20) NOT NULL DEFAULT 'string',
  `group` varchar(40) NOT NULL DEFAULT 'general',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`id`, `key`, `value`, `type`, `group`, `created_at`, `updated_at`) VALUES
(1, 'store_name', '88 MiniMart', 'string', 'general', '2026-09-26 10:03:15', '2026-09-26 10:52:12'),
(2, 'store_address', 'Zone 4, Bangued, Abra', 'string', 'general', '2026-09-26 10:03:15', '2026-09-26 10:52:12'),
(3, 'store_phone', '+1 555 0100', 'string', 'general', '2026-09-26 10:03:15', '2026-09-26 10:03:15'),
(4, 'store_email', 'hello@demostore.test', 'string', 'general', '2026-09-26 10:03:15', '2026-09-26 10:03:15'),
(5, 'currency_symbol', '₱', 'string', 'general', '2026-09-26 10:03:15', '2026-09-26 10:03:15'),
(6, 'tax_rate', '1.5', 'string', 'tax', '2026-09-26 10:03:16', '2026-09-26 10:52:12'),
(7, 'receipt_footer', 'Thank you for your purchase! Goods once sold are not returnable within 7 days.', 'string', 'receipt', '2026-09-26 10:03:16', '2026-09-26 10:52:12'),
(8, 'receipt_size', '80mm', 'string', 'receipt', '2026-09-26 10:03:16', '2026-09-26 10:52:12'),
(9, 'low_stock_default', '5', 'string', 'inventory', '2026-09-26 10:03:16', '2026-09-26 10:52:12');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('admin','staff') NOT NULL DEFAULT 'staff',
  `phone` varchar(30) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `last_login_at` timestamp NULL DEFAULT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `role`, `phone`, `address`, `is_active`, `last_login_at`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Store Administrator', 'admin@pos.test', '2026-09-26 10:03:16', '$2y$12$3tuUu02DRK.kFN1psGys8.t3m9dCaVvd5I3Zs.MjBEy44qu2L83oq', 'admin', '+1 555 0101', '12 Market Street, Downtown', 1, '2026-09-26 10:53:02', NULL, '2026-09-26 10:03:16', '2026-09-26 10:53:02'),
(2, 'Alice Cashier', 'alice@pos.test', '2026-09-26 10:03:17', '$2y$12$h2GWu8gGAMRR/fH8rnaYTO7u5bX8zTcOhWAEt2CLcI82aSqDDwKwu', 'staff', '+1 555 0102', NULL, 1, '2026-09-26 11:02:55', NULL, '2026-09-26 10:03:17', '2026-09-26 11:02:55'),
(3, 'Bruno Cashier', 'bruno@pos.test', '2026-09-26 10:03:17', '$2y$12$WJae.4KWr/UONZp5iMux0.q5lY2VKJ5/VXX4RMnsAhTyDAoYW3/yC', 'staff', '+1 555 0103', NULL, 1, '2026-09-24 22:03:17', NULL, '2026-09-26 10:03:17', '2026-09-26 10:03:17'),
(4, 'Carla (suspended)', 'carla@pos.test', '2026-09-26 10:03:17', '$2y$12$ejFySt.Td93YgTcKh4Xv3e2mUKAP/3OXFXGDqIfhbsrGYqLfOWtai', 'staff', NULL, NULL, 0, NULL, NULL, '2026-09-26 10:03:17', '2026-09-26 10:03:17');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `audit_logs`
--
ALTER TABLE `audit_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `audit_logs_user_id_foreign` (`user_id`),
  ADD KEY `audit_logs_auditable_type_auditable_id_index` (`auditable_type`,`auditable_id`),
  ADD KEY `audit_logs_action_index` (`action`);

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`),
  ADD KEY `cache_expiration_index` (`expiration`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`),
  ADD KEY `cache_locks_expiration_index` (`expiration`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `categories_name_unique` (`name`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `inventory_movements`
--
ALTER TABLE `inventory_movements`
  ADD PRIMARY KEY (`id`),
  ADD KEY `inventory_movements_user_id_foreign` (`user_id`),
  ADD KEY `inventory_movements_reference_type_reference_id_index` (`reference_type`,`reference_id`),
  ADD KEY `inventory_movements_product_id_created_at_index` (`product_id`,`created_at`),
  ADD KEY `inventory_movements_type_index` (`type`),
  ADD KEY `inventory_movements_batch_id_foreign` (`batch_id`),
  ADD KEY `inventory_movements_product_id_batch_id_index` (`product_id`,`batch_id`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `orders_order_number_unique` (`order_number`),
  ADD KEY `orders_user_id_foreign` (`user_id`),
  ADD KEY `orders_created_at_index` (`created_at`),
  ADD KEY `orders_status_index` (`status`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_items_product_id_foreign` (`product_id`),
  ADD KEY `order_items_order_id_product_id_index` (`order_id`,`product_id`);

--
-- Indexes for table `order_item_batches`
--
ALTER TABLE `order_item_batches`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_item_batches_batch_id_foreign` (`batch_id`),
  ADD KEY `order_item_batches_order_item_id_batch_id_index` (`order_item_id`,`batch_id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `products_category_id_is_active_index` (`category_id`,`is_active`),
  ADD KEY `products_name_index` (`name`);

--
-- Indexes for table `product_batches`
--
ALTER TABLE `product_batches`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_batches_product_expiry_index` (`product_id`,`expiry_date`),
  ADD KEY `product_batches_expiry_date_index` (`expiry_date`);

--
-- Indexes for table `refunds`
--
ALTER TABLE `refunds`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `refunds_refund_number_unique` (`refund_number`),
  ADD KEY `refunds_user_id_foreign` (`user_id`),
  ADD KEY `refunds_order_id_index` (`order_id`);

--
-- Indexes for table `refund_items`
--
ALTER TABLE `refund_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `refund_items_refund_id_foreign` (`refund_id`),
  ADD KEY `refund_items_order_item_id_foreign` (`order_item_id`),
  ADD KEY `refund_items_product_id_foreign` (`product_id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `settings_key_unique` (`key`),
  ADD KEY `settings_group_index` (`group`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD KEY `users_role_index` (`role`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `audit_logs`
--
ALTER TABLE `audit_logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=118;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `inventory_movements`
--
ALTER TABLE `inventory_movements`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=295;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=104;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=261;

--
-- AUTO_INCREMENT for table `order_item_batches`
--
ALTER TABLE `order_item_batches`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=261;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `product_batches`
--
ALTER TABLE `product_batches`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `refunds`
--
ALTER TABLE `refunds`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `refund_items`
--
ALTER TABLE `refund_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `audit_logs`
--
ALTER TABLE `audit_logs`
  ADD CONSTRAINT `audit_logs_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `inventory_movements`
--
ALTER TABLE `inventory_movements`
  ADD CONSTRAINT `inventory_movements_batch_id_foreign` FOREIGN KEY (`batch_id`) REFERENCES `product_batches` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `inventory_movements_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `inventory_movements_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `order_items_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `order_item_batches`
--
ALTER TABLE `order_item_batches`
  ADD CONSTRAINT `order_item_batches_batch_id_foreign` FOREIGN KEY (`batch_id`) REFERENCES `product_batches` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `order_item_batches_order_item_id_foreign` FOREIGN KEY (`order_item_id`) REFERENCES `order_items` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `product_batches`
--
ALTER TABLE `product_batches`
  ADD CONSTRAINT `product_batches_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `refunds`
--
ALTER TABLE `refunds`
  ADD CONSTRAINT `refunds_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `refunds_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `refund_items`
--
ALTER TABLE `refund_items`
  ADD CONSTRAINT `refund_items_order_item_id_foreign` FOREIGN KEY (`order_item_id`) REFERENCES `order_items` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `refund_items_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `refund_items_refund_id_foreign` FOREIGN KEY (`refund_id`) REFERENCES `refunds` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
