-- SQL Script to Create the Barangay Database Schema and Populate with Data
-- This script creates the database and all tables with their
-- respective columns, primary keys, unique keys, and foreign key constraints.
-- Initial default data is inserted into lookup tables.
-- Provided random data is inserted into main data tables.
-- All AUTO_INCREMENT values are reset to the next available ID after insertion.

-- !! IMPORTANT: BACK UP YOUR DATABASE BEFORE EXECUTING THESE COMMANDS !!
-- This script will DROP the 'barangay_dbs' if it exists, deleting all its data.

-- Disable foreign key checks to allow dropping and creating tables without issues
SET FOREIGN_KEY_CHECKS = 0;

-- Drop the database if it already exists to ensure a clean import
DROP DATABASE IF EXISTS `barangay_dbs`;

-- Set SQL mode and transaction settings
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Create Database: `barangay_dbs`
--
CREATE DATABASE IF NOT EXISTS `barangay_dbs` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `barangay_dbs`;

-- --------------------------------------------------------

--
-- Table structure for table `blood_type_lookup`
--
CREATE TABLE `blood_type_lookup` (
  `id` int(11) NOT NULL,
  `blood_type_name` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping default data for table `blood_type_lookup`
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
-- Dumping default data for table `civil_status_lookup`
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
-- Dumping default data for table `cooking_fuel_lookup`
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
-- Dumping default data for table `educational_attainment_lookup`
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

-- --------------------------------------------------------

--
-- Table structure for table `family_household`
--
CREATE TABLE `family_household` (
  `family_id` int(11) NOT NULL,
  `household_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
  `has_toilet` tinyint(1) DEFAULT 0,
  `has_electricity` tinyint(1) DEFAULT 0,
  `main_source_of_cooking_fuel_id` int(11) DEFAULT NULL,
  `tenure_status_id` int(11) DEFAULT NULL,
  `household_source_of_income_id` int(11) DEFAULT NULL,
  `monthly_household_income` decimal(10,2) DEFAULT NULL,
  `type_of_household_id` int(11) DEFAULT NULL,
  `type_of_house_material_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `monthly_income` decimal(10,2) DEFAULT NULL,
  `has_water` tinyint(1) DEFAULT 0,
  `has_internet` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `household_member`
--
CREATE TABLE `household_member` (
  `household_id` int(11) NOT NULL,
  `individual_id` int(11) NOT NULL,
  `relationship_to_head` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `household_type_lookup`
--
CREATE TABLE `household_type_lookup` (
  `id` int(11) NOT NULL,
  `household_type_name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping default data for table `household_type_lookup`
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
-- Dumping default data for table `house_material_lookup`
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
-- Dumping default data for table `income_source_lookup`
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
  `gender` char(1) NOT NULL,
  `birth_date` date NOT NULL,
  `civil_status_id` int(11) NOT NULL,
  `blood_type_id` int(11) DEFAULT NULL,
  `religion_id` int(11) DEFAULT NULL,
  `contact_number` varchar(20) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `salary_income` decimal(10,2) DEFAULT NULL,
  `is_solo_parent` tinyint(1) DEFAULT 0,
  `has_disability` tinyint(1) DEFAULT 0,
  `is_student` tinyint(1) DEFAULT 0,
  `school_attending` varchar(255) DEFAULT NULL,
  `is_scholar` tinyint(1) DEFAULT 0,
  `educational_attainment_id` int(11) DEFAULT NULL,
  `is_alive` tinyint(1) DEFAULT 1,
  `is_registered_voter` tinyint(1) DEFAULT 0,
  `is_ofw` tinyint(1) DEFAULT 0,
  `is_sss_member` tinyint(1) DEFAULT 0,
  `is_gsis_member` tinyint(1) DEFAULT 0,
  `is_philhealth_member` tinyint(1) DEFAULT 0,
  `working_for` varchar(255) DEFAULT NULL,
  `occupation` varchar(255) DEFAULT NULL,
  `is_4ps_beneficiary` tinyint(1) DEFAULT 0,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `religion_lookup`
--
CREATE TABLE `religion_lookup` (
  `id` int(11) NOT NULL,
  `religion_name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping default data for table `religion_lookup`
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
-- Dumping default data for table `tenure_status_lookup`
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
-- Dumping default data for table `water_source_lookup`
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
  ADD KEY `type_of_house_material_id` (`type_of_house_material_id`);

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
  ADD KEY `educational_attainment_id` (`educational_attainment_id`);

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
  MODIFY `family_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `household`
--
ALTER TABLE `household`
  MODIFY `household_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

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
  MODIFY `individual_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=101;

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
  MODIFY `zone_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

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

--
-- Dumping data for table `zone`
--
INSERT INTO `zone` (`zone_id`, `zone_name`, `description`, `barangay_official_assigned_individual_id`, `created_at`, `updated_at`) VALUES
(1, 'Zone Mabini', 'Main residential area of the barangay', NULL, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 'Zone Bonifacio', 'Commercial and residential mix', NULL, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(3, 'Zone Rizal', 'Near the barangay hall and school', NULL, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(4, 'Zone Del Pilar', 'Along the river bank', NULL, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(5, 'Zone Luna', 'Predominantly agricultural', NULL, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(6, 'Zone Jacinto', 'New developing area', NULL, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(7, 'Zone Aguinaldo', 'Hilly residential area', NULL, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(8, 'Zone Lapu-Lapu', 'Fisherman\'s community', NULL, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(9, 'Zone Katipunan', 'Dense residential block', NULL, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(10, 'Zone Silang', 'Mixed-use, older structures', NULL, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

--
-- Dumping data for table `individual`
--
INSERT INTO `individual` (
  `individual_id`,
  `surname`,
  `first_name`,
  `middle_name`,
  `gender`,
  `birth_date`,
  `civil_status_id`,
  `blood_type_id`,
  `religion_id`,
  `contact_number`,
  `email`,
  `salary_income`,
  `is_solo_parent`,
  `has_disability`,
  `is_student`,
  `school_attending`,
  `is_scholar`,
  `educational_attainment_id`,
  `is_alive`,
  `is_registered_voter`,
  `is_ofw`,
  `is_sss_member`,
  `is_gsis_member`,
  `is_philhealth_member`,
  `working_for`,
  `occupation`,
  `is_4ps_beneficiary`,
  `created_at`,
  `updated_at`
) VALUES
(
  1, 'Reyes', 'Juan', 'Dela Cruz', 'M', '1975-03-15', 2, 7, 1, '09171234567', 'juan.reyes@email.com', 25000.00, 0, 0, 0, NULL, 0, 8, 1, 1, 0, 1, 0, 1, 'Local Govt', 'Clerk', 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
),
(
  2, 'Santos', 'Maria', 'Garcia', 'F', '1980-08-22', 2, 1, 1, '09202345678', 'maria.santos@email.com', 18000.00, 0, 0, 0, NULL, 0, 8, 1, 1, 0, 1, 0, 1, 'Private Co.', 'Teacher', 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
),
(
  3, 'Dela Cruz', 'Pedro', 'Lim', 'M', '1960-01-10', 2, 3, 1, '09303456789', 'pedro.delacruz@email.com', 20000.00, 0, 0, 0, NULL, 0, 5, 1, 1, 0, 1, 0, 1, 'Self-employed', 'Farmer', 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
),
(
  4, 'Lim', 'Sarah', 'Tan', 'F', '1995-11-05', 1, 5, 1, '09454567890', 'sarah.lim@email.com', 0.00, 0, 0, 1, 'University of Manila', 0, 7, 1, 0, 0, 0, 0, NULL, 'Student', 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
),
(
  5, 'Garcia', 'Miguel', 'Lopez', 'M', '1970-04-30', 2, 7, 2, '09606789012', 'miguel.garcia@email.com', 30000.00, 0, 0, 0, NULL, 0, 9, 1, 1, 0, 1, 0, 1, 'Hospital', 'Doctor', 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
),
(
  6, 'Cruz', 'Elena', 'Gonzales', 'F', '1985-09-12', 2, 2, 1, '09707890123', 'elena.cruz@email.com', 22000.00, 0, 0, 0, NULL, 0, 8, 1, 1, 0, 1, 0, 1, 'Bank', 'Accountant', 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
),
(
  7, 'Ramos', 'Daniel', 'Reyes', 'M', '1990-02-28', 1, 8, 1, '09808901234', 'daniel.ramos@email.com', 15000.00, 0, 0, 0, NULL, 0, 6, 1, 1, 0, 1, 0, 1, 'Construction', 'Skilled Worker', 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
),
(
  8, 'Aquino', 'Anna', 'Mercado', 'F', '1965-06-18', 3, 4, 1, '09909012345', 'anna.aquino@email.com', 0.00, 1, 0, 0, NULL, 0, 5, 1, 1, 0, 0, 0, 1, NULL, 'Homemaker', 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
),
(
  9, 'Gonzales', 'Christian', 'Dizon', 'M', '1998-10-01', 1, 1, 1, '09051234567', 'christian.gonzales@email.com', 0.00, 0, 0, 1, 'Local High School', 1, 4, 1, 0, 0, 0, 0, NULL, 'Student', 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
),
(
  10, 'Castro', 'Sofia', 'Hernandez', 'F', '1972-07-07', 2, 6, 1, '09102345678', 'sofia.castro@email.com', 28000.00, 0, 0, 0, NULL, 0, 8, 1, 1, 0, 1, 0, 1, 'Retail', 'Store Manager', 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
),
(
  11, 'Rodriguez', 'Mark', 'Perez', 'M', '1988-03-20', 1, 7, 1, '09203456789', 'mark.rodriguez@email.com', 16000.00, 0, 0, 0, NULL, 0, 6, 1, 1, 0, 1, 0, 1, 'Manufacturing', 'Factory Worker', 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
),
(
  12, 'Tan', 'Jessica', 'Yap', 'F', '1992-05-25', 1, 8, 1, '09304567890', 'jessica.tan@email.com', 0.00, 0, 0, 1, 'College of Business', 0, 7, 1, 0, 0, 0, 0, NULL, 'Student', 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
),
(
  13, 'Perez', 'David', 'Cruz', 'M', '1968-11-11', 2, 3, 2, '09455678901', 'david.perez@email.com', 27000.00, 0, 0, 0, NULL, 0, 8, 1, 1, 0, 1, 0, 1, 'Fishing Industry', 'Fisherman', 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
),
(
  14, 'Hernandez', 'Camille', 'Santos', 'F', '1978-01-19', 2, 5, 1, '09606789012', 'camille.hernandez@email.com', 20000.00, 0, 0, 0, NULL, 0, 8, 1, 1, 0, 1, 0, 1, 'Private Co.', 'Office Assistant', 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
),
(
  15, 'Flores', 'Robert', 'Delgado', 'M', '1999-07-03', 1, 7, 1, '09707890123', 'robert.flores@email.com', 0.00, 0, 0, 1, 'Local College', 0, 7, 1, 0, 0, 0, 0, NULL, 'Student', 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
),
(
  16, 'De Guzman', 'Kimberly', 'Reyes', 'F', '1993-04-14', 1, 1, 1, '09808901234', 'kimberly.deguzman@email.com', 17000.00, 0, 0, 0, NULL, 0, 8, 1, 1, 0, 1, 0, 1, 'Restaurant', 'Service Crew', 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
),
(
  17, 'Rivera', 'Jose', 'Mariano', 'M', '1962-09-08', 2, 7, 1, '09909012345', 'jose.rivera@email.com', 23000.00, 0, 0, 0, NULL, 0, 8, 1, 1, 0, 1, 0, 1, 'Transportation', 'Jeepney Driver', 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
),
(
  18, 'Soriano', 'Christine', 'Cruz', 'F', '1982-12-01', 2, 3, 1, '09051234567', 'christine.soriano@email.com', 21000.00, 0, 0, 0, NULL, 0, 8, 1, 1, 0, 1, 0, 1, 'Public Market', 'Vendor', 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
),
(
  19, 'Santiago', 'Patrick', 'Gonzales', 'M', '1997-06-20', 1, 5, 1, '09102345678', 'patrick.santiago@email.com', 0.00, 0, 0, 1, 'Vocational School', 0, 6, 1, 0, 0, 0, 0, NULL, 'Student', 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
),
(
  20, 'Gomez', 'Nicole', 'Aquino', 'F', '1976-02-14', 2, 7, 1, '09203456789', 'nicole.gomez@email.com', 26000.00, 0, 0, 0, NULL, 0, 8, 1, 1, 0, 1, 0, 1, 'Real Estate', 'Agent', 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
),
(
  21, 'Ramos', 'Carlo', 'Garcia', 'M', '1985-04-03', 2, 7, 1, '09171112222', 'carlo.ramos@email.com', 24000.00, 0, 0, 0, NULL, 0, 8, 1, 1, 0, 1, 0, 1, 'Construction', 'Foreman', 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
),
(
  22, 'Lim', 'Angela', 'Diaz', 'F', '1990-09-10', 1, 1, 1, '09202223333', 'angela.lim@email.com', 0.00, 0, 0, 1, 'State University', 0, 7, 1, 0, 0, 0, 0, NULL, 'Student', 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
),
(
  23, 'Villanueva', 'Arturo', 'Reyes', 'M', '1965-12-01', 2, 3, 1, '09303334444', 'arturo.villanueva@email.com', 19000.00, 0, 0, 0, NULL, 0, 5, 1, 1, 0, 1, 0, 1, 'Agriculture', 'Farm Laborer', 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
),
(
  24, 'Yap', 'Grace', 'Martinez', 'F', '1978-06-07', 2, 5, 1, '09454445555', 'grace.yap@email.com', 21000.00, 0, 0, 0, NULL, 0, 8, 1, 1, 0, 1, 0, 1, 'Local Government', 'Social Worker', 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
),
(
  25, 'Marcelo', 'Joshua', 'Gomez', 'M', '1994-02-18', 1, 7, 1, '09606667777', 'joshua.marcelo@email.com', 0.00, 0, 0, 1, 'Private College', 0, 7, 1, 0, 0, 0, 0, NULL, 'Student', 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
),
(
  26, 'Palma', 'Sophia', 'Castro', 'F', '1989-11-23', 1, 2, 1, '09707778888', 'sophia.palma@email.com', 16000.00, 0, 0, 0, NULL, 0, 6, 1, 1, 0, 1, 0, 1, 'Retail', 'Sales Associate', 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
),
(
  27, 'Francisco', 'Michael', 'Alvarez', 'M', '1969-08-05', 2, 8, 1, '09808889999', 'michael.francisco@email.com', 28000.00, 0, 0, 0, NULL, 0, 9, 1, 1, 0, 1, 0, 1, 'Engineering Firm', 'Engineer', 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
),
(
  28, 'Mendoza', 'Chloe', 'Gonzales', 'F', '1973-03-09', 2, 4, 1, '09909990000', 'chloe.mendoza@email.com', 0.00, 0, 0, 0, NULL, 0, 5, 1, 1, 0, 0, 0, 1, NULL, 'Homemaker', 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
),
(
  29, 'Panganiban', 'Gabriel', 'Santos', 'M', '1996-01-12', 1, 1, 1, '09051001111', 'gabriel.panganiban@email.com', 0.00, 0, 0, 1, 'Local University', 0, 7, 1, 0, 0, 0, 0, NULL, 'Student', 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
),
(
  30, 'Reyes', 'Isabella', 'Cruz', 'F', '1971-05-16', 2, 6, 1, '09102112222', 'isabella.reyes@email.com', 23000.00, 0, 0, 0, NULL, 0, 8, 1, 1, 0, 1, 0, 1, 'School', 'Principal', 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
),
(
  31, 'Dela Rosa', 'Sophia', 'De Leon', 'F', '1998-07-20', 1, 7, 1, '09173334444', 'sophia.delarosa@email.com', 0.00, 0, 0, 1, 'High School', 0, 4, 1, 0, 0, 0, 0, NULL, 'Student', 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
),
(
  32, 'Cruz', 'Antonio', 'Ramos', 'M', '1960-02-29', 2, 8, 1, '09204445555', 'antonio.cruz@email.com', 18000.00, 0, 0, 0, NULL, 0, 5, 1, 1, 0, 1, 0, 1, 'Self-employed', 'Carpenter', 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
),
(
  33, 'Sy', 'Chloe', 'Tan', 'F', '1993-09-01', 1, 1, 1, '09305556666', 'chloe.sy@email.com', 15000.00, 0, 0, 0, NULL, 0, 6, 1, 1, 0, 1, 0, 1, 'Bakery', 'Baker', 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
),
(
  34, 'Tan', 'Ethan', 'Lim', 'M', '1970-11-10', 2, 3, 1, '09456667777', 'ethan.tan@email.com', 30000.00, 0, 0, 0, NULL, 0, 9, 1, 1, 0, 1, 0, 1, 'IT Company', 'Software Engineer', 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
),
(
  35, 'Gonzales', 'Mia', 'Garcia', 'F', '1987-01-01', 2, 5, 1, '09607778888', 'mia.gonzales@email.com', 20000.00, 0, 0, 0, NULL, 0, 8, 1, 1, 0, 1, 0, 1, 'Clinic', 'Nurse', 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
),
(
  36, 'Aquino', 'Noah', 'Santos', 'M', '1995-04-22', 1, 7, 1, '09708889999', 'noah.aquino@email.com', 0.00, 0, 0, 1, 'College of Arts', 0, 7, 1, 0, 0, 0, 0, NULL, 'Student', 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
),
(
  37, 'Castillo', 'Lily', 'Hernandez', 'F', '1963-06-15', 3, 2, 1, '09809990000', 'lily.castillo@email.com', 0.00, 1, 0, 0, NULL, 0, 5, 1, 1, 0, 0, 0, 1, NULL, 'Homemaker', 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
),
(
  38, 'Delgado', 'Leo', 'Reyes', 'M', '1999-08-08', 1, 4, 1, '09051112222', 'leo.delgado@email.com', 0.00, 0, 0, 1, 'Public High School', 0, 4, 1, 0, 0, 0, 0, NULL, 'Student', 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
),
(
  39, 'Fabian', 'Zoe', 'Mercado', 'F', '1974-10-25', 2, 6, 1, '09102223333', 'zoe.fabian@email.com', 27000.00, 0, 0, 0, NULL, 0, 8, 1, 1, 0, 1, 0, 1, 'Government Agency', 'Analyst', 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
),
(
  40, 'Imperial', 'Nathan', 'Dizon', 'M', '1981-12-19', 2, 8, 1, '09203334444', 'nathan.imperial@email.com', 22000.00, 0, 0, 0, NULL, 0, 8, 1, 1, 0, 1, 0, 1, 'Construction', 'Supervisor', 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
),
(
  41, 'Alonzo', 'Chloe', 'Santos', 'F', '1997-03-05', 1, 7, 1, '09175556666', 'chloe.alonzo@email.com', 0.00, 0, 0, 1, 'Local College', 0, 7, 1, 0, 0, 0, 0, NULL, 'Student', 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
),
(
  42, 'Bernardo', 'Lucas', 'Ramos', 'M', '1967-05-12', 2, 1, 1, '09206667777', 'lucas.bernardo@email.com', 25000.00, 0, 0, 0, NULL, 0, 8, 1, 1, 0, 1, 0, 1, 'Bank', 'Loan Officer', 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
),
(
  43, 'Chua', 'Sophie', 'Lim', 'F', '1983-08-28', 2, 3, 1, '09307778888', 'sophie.chua@email.com', 19000.00, 0, 0, 0, NULL, 0, 6, 1, 1, 0, 1, 0, 1, 'Small Business', 'Store Owner', 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
),
(
  44, 'Domingo', 'Liam', 'Tan', 'M', '1991-10-09', 1, 5, 1, '09458889999', 'liam.domingo@email.com', 0.00, 0, 0, 1, 'Art School', 0, 7, 1, 0, 0, 0, 0, NULL, 'Student', 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
),
(
  45, 'Evangelista', 'Ella', 'Cruz', 'F', '1979-12-03', 2, 7, 1, '09609990000', 'ella.evangelista@email.com', 24000.00, 0, 0, 0, NULL, 0, 8, 1, 1, 0, 1, 0, 1, 'Public Health', 'Health Worker', 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
),
(
  46, 'Gutierrez', 'Ethan', 'Perez', 'M', '1961-02-17', 2, 2, 1, '09701112222', 'ethan.gutierrez@email.com', 20000.00, 0, 0, 0, NULL, 0, 5, 1, 1, 0, 1, 0, 1, 'Farming', 'Farm Owner', 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
),
(
  47, 'Jose', 'Aria', 'Hernandez', 'F', '1996-04-20', 1, 4, 1, '09802223333', 'aria.jose@email.com', 0.00, 0, 0, 1, 'Vocational Training Center', 0, 6, 1, 0, 0, 0, 0, NULL, 'Student', 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
),
(
  48, 'Katigbak', 'Owen', 'Flores', 'M', '1984-06-25', 2, 6, 1, '09903334444', 'owen.katigbak@email.com', 21000.00, 0, 0, 0, NULL, 0, 8, 1, 1, 0, 1, 0, 1, 'Logistics', 'Driver', 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
),
(
  49, 'Legaspi', 'Scarlett', 'De Guzman', 'F', '1975-09-02', 2, 8, 1, '09054445555', 'scarlett.legaspi@email.com', 0.00, 0, 0, 0, NULL, 0, 5, 1, 1, 0, 0, 0, 1, NULL, 'Homemaker', 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
),
(
  50, 'Macapagal', 'Logan', 'Rivera', 'M', '1999-11-14', 1, 1, 1, '09105556666', 'logan.macapagal@email.com', 0.00, 0, 0, 1, 'University High School', 0, 4, 1, 0, 0, 0, 0, NULL, 'Student', 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
),
(
  51, 'Nepomuceno', 'Grace', 'Soriano', 'F', '1988-01-29', 2, 3, 1, '09177778888', 'grace.nepomuceno@email.com', 26000.00, 0, 0, 0, NULL, 0, 8, 1, 1, 0, 1, 0, 1, 'Marketing', 'Marketing Specialist', 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
),
(
  52, 'Ong', 'Caleb', 'Santiago', 'M', '1962-03-08', 2, 5, 1, '09208889999', 'caleb.ong@email.com', 23000.00, 0, 0, 0, NULL, 0, 8, 1, 1, 0, 1, 0, 1, 'Small Business', 'Restaurant Owner', 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
),
(
  53, 'Pineda', 'Ava', 'Gomez', 'F', '1992-05-19', 1, 7, 1, '09309990000', 'ava.pineda@email.com', 0.00, 0, 0, 1, 'National University', 0, 7, 1, 0, 0, 0, 0, NULL, 'Student', 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
),
(
  54, 'Quijano', 'Elijah', 'Ramos', 'M', '1977-07-23', 2, 2, 1, '09451001111', 'elijah.quijano@email.com', 20000.00, 0, 0, 0, NULL, 0, 8, 1, 1, 0, 1, 0, 1, 'Education', 'School Administrator', 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
),
(
  55, 'Remulla', 'Chloe', 'Lim', 'F', '1969-09-04', 3, 4, 1, '09602112222', 'chloe.remulla@email.com', 0.00, 1, 0, 0, NULL, 0, 5, 1, 1, 0, 0, 0, 1, NULL, 'Homemaker', 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
),
(
  56, 'Salazar', 'Mason', 'Diaz', 'M', '1998-11-15', 1, 6, 1, '09703334444', 'mason.salazar@email.com', 0.00, 0, 0, 1, 'College of Engineering', 0, 7, 1, 0, 0, 0, 0, NULL, 'Student', 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
),
(
  57, 'Teodoro', 'Victoria', 'Martinez', 'F', '1984-01-07', 2, 8, 1, '09804445555', 'victoria.teodoro@email.com', 18000.00, 0, 0, 0, NULL, 0, 6, 1, 1, 0, 1, 0, 1, 'Salon', 'Hairdresser', 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
),
(
  58, 'Umali', 'Alexander', 'Yap', 'M', '1960-03-18', 2, 1, 1, '09905556666', 'alexander.umali@email.com', 29000.00, 0, 0, 0, NULL, 0, 9, 1, 1, 0, 1, 0, 1, 'Law Firm', 'Lawyer', 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
),
(
  59, 'Valdez', 'Grace', 'Marcelo', 'F', '1994-05-29', 1, 3, 1, '09056667777', 'grace.valdez@email.com', 0.00, 0, 0, 1, 'Nursing School', 0, 7, 1, 0, 0, 0, 0, NULL, 'Student', 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
),
(
  60, 'Yap', 'Benjamin', 'Palma', 'M', '1971-07-04', 2, 5, 1, '09107778888', 'benjamin.yap@email.com', 25000.00, 0, 0, 0, NULL, 0, 8, 1, 1, 0, 1, 0, 1, 'Local Business', 'Manager', 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
),
(
  61, 'Zarate', 'Luna', 'Francisco', 'F', '1989-09-11', 1, 7, 1, '09179990000', 'luna.zarate@email.com', 17000.00, 0, 0, 0, NULL, 0, 6, 1, 1, 0, 1, 0, 1, 'Cafe', 'Barista', 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
),
(
  62, 'Austria', 'Daniel', 'Mendoza', 'M', '1966-11-21', 2, 2, 1, '09201001111', 'daniel.austria@email.com', 22000.00, 0, 0, 0, NULL, 0, 5, 1, 1, 0, 1, 0, 1, 'Fisheries', 'Boat Captain', 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
),
(
  63, 'Balagtas', 'Chloe', 'Panganiban', 'F', '1993-01-06', 1, 4, 1, '09302112222', 'chloe.balagtas@email.com', 0.00, 0, 0, 1, 'University of the Philippines', 0, 7, 1, 0, 0, 0, 0, NULL, 'Student', 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
),
(
  64, 'Capistrano', 'Jackson', 'Reyes', 'M', '1978-03-24', 2, 6, 1, '09453334444', 'jackson.capistrano@email.com', 20000.00, 0, 0, 0, NULL, 0, 8, 1, 1, 0, 1, 0, 1, 'Tourism', 'Tour Guide', 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
),
(
  65, 'Delos Santos', 'Hazel', 'Dela Rosa', 'F', '1964-05-09', 3, 8, 1, '09604445555', 'hazel.delossantos@email.com', 0.00, 1, 0, 0, NULL, 0, 5, 1, 1, 0, 0, 0, 1, NULL, 'Homemaker', 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
),
(
  66, 'Esguerra', 'Henry', 'Cruz', 'M', '1998-07-02', 1, 1, 1, '09705556666', 'henry.esguerra@email.com', 0.00, 0, 0, 1, 'Community College', 0, 4, 1, 0, 0, 0, 0, NULL, 'Student', 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
),
(
  67, 'Fortunato', 'Sophie', 'Sy', 'F', '1980-09-13', 2, 3, 1, '09806667777', 'sophie.fortunato@email.com', 28000.00, 0, 0, 0, NULL, 0, 8, 1, 1, 0, 1, 0, 1, 'Healthcare', 'Pharmacist', 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
),
(
  68, 'Generoso', 'Sebastian', 'Tan', 'M', '1968-11-04', 2, 5, 1, '09907778888', 'sebastian.generoso@email.com', 25000.00, 0, 0, 0, NULL, 0, 8, 1, 1, 0, 1, 0, 1, 'Agriculture', 'Farm Manager', 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
),
(
  69, 'Hermoso', 'Eleanor', 'Gonzales', 'F', '1995-01-21', 1, 7, 1, '09058889999', 'eleanor.hermoso@email.com', 0.00, 0, 0, 1, 'Polytechnic University', 0, 7, 1, 0, 0, 0, 0, NULL, 'Student', 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
),
(
  70, 'Javier', 'Owen', 'Aquino', 'M', '1973-03-02', 2, 2, 1, '09109990000', 'owen.javier@email.com', 21000.00, 0, 0, 0, NULL, 0, 8, 1, 1, 0, 1, 0, 1, 'Logistics', 'Warehouse Supervisor', 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
),
(
  71, 'Lacson', 'Stella', 'Castillo', 'F', '1961-05-18', 2, 4, 1, '09172002222', 'stella.lacson@email.com', 0.00, 0, 0, 0, NULL, 0, 5, 1, 1, 0, 0, 0, 1, NULL, 'Homemaker', 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
),
(
  72, 'Manalo', 'Arthur', 'Delgado', 'M', '1990-07-26', 1, 6, 1, '09203003333', 'arthur.manalo@email.com', 16000.00, 0, 0, 0, NULL, 0, 6, 1, 1, 0, 1, 0, 1, 'Food Service', 'Cook', 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
),
(
  73, 'Nario', 'Ruby', 'Fabian', 'F', '1976-09-07', 2, 8, 1, '09304004444', 'ruby.nario@email.com', 24000.00, 0, 0, 0, NULL, 0, 8, 1, 1, 0, 1, 0, 1, 'Tourism', 'Hotel Staff', 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
),
(
  74, 'Ocampo', 'Vincent', 'Imperial', 'M', '1965-11-16', 2, 1, 1, '09455005555', 'vincent.ocampo@email.com', 28000.00, 0, 0, 0, NULL, 0, 9, 1, 1, 0, 1, 0, 1, 'Academia', 'Professor', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
),
(
  75, 'Paras', 'Luna', 'Alonzo', 'F', '1992-01-01', 1, 3, 1, '09606006666', 'luna.paras@email.com', 0.00, 0, 0, 1, 'Law School', 0, 7, 1, 0, 0, 0, 0, NULL, 'Student', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
),
(
  76, 'Quizon', 'Victor', 'Bernardo', 'M', '1970-03-10', 2, 5, 1, '09707007777', 'victor.quizon@email.com', 22000.00, 0, 0, 0, NULL, 0, 8, 1, 1, 0, 1, 0, 1, 'IT Support', 'Tech Support', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
),
(
  77, 'Ramos', 'Hannah', 'Chua', 'F', '1986-05-27', 2, 7, 1, '09808008888', 'hannah.ramos@email.com', 19000.00, 0, 0, 0, NULL, 0, 6, 1, 1, 0, 1, 0, 1, 'Clothing', 'Seamstress', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
),
(
  78, 'Sarmiento', 'Oscar', 'Domingo', 'M', '1963-07-08', 2, 2, 1, '09909009999', 'oscar.sarmiento@email.com', 20000.00, 0, 0, 0, NULL, 0, 5, 1, 1, 0, 1, 0, 1, 'Local Transport', 'Taxi Driver', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
),
(
  79, 'Tolentino', 'Isabelle', 'Evangelista', 'F', '1997-09-17', 1, 4, 1, '09050001111', 'isabelle.tolentino@email.com', 0.00, 0, 0, 1, 'Arts and Design College', 0, 7, 1, 0, 0, 0, 0, NULL, 'Student', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
),
(
  80, 'Uy', 'Kevin', 'Gutierrez', 'M', '1981-11-23', 2, 6, 1, '09101112222', 'kevin.uy@email.com', 26000.00, 0, 0, 0, NULL, 0, 8, 1, 1, 0, 1, 0, 1, 'Finance', 'Banker', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
),
(
  81, 'Villanueva', 'Catherine', 'Jose', 'F', '1975-01-14', 2, 8, 1, '09172223333', 'catherine.villanueva@email.com', 23000.00, 0, 0, 0, NULL, 0, 8, 1, 1, 0, 1, 0, 1, 'Government', 'Councilor', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
),
(
  82, 'Wang', 'Liam', 'Katigbak', 'M', '1990-03-01', 1, 1, 1, '09203334444', 'liam.wang@email.com', 18000.00, 0, 0, 0, NULL, 0, 6, 1, 1, 0, 1, 0, 1, 'Retail', 'Sales Manager', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
),
(
  83, 'Xavier', 'Olivia', 'Legaspi', 'F', '1968-05-10', 2, 3, 1, '09304445555', 'olivia.xavier@email.com', 0.00, 0, 0, 0, NULL, 0, 5, 1, 1, 0, 0, 0, 1, NULL, 'Homemaker', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
),
(
  84, 'Yulo', 'Daniel', 'Macapagal', 'M', '1995-07-28', 1, 5, 1, '09455556666', 'daniel.yulo@email.com', 0.00, 0, 0, 1, 'Science High School', 0, 4, 1, 0, 0, 0, 0, NULL, 'Student', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
),
(
  85, 'Zafra', 'Mia', 'Nepomuceno', 'F', '1973-09-06', 2, 7, 1, '09606667777', 'mia.zafra@email.com', 27000.00, 0, 0, 0, NULL, 0, 8, 1, 1, 0, 1, 0, 1, 'Education', 'Guidance Counselor', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
),
(
  86, 'Abad', 'Noah', 'Ong', 'M', '1961-11-13', 2, 2, 1, '09707778888', 'noah.abad@email.com', 24000.00, 0, 0, 0, NULL, 0, 8, 1, 1, 0, 1, 0, 1, 'Healthcare', 'Paramedic', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
),
(
  87, 'Baluyut', 'Grace', 'Pineda', 'F', '1999-01-22', 1, 4, 1, '09808889999', 'grace.baluyut@email.com', 0.00, 0, 0, 1, 'University of Manila', 0, 7, 1, 0, 0, 0, 0, NULL, 'Student', 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
),
(
  88, 'Castañeda', 'Liam', 'Quijano', 'M', '1984-03-03', 2, 6, 1, '09909990000', 'liam.castaneda@email.com', 20000.00, 0, 0, 0, NULL, 0, 8, 1, 1, 0, 1, 0, 1, 'Sports', 'Coach', 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
),
(
  89, 'De Jesus', 'Ava', 'Remulla', 'F', '1970-05-15', 2, 8, 1, '09051001111', 'ava.dejesus@email.com', 0.00, 0, 0, 0, NULL, 0, 5, 1, 1, 0, 0, 0, 1, NULL, 'Homemaker', 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
),
(
  90, 'Echeverria', 'Elijah', 'Salazar', 'M', '1996-07-27', 1, 1, 1, '09102112222', 'elijah.echeverria@email.com', 0.00, 0, 0, 1, 'Vocational School', 0, 6, 1, 0, 0, 0, 0, NULL, 'Student', 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
),
(
  91, 'Flores', 'Sophia', 'Teodoro', 'F', '1982-09-08', 2, 3, 1, '09173334444', 'sophia.flores@email.com', 17000.00, 0, 0, 0, NULL, 0, 6, 1, 1, 0, 1, 0, 1, 'Retail', 'Cashier', 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
),
(
  92, 'Guerrero', 'Mason', 'Umali', 'M', '1960-11-19', 2, 5, 1, '09204445555', 'mason.guerrero@email.com', 28000.00, 0, 0, 0, NULL, 0, 9, 1, 1, 0, 1, 0, 1, 'Government', 'Mayor', 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
),
(
  93, 'Ignacio', 'Lily', 'Valdez', 'F', '1994-01-04', 1, 7, 1, '09305556666', 'lily.ignacio@email.com', 0.00, 0, 0, 1, 'Private University', 0, 7, 1, 0, 0, 0, 0, NULL, 'Student', 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
),
(
  94, 'Jalandoni', 'Alexander', 'Yap', 'M', '1979-03-13', 2, 2, 1, '09456667777', 'alexander.jalandoni@email.com', 25000.00, 0, 0, 0, NULL, 0, 8, 1, 1, 0, 1, 0, 1, 'Construction', 'Architect', 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
),
(
  95, 'Kabigting', 'Aria', 'Zarate', 'F', '1967-05-20', 2, 4, 1, '09607778888', 'aria.kabigting@email.com', 0.00, 0, 0, 0, NULL, 0, 5, 1, 1, 0, 0, 0, 1, NULL, 'Homemaker', 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
),
(
  96, 'Lacson', 'Owen', 'Austria', 'M', '1998-07-05', 1, 6, 1, '09708889999', 'owen.lacson@email.com', 0.00, 0, 0, 1, 'Public College', 0, 4, 1, 0, 0, 0, 0, NULL, 'Student', 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
),
(
  97, 'Magsaysay', 'Scarlett', 'Balagtas', 'F', '1985-09-16', 2, 8, 1, '09809990000', 'scarlett.magsaysay@email.com', 21000.00, 0, 0, 0, NULL, 0, 8, 1, 1, 0, 1, 0, 1, 'Restaurant', 'Chef', 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
),
(
  98, 'Navarro', 'Logan', 'Capistrano', 'M', '1962-11-28', 2, 1, 1, '09901001111', 'logan.navarro@email.com', 23000.00, 0, 0, 0, NULL, 0, 8, 1, 1,  0, 1, 0, 1, 'Transportation', 'Bus Driver', 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
),
(
  99, 'Ortega', 'Grace', 'Delos Santos', 'F', '1993-01-13', 1, 3, 1, '09052112222', 'grace.ortega@email.com', 0.00, 0, 0, 1, 'Art Institute', 0, 7, 1, 0, 0, 0, 0, NULL, 'Student', 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
),
(
  100, 'Pacheco', 'Caleb', 'Esguerra', 'M', '1977-03-20', 2, 5, 1, '09103334444', 'caleb.pacheco@email.com', 26000.00, 0, 0, 0, NULL, 0, 8, 1, 1, 0, 1, 0, 1, 'Finance', 'Bank Manager', 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
);

--
-- Dumping data for table `family`
--
INSERT INTO `family` (`family_id`, `main_family_surname`, `description`, `created_at`, `updated_at`) VALUES
(1, 'Reyes', 'The Reyes family from Zone Mabini', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 'Santos', 'The Santos family from Zone Bonifacio', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(3, 'Dela Cruz', 'The Dela Cruz family, farmers', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(4, 'Lim', 'The Lim family, mostly students', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(5, 'Garcia', 'The Garcia family, a medical household', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(6, 'Cruz', 'The Cruz family of accountants', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(7, 'Ramos', 'The Ramos family, construction workers', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(8, 'Aquino', 'The Aquino solo parent family', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(9, 'Gonzales', 'The Gonzales student family', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(10, 'Castro', 'The Castro family of retail managers', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(11, 'Rodriguez', 'The Rodriguez factory worker family', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(12, 'Tan', 'The Tan student family', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(13, 'Perez', 'The Perez fisherman family', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(14, 'Hernandez', 'The Hernandez office worker family', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(15, 'Flores', 'The Flores student family', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(16, 'De Guzman', 'The De Guzman service crew family', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(17, 'Rivera', 'The Rivera transportation family', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(18, 'Soriano', 'The Soriano vendor family', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(19, 'Santiago', 'The Santiago student family', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(20, 'Gomez', 'The Gomez real estate family', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(21, 'Villanueva', 'The Villanueva farm laborers', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(22, 'Yap', 'The Yap social workers', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(23, 'Marcelo', 'The Marcelo student family', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(24, 'Palma', 'The Palma sales associates', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(25, 'Francisco', 'The Francisco engineering family', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);


--
-- Dumping data for table `household`
--
INSERT INTO `household` (`household_id`, `zone_id`, `household_head_individual_id`, `address`, `what_water_source_id`, `has_toilet`, `has_electricity`, `main_source_of_cooking_fuel_id`, `tenure_status_id`, `household_source_of_income_id`, `monthly_household_income`, `type_of_household_id`, `type_of_house_material_id`, `created_at`, `updated_at`, `monthly_income`, `has_water`, `has_internet`) VALUES
(1, 1, 1, '123 Narra St., Purok 1', 1, 1, 1, 1, 1, 1, 45000.00, 1, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 45000.00, 1, 1),
(2, 2, 2, '45 Orchid St., Purok 2', 1, 1, 1, 1, 1, 1, 38000.00, 1, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 38000.00, 1, 1),
(3, 3, 3, '78 Sampaguita St., Purok 3', 2, 1, 1, 2, 1, 3, 20000.00, 2, 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 20000.00, 1, 0),
(4, 4, 5, '101 Dahlia St., Purok 4', 1, 1, 1, 1, 1, 8, 55000.00, 1, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 55000.00, 1, 1),
(5, 5, 6, '15 Acacia St., Purok 5', 1, 1, 1, 1, 2, 1, 28000.00, 1, 3, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 28000.00, 1, 0),
(6, 6, 7, '22 Mango St., Purok 6', 1, 1, 1, 1, 2, 1, 25000.00, 4, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 25000.00, 1, 0),
(7, 7, 8, '33 Guava St., Purok 7', 2, 1, 1, 2, 4, 8, 15000.00, 3, 4, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 15000.00, 1, 0),
(8, 8, 10, '44 Banana St., Purok 8', 1, 1, 1, 1, 1, 5, 40000.00, 1, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 40000.00, 1, 1),
(9, 9, 11, '55 Narra St., Purok 9', 1, 1, 1, 1, 1, 1, 28000.00, 1, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 28000.00, 1, 1),
(10, 10, 13, '66 Orchid St., Purok 10', 2, 1, 1, 2, 2, 4, 22000.00, 2, 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 22000.00, 1, 0),
(11, 1, 14, '77 Sampaguita St., Purok 1', 1, 1, 1, 1, 1, 1, 35000.00, 1, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 35000.00, 1, 1),
(12, 2, 16, '88 Dahlia St., Purok 2', 1, 1, 1, 1, 2, 1, 20000.00, 4, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 20000.00, 1, 0),
(13, 3, 17, '99 Acacia St., Purok 3', 2, 1, 1, 2, 1, 1, 28000.00, 1, 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 28000.00, 1, 0),
(14, 4, 18, '110 Mango St., Purok 4', 1, 1, 1, 1, 1, 1, 42000.00, 1, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 42000.00, 1, 1),
(15, 5, 20, '121 Guava St., Purok 5', 1, 1, 1, 1, 2, 1, 30000.00, 1, 3, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 30000.00, 1, 0),
(16, 6, 21, '132 Banana St., Purok 6', 2, 1, 1, 2, 4, 3, 18000.00, 3, 4, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 18000.00, 1, 0),
(17, 7, 23, '143 Narra St., Purok 7', 1, 1, 1, 1, 1, 1, 33000.00, 1, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 33000.00, 1, 1),
(18, 8, 24, '154 Orchid St., Purok 8', 1, 1, 1, 1, 1, 1, 27000.00, 1, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 27000.00, 1, 1),
(19, 9, 25, '165 Sampaguita St., Purok 9', 2, 1, 1, 2, 2, 1, 24000.00, 4, 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 24000.00, 1, 0),
(20, 10, 27, '176 Dahlia St., Purok 10', 1, 1, 1, 1, 1, 1, 39000.00, 1, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 39000.00, 1, 1),
(21, 1, 28, '187 Acacia St., Purok 1', 1, 1, 1, 1, 2, 1, 29000.00, 1, 3, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 29000.00, 1, 0),
(22, 2, 30, '198 Mango St., Purok 2', 2, 1, 1, 2, 4, 3, 17000.00, 3, 4, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 17000.00, 1, 0),
(23, 3, 32, '209 Guava St., Purok 3', 1, 1, 1, 1, 1, 1, 31000.00, 1, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 31000.00, 1, 1),
(24, 4, 33, '220 Banana St., Purok 4', 1, 1, 1, 1, 1, 1, 26000.00, 1, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 26000.00, 1, 1),
(25, 5, 34, '231 Narra St., Purok 5', 2, 1, 1, 2, 2, 1, 23000.00, 4, 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 23000.00, 1, 0),
(26, 6, 36, '242 Orchid St., Purok 6', 1, 1, 1, 1, 1, 1, 36000.00, 1, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 36000.00, 1, 1),
(27, 7, 37, '253 Sampaguita St., Purok 7', 1, 1, 1, 1, 2, 1, 27000.00, 1, 3, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 27000.00, 1, 0),
(28, 8, 38, '264 Dahlia St., Purok 8', 2, 1, 1, 2, 4, 3, 16000.00, 3, 4, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 16000.00, 1, 0),
(29, 9, 40, '275 Acacia St., Purok 9', 1, 1, 1, 1, 1, 1, 32000.00, 1, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 32000.00, 1, 1),
(30, 10, 41, '286 Mango St., Purok 10', 1, 1, 1, 1, 1, 1, 25000.00, 1, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 25000.00, 1, 1),
(31, 1, 43, '297 Guava St., Purok 1', 2, 1, 1, 2, 2, 1, 21000.00, 4, 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 21000.00, 1, 0),
(32, 2, 44, '308 Banana St., Purok 2', 1, 1, 1, 1, 1, 1, 38000.00, 1, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 38000.00, 1, 1),
(33, 3, 45, '319 Narra St., Purok 3', 1, 1, 1, 1, 2, 1, 29000.00, 1, 3, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 29000.00, 1, 0),
(34, 4, 47, '330 Orchid St., Purok 4', 2, 1, 1, 2, 4, 3, 19000.00, 3, 4, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 19000.00, 1, 0),
(35, 5, 48, '341 Sampaguita St., Purok 5', 1, 1, 1, 1, 1, 1, 34000.00, 1, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 34000.00, 1, 1),
(36, 6, 50, '352 Dahlia St., Purok 6', 1, 1, 1, 1, 1, 1, 28000.00, 1, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 28000.00, 1, 1),
(37, 7, 51, '363 Acacia St., Purok 7', 2, 1, 1, 2, 2, 1, 25000.00, 4, 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 25000.00, 1, 0),
(38, 8, 52, '374 Mango St., Purok 8', 1, 1, 1, 1, 1, 1, 40000.00, 1, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 40000.00, 1, 1),
(39, 9, 54, '385 Guava St., Purok 9', 1, 1, 1, 1, 2, 1, 30000.00, 1, 3, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 30000.00, 1, 0),
(40, 10, 55, '396 Banana St., Purok 10', 2, 1, 1, 2, 4, 3, 18000.00, 3, 4, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 18000.00, 1, 0),
(41, 1, 57, '407 Narra St., Purok 1', 1, 1, 1, 1, 1, 1, 35000.00, 1, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 35000.00, 1, 1),
(42, 2, 58, '418 Orchid St., Purok 2', 1, 1, 1, 1, 1, 1, 27000.00, 1, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 27000.00, 1, 1),
(43, 3, 60, '429 Sampaguita St., Purok 3', 2, 1, 1, 2, 2, 1, 24000.00, 4, 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 24000.00, 1, 0),
(44, 4, 61, '440 Dahlia St., Purok 4', 1, 1, 1, 1, 1, 1, 39000.00, 1, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 39000.00, 1, 1),
(45, 5, 63, '451 Acacia St., Purok 5', 1, 1, 1, 1, 2, 1, 29000.00, 1, 3, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 29000.00, 1, 0),
(46, 6, 64, '462 Mango St., Purok 6', 2, 1, 1, 2, 4, 3, 17000.00, 3, 4, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 17000.00, 1, 0),
(47, 7, 66, '473 Guava St., Purok 7', 1, 1, 1, 1, 1, 1, 31000.00, 1, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 31000.00, 1, 1),
(48, 8, 67, '484 Banana St., Purok 8', 1, 1, 1, 1, 1, 1, 26000.00, 1, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 26000.00, 1, 1),
(49, 9, 69, '495 Narra St., Purok 9', 2, 1, 1, 2, 2, 1, 23000.00, 4, 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 23000.00, 1, 0),
(50, 10, 70, '506 Orchid St., Purok 10', 1, 1, 1, 1, 1, 1, 36000.00, 1, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 36000.00, 1, 1);


--
-- Dumping data for table `household_member` (representing family structure within households)
--
INSERT INTO `household_member` (`household_id`, `individual_id`, `relationship_to_head`) VALUES
(1, 1, 'Head'), (1, 2, 'Spouse'), (1, 4, 'Daughter'), (1, 9, 'Son'),
(2, 5, 'Head'), (2, 6, 'Spouse'), (2, 12, 'Daughter'), (2, 15, 'Son'),
(3, 3, 'Head'), (3, 7, 'Son'), (3, 23, 'Spouse'), (3, 22, 'Daughter'),
(4, 10, 'Head'), (4, 11, 'Spouse'), (4, 19, 'Son'), (4, 20, 'Daughter'),
(5, 13, 'Head'), (5, 14, 'Spouse'), (5, 16, 'Daughter'), (5, 17, 'Son'),
(6, 18, 'Head'), (6, 21, 'Son'), (6, 24, 'Daughter'), (6, 26, 'Daughter'),
(7, 8, 'Head'), (7, 28, 'Daughter'), (7, 29, 'Son'), (7, 31, 'Son-in-law'),
(8, 27, 'Head'), (8, 30, 'Spouse'), (8, 33, 'Daughter'), (8, 35, 'Son'),
(9, 32, 'Head'), (9, 34, 'Spouse'), (9, 36, 'Son'), (9, 39, 'Daughter'),
(10, 37, 'Head'), (10, 38, 'Spouse'), (10, 40, 'Son'), (10, 42, 'Daughter'),
(11, 43, 'Head'), (11, 45, 'Spouse'), (11, 47, 'Daughter'), (11, 49, 'Son'),
(12, 44, 'Head'), (12, 46, 'Spouse'), (12, 48, 'Daughter'), (12, 50, 'Son'),
(13, 51, 'Head'), (13, 53, 'Spouse'), (13, 56, 'Daughter'), (13, 59, 'Son'),
(14, 52, 'Head'), (14, 54, 'Spouse'), (14, 57, 'Daughter'), (14, 61, 'Son'),
(15, 55, 'Head'), (15, 62, 'Son'), (15, 63, 'Daughter'), (15, 65, 'Daughter'),
(16, 58, 'Head'), (16, 60, 'Spouse'), (16, 64, 'Son'), (16, 66, 'Daughter'),
(17, 71, 'Head'), (17, 72, 'Son'), (17, 73, 'Daughter'), (17, 75, 'Daughter'),
(18, 74, 'Head'), (18, 76, 'Spouse'), (18, 77, 'Daughter'), (18, 79, 'Son'),
(19, 78, 'Head'), (19, 80, 'Son'), (19, 81, 'Daughter'), (19, 83, 'Daughter'),
(20, 82, 'Head'), (20, 84, 'Spouse'), (20, 85, 'Daughter'), (20, 87, 'Son'),
(21, 86, 'Head'), (21, 88, 'Spouse'), (21, 89, 'Daughter'), (21, 91, 'Son'),
(22, 90, 'Head'), (22, 92, 'Spouse'), (22, 93, 'Daughter'), (22, 95, 'Son'),
(23, 94, 'Head'), (23, 96, 'Spouse'), (23, 97, 'Daughter'), (23, 99, 'Son'),
(24, 98, 'Head'), (24, 100, 'Spouse');

--
-- Dumping data for table `family_household` (connecting households to families)
--
INSERT INTO `family_household` (`family_id`, `household_id`) VALUES
(1, 1), (1, 11),
(2, 2), (2, 12),
(3, 3), (3, 13),
(4, 4), (4, 14),
(5, 5), (5, 15),
(6, 6), (6, 16),
(7, 7), (7, 17),
(8, 8), (8, 18),
(9, 9), (9, 19),
(10, 10), (10, 20),
(11, 21), (11, 31),
(12, 22), (12, 32),
(13, 23), (13, 33),
(14, 24), (14, 34),
(15, 25), (15, 35),
(16, 26), (16, 36),
(17, 27), (17, 37),
(18, 28), (18, 38),
(19, 29), (19, 39),
(20, 30), (20, 40),
(21, 41), (21, 42),
(22, 43), (22, 44),
(23, 45), (23, 46),
(24, 47), (24, 48),
(25, 49), (25, 50);

-- Re-enable foreign key checks
SET FOREIGN_KEY_CHECKS = 1;
