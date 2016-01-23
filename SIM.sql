-- phpMyAdmin SQL Dump
-- version 4.0.10deb1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jan 14, 2016 at 10:46 PM
-- Server version: 5.5.46-0ubuntu0.14.04.2
-- PHP Version: 5.5.9-1ubuntu4.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `SIM`
--

-- --------------------------------------------------------

--
-- Table structure for table `JOB`
--

CREATE TABLE IF NOT EXISTS `Job` (
  `job_id` int(10) AUTO_INCREMENT, 
  `id` varchar(100) ,
  `name` varchar(10),
  `date` date,
  `client` varchar(100),
  `comment` TEXT,
  `checker_name` varchar(100),
  `engineer_name` varchar(100),
  `approved_name` varchar(100),
  `checker_date` date,
  `ref` varchar(100),
  `part` varchar(100),
  `rev` varchar(100),
  `approved_date` date,
  PRIMARY KEY (`job_id`)
);


CREATE TABLE IF NOT EXISTS `Member`
(
	`job_id` int(10) NOT NULL,
	`member_id` int(10),
	PRIMARY KEY(`member_id`, `job_id`)
);

CREATE TABLE IF NOT EXISTS `Member_incidence`
(
	`job_id` int(10) NOT NULL,
	`member_id` int(10),
	`joint_id` int(10),
	PRIMARY KEY(`job_id`, `member_id`, `joint_id`)
);
--
-- Dumping data for table `JOB`
--

-- --------------------------------------------------------

--
-- Table structure for table `JOB1`
--

CREATE TABLE IF NOT EXISTS `Joint` (
  `job_id` int(100) NOT NULL,
  `id` int(10) NOT NULL,
  `x`  double NOT NULL,
  `y`  double NOT NULL,
  `z`  double,
  PRIMARY KEY (`id`,`job_id`)
);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
