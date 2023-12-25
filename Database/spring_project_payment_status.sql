CREATE DATABASE  IF NOT EXISTS `spring_project` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `spring_project`;
-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: localhost    Database: spring_project
-- ------------------------------------------------------
-- Server version	8.0.32

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `payment_status`
--

DROP TABLE IF EXISTS `payment_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment_status` (
  `id` int NOT NULL AUTO_INCREMENT,
  `meter_no` varchar(45) DEFAULT NULL,
  `name` varchar(45) DEFAULT NULL,
  `month` varchar(45) DEFAULT NULL,
  `year` varchar(45) DEFAULT NULL,
  `meter_type` varchar(45) DEFAULT NULL,
  `units` double DEFAULT NULL,
  `total_bill` double DEFAULT NULL,
  `last_date_for_pay` date DEFAULT NULL,
  `bill_receive_date` date DEFAULT NULL,
  `fine_total` double DEFAULT NULL,
  `payment_status` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_status`
--

LOCK TABLES `payment_status` WRITE;
/*!40000 ALTER TABLE `payment_status` DISABLE KEYS */;
INSERT INTO `payment_status` VALUES (14,'123451','Shahidul Islam','January','2023','Business',75,717.925,'2023-02-10','2023-02-15',768.17975,'Paid'),(16,'123451','Shahidul Islam','February','2023','Business',105,1021.27,'2023-03-10','2023-03-16',1123.397,'Paid'),(18,'123452','Rubel Hossain','January','2023','Small Industry',180,2075.96,'2023-02-11','2023-02-16',2221.2772,'Paid'),(19,'123451','Shahidul Islam','March','2023','Business',100,977.4,'2023-04-13','2023-04-15',1045.818,'Paid'),(21,'123452','Rubel Hossain','February','2023','Small Industry',75,890.93,'2023-03-11',NULL,0,'Not Paid'),(23,'123453','Muhinur Rahman','August','2023','Residential',85,560.51,'2023-09-16',NULL,0,'Not Paid'),(24,'123451','Shahidul Islam','April','2023','Business',110,1065.14,'2023-05-10','2023-05-13',1139.6998,'Paid'),(25,'123451','Shahidul Islam','May','2023','Business',90,889.66,'2023-06-10','2023-06-12',951.9362,'Paid'),(26,'123451','Shahidul Islam','June','2023','Business',110,1065.14,'2023-07-11','2023-07-22',1224.911,'Paid'),(27,'123451','Shahidul Islam','July','2023','Business',60,594.34,'2023-08-10','2023-08-17',653.774,'Paid'),(28,'123451','Shahidul Islam','August','2023','Business',110,1065.14,'2023-09-08','2023-09-13',1139.6998,'Paid'),(29,'123451','Shahidul Islam','September','2023','Business',130,1240.62,'2023-10-12','2023-10-14',1327.4633999999999,'Paid'),(30,'123451','Shahidul Islam','April','2023','Business',110,1065.14,'2023-05-10',NULL,0,'Paid'),(31,'123452','Rubel Hossain','August','2023','Small Industry',100,1121.24,'2023-09-13','2023-09-16',1199.7268,'Paid'),(32,'123451','Shahidul Islam','October','2023','Business',100,1065.14,'2023-10-10',NULL,NULL,'Not Paid');
/*!40000 ALTER TABLE `payment_status` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-12-20 20:42:47
