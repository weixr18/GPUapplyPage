-- MySQL dump 10.13  Distrib 8.0.17, for Win64 (x86_64)
--
-- Host: localhost    Database: apl_sys
-- ------------------------------------------------------
-- Server version	8.0.17

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `apl_sys`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `apl_sys` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `apl_sys`;

--
-- Table structure for table `tb_record`
--

DROP TABLE IF EXISTS `tb_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_record` (
  `id` int(11) DEFAULT NULL,
  `username` varchar(20) DEFAULT NULL,
  `aptm_day` date DEFAULT NULL,
  `aptm_period` tinyint(4) DEFAULT NULL,
  `apl_time` datetime DEFAULT NULL,
  `isvalid` tinyint(4) DEFAULT NULL,
  `sysuserid` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_record`
--

LOCK TABLES `tb_record` WRITE;
/*!40000 ALTER TABLE `tb_record` DISABLE KEYS */;
INSERT INTO `tb_record` VALUES (2018075632,'wxr','2020-02-05',1,'2020-02-03 09:14:50',1,0),(2018473626,'wxr ','2020-02-03',2,'2020-02-03 09:16:36',1,0);
/*!40000 ALTER TABLE `tb_record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_users`
--

DROP TABLE IF EXISTS `tb_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_users` (
  `id` int(11) DEFAULT NULL,
  `password` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_users`
--

LOCK TABLES `tb_users` WRITE;
/*!40000 ALTER TABLE `tb_users` DISABLE KEYS */;
INSERT INTO `tb_users` VALUES (0,'b4ce6367'),(1,'97da8d73'),(2,'d67a3198'),(3,'f80fa190'),(4,'a0ebc7e2'),(5,'7cc54140'),(6,'801d41e4'),(7,'5356f4a0'),(8,'fa1f4a97'),(9,'b8e28308'),(10,'c443e409'),(11,'3910a4fc'),(12,'e106df5c'),(13,'e1487293'),(14,'539d2af1'),(15,'ebaf044c'),(16,'24352476'),(17,'0c535de2'),(18,'f11b4eb5'),(19,'59486f8b'),(20,'f6315955'),(21,'eff1945d'),(22,'168356cd'),(23,'23f4d9b7'),(24,'5ef0f0bf'),(25,'2c7fa945'),(26,'e8af12e5'),(27,'bff9ced9'),(28,'801d54e2'),(29,'fe662d89'),(30,'ec8b36fb'),(31,'3590044e'),(32,'df96c00a'),(33,'a13cbe3b'),(34,'4d59ea4d'),(35,'607ce333'),(36,'1b860860'),(37,'95270327'),(38,'e10db201'),(39,'b4034c02'),(40,'a3e6474d'),(41,'09aa9082'),(42,'53f4271d'),(43,'713c1600'),(44,'ae6c57a0'),(45,'dc65124b'),(46,'59189e97'),(47,'4f3b4b34'),(48,'55c042b8'),(49,'483f73e5'),(50,'e63f9e97'),(51,'e19f1c96'),(52,'3e536c64'),(53,'e3e91f37'),(54,'da7bc795'),(55,'78966e06'),(56,'544bf467'),(57,'8f06c456'),(58,'ecbb5a4c'),(59,'b553dad9'),(60,'a606fe07'),(61,'3cfed5a9'),(62,'36e0084c'),(63,'3e738232'),(64,'7397a5b5'),(65,'87f28136'),(66,'13d74373'),(67,'c2ca9854'),(68,'78a02842'),(69,'3740c473'),(70,'5533f5b5'),(71,'4f43b093'),(72,'54374a27'),(73,'30808bcc'),(74,'70718821'),(75,'13914a0e'),(76,'1b51fbb0'),(77,'5d9041ff'),(78,'5c2b9f5e'),(79,'c26b30cc'),(80,'9340eb62'),(81,'3e652592'),(82,'fa4967ae'),(83,'15b667b2'),(84,'ecb7ff93'),(85,'9be87dc5'),(86,'4b9d9f94'),(87,'2503320e'),(88,'6a6e608c'),(89,'67b3ff00'),(90,'c5808fa0'),(91,'c81ca54b'),(92,'8fbbe17f'),(93,'e9f80e50'),(94,'9da7c290'),(95,'198089c9'),(96,'d8d0edb6'),(97,'500863b0'),(98,'7ec6f1e9'),(99,'a22bc9c3');
/*!40000 ALTER TABLE `tb_users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-04-06 14:37:24
