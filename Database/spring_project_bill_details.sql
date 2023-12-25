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
-- Table structure for table `bill_details`
--

DROP TABLE IF EXISTS `bill_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bill_details` (
  `id` int NOT NULL AUTO_INCREMENT,
  `meter_no` int NOT NULL,
  `customer_name` varchar(45) NOT NULL,
  `address` varchar(45) NOT NULL,
  `meter_type` varchar(45) NOT NULL,
  `last_month_units` double NOT NULL,
  `current_month_units` double NOT NULL,
  `units` double NOT NULL,
  `bill_per_unit` double NOT NULL,
  `net_bill` double NOT NULL,
  `meter_rent` double NOT NULL,
  `tax` double NOT NULL,
  `month` varchar(45) NOT NULL,
  `year` varchar(45) NOT NULL,
  `total_bill` double NOT NULL,
  `pay_status` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bill_details`
--

LOCK TABLES `bill_details` WRITE;
/*!40000 ALTER TABLE `bill_details` DISABLE KEYS */;
INSERT INTO `bill_details` VALUES (18,123451,'Shahidul Islam','Babugonj','Business',0,75,75,7.7,577.5,100,40.425,'January','2023',717.925,'Paid'),(19,123451,'Shahidul Islam','Babugonj','Business',75,180,105,8.2,861,100,60.27,'February','2023',1021.27,'Paid'),(20,123452,'Rubel Hossain','Mirpur-10','Small Industry',0,180,180,9.65,1737,200,138.96,'January','2023',2075.96,'Paid'),(21,123451,'Shahidul Islam','Babugonj','Business',180,280,100,8.2,820,100,57.4,'March','2023',977.4,'Paid'),(22,123453,'Muhinur Rahman','Mohammadpur','Residential',0,85,85,5.72,486.2,50,24.31,'August','2023',560.51,'Not Paid'),(23,123452,'Rubel Hossain','Mirpur-10','Small Industry',180,255,75,8.53,639.75,200,51.18,'February','2023',890.93,'Not Paid'),(24,123451,'Shahidul Islam','Babugonj','Business',280,390,110,8.2,902,100,63.14,'April','2023',1065.14,'Paid'),(25,123451,'Shahidul Islam','Babugonj','Business',390,480,90,8.2,738,100,51.66,'May','2023',889.66,'Paid'),(26,123451,'Shahidul Islam','Babugonj','Business',480,590,110,8.2,902,100,63.14,'June','2023',1065.14,'Paid'),(27,123451,'Shahidul Islam','Babugonj','Business',590,650,60,7.7,462,100,32.34,'Julay','2023',594.34,'Paid'),(28,123451,'Shahidul Islam','Babugonj','Business',650,760,110,8.2,902,100,63.14,'August','2023',1065.14,'Paid'),(29,123451,'Shahidul Islam','Babugonj','Business',760,890,130,8.2,1066,100,74.62,'September','2023',1240.62,'Paid'),(30,123452,'Rubel Hossain','Mirpur-10','Small Industry',255,350,95,8.53,810.35,200,64.828,'April','2023',1075.178,'Not Paid'),(31,123452,'Rubel Hossain','Mirpur-10','Small Industry',350,450,100,8.53,853,200,68.24,'August','2023',1121.24,'Paid'),(32,123451,'Shahidul Islam','Babugonj','Business',890,990,100,8.2,820,100,75,'October','2023',1065.14,'Not Paid');
/*!40000 ALTER TABLE `bill_details` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-12-20 20:42:46
