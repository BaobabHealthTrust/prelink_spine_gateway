-- MySQL dump 10.13  Distrib 5.5.27, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: prelink_gateway
-- ------------------------------------------------------
-- Server version	5.5.27-0ubuntu2

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `lab_order`
--

DROP TABLE IF EXISTS `lab_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lab_order` (
  `lab_order_id` int(11) NOT NULL AUTO_INCREMENT,
  `request_number` varchar(45) DEFAULT NULL,
  `barcodes` varchar(255) DEFAULT NULL,
  `national_id` varchar(128) DEFAULT NULL,
  `priority_code` varchar(45) DEFAULT NULL,
  `date_collected` datetime DEFAULT NULL,
  `date_received` datetime DEFAULT NULL,
  `patient_id` int(11) DEFAULT NULL,
  `result` varchar(255) DEFAULT NULL,
  `date_result_received` datetime DEFAULT NULL,
  `test_code` varchar(255) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `test_unit` varchar(255) DEFAULT NULL,
  `colour` varchar(45) DEFAULT NULL,
  `test_range` varchar(255) DEFAULT NULL,
  `voided` int(1) DEFAULT '0',
  PRIMARY KEY (`lab_order_id`),
  UNIQUE KEY `lab_order_id_UNIQUE` (`lab_order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=95 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2012-09-25  8:22:42
