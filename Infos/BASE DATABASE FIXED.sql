-- Optimized SQL Script to Create the Barangay Database Schema
-- This script incorporates recommended indexing and addresses potential redundancy.

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
  `has_toilet` ENUM('Yes', 'No') DEFAULT 'No',
  `has_electricity` ENUM('Yes', 'No') DEFAULT 'No',
  `main_source_of_cooking_fuel_id` int(11) DEFAULT NULL,
  `tenure_status_id` int(11) DEFAULT NULL,
  `household_source_of_income_id` int(11) DEFAULT NULL,
  `monthly_household_income` decimal(10,2) DEFAULT NULL,
  `type_of_household_id` int(11) DEFAULT NULL,
  `type_of_house_material_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  -- `monthly_income` decimal(10,2) DEFAULT NULL, -- This column was commented out as redundant with monthly_household_income
  `has_water` ENUM('Yes', 'No') DEFAULT 'No',
  `has_internet` ENUM('Yes', 'No') DEFAULT 'No'
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
  `gender` ENUM('Male', 'Female') NOT NULL,
  `birth_date` date NOT NULL,
  `civil_status_id` int(11) NOT NULL,
  `blood_type_id` int(11) DEFAULT NULL,
  `religion_id` int(11) DEFAULT NULL,
  `contact_number` varchar(20) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `salary_income` decimal(10,2) DEFAULT NULL,
  `is_solo_parent` ENUM('Yes', 'No') DEFAULT 'No',
  `has_disability` ENUM('Yes', 'No') DEFAULT 'No',
  `is_student` ENUM('Yes', 'No') DEFAULT 'No',
  `school_attending` varchar(255) DEFAULT NULL,
  `is_scholar` ENUM('Yes', 'No') DEFAULT 'No',
  `educational_attainment_id` int(11) DEFAULT NULL,
  `is_alive` ENUM('Yes', 'No') DEFAULT 'Yes',
  `is_registered_voter` ENUM('Yes', 'No') DEFAULT 'No',
  `is_ofw` ENUM('Yes', 'No') DEFAULT 'No',
  `is_sss_member` ENUM('Yes', 'No') DEFAULT 'No',
  `is_gsis_member` ENUM('Yes', 'No') DEFAULT 'No',
  `is_philhealth_member` ENUM('Yes', 'No') DEFAULT 'No',
  `working_for` varchar(255) DEFAULT NULL,
  `occupation` varchar(255) DEFAULT NULL,
  `is_4ps_beneficiary` ENUM('Yes', 'No') DEFAULT 'No',
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

-- Add index for `address` in `household` table
ALTER TABLE `household` ADD INDEX `idx_address` (`address`);
-- Add index for `monthly_household_income` in `household` table
ALTER TABLE `household` ADD INDEX `idx_monthly_household_income` (`monthly_household_income`);

-- The following line was removed as the column 'monthly_income' does not exist in the table definition.
-- ALTER TABLE `household` DROP COLUMN `monthly_income`;

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

-- Add composite index for `surname` and `first_name` in `individual` table
ALTER TABLE `individual` ADD INDEX `idx_surname_firstname` (`surname`, `first_name`);
-- Add index for `birth_date` in `individual` table
ALTER TABLE `individual` ADD INDEX `idx_birth_date` (`birth_date`);
-- Add index for `contact_number` in `individual` table
ALTER TABLE `individual` ADD INDEX `idx_contact_number` (`contact_number`);
-- Add index for `email` in `individual` table
ALTER TABLE `individual` ADD INDEX `idx_email` (`email`);


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
  MODIFY `family_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

--
-- AUTO_INCREMENT for table `household`
--
ALTER TABLE `household`
  MODIFY `household_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

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
  MODIFY `individual_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

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
  MODIFY `zone_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

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
