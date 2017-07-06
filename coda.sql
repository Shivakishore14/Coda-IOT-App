-- MySQL dump 10.13  Distrib 5.7.18, for Win64 (x86_64)
--
-- Host: localhost    Database: coda
-- ------------------------------------------------------
-- Server version	5.7.18-log

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
-- Table structure for table `company`
--

DROP TABLE IF EXISTS `company`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `company` (
  `cid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT NULL,
  `secret` varchar(100) DEFAULT NULL,
  `addr1` varchar(150) NOT NULL,
  `addr2` varchar(150) NOT NULL,
  `city` varchar(50) NOT NULL,
  `state` varchar(50) NOT NULL,
  `country` varchar(50) NOT NULL,
  PRIMARY KEY (`cid`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `company`
--

LOCK TABLES `company` WRITE;
/*!40000 ALTER TABLE `company` DISABLE KEYS */;
INSERT INTO `company` VALUES (1,'coda','testHash123','','','','',''),(2,'MyComp12','UFXLyftl','adwqu','uy','iuyiu','yiu','yiuy'),(3,'coda2','mysec','ad2','jh','khkj','hkj','hkj');
/*!40000 ALTER TABLE `company` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sensor_data`
--

DROP TABLE IF EXISTS `sensor_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sensor_data` (
  `sid` int(11) DEFAULT NULL,
  `timestamp` varchar(100) DEFAULT NULL,
  `value` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sensor_data`
--

LOCK TABLES `sensor_data` WRITE;
/*!40000 ALTER TABLE `sensor_data` DISABLE KEYS */;
INSERT INTO `sensor_data` VALUES (1,'Wed Jul 05 2017 22:40:31 GMT+0530 (India Standard Time)','8'),(1,'Wed Jul 05 2017 22:40:32 GMT+0530 (India Standard Time)','2'),(1,'Wed Jul 05 2017 22:40:33 GMT+0530 (India Standard Time)','3'),(1,'Wed Jul 05 2017 22:40:34 GMT+0530 (India Standard Time)','7'),(1,'Wed Jul 05 2017 22:40:35 GMT+0530 (India Standard Time)','4'),(1,'Wed Jul 05 2017 22:40:36 GMT+0530 (India Standard Time)','5'),(1,'Wed Jul 05 2017 22:40:37 GMT+0530 (India Standard Time)','5'),(1,'Wed Jul 05 2017 22:40:38 GMT+0530 (India Standard Time)','0'),(1,'Wed Jul 05 2017 22:40:39 GMT+0530 (India Standard Time)','9'),(1,'Wed Jul 05 2017 22:40:40 GMT+0530 (India Standard Time)','6'),(1,'Wed Jul 05 2017 22:40:41 GMT+0530 (India Standard Time)','8'),(1,'Wed Jul 05 2017 22:40:42 GMT+0530 (India Standard Time)','1'),(1,'Thu Jul 06 2017 10:25:04 GMT+0530 (India Standard Time)','0'),(1,'Thu Jul 06 2017 10:25:05 GMT+0530 (India Standard Time)','1'),(1,'Thu Jul 06 2017 10:25:06 GMT+0530 (India Standard Time)','0'),(1,'Thu Jul 06 2017 10:25:07 GMT+0530 (India Standard Time)','0'),(1,'Thu Jul 06 2017 10:25:08 GMT+0530 (India Standard Time)','3'),(1,'Thu Jul 06 2017 10:25:09 GMT+0530 (India Standard Time)','1'),(1,'Thu Jul 06 2017 10:25:10 GMT+0530 (India Standard Time)','0'),(1,'Thu Jul 06 2017 10:25:11 GMT+0530 (India Standard Time)','2');
/*!40000 ALTER TABLE `sensor_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sensors`
--

DROP TABLE IF EXISTS `sensors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sensors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(20) DEFAULT NULL,
  `cid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cid` (`cid`),
  CONSTRAINT `sensors_ibfk_1` FOREIGN KEY (`cid`) REFERENCES `company` (`cid`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sensors`
--

LOCK TABLES `sensors` WRITE;
/*!40000 ALTER TABLE `sensors` DISABLE KEYS */;
INSERT INTO `sensors` VALUES (1,'humidity',1),(2,'pressure',1),(10,'humidity',3);
/*!40000 ALTER TABLE `sensors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `test`
--

DROP TABLE IF EXISTS `test`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `test` (
  `tid` int(11) NOT NULL,
  `name` varchar(20) DEFAULT NULL,
  `password` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`tid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `test`
--

LOCK TABLES `test` WRITE;
/*!40000 ALTER TABLE `test` DISABLE KEYS */;
INSERT INTO `test` VALUES (1,'shiva','kishore'),(2,'sk','shiva');
/*!40000 ALTER TABLE `test` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_company_mapping`
--

DROP TABLE IF EXISTS `user_company_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_company_mapping` (
  `userid` int(11) NOT NULL,
  `cid` int(11) NOT NULL,
  `role` varchar(20) NOT NULL,
  PRIMARY KEY (`userid`,`cid`),
  KEY `cid` (`cid`),
  CONSTRAINT `user_company_mapping_ibfk_2` FOREIGN KEY (`userid`) REFERENCES `users` (`id`),
  CONSTRAINT `user_company_mapping_ibfk_3` FOREIGN KEY (`cid`) REFERENCES `company` (`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_company_mapping`
--

LOCK TABLES `user_company_mapping` WRITE;
/*!40000 ALTER TABLE `user_company_mapping` DISABLE KEYS */;
INSERT INTO `user_company_mapping` VALUES (2,1,'user'),(10,1,'admin'),(10,2,'admin'),(10,3,'user'),(33,1,'user'),(33,3,'user'),(34,3,'admin');
/*!40000 ALTER TABLE `user_company_mapping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `firstname` varchar(20) DEFAULT NULL,
  `lastname` varchar(20) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `phone` varchar(100) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,NULL,NULL,NULL,NULL,NULL),(2,'jhgj','hgjh','jhg','gjh','gjh'),(4,'7','7','jhg2','7','hjhg'),(5,'','','','',''),(10,'shiva','s','shiva@my.com','9090090099','kishore'),(33,'shiva','kishore','shivakishore@my.com','9090909090','kishore'),(34,'kishore','sekhar','kishore@my.com','90909090','kishore');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-07-06 18:34:14
