-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 26, 2024 at 01:17 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `re_data`
--

-- --------------------------------------------------------

--
-- Table structure for table `actifs`
--

CREATE TABLE `actifs` (
  `level_0` bigint(20) NOT NULL,
  `index` bigint(20) DEFAULT NULL,
  `reference` bigint(20) DEFAULT NULL,
  `date_eval_contrat` datetime DEFAULT NULL,
  `type_actif` text DEFAULT NULL,
  `num_tf_req` text DEFAULT NULL,
  `adresse` text DEFAULT NULL,
  `surface` bigint(20) DEFAULT NULL,
  `desc_age` text DEFAULT NULL,
  `valeur_global` double DEFAULT NULL,
  `desc_1` text DEFAULT NULL,
  `desc_2` text DEFAULT NULL,
  `desc_3` text DEFAULT NULL,
  `lat_2` text DEFAULT NULL,
  `lon_2` double DEFAULT NULL,
  `pu` double DEFAULT NULL,
  `standing` text DEFAULT NULL,
  `age` bigint(20) DEFAULT NULL,
  `transaction` text NOT NULL,
  `enquete` text NOT NULL,
  `evaluation` text NOT NULL,
  `orientation` text NOT NULL,
  `destination` text NOT NULL,
  `parking` text NOT NULL,
  `ascenseur` text NOT NULL,
  `residenceType` text NOT NULL,
  `elevation` text NOT NULL,
  `villaType` text NOT NULL,
  `operation` text NOT NULL,
  `ville` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `actifs`
--
ALTER TABLE `actifs`
  ADD PRIMARY KEY (`level_0`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `actifs`
--
ALTER TABLE `actifs`
  MODIFY `level_0` bigint(20) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
