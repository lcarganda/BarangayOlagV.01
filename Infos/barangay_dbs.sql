-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 04, 2025 at 03:57 PM
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
-- Database: `barangay_dbs`
--

-- --------------------------------------------------------

--
-- Table structure for table `blood_type_lookup`
--

CREATE TABLE `blood_type_lookup` (
  `id` int(11) NOT NULL,
  `blood_type_name` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `blood_type_lookup`
--

INSERT INTO `blood_type_lookup` (`id`, `blood_type_name`) VALUES
(1, 'A+'),
(2, 'A-'),
(5, 'AB+'),
(6, 'AB-'),
(3, 'B+'),
(4, 'B-'),
(7, 'O+'),
(8, 'O-');

-- --------------------------------------------------------

--
-- Table structure for table `civil_status_lookup`
--

CREATE TABLE `civil_status_lookup` (
  `id` int(11) NOT NULL,
  `status_name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `civil_status_lookup`
--

INSERT INTO `civil_status_lookup` (`id`, `status_name`) VALUES
(5, 'Annulled'),
(4, 'Divorced'),
(2, 'Married'),
(6, 'Separated'),
(1, 'Single'),
(3, 'Widowed');

-- --------------------------------------------------------

--
-- Table structure for table `cooking_fuel_lookup`
--

CREATE TABLE `cooking_fuel_lookup` (
  `id` int(11) NOT NULL,
  `cooking_fuel_name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cooking_fuel_lookup`
--

INSERT INTO `cooking_fuel_lookup` (`id`, `cooking_fuel_name`) VALUES
(6, 'Biogas'),
(3, 'Charcoal'),
(5, 'Electricity'),
(4, 'Kerosene'),
(1, 'LPG'),
(7, 'Other'),
(2, 'Wood');

-- --------------------------------------------------------

--
-- Table structure for table `educational_attainment_lookup`
--

CREATE TABLE `educational_attainment_lookup` (
  `id` int(11) NOT NULL,
  `attainment_name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `educational_attainment_lookup`
--

INSERT INTO `educational_attainment_lookup` (`id`, `attainment_name`) VALUES
(8, 'College Graduate'),
(7, 'College Level'),
(3, 'Elementary Graduate'),
(2, 'Elementary Level'),
(5, 'High School Graduate'),
(4, 'High School Level'),
(1, 'None'),
(9, 'Post-Graduate'),
(6, 'Vocational');

-- --------------------------------------------------------

--
-- Table structure for table `family`
--

CREATE TABLE `family` (
  `family_id` int(11) NOT NULL,
  `main_family_surname` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `family`
--

INSERT INTO `family` (`family_id`, `main_family_surname`, `description`, `created_at`, `updated_at`) VALUES
(1, 'Cruz', 'Family 1 of Barangay Olag Pequiño', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(2, 'Reyes', 'Family 2 of Barangay Olag Pequiño', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(3, 'Santos', 'Family 3 of Barangay Olag Pequiño', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(4, 'Garcia', 'Family 4 of Barangay Olag Pequiño', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(5, 'Lim', 'Family 5 of Barangay Olag Pequiño', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(6, 'Gonzales', 'Family 6 of Barangay Olag Pequiño', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(7, 'Lopez', 'Family 7 of Barangay Olag Pequiño', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(8, 'Perez', 'Family 8 of Barangay Olag Pequiño', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(9, 'Aquino', 'Family 9 of Barangay Olag Pequiño', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(10, 'Ramos', 'Family 10 of Barangay Olag Pequiño', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(11, 'Diaz', 'Family 11 of Barangay Olag Pequiño', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(12, 'Torres', 'Family 12 of Barangay Olag Pequiño', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(13, 'Flores', 'Family 13 of Barangay Olag Pequiño', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(14, 'Villanueva', 'Family 14 of Barangay Olag Pequiño', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(15, 'Castro', 'Family 15 of Barangay Olag Pequiño', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(16, 'Rivera', 'Family 16 of Barangay Olag Pequiño', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(17, 'De Leon', 'Family 17 of Barangay Olag Pequiño', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(18, 'Mendoza', 'Family 18 of Barangay Olag Pequiño', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(19, 'Sy', 'Family 19 of Barangay Olag Pequiño', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(20, 'Tan', 'Family 20 of Barangay Olag Pequiño', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(21, 'Chua', 'Family 21 of Barangay Olag Pequiño', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(22, 'Go', 'Family 22 of Barangay Olag Pequiño', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(23, 'Uy', 'Family 23 of Barangay Olag Pequiño', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(24, 'Cheng', 'Family 24 of Barangay Olag Pequiño', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(25, 'Ong', 'Family 25 of Barangay Olag Pequiño', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(26, 'Yap', 'Family 26 of Barangay Olag Pequiño', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(27, 'Yu', 'Family 27 of Barangay Olag Pequiño', '2025-07-04 21:25:00', '2025-07-04 21:25:00');

-- --------------------------------------------------------

--
-- Table structure for table `family_household`
--

CREATE TABLE `family_household` (
  `family_id` int(11) NOT NULL,
  `household_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `family_household`
--

INSERT INTO `family_household` (`family_id`, `household_id`) VALUES
(1, 4),
(2, 2),
(3, 1),
(4, 3),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10),
(11, 11),
(12, 12),
(13, 13),
(14, 14),
(15, 15),
(16, 16),
(17, 17),
(18, 18),
(19, 19),
(20, 20),
(21, 21),
(22, 22),
(23, 23),
(24, 24),
(25, 25),
(26, 26),
(27, 27);

-- --------------------------------------------------------

--
-- Table structure for table `household`
--

CREATE TABLE `household` (
  `household_id` int(11) NOT NULL,
  `zone_id` int(11) NOT NULL,
  `household_head_individual_id` int(11) NOT NULL,
  `address` varchar(255) NOT NULL,
  `what_water_source_id` int(11) DEFAULT NULL,
  `has_toilet` enum('Yes','No') DEFAULT 'No',
  `has_electricity` enum('Yes','No') DEFAULT 'No',
  `main_source_of_cooking_fuel_id` int(11) DEFAULT NULL,
  `tenure_status_id` int(11) DEFAULT NULL,
  `household_source_of_income_id` int(11) DEFAULT NULL,
  `monthly_household_income` decimal(10,2) DEFAULT NULL,
  `type_of_household_id` int(11) DEFAULT NULL,
  `type_of_house_material_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `has_water` enum('Yes','No') DEFAULT 'No',
  `has_internet` enum('Yes','No') DEFAULT 'No'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `household`
--

INSERT INTO `household` (`household_id`, `zone_id`, `household_head_individual_id`, `address`, `what_water_source_id`, `has_toilet`, `has_electricity`, `main_source_of_cooking_fuel_id`, `tenure_status_id`, `household_source_of_income_id`, `monthly_household_income`, `type_of_household_id`, `type_of_house_material_id`, `created_at`, `updated_at`, `has_water`, `has_internet`) VALUES
(1, 4, 3, 'House 1, Zone G St.', 1, 'Yes', 'Yes', 1, 1, 1, 41323.23, 1, 1, '2025-07-04 21:25:00', '2025-07-04 21:25:00', 'Yes', 'Yes'),
(2, 6, 4, 'House 2, Zone B St.', 4, 'Yes', 'Yes', 1, 2, 1, 27878.07, 2, 1, '2025-07-04 21:25:00', '2025-07-04 21:25:00', 'Yes', 'No'),
(3, 7, 5, 'House 3, Zone D St.', 3, 'Yes', 'Yes', 1, 1, 1, 33390.87, 1, 1, '2025-07-04 21:25:00', '2025-07-04 21:25:00', 'Yes', 'Yes'),
(4, 2, 6, 'House 4, Zone G St.', 1, 'Yes', 'Yes', 1, 2, 1, 10885.58, 3, 2, '2025-07-04 21:25:00', '2025-07-04 21:25:00', 'Yes', 'No'),
(5, 5, 7, 'House 5, Zone G St.', 2, 'Yes', 'Yes', 1, 1, 1, 20815.70, 1, 1, '2025-07-04 21:25:00', '2025-07-04 21:25:00', 'Yes', 'Yes'),
(6, 1, 8, 'House 6, Zone A St.', 1, 'Yes', 'Yes', 1, 2, 1, 38827.42, 2, 1, '2025-07-04 21:25:00', '2025-07-04 21:25:00', 'Yes', 'Yes'),
(7, 3, 9, 'House 7, Zone C St.', 4, 'Yes', 'Yes', 1, 1, 1, 45600.00, 1, 1, '2025-07-04 21:25:00', '2025-07-04 21:25:00', 'Yes', 'Yes'),
(8, 6, 10, 'House 8, Zone F St.', 3, 'Yes', 'Yes', 1, 2, 1, 10000.00, 3, 2, '2025-07-04 21:25:00', '2025-07-04 21:25:00', 'Yes', 'No'),
(9, 7, 11, 'House 9, Zone D St.', 1, 'Yes', 'Yes', 1, 1, 1, 25000.00, 1, 1, '2025-07-04 21:25:00', '2025-07-04 21:25:00', 'Yes', 'Yes'),
(10, 2, 12, 'House 10, Zone G St.', 2, 'Yes', 'Yes', 1, 2, 1, 30000.00, 2, 1, '2025-07-04 21:25:00', '2025-07-04 21:25:00', 'Yes', 'Yes'),
(11, 5, 13, 'House 11, Zone G St.', 1, 'Yes', 'Yes', 1, 1, 1, 40000.00, 1, 1, '2025-07-04 21:25:00', '2025-07-04 21:25:00', 'Yes', 'Yes'),
(12, 1, 14, 'House 12, Zone A St.', 4, 'Yes', 'Yes', 1, 2, 1, 11500.00, 3, 2, '2025-07-04 21:25:00', '2025-07-04 21:25:00', 'Yes', 'No'),
(13, 3, 15, 'House 13, Zone C St.', 3, 'Yes', 'Yes', 1, 1, 1, 28000.00, 1, 1, '2025-07-04 21:25:00', '2025-07-04 21:25:00', 'Yes', 'Yes'),
(14, 6, 16, 'House 14, Zone F St.', 1, 'Yes', 'Yes', 1, 2, 1, 35000.00, 2, 1, '2025-07-04 21:25:00', '2025-07-04 21:25:00', 'Yes', 'Yes'),
(15, 7, 19, 'House 15, Zone D St.', 2, 'Yes', 'Yes', 1, 1, 1, 42000.00, 1, 1, '2025-07-04 21:25:00', '2025-07-04 21:25:00', 'Yes', 'Yes'),
(16, 2, 20, 'House 16, Zone G St.', 1, 'Yes', 'Yes', 1, 2, 1, 10500.00, 3, 2, '2025-07-04 21:25:00', '2025-07-04 21:25:00', 'Yes', 'No'),
(17, 5, 21, 'House 17, Zone G St.', 4, 'Yes', 'Yes', 1, 1, 1, 26000.00, 1, 1, '2025-07-04 21:25:00', '2025-07-04 21:25:00', 'Yes', 'Yes'),
(18, 1, 22, 'House 18, Zone A St.', 3, 'Yes', 'Yes', 1, 2, 1, 31000.00, 2, 1, '2025-07-04 21:25:00', '2025-07-04 21:25:00', 'Yes', 'Yes'),
(19, 3, 24, 'House 19, Zone C St.', 1, 'Yes', 'Yes', 1, 1, 1, 39000.00, 1, 1, '2025-07-04 21:25:00', '2025-07-04 21:25:00', 'Yes', 'Yes'),
(20, 6, 25, 'House 20, Zone F St.', 2, 'Yes', 'Yes', 1, 2, 1, 11000.00, 3, 2, '2025-07-04 21:25:00', '2025-07-04 21:25:00', 'Yes', 'No'),
(21, 7, 26, 'House 21, Zone D St.', 1, 'Yes', 'Yes', 1, 1, 1, 29000.00, 1, 1, '2025-07-04 21:25:00', '2025-07-04 21:25:00', 'Yes', 'Yes'),
(22, 2, 27, 'House 22, Zone G St.', 4, 'Yes', 'Yes', 1, 2, 1, 36000.00, 2, 1, '2025-07-04 21:25:00', '2025-07-04 21:25:00', 'Yes', 'Yes'),
(23, 5, 30, 'House 23, Zone G St.', 3, 'Yes', 'Yes', 1, 1, 1, 43000.00, 1, 1, '2025-07-04 21:25:00', '2025-07-04 21:25:00', 'Yes', 'Yes'),
(24, 1, 31, 'House 24, Zone A St.', 1, 'Yes', 'Yes', 1, 2, 1, 10200.00, 3, 2, '2025-07-04 21:25:00', '2025-07-04 21:25:00', 'Yes', 'No'),
(25, 3, 32, 'House 25, Zone C St.', 2, 'Yes', 'Yes', 1, 1, 1, 27000.00, 1, 1, '2025-07-04 21:25:00', '2025-07-04 21:25:00', 'Yes', 'Yes'),
(26, 6, 35, 'House 26, Zone F St.', 1, 'Yes', 'Yes', 1, 2, 1, 34000.00, 2, 1, '2025-07-04 21:25:00', '2025-07-04 21:25:00', 'Yes', 'Yes'),
(27, 7, 36, 'House 27, Zone D St.', 4, 'Yes', 'Yes', 1, 1, 1, 41000.00, 1, 1, '2025-07-04 21:25:00', '2025-07-04 21:25:00', 'Yes', 'Yes'),
(28, 2, 37, 'House 28, Zone G St.', 3, 'Yes', 'Yes', 1, 2, 1, 11800.00, 3, 2, '2025-07-04 21:25:00', '2025-07-04 21:25:00', 'Yes', 'No'),
(29, 5, 38, 'House 29, Zone G St.', 1, 'Yes', 'Yes', 1, 1, 1, 28000.00, 1, 1, '2025-07-04 21:25:00', '2025-07-04 21:25:00', 'Yes', 'Yes'),
(30, 1, 40, 'House 30, Zone A St.', 2, 'Yes', 'Yes', 1, 2, 1, 35000.00, 2, 1, '2025-07-04 21:25:00', '2025-07-04 21:25:00', 'Yes', 'Yes'),
(31, 3, 41, 'House 31, Zone C St.', 1, 'Yes', 'Yes', 1, 1, 1, 42000.00, 1, 1, '2025-07-04 21:25:00', '2025-07-04 21:25:00', 'Yes', 'Yes'),
(32, 6, 42, 'House 32, Zone F St.', 4, 'Yes', 'Yes', 1, 2, 1, 10300.00, 3, 2, '2025-07-04 21:25:00', '2025-07-04 21:25:00', 'Yes', 'No'),
(33, 7, 43, 'House 33, Zone D St.', 3, 'Yes', 'Yes', 1, 1, 1, 26000.00, 1, 1, '2025-07-04 21:25:00', '2025-07-04 21:25:00', 'Yes', 'Yes'),
(34, 2, 46, 'House 34, Zone G St.', 1, 'Yes', 'Yes', 1, 2, 1, 33000.00, 2, 1, '2025-07-04 21:25:00', '2025-07-04 21:25:00', 'Yes', 'Yes'),
(35, 5, 47, 'House 35, Zone G St.', 2, 'Yes', 'Yes', 1, 1, 1, 40000.00, 1, 1, '2025-07-04 21:25:00', '2025-07-04 21:25:00', 'Yes', 'Yes'),
(36, 1, 48, 'House 36, Zone A St.', 1, 'Yes', 'Yes', 1, 2, 1, 11200.00, 3, 2, '2025-07-04 21:25:00', '2025-07-04 21:25:00', 'Yes', 'No'),
(37, 3, 51, 'House 37, Zone C St.', 4, 'Yes', 'Yes', 1, 1, 1, 29000.00, 1, 1, '2025-07-04 21:25:00', '2025-07-04 21:25:00', 'Yes', 'Yes'),
(38, 6, 52, 'House 38, Zone F St.', 3, 'Yes', 'Yes', 1, 2, 1, 36000.00, 2, 1, '2025-07-04 21:25:00', '2025-07-04 21:25:00', 'Yes', 'Yes'),
(39, 7, 53, 'House 39, Zone D St.', 1, 'Yes', 'Yes', 1, 1, 1, 43000.00, 1, 1, '2025-07-04 21:25:00', '2025-07-04 21:25:00', 'Yes', 'Yes'),
(40, 2, 54, 'House 40, Zone G St.', 2, 'Yes', 'Yes', 1, 2, 1, 10700.00, 3, 2, '2025-07-04 21:25:00', '2025-07-04 21:25:00', 'Yes', 'No'),
(41, 5, 56, 'House 41, Zone G St.', 1, 'Yes', 'Yes', 1, 1, 1, 27000.00, 1, 1, '2025-07-04 21:25:00', '2025-07-04 21:25:00', 'Yes', 'Yes'),
(42, 1, 57, 'House 42, Zone A St.', 4, 'Yes', 'Yes', 1, 2, 1, 34000.00, 2, 1, '2025-07-04 21:25:00', '2025-07-04 21:25:00', 'Yes', 'Yes'),
(43, 3, 58, 'House 43, Zone C St.', 3, 'Yes', 'Yes', 1, 1, 1, 41000.00, 1, 1, '2025-07-04 21:25:00', '2025-07-04 21:25:00', 'Yes', 'Yes'),
(44, 6, 59, 'House 44, Zone F St.', 1, 'Yes', 'Yes', 1, 2, 1, 11900.00, 3, 2, '2025-07-04 21:25:00', '2025-07-04 21:25:00', 'Yes', 'No'),
(45, 7, 62, 'House 45, Zone D St.', 2, 'Yes', 'Yes', 1, 1, 1, 28000.00, 1, 1, '2025-07-04 21:25:00', '2025-07-04 21:25:00', 'Yes', 'Yes'),
(46, 2, 63, 'House 46, Zone G St.', 1, 'Yes', 'Yes', 1, 2, 1, 35000.00, 2, 1, '2025-07-04 21:25:00', '2025-07-04 21:25:00', 'Yes', 'Yes'),
(47, 5, 64, 'House 47, Zone G St.', 4, 'Yes', 'Yes', 1, 1, 1, 42000.00, 1, 1, '2025-07-04 21:25:00', '2025-07-04 21:25:00', 'Yes', 'Yes'),
(48, 1, 65, 'House 48, Zone A St.', 3, 'Yes', 'Yes', 1, 2, 1, 10100.00, 3, 2, '2025-07-04 21:25:00', '2025-07-04 21:25:00', 'Yes', 'No'),
(49, 3, 66, 'House 49, Zone C St.', 1, 'Yes', 'Yes', 1, 1, 1, 26000.00, 1, 1, '2025-07-04 21:25:00', '2025-07-04 21:25:00', 'Yes', 'Yes'),
(50, 6, 67, 'House 50, Zone F St.', 2, 'Yes', 'Yes', 1, 2, 1, 33000.00, 2, 1, '2025-07-04 21:25:00', '2025-07-04 21:25:00', 'Yes', 'Yes'),
(51, 7, 69, 'House 51, Zone D St.', 1, 'Yes', 'Yes', 1, 1, 1, 40000.00, 1, 1, '2025-07-04 21:25:00', '2025-07-04 21:25:00', 'Yes', 'Yes'),
(52, 2, 70, 'House 52, Zone G St.', 4, 'Yes', 'Yes', 1, 2, 1, 11400.00, 3, 2, '2025-07-04 21:25:00', '2025-07-04 21:25:00', 'Yes', 'No'),
(53, 5, 71, 'House 53, Zone G St.', 3, 'Yes', 'Yes', 1, 1, 1, 29000.00, 1, 1, '2025-07-04 21:25:00', '2025-07-04 21:25:00', 'Yes', 'Yes'),
(54, 1, 72, 'House 54, Zone A St.', 1, 'Yes', 'Yes', 1, 2, 1, 36000.00, 2, 1, '2025-07-04 21:25:00', '2025-07-04 21:25:00', 'Yes', 'Yes'),
(55, 3, 73, 'House 55, Zone C St.', 2, 'Yes', 'Yes', 1, 1, 1, 43000.00, 1, 1, '2025-07-04 21:25:00', '2025-07-04 21:25:00', 'Yes', 'Yes');

-- --------------------------------------------------------

--
-- Table structure for table `household_member`
--

CREATE TABLE `household_member` (
  `household_id` int(11) NOT NULL,
  `individual_id` int(11) NOT NULL,
  `relationship_to_head` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `household_member`
--

INSERT INTO `household_member` (`household_id`, `individual_id`, `relationship_to_head`) VALUES
(1, 1, 'Child'),
(1, 3, 'Head'),
(1, 111, 'Child'),
(1, 166, 'Child'),
(1, 221, 'Child'),
(2, 2, 'Child'),
(2, 4, 'Head'),
(2, 112, 'Child'),
(2, 167, 'Child'),
(2, 222, 'Child'),
(3, 5, 'Head'),
(3, 17, 'Child'),
(3, 113, 'Child'),
(3, 168, 'Child'),
(3, 223, 'Child'),
(4, 6, 'Head'),
(4, 18, 'Child'),
(4, 114, 'Child'),
(4, 169, 'Child'),
(4, 224, 'Child'),
(5, 7, 'Head'),
(5, 23, 'Child'),
(5, 115, 'Child'),
(5, 170, 'Child'),
(5, 225, 'Child'),
(6, 8, 'Head'),
(6, 28, 'Child'),
(6, 116, 'Child'),
(6, 171, 'Child'),
(6, 226, 'Child'),
(7, 9, 'Head'),
(7, 29, 'Child'),
(7, 117, 'Child'),
(7, 172, 'Child'),
(7, 227, 'Child'),
(8, 10, 'Head'),
(8, 33, 'Child'),
(8, 118, 'Child'),
(8, 173, 'Child'),
(8, 228, 'Child'),
(9, 11, 'Head'),
(9, 34, 'Child'),
(9, 119, 'Child'),
(9, 174, 'Child'),
(9, 229, 'Child'),
(10, 12, 'Head'),
(10, 39, 'Child'),
(10, 120, 'Child'),
(10, 175, 'Child'),
(10, 230, 'Child'),
(11, 13, 'Head'),
(11, 44, 'Child'),
(11, 121, 'Child'),
(11, 176, 'Child'),
(11, 231, 'Child'),
(12, 14, 'Head'),
(12, 45, 'Child'),
(12, 122, 'Child'),
(12, 177, 'Child'),
(12, 232, 'Child'),
(13, 15, 'Head'),
(13, 49, 'Child'),
(13, 123, 'Child'),
(13, 178, 'Child'),
(13, 233, 'Child'),
(14, 16, 'Head'),
(14, 50, 'Child'),
(14, 124, 'Child'),
(14, 179, 'Child'),
(14, 234, 'Child'),
(15, 19, 'Head'),
(15, 55, 'Child'),
(15, 125, 'Child'),
(15, 180, 'Child'),
(15, 235, 'Child'),
(16, 20, 'Head'),
(16, 60, 'Child'),
(16, 126, 'Child'),
(16, 181, 'Child'),
(16, 236, 'Child'),
(17, 21, 'Head'),
(17, 61, 'Child'),
(17, 127, 'Child'),
(17, 182, 'Child'),
(17, 237, 'Child'),
(18, 22, 'Head'),
(18, 68, 'Child'),
(18, 128, 'Child'),
(18, 183, 'Child'),
(18, 238, 'Child'),
(19, 24, 'Head'),
(19, 74, 'Child'),
(19, 129, 'Child'),
(19, 184, 'Child'),
(19, 239, 'Child'),
(20, 25, 'Head'),
(20, 75, 'Child'),
(20, 130, 'Child'),
(20, 185, 'Child'),
(20, 240, 'Child'),
(21, 26, 'Head'),
(21, 76, 'Child'),
(21, 131, 'Child'),
(21, 186, 'Child'),
(21, 241, 'Child'),
(22, 27, 'Head'),
(22, 77, 'Child'),
(22, 132, 'Child'),
(22, 187, 'Child'),
(22, 242, 'Child'),
(23, 30, 'Head'),
(23, 78, 'Child'),
(23, 133, 'Child'),
(23, 188, 'Child'),
(23, 243, 'Child'),
(24, 31, 'Head'),
(24, 79, 'Child'),
(24, 134, 'Child'),
(24, 189, 'Child'),
(24, 244, 'Child'),
(25, 32, 'Head'),
(25, 80, 'Child'),
(25, 135, 'Child'),
(25, 190, 'Child'),
(25, 245, 'Child'),
(26, 35, 'Head'),
(26, 81, 'Child'),
(26, 136, 'Child'),
(26, 191, 'Child'),
(26, 246, 'Child'),
(27, 36, 'Head'),
(27, 82, 'Child'),
(27, 137, 'Child'),
(27, 192, 'Child'),
(27, 247, 'Child'),
(28, 37, 'Head'),
(28, 83, 'Child'),
(28, 138, 'Child'),
(28, 193, 'Child'),
(28, 248, 'Child'),
(29, 38, 'Head'),
(29, 84, 'Child'),
(29, 139, 'Child'),
(29, 194, 'Child'),
(29, 249, 'Child'),
(30, 40, 'Head'),
(30, 85, 'Child'),
(30, 140, 'Child'),
(30, 195, 'Child'),
(30, 250, 'Child'),
(31, 41, 'Head'),
(31, 86, 'Child'),
(31, 141, 'Child'),
(31, 196, 'Child'),
(32, 42, 'Head'),
(32, 87, 'Child'),
(32, 142, 'Child'),
(32, 197, 'Child'),
(33, 43, 'Head'),
(33, 88, 'Child'),
(33, 143, 'Child'),
(33, 198, 'Child'),
(34, 46, 'Head'),
(34, 89, 'Child'),
(34, 144, 'Child'),
(34, 199, 'Child'),
(35, 47, 'Head'),
(35, 90, 'Child'),
(35, 145, 'Child'),
(35, 200, 'Child'),
(36, 48, 'Head'),
(36, 91, 'Child'),
(36, 146, 'Child'),
(36, 201, 'Child'),
(37, 51, 'Head'),
(37, 92, 'Child'),
(37, 147, 'Child'),
(37, 202, 'Child'),
(38, 52, 'Head'),
(38, 93, 'Child'),
(38, 148, 'Child'),
(38, 203, 'Child'),
(39, 53, 'Head'),
(39, 94, 'Child'),
(39, 149, 'Child'),
(39, 204, 'Child'),
(40, 54, 'Head'),
(40, 95, 'Child'),
(40, 150, 'Child'),
(40, 205, 'Child'),
(41, 56, 'Head'),
(41, 96, 'Child'),
(41, 151, 'Child'),
(41, 206, 'Child'),
(42, 57, 'Head'),
(42, 97, 'Child'),
(42, 152, 'Child'),
(42, 207, 'Child'),
(43, 58, 'Head'),
(43, 98, 'Child'),
(43, 153, 'Child'),
(43, 208, 'Child'),
(44, 59, 'Head'),
(44, 99, 'Child'),
(44, 154, 'Child'),
(44, 209, 'Child'),
(45, 62, 'Head'),
(45, 100, 'Child'),
(45, 155, 'Child'),
(45, 210, 'Child'),
(46, 63, 'Head'),
(46, 101, 'Child'),
(46, 156, 'Child'),
(46, 211, 'Child'),
(47, 64, 'Head'),
(47, 102, 'Child'),
(47, 157, 'Child'),
(47, 212, 'Child'),
(48, 65, 'Head'),
(48, 103, 'Child'),
(48, 158, 'Child'),
(48, 213, 'Child'),
(49, 66, 'Head'),
(49, 104, 'Child'),
(49, 159, 'Child'),
(49, 214, 'Child'),
(50, 67, 'Head'),
(50, 105, 'Child'),
(50, 160, 'Child'),
(50, 215, 'Child'),
(51, 69, 'Head'),
(51, 106, 'Child'),
(51, 161, 'Child'),
(51, 216, 'Child'),
(52, 70, 'Head'),
(52, 107, 'Child'),
(52, 162, 'Child'),
(52, 217, 'Child'),
(53, 71, 'Head'),
(53, 108, 'Child'),
(53, 163, 'Child'),
(53, 218, 'Child'),
(54, 72, 'Head'),
(54, 109, 'Child'),
(54, 164, 'Child'),
(54, 219, 'Child'),
(55, 73, 'Head'),
(55, 110, 'Child'),
(55, 165, 'Child'),
(55, 220, 'Child');

-- --------------------------------------------------------

--
-- Table structure for table `household_type_lookup`
--

CREATE TABLE `household_type_lookup` (
  `id` int(11) NOT NULL,
  `household_type_name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `household_type_lookup`
--

INSERT INTO `household_type_lookup` (`id`, `household_type_name`) VALUES
(6, 'Dormitory'),
(2, 'Extended Family'),
(5, 'Group Quarters'),
(1, 'Nuclear Family'),
(7, 'Other'),
(4, 'Single Individual'),
(3, 'Single Parent');

-- --------------------------------------------------------

--
-- Table structure for table `house_material_lookup`
--

CREATE TABLE `house_material_lookup` (
  `id` int(11) NOT NULL,
  `house_material_name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `house_material_lookup`
--

INSERT INTO `house_material_lookup` (`id`, `house_material_name`) VALUES
(1, 'Concrete'),
(4, 'Light Materials (e.g., Bamboo, Nipa)'),
(3, 'Mixed Materials'),
(7, 'Other'),
(5, 'Salvaged Materials'),
(6, 'Semi-Concrete'),
(2, 'Wood');

-- --------------------------------------------------------

--
-- Table structure for table `income_source_lookup`
--

CREATE TABLE `income_source_lookup` (
  `id` int(11) NOT NULL,
  `income_source_name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `income_source_lookup`
--

INSERT INTO `income_source_lookup` (`id`, `income_source_name`) VALUES
(8, 'Donations'),
(2, 'Employment (Government)'),
(1, 'Employment (Private)'),
(3, 'Farming'),
(4, 'Fishing'),
(9, 'Other'),
(7, 'Pension'),
(6, 'Remittances'),
(5, 'Small Business');

-- --------------------------------------------------------

--
-- Table structure for table `individual`
--

CREATE TABLE `individual` (
  `individual_id` int(11) NOT NULL,
  `surname` varchar(255) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `middle_name` varchar(255) DEFAULT NULL,
  `gender` enum('Male','Female') NOT NULL,
  `birth_date` date NOT NULL,
  `civil_status_id` int(11) NOT NULL,
  `blood_type_id` int(11) DEFAULT NULL,
  `religion_id` int(11) DEFAULT NULL,
  `contact_number` varchar(20) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `salary_income` decimal(10,2) DEFAULT NULL,
  `is_solo_parent` enum('Yes','No') DEFAULT 'No',
  `has_disability` enum('Yes','No') DEFAULT 'No',
  `is_student` enum('Yes','No') DEFAULT 'No',
  `school_attending` varchar(255) DEFAULT NULL,
  `is_scholar` enum('Yes','No') DEFAULT 'No',
  `educational_attainment_id` int(11) DEFAULT NULL,
  `is_alive` enum('Yes','No') DEFAULT 'Yes',
  `is_registered_voter` enum('Yes','No') DEFAULT 'No',
  `is_ofw` enum('Yes','No') DEFAULT 'No',
  `is_sss_member` enum('Yes','No') DEFAULT 'No',
  `is_gsis_member` enum('Yes','No') DEFAULT 'No',
  `is_philhealth_member` enum('Yes','No') DEFAULT 'No',
  `working_for` varchar(255) DEFAULT NULL,
  `occupation` varchar(255) DEFAULT NULL,
  `is_4ps_beneficiary` enum('Yes','No') DEFAULT 'No',
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `individual`
--

INSERT INTO `individual` (`individual_id`, `surname`, `first_name`, `middle_name`, `gender`, `birth_date`, `civil_status_id`, `blood_type_id`, `religion_id`, `contact_number`, `email`, `salary_income`, `is_solo_parent`, `has_disability`, `is_student`, `school_attending`, `is_scholar`, `educational_attainment_id`, `is_alive`, `is_registered_voter`, `is_ofw`, `is_sss_member`, `is_gsis_member`, `is_philhealth_member`, `working_for`, `occupation`, `is_4ps_beneficiary`, `created_at`, `updated_at`) VALUES
(1, 'De Leon', 'Mark', 'T.', 'Male', '2015-06-05', 1, 6, 1, '09789012345', 'person1@example.com', NULL, 'No', 'No', 'Yes', 'School 5', 'No', 2, 'Yes', 'No', 'No', 'No', 'No', 'No', NULL, 'Student', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(2, 'Reyes', 'Kevin', 'S.', 'Male', '2005-06-15', 1, 3, 1, '09876543210', 'person2@example.com', NULL, 'No', 'No', 'Yes', 'School 2', 'No', 4, 'Yes', 'Yes', 'No', 'No', 'No', 'No', NULL, 'Student', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(3, 'Santos', 'Grace', 'A.', 'Female', '1998-09-20', 2, 7, 1, '09123456789', 'person3@example.com', 25000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Private Company A', 'Teacher', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(4, 'Bautista', 'Daniel', 'M.', 'Male', '1985-03-10', 2, 8, 3, '09234567890', 'person4@example.com', 35000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Government Agency B', 'Engineer', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(5, 'Garcia', 'Nicole', 'P.', 'Female', '1970-11-25', 2, 1, 1, '09345678901', 'person5@example.com', 28000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Local Business C', 'Nurse', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(6, 'Lim', 'Paul', 'L.', 'Male', '1960-01-01', 3, 2, 1, '09456789012', 'person6@example.com', 15000.00, 'No', 'No', 'No', NULL, 'No', 5, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', NULL, 'Retired', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(7, 'Cruz', 'Olivia', 'C.', 'Female', '1955-07-07', 3, 5, 1, '09567890123', 'person7@example.com', 18000.00, 'No', 'No', 'No', NULL, 'No', 5, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', NULL, 'Retired', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(8, 'Gonzales', 'Christian', 'K.', 'Male', '1990-04-12', 2, 4, 3, '09678901234', 'person8@example.com', 22000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Self-Employed', 'Vendor', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(9, 'Lopez', 'Joyce', 'R.', 'Female', '2000-02-29', 1, 1, 1, '09789012345', 'person9@example.com', 18000.00, 'No', 'No', 'No', NULL, 'No', 7, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Private Company A', 'Office Worker', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(10, 'Perez', 'Juan', 'E.', 'Male', '1980-08-01', 2, 2, 1, '09876543210', 'person10@example.com', 40000.00, 'No', 'No', 'No', NULL, 'No', 9, 'Yes', 'Yes', 'No', 'Yes', 'Yes', 'Yes', 'Government Agency B', 'Engineer', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(11, 'Aquino', 'Maria', 'F.', 'Female', '1975-05-05', 2, 5, 1, '09123456789', 'person11@example.com', 32000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Local Business C', 'Teacher', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(12, 'Ramos', 'Jose', 'G.', 'Male', '1965-10-10', 2, 7, 3, '09234567890', 'person12@example.com', 20000.00, 'No', 'No', 'No', NULL, 'No', 6, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Self-Employed', 'Farmer', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(13, 'Diaz', 'Elena', 'H.', 'Female', '1995-12-15', 1, 8, 1, '09345678901', 'person13@example.com', 27000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Private Company A', 'Office Worker', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(14, 'Torres', 'Pedro', 'I.', 'Male', '1988-06-20', 2, 1, 1, '09456789012', 'person14@example.com', 38000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Government Agency B', 'Engineer', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(15, 'Flores', 'Sofia', 'J.', 'Female', '1972-03-01', 2, 2, 1, '09567890123', 'person15@example.com', 29000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Local Business C', 'Nurse', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(16, 'Villanueva', 'Luis', 'K.', 'Male', '1968-09-09', 2, 5, 3, '09678901234', 'person16@example.com', 21000.00, 'No', 'No', 'No', NULL, 'No', 6, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Self-Employed', 'Fisherman', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(17, 'Castro', 'Isabel', 'L.', 'Female', '2010-01-10', 1, 4, 1, '09789012345', 'person17@example.com', NULL, 'No', 'No', 'Yes', 'School 1', 'No', 3, 'Yes', 'No', 'No', 'No', 'No', 'No', NULL, 'Student', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(18, 'Rivera', 'Carlos', 'M.', 'Male', '2002-04-04', 1, 6, 1, '09876543210', 'person18@example.com', NULL, 'No', 'No', 'Yes', 'School 3', 'No', 5, 'Yes', 'Yes', 'No', 'No', 'No', 'No', NULL, 'Student', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(19, 'De Leon', 'Ana', 'N.', 'Female', '1992-07-17', 2, 7, 1, '09123456789', 'person19@example.com', 26000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Private Company A', 'Office Worker', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(20, 'Mendoza', 'Miguel', 'O.', 'Male', '1983-02-22', 2, 8, 3, '09234567890', 'person20@example.com', 37000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Government Agency B', 'Construction Worker', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(21, 'Sy', 'Teresa', 'P.', 'Female', '1978-08-08', 2, 1, 1, '09345678901', 'person21@example.com', 30000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Local Business C', 'Teacher', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(22, 'Tan', 'Diego', 'Q.', 'Male', '1963-05-13', 2, 2, 1, '09456789012', 'person22@example.com', 19000.00, 'No', 'No', 'No', NULL, 'No', 6, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Self-Employed', 'Vendor', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(23, 'Chua', 'Carmen', 'R.', 'Female', '2007-09-01', 1, 5, 1, '09567890123', 'person23@example.com', NULL, 'No', 'No', 'Yes', 'School 4', 'No', 3, 'Yes', 'No', 'No', 'No', 'No', 'No', NULL, 'Student', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(24, 'Go', 'Ricardo', 'S.', 'Male', '1997-11-11', 1, 7, 3, '09678901234', 'person24@example.com', 24000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Private Company A', 'Office Worker', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(25, 'Uy', 'Laura', 'T.', 'Female', '1981-06-06', 2, 8, 1, '09789012345', 'person25@example.com', 33000.00, 'No', 'No', 'No', NULL, 'No', 9, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Government Agency B', 'Teacher', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(26, 'Cheng', 'Fernando', 'U.', 'Male', '1976-03-03', 2, 1, 1, '09876543210', 'person26@example.com', 31000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Local Business C', 'Engineer', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(27, 'Ong', 'Patricia', 'V.', 'Female', '1961-10-20', 2, 2, 3, '09123456789', 'person27@example.com', 23000.00, 'No', 'No', 'No', NULL, 'No', 6, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Self-Employed', 'Farmer', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(28, 'Yap', 'Javier', 'W.', 'Male', '2013-02-14', 1, 5, 1, '09234567890', 'person28@example.com', NULL, 'No', 'No', 'Yes', 'School 2', 'No', 2, 'Yes', 'No', 'No', 'No', 'No', 'No', NULL, 'Student', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(29, 'Yu', 'Monica', 'X.', 'Female', '2009-08-05', 1, 7, 1, '09345678901', 'person29@example.com', NULL, 'No', 'No', 'Yes', 'School 5', 'No', 3, 'Yes', 'No', 'No', 'No', 'No', 'No', NULL, 'Student', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(30, 'Soriano', 'Juan', 'Y.', 'Male', '1994-01-25', 1, 8, 3, '09456789012', 'person30@example.com', 28000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Private Company A', 'Office Worker', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(31, 'Dela Cruz', 'Maria', 'Z.', 'Female', '1987-04-18', 2, 1, 1, '09567890123', 'person31@example.com', 36000.00, 'No', 'No', 'No', NULL, 'No', 9, 'Yes', 'Yes', 'No', 'Yes', 'Yes', 'Yes', 'Government Agency B', 'Teacher', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(32, 'Reyes', 'Jose', 'A.', 'Male', '1971-07-03', 2, 2, 1, '09678901234', 'person32@example.com', 25000.00, 'No', 'No', 'No', NULL, 'No', 6, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Self-Employed', 'Construction Worker', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(33, 'Santos', 'Elena', 'B.', 'Female', '2016-11-08', 1, 5, 1, '09789012345', 'person33@example.com', NULL, 'No', 'No', 'Yes', 'School 1', 'No', 2, 'Yes', 'No', 'No', 'No', 'No', 'No', NULL, 'Student', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(34, 'Bautista', 'Pedro', 'C.', 'Male', '2004-03-28', 1, 7, 3, '09876543210', 'person34@example.com', NULL, 'No', 'No', 'Yes', 'School 3', 'No', 4, 'Yes', 'Yes', 'No', 'No', 'No', 'No', NULL, 'Student', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(35, 'Garcia', 'Sofia', 'D.', 'Female', '1999-09-19', 1, 8, 1, '09123456789', 'person35@example.com', 27000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Private Company A', 'Nurse', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(36, 'Lim', 'Luis', 'E.', 'Male', '1982-06-02', 2, 1, 1, '09234567890', 'person36@example.com', 34000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Government Agency B', 'Engineer', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(37, 'Cruz', 'Isabel', 'F.', 'Female', '1977-12-12', 2, 2, 1, '09345678901', 'person37@example.com', 28000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Local Business C', 'Teacher', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(38, 'Gonzales', 'Carlos', 'G.', 'Male', '1962-08-23', 2, 5, 3, '09456789012', 'person38@example.com', 20000.00, 'No', 'No', 'No', NULL, 'No', 6, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Self-Employed', 'Farmer', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(39, 'Lopez', 'Ana', 'H.', 'Female', '2011-05-15', 1, 7, 1, '09567890123', 'person39@example.com', NULL, 'No', 'No', 'Yes', 'School 4', 'No', 3, 'Yes', 'No', 'No', 'No', 'No', 'No', NULL, 'Student', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(40, 'Perez', 'Miguel', 'I.', 'Male', '2001-01-01', 1, 8, 1, '09678901234', 'person40@example.com', 15000.00, 'No', 'No', 'No', NULL, 'No', 5, 'Yes', 'Yes', 'No', 'No', 'No', 'No', 'Private Company A', 'Vendor', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(41, 'Aquino', 'Teresa', 'J.', 'Female', '1993-04-04', 2, 1, 1, '09789012345', 'person41@example.com', 29000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Government Agency B', 'Office Worker', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(42, 'Ramos', 'Diego', 'K.', 'Male', '1984-07-07', 2, 2, 3, '09876543210', 'person42@example.com', 38000.00, 'No', 'No', 'No', NULL, 'No', 9, 'Yes', 'Yes', 'No', 'Yes', 'Yes', 'Yes', 'Local Business C', 'Engineer', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(43, 'Diaz', 'Carmen', 'L.', 'Female', '1969-02-19', 2, 5, 1, '09123456789', 'person43@example.com', 26000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Self-Employed', 'Nurse', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(44, 'Torres', 'Ricardo', 'M.', 'Male', '2014-09-29', 1, 7, 1, '09234567890', 'person44@example.com', NULL, 'No', 'No', 'Yes', 'School 5', 'No', 2, 'Yes', 'No', 'No', 'No', 'No', 'No', NULL, 'Student', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(45, 'Flores', 'Laura', 'N.', 'Female', '2006-12-03', 1, 8, 3, '09345678901', 'person45@example.com', NULL, 'No', 'No', 'Yes', 'School 2', 'No', 3, 'Yes', 'No', 'No', 'No', 'No', 'No', NULL, 'Student', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(46, 'Villanueva', 'Fernando', 'O.', 'Male', '1996-05-08', 1, 1, 1, '09456789012', 'person46@example.com', 25000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Private Company A', 'Office Worker', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(47, 'Castro', 'Patricia', 'P.', 'Female', '1989-01-11', 2, 2, 1, '09567890123', 'person47@example.com', 35000.00, 'No', 'No', 'No', NULL, 'No', 9, 'Yes', 'Yes', 'No', 'Yes', 'Yes', 'Yes', 'Government Agency B', 'Teacher', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(48, 'Rivera', 'Javier', 'Q.', 'Male', '1974-03-27', 2, 5, 3, '09678901234', 'person48@example.com', 28000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Local Business C', 'Construction Worker', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(49, 'De Leon', 'Monica', 'R.', 'Female', '2012-10-06', 1, 7, 1, '09789012345', 'person49@example.com', NULL, 'No', 'No', 'Yes', 'School 3', 'No', 2, 'Yes', 'No', 'No', 'No', 'No', 'No', NULL, 'Student', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(50, 'Mendoza', 'Christian', 'S.', 'Male', '2003-07-21', 1, 8, 1, '09876543210', 'person50@example.com', NULL, 'No', 'No', 'Yes', 'School 4', 'No', 4, 'Yes', 'Yes', 'No', 'No', 'No', 'No', NULL, 'Student', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(51, 'Sy', 'Grace', 'T.', 'Female', '1991-09-02', 2, 1, 1, '09123456789', 'person51@example.com', 27000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Private Company A', 'Teacher', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(52, 'Tan', 'Mark', 'U.', 'Male', '1986-12-16', 2, 2, 3, '09234567890', 'person52@example.com', 33000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Government Agency B', 'Engineer', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(53, 'Chua', 'Sarah', 'V.', 'Female', '1979-05-25', 2, 5, 1, '09345678901', 'person53@example.com', 29000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Local Business C', 'Nurse', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(54, 'Go', 'Daniel', 'W.', 'Male', '1964-08-18', 2, 7, 1, '09456789012', 'person54@example.com', 21000.00, 'No', 'No', 'No', NULL, 'No', 6, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Self-Employed', 'Vendor', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(55, 'Uy', 'Joyce', 'X.', 'Female', '2008-01-07', 1, 8, 3, '09567890123', 'person55@example.com', NULL, 'No', 'No', 'Yes', 'School 1', 'No', 3, 'Yes', 'No', 'No', 'No', 'No', 'No', NULL, 'Student', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(56, 'Cheng', 'Kevin', 'Y.', 'Male', '2000-04-14', 1, 1, 1, '09678901234', 'person56@example.com', 17000.00, 'No', 'No', 'No', NULL, 'No', 5, 'Yes', 'Yes', 'No', 'No', 'No', 'No', 'Private Company A', 'Office Worker', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(57, 'Ong', 'Nicole', 'Z.', 'Female', '1990-07-28', 2, 2, 1, '09789012345', 'person57@example.com', 30000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Government Agency B', 'Teacher', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(58, 'Yap', 'Paul', 'A.', 'Male', '1983-09-05', 2, 5, 3, '09876543210', 'person58@example.com', 39000.00, 'No', 'No', 'No', NULL, 'No', 9, 'Yes', 'Yes', 'No', 'Yes', 'Yes', 'Yes', 'Local Business C', 'Engineer', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(59, 'Yu', 'Olivia', 'B.', 'Female', '1968-01-30', 2, 7, 1, '09123456789', 'person59@example.com', 27000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Self-Employed', 'Nurse', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(60, 'Soriano', 'Christian', 'C.', 'Male', '2017-04-22', 1, 8, 1, '09234567890', 'person60@example.com', NULL, 'No', 'No', 'Yes', 'School 5', 'No', 2, 'Yes', 'No', 'No', 'No', 'No', 'No', NULL, 'Student', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(61, 'Dela Cruz', 'Grace', 'D.', 'Female', '2005-06-15', 1, 1, 1, '09345678901', 'person61@example.com', NULL, 'No', 'No', 'Yes', 'School 2', 'No', 4, 'Yes', 'Yes', 'No', 'No', 'No', 'No', NULL, 'Student', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(62, 'Reyes', 'Mark', 'E.', 'Male', '1998-09-20', 2, 2, 3, '09456789012', 'person62@example.com', 25000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Private Company A', 'Teacher', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(63, 'Santos', 'Sarah', 'F.', 'Female', '1985-03-10', 2, 5, 1, '09567890123', 'person63@example.com', 35000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Government Agency B', 'Engineer', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(64, 'Bautista', 'Daniel', 'G.', 'Male', '1970-11-25', 2, 7, 1, '09678901234', 'person64@example.com', 28000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Local Business C', 'Nurse', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(65, 'Garcia', 'Joyce', 'H.', 'Female', '1960-01-01', 3, 8, 3, '09789012345', 'person65@example.com', 15000.00, 'No', 'No', 'No', NULL, 'No', 5, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', NULL, 'Retired', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(66, 'Lim', 'Kevin', 'I.', 'Male', '1955-07-07', 3, 1, 1, '09876543210', 'person66@example.com', 18000.00, 'No', 'No', 'No', NULL, 'No', 5, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', NULL, 'Retired', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(67, 'Cruz', 'Nicole', 'J.', 'Female', '1990-04-12', 2, 2, 1, '09123456789', 'person67@example.com', 22000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Self-Employed', 'Vendor', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(68, 'Gonzales', 'Paul', 'K.', 'Male', '2000-02-29', 1, 5, 3, '09234567890', 'person68@example.com', 18000.00, 'No', 'No', 'No', NULL, 'No', 7, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Private Company A', 'Office Worker', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(69, 'Lopez', 'Olivia', 'L.', 'Female', '1980-08-01', 2, 7, 1, '09345678901', 'person69@example.com', 40000.00, 'No', 'No', 'No', NULL, 'No', 9, 'Yes', 'Yes', 'No', 'Yes', 'Yes', 'Yes', 'Government Agency B', 'Engineer', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(70, 'Perez', 'Christian', 'M.', 'Male', '1975-05-05', 2, 8, 1, '09456789012', 'person70@example.com', 32000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Local Business C', 'Teacher', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(71, 'Aquino', 'Grace', 'N.', 'Female', '1965-10-10', 2, 1, 3, '09567890123', 'person71@example.com', 20000.00, 'No', 'No', 'No', NULL, 'No', 6, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Self-Employed', 'Farmer', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(72, 'Ramos', 'Mark', 'O.', 'Male', '1995-12-15', 1, 2, 1, '09678901234', 'person72@example.com', 27000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Private Company A', 'Office Worker', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(73, 'Diaz', 'Sarah', 'P.', 'Female', '1988-06-20', 2, 5, 1, '09789012345', 'person73@example.com', 38000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Government Agency B', 'Engineer', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(74, 'Torres', 'Daniel', 'Q.', 'Male', '1972-03-01', 2, 7, 1, '09876543210', 'person74@example.com', 29000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Local Business C', 'Nurse', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(75, 'Flores', 'Joyce', 'R.', 'Female', '1968-09-09', 2, 8, 3, '09123456789', 'person75@example.com', 21000.00, 'No', 'No', 'No', NULL, 'No', 6, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Self-Employed', 'Fisherman', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(76, 'Villanueva', 'Kevin', 'S.', 'Male', '2010-01-10', 1, 1, 1, '09234567890', 'person76@example.com', NULL, 'No', 'No', 'Yes', 'School 1', 'No', 3, 'Yes', 'No', 'No', 'No', 'No', 'No', NULL, 'Student', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(77, 'Castro', 'Nicole', 'T.', 'Female', '2002-04-04', 1, 2, 1, '09345678901', 'person77@example.com', NULL, 'No', 'No', 'Yes', 'School 3', 'No', 5, 'Yes', 'Yes', 'No', 'No', 'No', 'No', NULL, 'Student', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(78, 'Rivera', 'Paul', 'U.', 'Male', '1992-07-17', 2, 5, 3, '09456789012', 'person78@example.com', 26000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Private Company A', 'Office Worker', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(79, 'De Leon', 'Olivia', 'V.', 'Female', '1983-02-22', 2, 7, 1, '09567890123', 'person79@example.com', 37000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Government Agency B', 'Construction Worker', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(80, 'Mendoza', 'Christian', 'W.', 'Male', '1978-08-08', 2, 8, 1, '09678901234', 'person80@example.com', 30000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Local Business C', 'Teacher', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(81, 'Sy', 'Grace', 'X.', 'Female', '1963-05-13', 2, 1, 3, '09789012345', 'person81@example.com', 19000.00, 'No', 'No', 'No', NULL, 'No', 6, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Self-Employed', 'Vendor', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(82, 'Tan', 'Mark', 'Y.', 'Male', '2007-09-01', 1, 2, 1, '09876543210', 'person82@example.com', NULL, 'No', 'No', 'Yes', 'School 4', 'No', 3, 'Yes', 'No', 'No', 'No', 'No', 'No', NULL, 'Student', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(83, 'Chua', 'Sarah', 'Z.', 'Female', '1997-11-11', 1, 5, 1, '09123456789', 'person83@example.com', 24000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Private Company A', 'Office Worker', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(84, 'Go', 'Daniel', 'A.', 'Male', '1981-06-06', 2, 7, 3, '09234567890', 'person84@example.com', 33000.00, 'No', 'No', 'No', NULL, 'No', 9, 'Yes', 'Yes', 'No', 'Yes', 'Yes', 'Yes', 'Government Agency B', 'Teacher', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(85, 'Uy', 'Joyce', 'B.', 'Female', '1976-03-03', 2, 8, 1, '09345678901', 'person85@example.com', 31000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Local Business C', 'Engineer', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(86, 'Cheng', 'Kevin', 'C.', 'Male', '1961-10-20', 2, 1, 1, '09456789012', 'person86@example.com', 23000.00, 'No', 'No', 'No', NULL, 'No', 6, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Self-Employed', 'Farmer', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(87, 'Ong', 'Nicole', 'D.', 'Female', '2013-02-14', 1, 2, 1, '09567890123', 'person87@example.com', NULL, 'No', 'No', 'Yes', 'School 2', 'No', 2, 'Yes', 'No', 'No', 'No', 'No', 'No', NULL, 'Student', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(88, 'Yap', 'Paul', 'E.', 'Male', '2009-08-05', 1, 5, 3, '09678901234', 'person88@example.com', NULL, 'No', 'No', 'Yes', 'School 5', 'No', 3, 'Yes', 'No', 'No', 'No', 'No', 'No', NULL, 'Student', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(89, 'Yu', 'Olivia', 'F.', 'Female', '1994-01-25', 1, 7, 1, '09789012345', 'person89@example.com', 28000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Private Company A', 'Office Worker', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(90, 'Soriano', 'Christian', 'G.', 'Male', '1987-04-18', 2, 8, 1, '09876543210', 'person90@example.com', 36000.00, 'No', 'No', 'No', NULL, 'No', 9, 'Yes', 'Yes', 'No', 'Yes', 'Yes', 'Yes', 'Government Agency B', 'Teacher', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(91, 'Dela Cruz', 'Grace', 'H.', 'Female', '1971-07-03', 2, 1, 3, '09123456789', 'person91@example.com', 25000.00, 'No', 'No', 'No', NULL, 'No', 6, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Self-Employed', 'Construction Worker', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(92, 'Reyes', 'Mark', 'I.', 'Male', '2016-11-08', 1, 2, 1, '09234567890', 'person92@example.com', NULL, 'No', 'No', 'Yes', 'School 1', 'No', 2, 'Yes', 'No', 'No', 'No', 'No', 'No', NULL, 'Student', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(93, 'Santos', 'Sarah', 'J.', 'Female', '2004-03-28', 1, 5, 1, '09345678901', 'person93@example.com', NULL, 'No', 'No', 'Yes', 'School 3', 'No', 4, 'Yes', 'Yes', 'No', 'No', 'No', 'No', NULL, 'Student', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(94, 'Bautista', 'Daniel', 'K.', 'Male', '1999-09-19', 1, 7, 3, '09456789012', 'person94@example.com', 27000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Private Company A', 'Nurse', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(95, 'Garcia', 'Joyce', 'L.', 'Female', '1982-06-02', 2, 8, 1, '09567890123', 'person95@example.com', 34000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Government Agency B', 'Engineer', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(96, 'Lim', 'Kevin', 'M.', 'Male', '1977-12-12', 2, 1, 1, '09678901234', 'person96@example.com', 28000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Local Business C', 'Teacher', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(97, 'Cruz', 'Nicole', 'N.', 'Female', '1962-08-23', 2, 2, 3, '09789012345', 'person97@example.com', 20000.00, 'No', 'No', 'No', NULL, 'No', 6, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Self-Employed', 'Farmer', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(98, 'Gonzales', 'Paul', 'O.', 'Male', '2011-05-15', 1, 5, 1, '09876543210', 'person98@example.com', NULL, 'No', 'No', 'Yes', 'School 4', 'No', 3, 'Yes', 'No', 'No', 'No', 'No', 'No', NULL, 'Student', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(99, 'Lopez', 'Olivia', 'P.', 'Female', '2001-01-01', 1, 7, 1, '09123456789', 'person99@example.com', 15000.00, 'No', 'No', 'No', NULL, 'No', 5, 'Yes', 'Yes', 'No', 'No', 'No', 'No', 'Private Company A', 'Vendor', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(100, 'Perez', 'Christian', 'Q.', 'Male', '1993-04-04', 2, 8, 3, '09234567890', 'person100@example.com', 29000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Government Agency B', 'Office Worker', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(101, 'Aquino', 'Grace', 'R.', 'Female', '1984-07-07', 2, 1, 1, '09345678901', 'person101@example.com', 38000.00, 'No', 'No', 'No', NULL, 'No', 9, 'Yes', 'Yes', 'No', 'Yes', 'Yes', 'Yes', 'Local Business C', 'Engineer', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(102, 'Ramos', 'Mark', 'S.', 'Male', '1969-02-19', 2, 2, 1, '09456789012', 'person102@example.com', 26000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Self-Employed', 'Nurse', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(103, 'Diaz', 'Sarah', 'T.', 'Female', '2014-09-29', 1, 5, 3, '09567890123', 'person103@example.com', NULL, 'No', 'No', 'Yes', 'School 5', 'No', 2, 'Yes', 'No', 'No', 'No', 'No', 'No', NULL, 'Student', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(104, 'Torres', 'Daniel', 'U.', 'Male', '2006-12-03', 1, 7, 1, '09678901234', 'person104@example.com', NULL, 'No', 'No', 'Yes', 'School 2', 'No', 3, 'Yes', 'No', 'No', 'No', 'No', 'No', NULL, 'Student', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(105, 'Flores', 'Joyce', 'V.', 'Female', '1996-05-08', 1, 8, 1, '09789012345', 'person105@example.com', 25000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Private Company A', 'Office Worker', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(106, 'Villanueva', 'Kevin', 'W.', 'Male', '1989-01-11', 2, 1, 3, '09876543210', 'person106@example.com', 35000.00, 'No', 'No', 'No', NULL, 'No', 9, 'Yes', 'Yes', 'No', 'Yes', 'Yes', 'Yes', 'Government Agency B', 'Teacher', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(107, 'Castro', 'Nicole', 'X.', 'Female', '1974-03-27', 2, 2, 1, '09123456789', 'person107@example.com', 28000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Local Business C', 'Construction Worker', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(108, 'Rivera', 'Paul', 'Y.', 'Male', '2012-10-06', 1, 5, 1, '09234567890', 'person108@example.com', NULL, 'No', 'No', 'Yes', 'School 3', 'No', 2, 'Yes', 'No', 'No', 'No', 'No', 'No', NULL, 'Student', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(109, 'De Leon', 'Olivia', 'Z.', 'Female', '2003-07-21', 1, 7, 3, '09345678901', 'person109@example.com', NULL, 'No', 'No', 'Yes', 'School 4', 'No', 4, 'Yes', 'Yes', 'No', 'No', 'No', 'No', NULL, 'Student', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(110, 'Mendoza', 'Christian', 'A.', 'Male', '1991-09-02', 2, 8, 1, '09456789012', 'person110@example.com', 27000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Private Company A', 'Teacher', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(111, 'Sy', 'Grace', 'B.', 'Female', '1986-12-16', 2, 1, 1, '09567890123', 'person111@example.com', 33000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Government Agency B', 'Engineer', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(112, 'Tan', 'Mark', 'C.', 'Male', '1979-05-25', 2, 2, 3, '09678901234', 'person112@example.com', 29000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Local Business C', 'Nurse', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(113, 'Chua', 'Sarah', 'D.', 'Female', '1964-08-18', 2, 5, 1, '09789012345', 'person113@example.com', 21000.00, 'No', 'No', 'No', NULL, 'No', 6, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Self-Employed', 'Vendor', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(114, 'Go', 'Daniel', 'E.', 'Male', '2008-01-07', 1, 7, 1, '09876543210', 'person114@example.com', NULL, 'No', 'No', 'Yes', 'School 1', 'No', 3, 'Yes', 'No', 'No', 'No', 'No', 'No', NULL, 'Student', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(115, 'Uy', 'Joyce', 'F.', 'Female', '2000-04-14', 1, 8, 3, '09123456789', 'person115@example.com', 17000.00, 'No', 'No', 'No', NULL, 'No', 5, 'Yes', 'Yes', 'No', 'No', 'No', 'No', 'Private Company A', 'Office Worker', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(116, 'Cheng', 'Kevin', 'G.', 'Male', '1990-07-28', 2, 1, 1, '09234567890', 'person116@example.com', 30000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Government Agency B', 'Teacher', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(117, 'Ong', 'Nicole', 'H.', 'Female', '1983-09-05', 2, 2, 1, '09345678901', 'person117@example.com', 39000.00, 'No', 'No', 'No', NULL, 'No', 9, 'Yes', 'Yes', 'No', 'Yes', 'Yes', 'Yes', 'Local Business C', 'Engineer', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(118, 'Yap', 'Paul', 'I.', 'Male', '1968-01-30', 2, 5, 3, '09456789012', 'person118@example.com', 27000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Self-Employed', 'Nurse', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(119, 'Yu', 'Olivia', 'J.', 'Female', '2017-04-22', 1, 7, 1, '09567890123', 'person119@example.com', NULL, 'No', 'No', 'Yes', 'School 5', 'No', 2, 'Yes', 'No', 'No', 'No', 'No', 'No', NULL, 'Student', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(120, 'Soriano', 'Christian', 'K.', 'Male', '2005-06-15', 1, 8, 1, '09678901234', 'person120@example.com', NULL, 'No', 'No', 'Yes', 'School 2', 'No', 4, 'Yes', 'Yes', 'No', 'No', 'No', 'No', NULL, 'Student', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(121, 'Dela Cruz', 'Grace', 'L.', 'Female', '1998-09-20', 2, 1, 3, '09789012345', 'person121@example.com', 25000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Private Company A', 'Teacher', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(122, 'Reyes', 'Mark', 'M.', 'Male', '1985-03-10', 2, 2, 1, '09876543210', 'person122@example.com', 35000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Government Agency B', 'Engineer', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(123, 'Santos', 'Sarah', 'N.', 'Female', '1970-11-25', 2, 5, 1, '09123456789', 'person123@example.com', 28000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Local Business C', 'Nurse', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(124, 'Bautista', 'Daniel', 'O.', 'Male', '1960-01-01', 3, 7, 3, '09234567890', 'person124@example.com', 15000.00, 'No', 'No', 'No', NULL, 'No', 5, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', NULL, 'Retired', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(125, 'Garcia', 'Joyce', 'P.', 'Female', '1955-07-07', 3, 8, 1, '09345678901', 'person125@example.com', 18000.00, 'No', 'No', 'No', NULL, 'No', 5, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', NULL, 'Retired', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(126, 'Lim', 'Kevin', 'Q.', 'Male', '1990-04-12', 2, 1, 1, '09456789012', 'person126@example.com', 22000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Self-Employed', 'Vendor', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(127, 'Cruz', 'Nicole', 'R.', 'Female', '2000-02-29', 1, 2, 3, '09567890123', 'person127@example.com', 18000.00, 'No', 'No', 'No', NULL, 'No', 7, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Private Company A', 'Office Worker', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(128, 'Gonzales', 'Paul', 'S.', 'Male', '1980-08-01', 2, 5, 1, '09678901234', 'person128@example.com', 40000.00, 'No', 'No', 'No', NULL, 'No', 9, 'Yes', 'Yes', 'No', 'Yes', 'Yes', 'Yes', 'Government Agency B', 'Engineer', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(129, 'Lopez', 'Olivia', 'T.', 'Female', '1975-05-05', 2, 7, 1, '09789012345', 'person129@example.com', 32000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Local Business C', 'Teacher', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(130, 'Perez', 'Christian', 'U.', 'Male', '1965-10-10', 2, 8, 3, '09876543210', 'person130@example.com', 20000.00, 'No', 'No', 'No', NULL, 'No', 6, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Self-Employed', 'Farmer', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(131, 'Aquino', 'Grace', 'V.', 'Female', '1995-12-15', 1, 1, 1, '09123456789', 'person131@example.com', 27000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Private Company A', 'Office Worker', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(132, 'Ramos', 'Mark', 'W.', 'Male', '1988-06-20', 2, 2, 1, '09234567890', 'person132@example.com', 38000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Government Agency B', 'Engineer', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(133, 'Diaz', 'Sarah', 'X.', 'Female', '1972-03-01', 2, 5, 3, '09345678901', 'person133@example.com', 29000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Local Business C', 'Nurse', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(134, 'Torres', 'Daniel', 'Y.', 'Male', '1968-09-09', 2, 7, 1, '09456789012', 'person134@example.com', 21000.00, 'No', 'No', 'No', NULL, 'No', 6, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Self-Employed', 'Fisherman', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(135, 'Flores', 'Joyce', 'Z.', 'Female', '2010-01-10', 1, 8, 1, '09567890123', 'person135@example.com', NULL, 'No', 'No', 'Yes', 'School 1', 'No', 3, 'Yes', 'No', 'No', 'No', 'No', 'No', NULL, 'Student', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(136, 'Villanueva', 'Kevin', 'A.', 'Male', '2002-04-04', 1, 1, 3, '09678901234', 'person136@example.com', NULL, 'No', 'No', 'Yes', 'School 3', 'No', 5, 'Yes', 'Yes', 'No', 'No', 'No', 'No', NULL, 'Student', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(137, 'Castro', 'Nicole', 'B.', 'Female', '1992-07-17', 2, 2, 1, '09789012345', 'person137@example.com', 26000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Private Company A', 'Office Worker', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(138, 'Rivera', 'Paul', 'C.', 'Male', '1983-02-22', 2, 5, 1, '09876543210', 'person138@example.com', 37000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Government Agency B', 'Construction Worker', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(139, 'De Leon', 'Olivia', 'D.', 'Female', '1978-08-08', 2, 7, 3, '09123456789', 'person139@example.com', 30000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Local Business C', 'Teacher', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(140, 'Mendoza', 'Christian', 'E.', 'Male', '1963-05-13', 2, 8, 1, '09234567890', 'person140@example.com', 19000.00, 'No', 'No', 'No', NULL, 'No', 6, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Self-Employed', 'Vendor', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(141, 'Sy', 'Grace', 'F.', 'Female', '2007-09-01', 1, 1, 1, '09345678901', 'person141@example.com', NULL, 'No', 'No', 'Yes', 'School 4', 'No', 3, 'Yes', 'No', 'No', 'No', 'No', 'No', NULL, 'Student', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(142, 'Tan', 'Mark', 'G.', 'Male', '1997-11-11', 1, 2, 3, '09456789012', 'person142@example.com', 24000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Private Company A', 'Office Worker', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(143, 'Chua', 'Sarah', 'H.', 'Female', '1981-06-06', 2, 5, 1, '09567890123', 'person143@example.com', 33000.00, 'No', 'No', 'No', NULL, 'No', 9, 'Yes', 'Yes', 'No', 'Yes', 'Yes', 'Yes', 'Government Agency B', 'Teacher', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(144, 'Go', 'Daniel', 'I.', 'Male', '1976-03-03', 2, 7, 1, '09678901234', 'person144@example.com', 31000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Local Business C', 'Engineer', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(145, 'Uy', 'Joyce', 'J.', 'Female', '1961-10-20', 2, 8, 3, '09789012345', 'person145@example.com', 23000.00, 'No', 'No', 'No', NULL, 'No', 6, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Self-Employed', 'Farmer', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(146, 'Cheng', 'Kevin', 'K.', 'Male', '2013-02-14', 1, 1, 1, '09876543210', 'person146@example.com', NULL, 'No', 'No', 'Yes', 'School 2', 'No', 2, 'Yes', 'No', 'No', 'No', 'No', 'No', NULL, 'Student', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(147, 'Ong', 'Nicole', 'L.', 'Female', '2009-08-05', 1, 2, 1, '09123456789', 'person147@example.com', NULL, 'No', 'No', 'Yes', 'School 5', 'No', 3, 'Yes', 'No', 'No', 'No', 'No', 'No', NULL, 'Student', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(148, 'Yap', 'Paul', 'M.', 'Male', '1994-01-25', 1, 5, 3, '09234567890', 'person148@example.com', 28000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Private Company A', 'Office Worker', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(149, 'Yu', 'Olivia', 'N.', 'Female', '1987-04-18', 2, 7, 1, '09345678901', 'person149@example.com', 36000.00, 'No', 'No', 'No', NULL, 'No', 9, 'Yes', 'Yes', 'No', 'Yes', 'Yes', 'Yes', 'Government Agency B', 'Teacher', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(150, 'Soriano', 'Christian', 'O.', 'Male', '1971-07-03', 2, 8, 1, '09456789012', 'person150@example.com', 25000.00, 'No', 'No', 'No', NULL, 'No', 6, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Self-Employed', 'Construction Worker', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(151, 'Dela Cruz', 'Grace', 'P.', 'Female', '2016-11-08', 1, 1, 3, '09567890123', 'person151@example.com', NULL, 'No', 'No', 'Yes', 'School 1', 'No', 2, 'Yes', 'No', 'No', 'No', 'No', 'No', NULL, 'Student', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(152, 'Reyes', 'Mark', 'Q.', 'Male', '2004-03-28', 1, 2, 1, '09678901234', 'person152@example.com', NULL, 'No', 'No', 'Yes', 'School 3', 'No', 4, 'Yes', 'Yes', 'No', 'No', 'No', 'No', NULL, 'Student', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(153, 'Santos', 'Sarah', 'R.', 'Female', '1999-09-19', 1, 5, 1, '09789012345', 'person153@example.com', 27000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Private Company A', 'Nurse', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(154, 'Bautista', 'Daniel', 'S.', 'Male', '1982-06-02', 2, 7, 3, '09876543210', 'person154@example.com', 34000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Government Agency B', 'Engineer', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(155, 'Garcia', 'Joyce', 'T.', 'Female', '1977-12-12', 2, 8, 1, '09123456789', 'person155@example.com', 28000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Local Business C', 'Teacher', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(156, 'Lim', 'Kevin', 'U.', 'Male', '1962-08-23', 2, 1, 1, '09234567890', 'person156@example.com', 20000.00, 'No', 'No', 'No', NULL, 'No', 6, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Self-Employed', 'Farmer', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(157, 'Cruz', 'Nicole', 'V.', 'Female', '2011-05-15', 1, 2, 3, '09345678901', 'person157@example.com', NULL, 'No', 'No', 'Yes', 'School 4', 'No', 3, 'Yes', 'No', 'No', 'No', 'No', 'No', NULL, 'Student', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(158, 'Gonzales', 'Paul', 'W.', 'Male', '2001-01-01', 1, 5, 1, '09456789012', 'person158@example.com', 15000.00, 'No', 'No', 'No', NULL, 'No', 5, 'Yes', 'Yes', 'No', 'No', 'No', 'No', 'Private Company A', 'Vendor', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(159, 'Lopez', 'Olivia', 'X.', 'Female', '1993-04-04', 2, 7, 1, '09567890123', 'person159@example.com', 29000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Government Agency B', 'Office Worker', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(160, 'Perez', 'Christian', 'Y.', 'Male', '1984-07-07', 2, 8, 3, '09678901234', 'person160@example.com', 38000.00, 'No', 'No', 'No', NULL, 'No', 9, 'Yes', 'Yes', 'No', 'Yes', 'Yes', 'Yes', 'Local Business C', 'Engineer', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(161, 'Aquino', 'Grace', 'Z.', 'Female', '1969-02-19', 2, 1, 1, '09789012345', 'person161@example.com', 26000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Self-Employed', 'Nurse', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(162, 'Ramos', 'Mark', 'A.', 'Male', '2014-09-29', 1, 2, 1, '09876543210', 'person162@example.com', NULL, 'No', 'No', 'Yes', 'School 5', 'No', 2, 'Yes', 'No', 'No', 'No', 'No', 'No', NULL, 'Student', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(163, 'Diaz', 'Sarah', 'B.', 'Female', '2006-12-03', 1, 5, 3, '09123456789', 'person163@example.com', NULL, 'No', 'No', 'Yes', 'School 2', 'No', 3, 'Yes', 'No', 'No', 'No', 'No', 'No', NULL, 'Student', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(164, 'Torres', 'Daniel', 'C.', 'Male', '1996-05-08', 1, 7, 1, '09234567890', 'person164@example.com', 25000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Private Company A', 'Office Worker', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(165, 'Flores', 'Joyce', 'D.', 'Female', '1989-01-11', 2, 8, 1, '09345678901', 'person165@example.com', 35000.00, 'No', 'No', 'No', NULL, 'No', 9, 'Yes', 'Yes', 'No', 'Yes', 'Yes', 'Yes', 'Government Agency B', 'Teacher', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(166, 'Villanueva', 'Kevin', 'E.', 'Male', '1974-03-27', 2, 1, 3, '09456789012', 'person166@example.com', 28000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Local Business C', 'Construction Worker', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(167, 'Castro', 'Nicole', 'F.', 'Female', '2012-10-06', 1, 2, 1, '09567890123', 'person167@example.com', NULL, 'No', 'No', 'Yes', 'School 3', 'No', 2, 'Yes', 'No', 'No', 'No', 'No', 'No', NULL, 'Student', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(168, 'Rivera', 'Paul', 'G.', 'Male', '2003-07-21', 1, 5, 1, '09678901234', 'person168@example.com', NULL, 'No', 'No', 'Yes', 'School 4', 'No', 4, 'Yes', 'Yes', 'No', 'No', 'No', 'No', NULL, 'Student', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(169, 'De Leon', 'Olivia', 'H.', 'Female', '1991-09-02', 2, 7, 3, '09789012345', 'person169@example.com', 27000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Private Company A', 'Teacher', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(170, 'Mendoza', 'Christian', 'I.', 'Male', '1986-12-16', 2, 8, 1, '09876543210', 'person170@example.com', 33000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Government Agency B', 'Engineer', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(171, 'Sy', 'Grace', 'J.', 'Female', '1979-05-25', 2, 1, 1, '09123456789', 'person171@example.com', 29000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Local Business C', 'Nurse', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(172, 'Tan', 'Mark', 'K.', 'Male', '1964-08-18', 2, 2, 3, '09234567890', 'person172@example.com', 21000.00, 'No', 'No', 'No', NULL, 'No', 6, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Self-Employed', 'Vendor', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(173, 'Chua', 'Sarah', 'L.', 'Female', '2008-01-07', 1, 5, 1, '09345678901', 'person173@example.com', NULL, 'No', 'No', 'Yes', 'School 1', 'No', 3, 'Yes', 'No', 'No', 'No', 'No', 'No', NULL, 'Student', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(174, 'Go', 'Daniel', 'M.', 'Male', '2000-04-14', 1, 7, 1, '09456789012', 'person174@example.com', 17000.00, 'No', 'No', 'No', NULL, 'No', 5, 'Yes', 'Yes', 'No', 'No', 'No', 'No', 'Private Company A', 'Office Worker', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(175, 'Uy', 'Joyce', 'N.', 'Female', '1990-07-28', 2, 8, 3, '09567890123', 'person175@example.com', 30000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Government Agency B', 'Teacher', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(176, 'Cheng', 'Kevin', 'O.', 'Male', '1983-09-05', 2, 1, 1, '09678901234', 'person176@example.com', 39000.00, 'No', 'No', 'No', NULL, 'No', 9, 'Yes', 'Yes', 'No', 'Yes', 'Yes', 'Yes', 'Local Business C', 'Engineer', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(177, 'Ong', 'Nicole', 'P.', 'Female', '1968-01-30', 2, 2, 1, '09789012345', 'person177@example.com', 27000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Self-Employed', 'Nurse', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(178, 'Yap', 'Paul', 'Q.', 'Male', '2017-04-22', 1, 5, 3, '09876543210', 'person178@example.com', NULL, 'No', 'No', 'Yes', 'School 5', 'No', 2, 'Yes', 'No', 'No', 'No', 'No', 'No', NULL, 'Student', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(179, 'Yu', 'Olivia', 'R.', 'Female', '2005-06-15', 1, 7, 1, '09123456789', 'person179@example.com', NULL, 'No', 'No', 'Yes', 'School 2', 'No', 4, 'Yes', 'Yes', 'No', 'No', 'No', 'No', NULL, 'Student', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(180, 'Soriano', 'Christian', 'S.', 'Male', '1998-09-20', 2, 8, 1, '09234567890', 'person180@example.com', 25000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Private Company A', 'Teacher', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(181, 'Dela Cruz', 'Grace', 'T.', 'Female', '1985-03-10', 2, 1, 3, '09345678901', 'person181@example.com', 35000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Government Agency B', 'Engineer', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(182, 'Reyes', 'Mark', 'U.', 'Male', '1970-11-25', 2, 2, 1, '09456789012', 'person182@example.com', 28000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Local Business C', 'Nurse', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(183, 'Santos', 'Sarah', 'V.', 'Female', '1960-01-01', 3, 5, 1, '09567890123', 'person183@example.com', 15000.00, 'No', 'No', 'No', NULL, 'No', 5, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', NULL, 'Retired', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(184, 'Bautista', 'Daniel', 'W.', 'Male', '1955-07-07', 3, 7, 3, '09678901234', 'person184@example.com', 18000.00, 'No', 'No', 'No', NULL, 'No', 5, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', NULL, 'Retired', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(185, 'Garcia', 'Joyce', 'X.', 'Female', '1990-04-12', 2, 8, 1, '09789012345', 'person185@example.com', 22000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Self-Employed', 'Vendor', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(186, 'Lim', 'Kevin', 'Y.', 'Male', '2000-02-29', 1, 1, 1, '09876543210', 'person186@example.com', 18000.00, 'No', 'No', 'No', NULL, 'No', 7, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Private Company A', 'Office Worker', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(187, 'Cruz', 'Nicole', 'Z.', 'Female', '1980-08-01', 2, 2, 3, '09123456789', 'person187@example.com', 40000.00, 'No', 'No', 'No', NULL, 'No', 9, 'Yes', 'Yes', 'No', 'Yes', 'Yes', 'Yes', 'Government Agency B', 'Engineer', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00');
INSERT INTO `individual` (`individual_id`, `surname`, `first_name`, `middle_name`, `gender`, `birth_date`, `civil_status_id`, `blood_type_id`, `religion_id`, `contact_number`, `email`, `salary_income`, `is_solo_parent`, `has_disability`, `is_student`, `school_attending`, `is_scholar`, `educational_attainment_id`, `is_alive`, `is_registered_voter`, `is_ofw`, `is_sss_member`, `is_gsis_member`, `is_philhealth_member`, `working_for`, `occupation`, `is_4ps_beneficiary`, `created_at`, `updated_at`) VALUES
(188, 'Gonzales', 'Paul', 'A.', 'Male', '1975-05-05', 2, 5, 1, '09234567890', 'person188@example.com', 32000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Local Business C', 'Teacher', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(189, 'Lopez', 'Olivia', 'B.', 'Female', '1965-10-10', 2, 7, 1, '09345678901', 'person189@example.com', 20000.00, 'No', 'No', 'No', NULL, 'No', 6, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Self-Employed', 'Farmer', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(190, 'Perez', 'Christian', 'C.', 'Male', '1995-12-15', 1, 8, 3, '09456789012', 'person190@example.com', 27000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Private Company A', 'Office Worker', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(191, 'Aquino', 'Grace', 'D.', 'Female', '1988-06-20', 2, 1, 1, '09567890123', 'person191@example.com', 38000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Government Agency B', 'Engineer', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(192, 'Ramos', 'Mark', 'E.', 'Male', '1972-03-01', 2, 2, 1, '09678901234', 'person192@example.com', 29000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Local Business C', 'Nurse', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(193, 'Diaz', 'Sarah', 'F.', 'Female', '1968-09-09', 2, 5, 3, '09789012345', 'person193@example.com', 21000.00, 'No', 'No', 'No', NULL, 'No', 6, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Self-Employed', 'Fisherman', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(194, 'Torres', 'Daniel', 'G.', 'Male', '2010-01-10', 1, 7, 1, '09876543210', 'person194@example.com', NULL, 'No', 'No', 'Yes', 'School 1', 'No', 3, 'Yes', 'No', 'No', 'No', 'No', 'No', NULL, 'Student', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(195, 'Flores', 'Joyce', 'H.', 'Female', '2002-04-04', 1, 8, 1, '09123456789', 'person195@example.com', NULL, 'No', 'No', 'Yes', 'School 3', 'No', 5, 'Yes', 'Yes', 'No', 'No', 'No', 'No', NULL, 'Student', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(196, 'Villanueva', 'Kevin', 'I.', 'Male', '1992-07-17', 2, 1, 3, '09234567890', 'person196@example.com', 26000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Private Company A', 'Office Worker', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(197, 'Castro', 'Nicole', 'J.', 'Female', '1983-02-22', 2, 2, 1, '09345678901', 'person197@example.com', 37000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Government Agency B', 'Construction Worker', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(198, 'Rivera', 'Paul', 'K.', 'Male', '1978-08-08', 2, 5, 1, '09456789012', 'person198@example.com', 30000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Local Business C', 'Teacher', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(199, 'De Leon', 'Olivia', 'L.', 'Female', '1963-05-13', 2, 7, 3, '09567890123', 'person199@example.com', 19000.00, 'No', 'No', 'No', NULL, 'No', 6, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Self-Employed', 'Vendor', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(200, 'Mendoza', 'Christian', 'M.', 'Male', '2007-09-01', 1, 8, 1, '09678901234', 'person200@example.com', NULL, 'No', 'No', 'Yes', 'School 4', 'No', 3, 'Yes', 'No', 'No', 'No', 'No', 'No', NULL, 'Student', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(201, 'Sy', 'Grace', 'N.', 'Female', '1997-11-11', 1, 1, 1, '09789012345', 'person201@example.com', 24000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Private Company A', 'Office Worker', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(202, 'Tan', 'Mark', 'O.', 'Male', '1981-06-06', 2, 2, 3, '09876543210', 'person202@example.com', 33000.00, 'No', 'No', 'No', NULL, 'No', 9, 'Yes', 'Yes', 'No', 'Yes', 'Yes', 'Yes', 'Government Agency B', 'Teacher', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(203, 'Chua', 'Sarah', 'P.', 'Female', '1976-03-03', 2, 5, 1, '09123456789', 'person203@example.com', 31000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Local Business C', 'Engineer', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(204, 'Go', 'Daniel', 'Q.', 'Male', '1961-10-20', 2, 7, 1, '09234567890', 'person204@example.com', 23000.00, 'No', 'No', 'No', NULL, 'No', 6, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Self-Employed', 'Farmer', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(205, 'Uy', 'Joyce', 'R.', 'Female', '2013-02-14', 1, 8, 3, '09345678901', 'person205@example.com', NULL, 'No', 'No', 'Yes', 'School 2', 'No', 2, 'Yes', 'No', 'No', 'No', 'No', 'No', NULL, 'Student', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(206, 'Cheng', 'Kevin', 'S.', 'Male', '2009-08-05', 1, 1, 1, '09456789012', 'person206@example.com', NULL, 'No', 'No', 'Yes', 'School 5', 'No', 3, 'Yes', 'No', 'No', 'No', 'No', 'No', NULL, 'Student', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(207, 'Ong', 'Nicole', 'T.', 'Female', '1994-01-25', 1, 2, 1, '09567890123', 'person207@example.com', 28000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Private Company A', 'Office Worker', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(208, 'Yap', 'Paul', 'U.', 'Male', '1987-04-18', 2, 5, 3, '09678901234', 'person208@example.com', 36000.00, 'No', 'No', 'No', NULL, 'No', 9, 'Yes', 'Yes', 'No', 'Yes', 'Yes', 'Yes', 'Government Agency B', 'Teacher', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(209, 'Yu', 'Olivia', 'V.', 'Female', '1971-07-03', 2, 7, 1, '09789012345', 'person209@example.com', 25000.00, 'No', 'No', 'No', NULL, 'No', 6, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Self-Employed', 'Construction Worker', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(210, 'Soriano', 'Christian', 'W.', 'Male', '2016-11-08', 1, 8, 1, '09876543210', 'person210@example.com', NULL, 'No', 'No', 'Yes', 'School 1', 'No', 2, 'Yes', 'No', 'No', 'No', 'No', 'No', NULL, 'Student', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(211, 'Dela Cruz', 'Grace', 'X.', 'Female', '2004-03-28', 1, 1, 1, '09123456789', 'person211@example.com', NULL, 'No', 'No', 'Yes', 'School 3', 'No', 4, 'Yes', 'Yes', 'No', 'No', 'No', 'No', NULL, 'Student', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(212, 'Reyes', 'Mark', 'Y.', 'Male', '1999-09-19', 1, 2, 3, '09234567890', 'person212@example.com', 27000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Private Company A', 'Nurse', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(213, 'Santos', 'Sarah', 'Z.', 'Female', '1982-06-02', 2, 5, 1, '09345678901', 'person213@example.com', 34000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Government Agency B', 'Engineer', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(214, 'Bautista', 'Daniel', 'A.', 'Male', '1977-12-12', 2, 7, 1, '09456789012', 'person214@example.com', 28000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Local Business C', 'Teacher', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(215, 'Garcia', 'Joyce', 'B.', 'Female', '1962-08-23', 2, 8, 3, '09567890123', 'person215@example.com', 20000.00, 'No', 'No', 'No', NULL, 'No', 6, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Self-Employed', 'Farmer', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(216, 'Lim', 'Kevin', 'C.', 'Male', '2011-05-15', 1, 1, 1, '09678901234', 'person216@example.com', NULL, 'No', 'No', 'Yes', 'School 4', 'No', 3, 'Yes', 'No', 'No', 'No', 'No', 'No', NULL, 'Student', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(217, 'Cruz', 'Nicole', 'D.', 'Female', '2001-01-01', 1, 2, 1, '09789012345', 'person217@example.com', 15000.00, 'No', 'No', 'No', NULL, 'No', 5, 'Yes', 'Yes', 'No', 'No', 'No', 'No', 'Private Company A', 'Vendor', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(218, 'Gonzales', 'Paul', 'E.', 'Male', '1993-04-04', 2, 5, 3, '09876543210', 'person218@example.com', 29000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Government Agency B', 'Office Worker', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(219, 'Lopez', 'Olivia', 'F.', 'Female', '1984-07-07', 2, 7, 1, '09123456789', 'person219@example.com', 38000.00, 'No', 'No', 'No', NULL, 'No', 9, 'Yes', 'Yes', 'No', 'Yes', 'Yes', 'Yes', 'Local Business C', 'Engineer', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(220, 'Perez', 'Christian', 'G.', 'Male', '1969-02-19', 2, 8, 1, '09234567890', 'person220@example.com', 26000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Self-Employed', 'Nurse', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(221, 'Aquino', 'Grace', 'H.', 'Female', '2014-09-29', 1, 1, 1, '09345678901', 'person221@example.com', NULL, 'No', 'No', 'Yes', 'School 5', 'No', 2, 'Yes', 'No', 'No', 'No', 'No', 'No', NULL, 'Student', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(222, 'Ramos', 'Mark', 'I.', 'Male', '2006-12-03', 1, 2, 3, '09456789012', 'person222@example.com', NULL, 'No', 'No', 'Yes', 'School 2', 'No', 3, 'Yes', 'No', 'No', 'No', 'No', 'No', NULL, 'Student', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(223, 'Diaz', 'Sarah', 'J.', 'Female', '1996-05-08', 1, 5, 1, '09567890123', 'person223@example.com', 25000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Private Company A', 'Office Worker', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(224, 'Torres', 'Daniel', 'K.', 'Male', '1989-01-11', 2, 7, 1, '09678901234', 'person224@example.com', 35000.00, 'No', 'No', 'No', NULL, 'No', 9, 'Yes', 'Yes', 'No', 'Yes', 'Yes', 'Yes', 'Government Agency B', 'Teacher', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(225, 'Flores', 'Joyce', 'L.', 'Female', '1974-03-27', 2, 8, 3, '09789012345', 'person225@example.com', 28000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Local Business C', 'Construction Worker', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(226, 'Villanueva', 'Kevin', 'M.', 'Male', '2012-10-06', 1, 1, 1, '09876543210', 'person226@example.com', NULL, 'No', 'No', 'Yes', 'School 3', 'No', 2, 'Yes', 'No', 'No', 'No', 'No', 'No', NULL, 'Student', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(227, 'Castro', 'Nicole', 'N.', 'Female', '2003-07-21', 1, 2, 1, '09123456789', 'person227@example.com', NULL, 'No', 'No', 'Yes', 'School 4', 'No', 4, 'Yes', 'Yes', 'No', 'No', 'No', 'No', NULL, 'Student', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(228, 'Rivera', 'Paul', 'O.', 'Male', '1991-09-02', 2, 5, 3, '09234567890', 'person228@example.com', 27000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Private Company A', 'Teacher', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(229, 'De Leon', 'Olivia', 'P.', 'Female', '1986-12-16', 2, 7, 1, '09345678901', 'person229@example.com', 33000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Government Agency B', 'Engineer', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(230, 'Mendoza', 'Christian', 'Q.', 'Male', '1979-05-25', 2, 8, 1, '09456789012', 'person230@example.com', 29000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Local Business C', 'Nurse', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(231, 'Sy', 'Grace', 'R.', 'Female', '1964-08-18', 2, 1, 3, '09567890123', 'person231@example.com', 21000.00, 'No', 'No', 'No', NULL, 'No', 6, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Self-Employed', 'Vendor', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(232, 'Tan', 'Mark', 'S.', 'Male', '2008-01-07', 1, 2, 1, '09678901234', 'person232@example.com', NULL, 'No', 'No', 'Yes', 'School 1', 'No', 3, 'Yes', 'No', 'No', 'No', 'No', 'No', NULL, 'Student', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(233, 'Chua', 'Sarah', 'T.', 'Female', '2000-04-14', 1, 5, 1, '09789012345', 'person233@example.com', 17000.00, 'No', 'No', 'No', NULL, 'No', 5, 'Yes', 'Yes', 'No', 'No', 'No', 'No', 'Private Company A', 'Office Worker', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(234, 'Go', 'Daniel', 'U.', 'Male', '1990-07-28', 2, 7, 3, '09876543210', 'person234@example.com', 30000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Government Agency B', 'Teacher', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(235, 'Uy', 'Joyce', 'V.', 'Female', '1983-09-05', 2, 8, 1, '09123456789', 'person235@example.com', 39000.00, 'No', 'No', 'No', NULL, 'No', 9, 'Yes', 'Yes', 'No', 'Yes', 'Yes', 'Yes', 'Local Business C', 'Engineer', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(236, 'Cheng', 'Kevin', 'W.', 'Male', '1968-01-30', 2, 1, 1, '09234567890', 'person236@example.com', 27000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Self-Employed', 'Nurse', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(237, 'Ong', 'Nicole', 'X.', 'Female', '2017-04-22', 1, 2, 1, '09345678901', 'person237@example.com', NULL, 'No', 'No', 'Yes', 'School 5', 'No', 2, 'Yes', 'No', 'No', 'No', 'No', 'No', NULL, 'Student', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(238, 'Yap', 'Paul', 'Y.', 'Male', '2005-06-15', 1, 5, 3, '09456789012', 'person238@example.com', NULL, 'No', 'No', 'Yes', 'School 2', 'No', 4, 'Yes', 'Yes', 'No', 'No', 'No', 'No', NULL, 'Student', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(239, 'Yu', 'Olivia', 'Z.', 'Female', '1998-09-20', 2, 7, 1, '09567890123', 'person239@example.com', 25000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Private Company A', 'Teacher', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(240, 'Soriano', 'Christian', 'A.', 'Male', '1985-03-10', 2, 8, 1, '09678901234', 'person240@example.com', 35000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Government Agency B', 'Engineer', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(241, 'Dela Cruz', 'Grace', 'B.', 'Female', '1970-11-25', 2, 1, 3, '09789012345', 'person241@example.com', 28000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Local Business C', 'Nurse', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(242, 'Reyes', 'Mark', 'C.', 'Male', '1960-01-01', 3, 2, 1, '09876543210', 'person242@example.com', 15000.00, 'No', 'No', 'No', NULL, 'No', 5, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', NULL, 'Retired', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(243, 'Santos', 'Sarah', 'D.', 'Female', '1955-07-07', 3, 5, 1, '09123456789', 'person243@example.com', 18000.00, 'No', 'No', 'No', NULL, 'No', 5, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', NULL, 'Retired', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(244, 'Bautista', 'Daniel', 'E.', 'Male', '1990-04-12', 2, 7, 3, '09234567890', 'person244@example.com', 22000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Self-Employed', 'Vendor', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(245, 'Garcia', 'Joyce', 'F.', 'Female', '2000-02-29', 1, 8, 1, '09345678901', 'person245@example.com', 18000.00, 'No', 'No', 'No', NULL, 'No', 7, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Private Company A', 'Office Worker', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(246, 'Lim', 'Kevin', 'G.', 'Male', '1980-08-01', 2, 1, 1, '09456789012', 'person246@example.com', 40000.00, 'No', 'No', 'No', NULL, 'No', 9, 'Yes', 'Yes', 'No', 'Yes', 'Yes', 'Yes', 'Government Agency B', 'Engineer', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(247, 'Cruz', 'Nicole', 'H.', 'Female', '1975-05-05', 2, 2, 3, '09567890123', 'person247@example.com', 32000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Local Business C', 'Teacher', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(248, 'Gonzales', 'Paul', 'I.', 'Male', '1965-10-10', 2, 5, 1, '09678901234', 'person248@example.com', 20000.00, 'No', 'No', 'No', NULL, 'No', 6, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Self-Employed', 'Farmer', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(249, 'Lopez', 'Olivia', 'J.', 'Female', '1995-12-15', 1, 7, 1, '09789012345', 'person249@example.com', 27000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Private Company A', 'Office Worker', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(250, 'Perez', 'Christian', 'K.', 'Male', '1988-06-20', 2, 8, 3, '09876543210', 'person250@example.com', 38000.00, 'No', 'No', 'No', NULL, 'No', 8, 'Yes', 'Yes', 'No', 'Yes', 'No', 'Yes', 'Government Agency B', 'Engineer', 'No', '2025-07-04 21:25:00', '2025-07-04 21:25:00');

-- --------------------------------------------------------

--
-- Table structure for table `religion_lookup`
--

CREATE TABLE `religion_lookup` (
  `id` int(11) NOT NULL,
  `religion_name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `religion_lookup`
--

INSERT INTO `religion_lookup` (`id`, `religion_name`) VALUES
(9, 'Agnostic'),
(10, 'Atheist'),
(6, 'Born Again Christian'),
(7, 'Buddhist'),
(8, 'Hindu'),
(4, 'Iglesia ni Cristo'),
(2, 'Islam'),
(5, 'Jehovahs Witness'),
(11, 'Other'),
(3, 'Protestant'),
(1, 'Roman Catholic');

-- --------------------------------------------------------

--
-- Table structure for table `tenure_status_lookup`
--

CREATE TABLE `tenure_status_lookup` (
  `id` int(11) NOT NULL,
  `tenure_status_name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tenure_status_lookup`
--

INSERT INTO `tenure_status_lookup` (`id`, `tenure_status_name`) VALUES
(5, 'Informal Settler'),
(4, 'Living with Relatives'),
(6, 'Other'),
(1, 'Owned'),
(3, 'Rent-Free'),
(2, 'Rented');

-- --------------------------------------------------------

--
-- Table structure for table `water_source_lookup`
--

CREATE TABLE `water_source_lookup` (
  `id` int(11) NOT NULL,
  `water_source_name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `water_source_lookup`
--

INSERT INTO `water_source_lookup` (`id`, `water_source_name`) VALUES
(5, 'Bottled Water'),
(2, 'Deep Well'),
(7, 'Other'),
(1, 'Piped Water'),
(6, 'Rainwater'),
(3, 'Shallow Well'),
(4, 'Spring');

-- --------------------------------------------------------

--
-- Table structure for table `zone`
--

CREATE TABLE `zone` (
  `zone_id` int(11) NOT NULL,
  `zone_name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `barangay_official_assigned_individual_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `zone`
--

INSERT INTO `zone` (`zone_id`, `zone_name`, `description`, `barangay_official_assigned_individual_id`, `created_at`, `updated_at`) VALUES
(1, 'Zone A', 'Description for Zone A', 14, '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(2, 'Zone B', 'Description for Zone B', 12, '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(3, 'Zone C', 'Description for Zone C', 10, '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(4, 'Zone D', 'Description for Zone D', 11, '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(5, 'Zone E', 'Description for Zone E', 13, '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(6, 'Zone F', 'Description for Zone F', 15, '2025-07-04 21:25:00', '2025-07-04 21:25:00'),
(7, 'Zone G', 'Description for Zone G', 16, '2025-07-04 21:25:00', '2025-07-04 21:25:00');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `blood_type_lookup`
--
ALTER TABLE `blood_type_lookup`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `blood_type_name` (`blood_type_name`);

--
-- Indexes for table `civil_status_lookup`
--
ALTER TABLE `civil_status_lookup`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `status_name` (`status_name`);

--
-- Indexes for table `cooking_fuel_lookup`
--
ALTER TABLE `cooking_fuel_lookup`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `cooking_fuel_name` (`cooking_fuel_name`);

--
-- Indexes for table `educational_attainment_lookup`
--
ALTER TABLE `educational_attainment_lookup`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `attainment_name` (`attainment_name`);

--
-- Indexes for table `family`
--
ALTER TABLE `family`
  ADD PRIMARY KEY (`family_id`);

--
-- Indexes for table `family_household`
--
ALTER TABLE `family_household`
  ADD PRIMARY KEY (`family_id`,`household_id`),
  ADD KEY `household_id` (`household_id`);

--
-- Indexes for table `household`
--
ALTER TABLE `household`
  ADD PRIMARY KEY (`household_id`),
  ADD KEY `zone_id` (`zone_id`),
  ADD KEY `household_head_individual_id` (`household_head_individual_id`),
  ADD KEY `what_water_source_id` (`what_water_source_id`),
  ADD KEY `main_source_of_cooking_fuel_id` (`main_source_of_cooking_fuel_id`),
  ADD KEY `tenure_status_id` (`tenure_status_id`),
  ADD KEY `household_source_of_income_id` (`household_source_of_income_id`),
  ADD KEY `type_of_household_id` (`type_of_household_id`),
  ADD KEY `type_of_house_material_id` (`type_of_house_material_id`),
  ADD KEY `idx_address` (`address`),
  ADD KEY `idx_monthly_household_income` (`monthly_household_income`);

--
-- Indexes for table `household_member`
--
ALTER TABLE `household_member`
  ADD PRIMARY KEY (`household_id`,`individual_id`),
  ADD KEY `individual_id` (`individual_id`);

--
-- Indexes for table `household_type_lookup`
--
ALTER TABLE `household_type_lookup`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `household_type_name` (`household_type_name`);

--
-- Indexes for table `house_material_lookup`
--
ALTER TABLE `house_material_lookup`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `house_material_name` (`house_material_name`);

--
-- Indexes for table `income_source_lookup`
--
ALTER TABLE `income_source_lookup`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `income_source_name` (`income_source_name`);

--
-- Indexes for table `individual`
--
ALTER TABLE `individual`
  ADD PRIMARY KEY (`individual_id`),
  ADD KEY `civil_status_id` (`civil_status_id`),
  ADD KEY `blood_type_id` (`blood_type_id`),
  ADD KEY `religion_id` (`religion_id`),
  ADD KEY `educational_attainment_id` (`educational_attainment_id`),
  ADD KEY `idx_surname_firstname` (`surname`,`first_name`),
  ADD KEY `idx_birth_date` (`birth_date`),
  ADD KEY `idx_contact_number` (`contact_number`),
  ADD KEY `idx_email` (`email`);

--
-- Indexes for table `religion_lookup`
--
ALTER TABLE `religion_lookup`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `religion_name` (`religion_name`);

--
-- Indexes for table `tenure_status_lookup`
--
ALTER TABLE `tenure_status_lookup`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `tenure_status_name` (`tenure_status_name`);

--
-- Indexes for table `water_source_lookup`
--
ALTER TABLE `water_source_lookup`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `water_source_name` (`water_source_name`);

--
-- Indexes for table `zone`
--
ALTER TABLE `zone`
  ADD PRIMARY KEY (`zone_id`),
  ADD UNIQUE KEY `zone_name` (`zone_name`),
  ADD KEY `fk_barangay_official` (`barangay_official_assigned_individual_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `blood_type_lookup`
--
ALTER TABLE `blood_type_lookup`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `civil_status_lookup`
--
ALTER TABLE `civil_status_lookup`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `cooking_fuel_lookup`
--
ALTER TABLE `cooking_fuel_lookup`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `educational_attainment_lookup`
--
ALTER TABLE `educational_attainment_lookup`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `family`
--
ALTER TABLE `family`
  MODIFY `family_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `household`
--
ALTER TABLE `household`
  MODIFY `household_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56;

--
-- AUTO_INCREMENT for table `household_type_lookup`
--
ALTER TABLE `household_type_lookup`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `house_material_lookup`
--
ALTER TABLE `house_material_lookup`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `income_source_lookup`
--
ALTER TABLE `income_source_lookup`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `individual`
--
ALTER TABLE `individual`
  MODIFY `individual_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=251;

--
-- AUTO_INCREMENT for table `religion_lookup`
--
ALTER TABLE `religion_lookup`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `tenure_status_lookup`
--
ALTER TABLE `tenure_status_lookup`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `water_source_lookup`
--
ALTER TABLE `water_source_lookup`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `zone`
--
ALTER TABLE `zone`
  MODIFY `zone_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `family_household`
--
ALTER TABLE `family_household`
  ADD CONSTRAINT `family_household_ibfk_1` FOREIGN KEY (`family_id`) REFERENCES `family` (`family_id`),
  ADD CONSTRAINT `family_household_ibfk_2` FOREIGN KEY (`household_id`) REFERENCES `household` (`household_id`);

--
-- Constraints for table `household`
--
ALTER TABLE `household`
  ADD CONSTRAINT `household_ibfk_1` FOREIGN KEY (`zone_id`) REFERENCES `zone` (`zone_id`),
  ADD CONSTRAINT `household_ibfk_2` FOREIGN KEY (`household_head_individual_id`) REFERENCES `individual` (`individual_id`),
  ADD CONSTRAINT `household_ibfk_3` FOREIGN KEY (`what_water_source_id`) REFERENCES `water_source_lookup` (`id`),
  ADD CONSTRAINT `household_ibfk_4` FOREIGN KEY (`main_source_of_cooking_fuel_id`) REFERENCES `cooking_fuel_lookup` (`id`),
  ADD CONSTRAINT `household_ibfk_5` FOREIGN KEY (`tenure_status_id`) REFERENCES `tenure_status_lookup` (`id`),
  ADD CONSTRAINT `household_ibfk_6` FOREIGN KEY (`household_source_of_income_id`) REFERENCES `income_source_lookup` (`id`),
  ADD CONSTRAINT `household_ibfk_7` FOREIGN KEY (`type_of_household_id`) REFERENCES `household_type_lookup` (`id`),
  ADD CONSTRAINT `household_ibfk_8` FOREIGN KEY (`type_of_house_material_id`) REFERENCES `house_material_lookup` (`id`);

--
-- Constraints for table `household_member`
--
ALTER TABLE `household_member`
  ADD CONSTRAINT `household_member_ibfk_1` FOREIGN KEY (`household_id`) REFERENCES `household` (`household_id`),
  ADD CONSTRAINT `household_member_ibfk_2` FOREIGN KEY (`individual_id`) REFERENCES `individual` (`individual_id`);

--
-- Constraints for table `individual`
--
ALTER TABLE `individual`
  ADD CONSTRAINT `individual_ibfk_1` FOREIGN KEY (`civil_status_id`) REFERENCES `civil_status_lookup` (`id`),
  ADD CONSTRAINT `individual_ibfk_2` FOREIGN KEY (`blood_type_id`) REFERENCES `blood_type_lookup` (`id`),
  ADD CONSTRAINT `individual_ibfk_3` FOREIGN KEY (`religion_id`) REFERENCES `religion_lookup` (`id`),
  ADD CONSTRAINT `individual_ibfk_4` FOREIGN KEY (`educational_attainment_id`) REFERENCES `educational_attainment_lookup` (`id`);

--
-- Constraints for table `zone`
--
ALTER TABLE `zone`
  ADD CONSTRAINT `fk_barangay_official` FOREIGN KEY (`barangay_official_assigned_individual_id`) REFERENCES `individual` (`individual_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;












-- Create logininfo table
CREATE TABLE logininfo (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL, -- IMPORTANT: In a real application, always store hashed passwords using PHP's password_hash()
    role ENUM('admin','user') NOT NULL DEFAULT 'user'
);

-- Insert admin and user (Passphrases provided here are plain text for demonstration purposes only)
INSERT INTO logininfo (username, password, role) VALUES
('olagadmin', 'AdminOlag', 'admin'),
('olaguser', 'user123', 'user');