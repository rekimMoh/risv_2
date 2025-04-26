-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: risv
-- ------------------------------------------------------
-- Server version	5.5.5-10.4.32-MariaDB

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
-- Table structure for table `antecedant_examens`
--

DROP TABLE IF EXISTS `antecedant_examens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `antecedant_examens` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `examen_id` bigint(20) unsigned DEFAULT NULL,
  `antecedent_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `antecedent_examens_examen_id_foreign` (`examen_id`),
  KEY `antecedent_examens_antecedent_id_foreign` (`antecedent_id`),
  CONSTRAINT `antecedent_examens_antecedent_id_foreign` FOREIGN KEY (`antecedent_id`) REFERENCES `antecedents` (`IDAntecedent`),
  CONSTRAINT `antecedent_examens_examen_id_foreign` FOREIGN KEY (`examen_id`) REFERENCES `examens` (`IDExamen`)
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `antecedant_examens`
--

LOCK TABLES `antecedant_examens` WRITE;
/*!40000 ALTER TABLE `antecedant_examens` DISABLE KEYS */;
INSERT INTO `antecedant_examens` VALUES (62,64,1,'2024-01-30 20:50:46','2024-01-30 20:50:46'),(63,67,1,'2024-02-02 22:41:04','2024-02-02 22:41:04'),(64,67,2,'2024-02-02 22:41:04','2024-02-02 22:41:04'),(65,73,1,'2024-09-01 10:55:53','2024-09-01 10:55:53'),(66,74,1,'2024-09-04 07:05:39','2024-09-04 07:05:39');
/*!40000 ALTER TABLE `antecedant_examens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `antecedents`
--

DROP TABLE IF EXISTS `antecedents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `antecedents` (
  `IDAntecedent` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `libelleAntecedent` varchar(255) DEFAULT NULL,
  `UIAntecedent` int(11) DEFAULT NULL,
  `etatAntecedent` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`IDAntecedent`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `antecedents`
--

LOCK TABLES `antecedents` WRITE;
/*!40000 ALTER TABLE `antecedents` DISABLE KEYS */;
INSERT INTO `antecedents` VALUES (1,'Allergie 001',1,1,'2023-05-29 21:27:46','2025-02-28 21:56:14'),(2,'HTA',1,1,'2023-05-29 21:28:04','2025-02-28 21:56:05'),(3,'Diabète',1,1,'2023-05-29 21:28:17','2023-06-09 21:07:05'),(5,'Covid-19',1,1,'2025-02-28 21:56:40','2025-03-03 15:37:55');
/*!40000 ALTER TABLE `antecedents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache`
--

DROP TABLE IF EXISTS `cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache`
--

LOCK TABLES `cache` WRITE;
/*!40000 ALTER TABLE `cache` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache_locks`
--

DROP TABLE IF EXISTS `cache_locks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache_locks`
--

LOCK TABLES `cache_locks` WRITE;
/*!40000 ALTER TABLE `cache_locks` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache_locks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `caisses`
--

DROP TABLE IF EXISTS `caisses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `caisses` (
  `IDCaisse` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `net` decimal(8,2) DEFAULT NULL,
  `tva` decimal(8,2) DEFAULT NULL,
  `ttc` decimal(8,2) DEFAULT NULL,
  `verse` decimal(8,2) DEFAULT NULL,
  `reset` decimal(8,2) DEFAULT NULL,
  `UICaisse` int(11) DEFAULT NULL,
  `etatCaisse` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`IDCaisse`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `caisses`
--

LOCK TABLES `caisses` WRITE;
/*!40000 ALTER TABLE `caisses` DISABLE KEYS */;
INSERT INTO `caisses` VALUES (37,4000.00,0.00,4000.00,3997.00,0.00,1,NULL,'2024-01-30 20:50:46','2024-01-30 20:50:46'),(38,6100.00,0.00,6100.00,6000.00,100.00,1,NULL,'2024-02-01 23:36:55','2024-02-01 23:36:55'),(39,4500.00,0.00,4500.00,4200.00,300.00,1,NULL,'2024-02-02 22:41:04','2024-02-08 21:59:47'),(40,12500.00,0.00,12500.00,12500.00,0.00,1,NULL,'2024-02-03 00:02:32','2024-02-03 22:52:50'),(41,5000.00,950.00,5950.00,5950.00,0.00,1,NULL,'2024-02-03 20:11:50','2024-02-03 20:11:50'),(42,11000.00,2090.00,13090.00,13090.00,0.00,1,NULL,'2024-02-14 21:16:28','2024-02-14 21:17:43'),(43,3200.00,0.00,3200.00,3200.00,0.00,1,NULL,'2024-09-01 10:55:53','2024-09-04 06:56:47'),(44,1200.00,0.00,1200.00,1100.00,100.00,1,NULL,'2024-09-04 07:05:39','2024-09-04 07:05:39'),(45,3000.00,570.00,3570.00,3500.00,70.00,1,NULL,'2024-09-04 07:06:31','2024-09-04 07:06:31'),(46,5500.00,0.00,5500.00,5500.00,0.00,1,NULL,'2024-09-06 21:22:16','2024-09-06 21:22:29'),(47,2600.00,0.00,2600.00,2600.00,0.00,1,NULL,'2024-11-18 19:43:43','2024-11-18 19:43:58'),(48,3800.00,722.00,4522.00,4522.00,0.00,1,NULL,'2025-03-07 23:24:57','2025-03-07 23:25:58');
/*!40000 ALTER TABLE `caisses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `classe_produits`
--

DROP TABLE IF EXISTS `classe_produits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `classe_produits` (
  `IDClasseProduit` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `libelleCP` varchar(255) DEFAULT NULL,
  `UICP` int(11) DEFAULT NULL,
  `etatCP` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`IDClasseProduit`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `classe_produits`
--

LOCK TABLES `classe_produits` WRITE;
/*!40000 ALTER TABLE `classe_produits` DISABLE KEYS */;
INSERT INTO `classe_produits` VALUES (2,'CLASSE PRODUIT 00112',1,0,'2023-05-18 22:19:15','2025-03-07 21:12:58'),(3,'CLASSE PRODUIT 002',1,1,'2023-05-18 22:26:01','2025-03-03 15:34:25'),(4,'CLASSE PRODUIT 003',1,0,'2023-05-18 22:26:07','2025-03-06 19:34:39'),(5,'CLASSE PRODUIT 004',1,1,'2023-05-18 22:26:11','2023-05-18 22:26:11'),(6,'CLASSE PRODUIT 005',1,1,'2023-05-18 22:26:15','2023-05-18 22:26:15'),(7,'CLASSE PRODUIT 006',1,1,'2023-05-18 22:26:19','2025-03-07 21:13:03'),(8,'CLASSE PRODUIT 007',1,1,'2023-05-18 22:26:24','2023-05-18 22:26:24'),(9,'CLASSE PRODUIT 008',1,1,'2023-05-18 22:26:28','2023-05-18 22:26:28'),(10,'CLASSE PRODUIT 009',1,1,'2023-05-18 22:26:33','2023-05-18 22:26:33'),(11,'CLASSE PRODUIT 01000d',1,1,'2023-05-18 22:26:41','2025-02-28 19:49:13'),(12,'CLASSE PRODUIT 011',1,1,'2023-05-18 22:26:46','2025-02-28 19:55:22'),(13,'CLASSE PRODUIT 012',1,1,'2023-05-18 22:26:51','2023-05-18 22:26:51');
/*!40000 ALTER TABLE `classe_produits` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clients`
--

DROP TABLE IF EXISTS `clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clients` (
  `IDClient` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`IDClient`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clients`
--

LOCK TABLES `clients` WRITE;
/*!40000 ALTER TABLE `clients` DISABLE KEYS */;
/*!40000 ALTER TABLE `clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `compte_rendu_models`
--

DROP TABLE IF EXISTS `compte_rendu_models`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `compte_rendu_models` (
  `IDCRM` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `titreCRM` varchar(255) NOT NULL,
  `contenuCRM` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `etatCRM` int(11) DEFAULT NULL,
  `UICRM` int(11) DEFAULT NULL,
  PRIMARY KEY (`IDCRM`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `compte_rendu_models`
--

LOCK TABLES `compte_rendu_models` WRITE;
/*!40000 ALTER TABLE `compte_rendu_models` DISABLE KEYS */;
INSERT INTO `compte_rendu_models` VALUES (2,'qs fqsdf qsdf','f qsdfqsdf qsdf qs','2023-05-20 21:44:51','2023-05-20 21:44:51',1,1);
/*!40000 ALTER TABLE `compte_rendu_models` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `compte_rendus`
--

DROP TABLE IF EXISTS `compte_rendus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `compte_rendus` (
  `IDCR` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `contenuCR` text DEFAULT NULL,
  `UICR` int(11) DEFAULT NULL,
  `etatCR` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `examen_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`IDCR`),
  KEY `compte_rendus_examen_id_foreign` (`examen_id`),
  CONSTRAINT `compte_rendus_examen_id_foreign` FOREIGN KEY (`examen_id`) REFERENCES `examens` (`IDExamen`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `compte_rendus`
--

LOCK TABLES `compte_rendus` WRITE;
/*!40000 ALTER TABLE `compte_rendus` DISABLE KEYS */;
/*!40000 ALTER TABLE `compte_rendus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `conventions`
--

DROP TABLE IF EXISTS `conventions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `conventions` (
  `IDconv` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `client_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`IDconv`),
  KEY `conventions_client_id_foreign` (`client_id`),
  CONSTRAINT `conventions_client_id_foreign` FOREIGN KEY (`client_id`) REFERENCES `clients` (`IDClient`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `conventions`
--

LOCK TABLES `conventions` WRITE;
/*!40000 ALTER TABLE `conventions` DISABLE KEYS */;
/*!40000 ALTER TABLE `conventions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `day_hour_shifts`
--

DROP TABLE IF EXISTS `day_hour_shifts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `day_hour_shifts` (
  `IDDHS` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `day_id` bigint(20) unsigned DEFAULT NULL,
  `shift_id` bigint(20) unsigned DEFAULT NULL,
  `hour_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`IDDHS`),
  KEY `day_hour_shifts_day_id_foreign` (`day_id`),
  KEY `day_hour_shifts_shift_id_foreign` (`shift_id`),
  KEY `day_hour_shifts_hour_id_foreign` (`hour_id`),
  CONSTRAINT `day_hour_shifts_day_id_foreign` FOREIGN KEY (`day_id`) REFERENCES `days` (`IDDay`),
  CONSTRAINT `day_hour_shifts_hour_id_foreign` FOREIGN KEY (`hour_id`) REFERENCES `hours` (`IDHour`),
  CONSTRAINT `day_hour_shifts_shift_id_foreign` FOREIGN KEY (`shift_id`) REFERENCES `shifts` (`IDShift`)
) ENGINE=InnoDB AUTO_INCREMENT=503 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `day_hour_shifts`
--

LOCK TABLES `day_hour_shifts` WRITE;
/*!40000 ALTER TABLE `day_hour_shifts` DISABLE KEYS */;
INSERT INTO `day_hour_shifts` VALUES (331,3,9,3,'2025-03-08 11:25:15','2025-03-08 11:25:15'),(332,3,9,4,'2025-03-08 11:25:15','2025-03-08 11:25:15'),(333,3,9,5,'2025-03-08 11:25:15','2025-03-08 11:25:15'),(334,3,9,6,'2025-03-08 11:25:15','2025-03-08 11:25:15'),(335,1,8,1,'2025-03-08 11:25:44','2025-03-08 11:25:44'),(336,1,8,2,'2025-03-08 11:25:44','2025-03-08 11:25:44'),(337,1,8,3,'2025-03-08 11:25:44','2025-03-08 11:25:44'),(338,1,8,4,'2025-03-08 11:25:44','2025-03-08 11:25:44'),(339,1,8,5,'2025-03-08 11:25:44','2025-03-08 11:25:44'),(340,1,8,6,'2025-03-08 11:25:44','2025-03-08 11:25:44'),(341,1,8,7,'2025-03-08 11:25:44','2025-03-08 11:25:44'),(342,1,8,8,'2025-03-08 11:25:44','2025-03-08 11:25:44'),(343,1,8,19,'2025-03-08 11:25:44','2025-03-08 11:25:44'),(344,1,8,20,'2025-03-08 11:25:44','2025-03-08 11:25:44'),(345,1,8,21,'2025-03-08 11:25:44','2025-03-08 11:25:44'),(346,1,8,22,'2025-03-08 11:25:44','2025-03-08 11:25:44'),(347,1,8,23,'2025-03-08 11:25:44','2025-03-08 11:25:44'),(348,1,8,24,'2025-03-08 11:25:44','2025-03-08 11:25:44'),(349,2,8,1,'2025-03-08 11:25:44','2025-03-08 11:25:44'),(350,2,8,2,'2025-03-08 11:25:44','2025-03-08 11:25:44'),(351,2,8,3,'2025-03-08 11:25:44','2025-03-08 11:25:44'),(352,2,8,4,'2025-03-08 11:25:44','2025-03-08 11:25:44'),(353,2,8,5,'2025-03-08 11:25:44','2025-03-08 11:25:44'),(354,2,8,6,'2025-03-08 11:25:44','2025-03-08 11:25:44'),(355,2,8,7,'2025-03-08 11:25:44','2025-03-08 11:25:44'),(356,2,8,8,'2025-03-08 11:25:44','2025-03-08 11:25:44'),(357,2,8,19,'2025-03-08 11:25:44','2025-03-08 11:25:44'),(358,2,8,20,'2025-03-08 11:25:44','2025-03-08 11:25:44'),(359,2,8,21,'2025-03-08 11:25:44','2025-03-08 11:25:44'),(360,2,8,22,'2025-03-08 11:25:44','2025-03-08 11:25:44'),(361,2,8,23,'2025-03-08 11:25:44','2025-03-08 11:25:44'),(362,2,8,24,'2025-03-08 11:25:44','2025-03-08 11:25:44'),(363,3,8,1,'2025-03-08 11:25:44','2025-03-08 11:25:44'),(364,3,8,2,'2025-03-08 11:25:44','2025-03-08 11:25:44'),(365,3,8,3,'2025-03-08 11:25:44','2025-03-08 11:25:44'),(366,3,8,4,'2025-03-08 11:25:44','2025-03-08 11:25:44'),(367,3,8,5,'2025-03-08 11:25:44','2025-03-08 11:25:44'),(368,3,8,6,'2025-03-08 11:25:44','2025-03-08 11:25:44'),(369,3,8,7,'2025-03-08 11:25:44','2025-03-08 11:25:44'),(370,3,8,8,'2025-03-08 11:25:44','2025-03-08 11:25:44'),(371,3,8,19,'2025-03-08 11:25:44','2025-03-08 11:25:44'),(372,3,8,20,'2025-03-08 11:25:44','2025-03-08 11:25:44'),(373,3,8,21,'2025-03-08 11:25:44','2025-03-08 11:25:44'),(374,3,8,22,'2025-03-08 11:25:44','2025-03-08 11:25:44'),(375,3,8,23,'2025-03-08 11:25:44','2025-03-08 11:25:44'),(376,3,8,24,'2025-03-08 11:25:44','2025-03-08 11:25:44'),(377,4,8,1,'2025-03-08 11:25:44','2025-03-08 11:25:44'),(378,4,8,2,'2025-03-08 11:25:44','2025-03-08 11:25:44'),(379,4,8,3,'2025-03-08 11:25:44','2025-03-08 11:25:44'),(380,4,8,4,'2025-03-08 11:25:44','2025-03-08 11:25:44'),(381,4,8,5,'2025-03-08 11:25:44','2025-03-08 11:25:44'),(382,4,8,6,'2025-03-08 11:25:44','2025-03-08 11:25:44'),(383,4,8,7,'2025-03-08 11:25:44','2025-03-08 11:25:44'),(384,4,8,8,'2025-03-08 11:25:44','2025-03-08 11:25:44'),(385,4,8,19,'2025-03-08 11:25:44','2025-03-08 11:25:44'),(386,4,8,20,'2025-03-08 11:25:44','2025-03-08 11:25:44'),(387,4,8,21,'2025-03-08 11:25:44','2025-03-08 11:25:44'),(388,4,8,22,'2025-03-08 11:25:44','2025-03-08 11:25:44'),(389,4,8,23,'2025-03-08 11:25:44','2025-03-08 11:25:44'),(390,4,8,24,'2025-03-08 11:25:44','2025-03-08 11:25:44'),(391,5,8,1,'2025-03-08 11:25:44','2025-03-08 11:25:44'),(392,5,8,2,'2025-03-08 11:25:44','2025-03-08 11:25:44'),(393,5,8,3,'2025-03-08 11:25:44','2025-03-08 11:25:44'),(394,5,8,4,'2025-03-08 11:25:44','2025-03-08 11:25:44'),(395,5,8,5,'2025-03-08 11:25:44','2025-03-08 11:25:44'),(396,5,8,6,'2025-03-08 11:25:44','2025-03-08 11:25:44'),(397,5,8,7,'2025-03-08 11:25:44','2025-03-08 11:25:44'),(398,5,8,8,'2025-03-08 11:25:44','2025-03-08 11:25:44'),(399,5,8,19,'2025-03-08 11:25:44','2025-03-08 11:25:44'),(400,5,8,20,'2025-03-08 11:25:44','2025-03-08 11:25:44'),(401,5,8,21,'2025-03-08 11:25:44','2025-03-08 11:25:44'),(402,5,8,22,'2025-03-08 11:25:44','2025-03-08 11:25:44'),(403,5,8,23,'2025-03-08 11:25:44','2025-03-08 11:25:44'),(404,5,8,24,'2025-03-08 11:25:44','2025-03-08 11:25:44'),(405,6,8,1,'2025-03-08 11:25:44','2025-03-08 11:25:44'),(406,6,8,2,'2025-03-08 11:25:44','2025-03-08 11:25:44'),(407,6,8,3,'2025-03-08 11:25:44','2025-03-08 11:25:44'),(408,6,8,4,'2025-03-08 11:25:44','2025-03-08 11:25:44'),(409,6,8,5,'2025-03-08 11:25:44','2025-03-08 11:25:44'),(410,6,8,6,'2025-03-08 11:25:44','2025-03-08 11:25:44'),(411,6,8,7,'2025-03-08 11:25:44','2025-03-08 11:25:44'),(412,6,8,8,'2025-03-08 11:25:44','2025-03-08 11:25:44'),(413,6,8,19,'2025-03-08 11:25:44','2025-03-08 11:25:44'),(414,6,8,20,'2025-03-08 11:25:44','2025-03-08 11:25:44'),(415,6,8,21,'2025-03-08 11:25:44','2025-03-08 11:25:44'),(416,6,8,22,'2025-03-08 11:25:44','2025-03-08 11:25:44'),(417,6,8,23,'2025-03-08 11:25:45','2025-03-08 11:25:45'),(418,6,8,24,'2025-03-08 11:25:45','2025-03-08 11:25:45'),(419,7,8,1,'2025-03-08 11:25:45','2025-03-08 11:25:45'),(420,7,8,2,'2025-03-08 11:25:45','2025-03-08 11:25:45'),(421,7,8,3,'2025-03-08 11:25:45','2025-03-08 11:25:45'),(422,7,8,4,'2025-03-08 11:25:45','2025-03-08 11:25:45'),(423,7,8,5,'2025-03-08 11:25:45','2025-03-08 11:25:45'),(424,7,8,6,'2025-03-08 11:25:45','2025-03-08 11:25:45'),(425,7,8,7,'2025-03-08 11:25:45','2025-03-08 11:25:45'),(426,7,8,8,'2025-03-08 11:25:45','2025-03-08 11:25:45'),(427,7,8,19,'2025-03-08 11:25:45','2025-03-08 11:25:45'),(428,7,8,20,'2025-03-08 11:25:45','2025-03-08 11:25:45'),(429,7,8,21,'2025-03-08 11:25:45','2025-03-08 11:25:45'),(430,7,8,22,'2025-03-08 11:25:45','2025-03-08 11:25:45'),(431,7,8,23,'2025-03-08 11:25:45','2025-03-08 11:25:45'),(432,7,8,24,'2025-03-08 11:25:45','2025-03-08 11:25:45'),(433,1,7,9,'2025-03-16 20:33:24','2025-03-16 20:33:24'),(434,1,7,10,'2025-03-16 20:33:24','2025-03-16 20:33:24'),(435,1,7,11,'2025-03-16 20:33:24','2025-03-16 20:33:24'),(436,1,7,12,'2025-03-16 20:33:24','2025-03-16 20:33:24'),(437,1,7,13,'2025-03-16 20:33:24','2025-03-16 20:33:24'),(438,1,7,14,'2025-03-16 20:33:24','2025-03-16 20:33:24'),(439,1,7,15,'2025-03-16 20:33:24','2025-03-16 20:33:24'),(440,1,7,16,'2025-03-16 20:33:24','2025-03-16 20:33:24'),(441,1,7,17,'2025-03-16 20:33:24','2025-03-16 20:33:24'),(442,1,7,18,'2025-03-16 20:33:24','2025-03-16 20:33:24'),(443,2,7,9,'2025-03-16 20:33:24','2025-03-16 20:33:24'),(444,2,7,10,'2025-03-16 20:33:24','2025-03-16 20:33:24'),(445,2,7,11,'2025-03-16 20:33:24','2025-03-16 20:33:24'),(446,2,7,12,'2025-03-16 20:33:24','2025-03-16 20:33:24'),(447,2,7,13,'2025-03-16 20:33:24','2025-03-16 20:33:24'),(448,2,7,14,'2025-03-16 20:33:24','2025-03-16 20:33:24'),(449,2,7,15,'2025-03-16 20:33:24','2025-03-16 20:33:24'),(450,2,7,16,'2025-03-16 20:33:24','2025-03-16 20:33:24'),(451,2,7,17,'2025-03-16 20:33:24','2025-03-16 20:33:24'),(452,2,7,18,'2025-03-16 20:33:24','2025-03-16 20:33:24'),(453,3,7,9,'2025-03-16 20:33:24','2025-03-16 20:33:24'),(454,3,7,10,'2025-03-16 20:33:24','2025-03-16 20:33:24'),(455,3,7,11,'2025-03-16 20:33:24','2025-03-16 20:33:24'),(456,3,7,12,'2025-03-16 20:33:24','2025-03-16 20:33:24'),(457,3,7,13,'2025-03-16 20:33:24','2025-03-16 20:33:24'),(458,3,7,14,'2025-03-16 20:33:24','2025-03-16 20:33:24'),(459,3,7,15,'2025-03-16 20:33:24','2025-03-16 20:33:24'),(460,3,7,16,'2025-03-16 20:33:24','2025-03-16 20:33:24'),(461,3,7,17,'2025-03-16 20:33:24','2025-03-16 20:33:24'),(462,3,7,18,'2025-03-16 20:33:24','2025-03-16 20:33:24'),(463,4,7,9,'2025-03-16 20:33:24','2025-03-16 20:33:24'),(464,4,7,10,'2025-03-16 20:33:24','2025-03-16 20:33:24'),(465,4,7,11,'2025-03-16 20:33:24','2025-03-16 20:33:24'),(466,4,7,12,'2025-03-16 20:33:24','2025-03-16 20:33:24'),(467,4,7,13,'2025-03-16 20:33:24','2025-03-16 20:33:24'),(468,4,7,14,'2025-03-16 20:33:24','2025-03-16 20:33:24'),(469,4,7,15,'2025-03-16 20:33:24','2025-03-16 20:33:24'),(470,4,7,16,'2025-03-16 20:33:24','2025-03-16 20:33:24'),(471,4,7,17,'2025-03-16 20:33:24','2025-03-16 20:33:24'),(472,4,7,18,'2025-03-16 20:33:24','2025-03-16 20:33:24'),(473,5,7,9,'2025-03-16 20:33:24','2025-03-16 20:33:24'),(474,5,7,10,'2025-03-16 20:33:24','2025-03-16 20:33:24'),(475,5,7,11,'2025-03-16 20:33:24','2025-03-16 20:33:24'),(476,5,7,12,'2025-03-16 20:33:24','2025-03-16 20:33:24'),(477,5,7,13,'2025-03-16 20:33:24','2025-03-16 20:33:24'),(478,5,7,14,'2025-03-16 20:33:24','2025-03-16 20:33:24'),(479,5,7,15,'2025-03-16 20:33:24','2025-03-16 20:33:24'),(480,5,7,16,'2025-03-16 20:33:24','2025-03-16 20:33:24'),(481,5,7,17,'2025-03-16 20:33:24','2025-03-16 20:33:24'),(482,5,7,18,'2025-03-16 20:33:24','2025-03-16 20:33:24'),(483,6,7,9,'2025-03-16 20:33:24','2025-03-16 20:33:24'),(484,6,7,10,'2025-03-16 20:33:24','2025-03-16 20:33:24'),(485,6,7,11,'2025-03-16 20:33:24','2025-03-16 20:33:24'),(486,6,7,12,'2025-03-16 20:33:24','2025-03-16 20:33:24'),(487,6,7,13,'2025-03-16 20:33:24','2025-03-16 20:33:24'),(488,6,7,14,'2025-03-16 20:33:24','2025-03-16 20:33:24'),(489,6,7,15,'2025-03-16 20:33:24','2025-03-16 20:33:24'),(490,6,7,16,'2025-03-16 20:33:24','2025-03-16 20:33:24'),(491,6,7,17,'2025-03-16 20:33:24','2025-03-16 20:33:24'),(492,6,7,18,'2025-03-16 20:33:24','2025-03-16 20:33:24'),(493,7,7,9,'2025-03-16 20:33:24','2025-03-16 20:33:24'),(494,7,7,10,'2025-03-16 20:33:24','2025-03-16 20:33:24'),(495,7,7,11,'2025-03-16 20:33:24','2025-03-16 20:33:24'),(496,7,7,12,'2025-03-16 20:33:24','2025-03-16 20:33:24'),(497,7,7,13,'2025-03-16 20:33:24','2025-03-16 20:33:24'),(498,7,7,14,'2025-03-16 20:33:24','2025-03-16 20:33:24'),(499,7,7,15,'2025-03-16 20:33:24','2025-03-16 20:33:24'),(500,7,7,16,'2025-03-16 20:33:24','2025-03-16 20:33:24'),(501,7,7,17,'2025-03-16 20:33:24','2025-03-16 20:33:24'),(502,7,7,18,'2025-03-16 20:33:24','2025-03-16 20:33:24');
/*!40000 ALTER TABLE `day_hour_shifts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `days`
--

DROP TABLE IF EXISTS `days`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `days` (
  `IDDay` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `libelleDay` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`IDDay`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `days`
--

LOCK TABLES `days` WRITE;
/*!40000 ALTER TABLE `days` DISABLE KEYS */;
INSERT INTO `days` VALUES (1,'Dimanche',NULL,NULL),(2,'Lundi',NULL,NULL),(3,'Mardi ',NULL,NULL),(4,'Mercredi',NULL,NULL),(5,'Jeudi',NULL,NULL),(6,'Vendredi',NULL,NULL),(7,'Samedi',NULL,NULL);
/*!40000 ALTER TABLE `days` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `etat_caisses`
--

DROP TABLE IF EXISTS `etat_caisses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `etat_caisses` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `liblleEtatCiasse` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `etat_caisses`
--

LOCK TABLES `etat_caisses` WRITE;
/*!40000 ALTER TABLE `etat_caisses` DISABLE KEYS */;
INSERT INTO `etat_caisses` VALUES (1,'Paiment Total',NULL,NULL),(2,'Reste a paiyee',NULL,NULL),(3,'solde avce tranche',NULL,NULL);
/*!40000 ALTER TABLE `etat_caisses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `etudes`
--

DROP TABLE IF EXISTS `etudes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `etudes` (
  `IDEtude` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `libelleEtude` varchar(255) DEFAULT NULL,
  `UIEtude` int(11) DEFAULT NULL,
  `etatEtude` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `service_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`IDEtude`),
  KEY `etudes_service_id_foreign` (`service_id`),
  CONSTRAINT `etudes_service_id_foreign` FOREIGN KEY (`service_id`) REFERENCES `services` (`IDService`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `etudes`
--

LOCK TABLES `etudes` WRITE;
/*!40000 ALTER TABLE `etudes` DISABLE KEYS */;
INSERT INTO `etudes` VALUES (39,'ABDO',1,1,'2023-10-29 21:33:36','2025-03-23 21:54:46',1),(40,'ABDOPELV',1,1,'2023-10-29 21:34:34','2025-03-21 21:40:57',3),(41,'CHEVILLE554',1,1,'2023-10-29 21:35:00','2025-03-24 22:03:49',4),(42,'COMP MAMMO',1,1,'2023-11-17 20:35:22','2025-03-21 21:40:58',1),(43,'COUDE',1,1,'2023-11-17 20:35:53','2023-11-17 20:35:53',1),(45,'DOPP 1 MB INF',1,0,'2023-11-17 20:39:30','2025-03-24 22:06:46',4),(51,'test etude 0055',1,1,'2025-03-24 21:48:38','2025-03-24 22:06:38',1),(53,'test etude 002',1,1,'2025-03-24 21:50:17','2025-03-24 21:50:17',2);
/*!40000 ALTER TABLE `etudes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `examens`
--

DROP TABLE IF EXISTS `examens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `examens` (
  `IDExamen` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `dateEffetExam` date DEFAULT NULL,
  `radiologue_id` int(11) DEFAULT NULL,
  `UIExam` int(11) DEFAULT NULL,
  `RDVExam` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `patient_id` bigint(20) unsigned DEFAULT NULL,
  `produit_id` bigint(20) unsigned DEFAULT NULL,
  `class_produit_id` bigint(20) unsigned DEFAULT NULL,
  `etude_id` bigint(20) unsigned DEFAULT NULL,
  `service_id` bigint(20) unsigned DEFAULT NULL,
  `prescripeur_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`IDExamen`),
  KEY `examens_patient_id_foreign` (`patient_id`),
  KEY `examens_produit_id_foreign` (`produit_id`),
  KEY `examens_class_produit_id_foreign` (`class_produit_id`),
  KEY `examens_etude_id_foreign` (`etude_id`),
  KEY `examens_service_id_foreign` (`service_id`),
  KEY `examens_prescripeur_id_foreign` (`prescripeur_id`),
  CONSTRAINT `examens_class_produit_id_foreign` FOREIGN KEY (`class_produit_id`) REFERENCES `produits` (`class_produit_id`),
  CONSTRAINT `examens_etude_id_foreign` FOREIGN KEY (`etude_id`) REFERENCES `etudes` (`IDEtude`),
  CONSTRAINT `examens_patient_id_foreign` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`IDPatient`),
  CONSTRAINT `examens_prescripeur_id_foreign` FOREIGN KEY (`prescripeur_id`) REFERENCES `prescripteurs` (`IDPrescripteur`),
  CONSTRAINT `examens_produit_id_foreign` FOREIGN KEY (`produit_id`) REFERENCES `produits` (`IDProduit`),
  CONSTRAINT `examens_service_id_foreign` FOREIGN KEY (`service_id`) REFERENCES `services` (`IDService`)
) ENGINE=InnoDB AUTO_INCREMENT=79 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `examens`
--

LOCK TABLES `examens` WRITE;
/*!40000 ALTER TABLE `examens` DISABLE KEYS */;
INSERT INTO `examens` VALUES (64,NULL,8,1,NULL,'2024-01-30 20:50:46','2024-01-30 20:50:46',14,NULL,NULL,42,1,NULL),(65,NULL,7,1,NULL,'2024-02-01 23:36:55','2024-02-01 23:36:55',9,NULL,NULL,43,1,NULL),(66,NULL,8,1,NULL,'2024-02-01 23:36:55','2024-02-01 23:36:55',9,NULL,NULL,42,1,NULL),(67,NULL,22,1,NULL,'2024-02-02 22:41:04','2024-02-02 22:41:04',9,NULL,NULL,42,1,NULL),(68,NULL,7,1,NULL,'2024-02-03 00:02:32','2024-02-03 00:02:32',14,5,NULL,43,1,NULL),(69,NULL,7,1,NULL,'2024-02-03 00:02:32','2024-02-03 00:02:32',14,4,NULL,42,1,NULL),(70,NULL,8,1,NULL,'2024-02-03 20:11:50','2024-02-03 20:11:50',9,4,NULL,42,1,NULL),(71,NULL,8,1,NULL,'2024-02-14 21:16:28','2024-02-14 21:16:28',14,4,NULL,42,1,NULL),(72,NULL,12,1,NULL,'2024-02-14 21:16:28','2024-02-14 21:16:28',14,4,NULL,42,1,NULL),(73,NULL,8,1,NULL,'2024-09-01 10:55:53','2024-09-01 10:55:53',7,4,NULL,42,1,NULL),(74,NULL,22,1,NULL,'2024-09-04 07:05:39','2024-09-04 07:05:39',7,NULL,NULL,42,1,NULL),(75,NULL,8,1,NULL,'2024-09-04 07:06:31','2024-09-04 07:06:31',7,4,NULL,43,1,NULL),(76,NULL,8,1,NULL,'2024-09-06 21:22:16','2024-09-06 21:22:16',9,4,NULL,42,1,NULL),(77,NULL,8,1,NULL,'2024-11-18 19:43:43','2024-11-18 19:43:43',7,NULL,NULL,43,1,NULL),(78,NULL,8,1,NULL,'2025-03-07 23:24:57','2025-03-07 23:24:57',9,14,NULL,42,1,NULL);
/*!40000 ALTER TABLE `examens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `failed_jobs`
--

LOCK TABLES `failed_jobs` WRITE;
/*!40000 ALTER TABLE `failed_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `failed_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hours`
--

DROP TABLE IF EXISTS `hours`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hours` (
  `IDHour` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `libelleHour` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`IDHour`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hours`
--

LOCK TABLES `hours` WRITE;
/*!40000 ALTER TABLE `hours` DISABLE KEYS */;
INSERT INTO `hours` VALUES (1,'00',NULL,NULL),(2,'01',NULL,NULL),(3,'02',NULL,NULL),(4,'03',NULL,NULL),(5,'04',NULL,NULL),(6,'05',NULL,NULL),(7,'06',NULL,NULL),(8,'07',NULL,NULL),(9,'08',NULL,NULL),(10,'09',NULL,NULL),(11,'10',NULL,NULL),(12,'11',NULL,NULL),(13,'12',NULL,NULL),(14,'13',NULL,NULL),(15,'14',NULL,NULL),(16,'15',NULL,NULL),(17,'16',NULL,NULL),(18,'17',NULL,NULL),(19,'18',NULL,NULL),(20,'19',NULL,NULL),(21,'20',NULL,NULL),(22,'21',NULL,NULL),(23,'22',NULL,NULL),(24,'23',NULL,NULL);
/*!40000 ALTER TABLE `hours` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `job_batches`
--

DROP TABLE IF EXISTS `job_batches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job_batches`
--

LOCK TABLES `job_batches` WRITE;
/*!40000 ALTER TABLE `job_batches` DISABLE KEYS */;
/*!40000 ALTER TABLE `job_batches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) unsigned NOT NULL,
  `reserved_at` int(10) unsigned DEFAULT NULL,
  `available_at` int(10) unsigned NOT NULL,
  `created_at` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jobs`
--

LOCK TABLES `jobs` WRITE;
/*!40000 ALTER TABLE `jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lien_users`
--

DROP TABLE IF EXISTS `lien_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lien_users` (
  `IDLienUser` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `lien_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`IDLienUser`),
  KEY `lien_users_user_id_foreign` (`user_id`),
  KEY `lien_users_lien_id_foreign` (`lien_id`),
  CONSTRAINT `lien_users_lien_id_foreign` FOREIGN KEY (`lien_id`) REFERENCES `liens` (`IDLien`),
  CONSTRAINT `lien_users_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=684 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lien_users`
--

LOCK TABLES `lien_users` WRITE;
/*!40000 ALTER TABLE `lien_users` DISABLE KEYS */;
INSERT INTO `lien_users` VALUES (53,16,3,'2023-05-12 22:17:41','2023-05-12 22:17:41'),(54,16,4,'2023-05-12 22:17:41','2023-05-12 22:17:41'),(55,16,5,'2023-05-12 22:17:41','2023-05-12 22:17:41'),(56,16,8,'2023-05-12 22:17:41','2023-05-12 22:17:41'),(57,16,9,'2023-05-12 22:17:41','2023-05-12 22:17:41'),(190,15,3,'2023-05-13 21:36:56','2023-05-13 21:36:56'),(191,15,4,'2023-05-13 21:36:56','2023-05-13 21:36:56'),(192,15,5,'2023-05-13 21:36:56','2023-05-13 21:36:56'),(193,15,8,'2023-05-13 21:36:56','2023-05-13 21:36:56'),(194,15,9,'2023-05-13 21:36:56','2023-05-13 21:36:56'),(195,15,10,'2023-05-13 21:36:56','2023-05-13 21:36:56'),(196,15,12,'2023-05-13 21:36:56','2023-05-13 21:36:56'),(197,15,15,'2023-05-13 21:36:56','2023-05-13 21:36:56'),(198,15,11,'2023-05-13 21:36:56','2023-05-13 21:36:56'),(199,15,6,'2023-05-13 21:36:56','2023-05-13 21:36:56'),(214,21,3,'2023-05-13 21:38:09','2023-05-13 21:38:09'),(215,21,7,'2023-05-13 21:38:09','2023-05-13 21:38:09'),(216,21,8,'2023-05-13 21:38:09','2023-05-13 21:38:09'),(217,21,11,'2023-05-13 21:38:09','2023-05-13 21:38:09'),(218,21,13,'2023-05-13 21:38:09','2023-05-13 21:38:09'),(219,21,4,'2023-05-13 21:38:09','2023-05-13 21:38:09'),(220,21,9,'2023-05-13 21:38:09','2023-05-13 21:38:09'),(230,14,3,'2023-05-13 21:40:40','2023-05-13 21:40:40'),(231,14,4,'2023-05-13 21:40:40','2023-05-13 21:40:40'),(232,14,5,'2023-05-13 21:40:40','2023-05-13 21:40:40'),(233,14,9,'2023-05-13 21:40:40','2023-05-13 21:40:40'),(234,14,10,'2023-05-13 21:40:40','2023-05-13 21:40:40'),(235,14,12,'2023-05-13 21:40:40','2023-05-13 21:40:40'),(236,14,15,'2023-05-13 21:40:40','2023-05-13 21:40:40'),(237,14,11,'2023-05-13 21:40:40','2023-05-13 21:40:40'),(238,14,8,'2023-05-13 21:40:40','2023-05-13 21:40:40'),(242,17,3,'2023-05-13 21:43:03','2023-05-13 21:43:03'),(243,17,8,'2023-05-13 21:43:03','2023-05-13 21:43:03'),(244,17,4,'2023-05-13 21:43:03','2023-05-13 21:43:03'),(245,17,5,'2023-05-13 21:43:03','2023-05-13 21:43:03'),(246,17,9,'2023-05-13 21:43:03','2023-05-13 21:43:03'),(247,17,11,'2023-05-13 21:43:03','2023-05-13 21:43:03'),(248,17,1,'2023-05-13 21:43:03','2023-05-13 21:43:03'),(277,10,1,'2023-05-13 21:54:06','2023-05-13 21:54:06'),(278,10,12,'2023-05-13 21:54:06','2023-05-13 21:54:06'),(279,10,13,'2023-05-13 21:54:06','2023-05-13 21:54:06'),(280,10,14,'2023-05-13 21:54:06','2023-05-13 21:54:06'),(281,10,15,'2023-05-13 21:54:06','2023-05-13 21:54:06'),(282,10,11,'2023-05-13 21:54:06','2023-05-13 21:54:06'),(283,10,5,'2023-05-13 21:54:06','2023-05-13 21:54:06'),(284,10,9,'2023-05-13 21:54:06','2023-05-13 21:54:06'),(285,10,8,'2023-05-13 21:54:06','2023-05-13 21:54:06'),(286,10,4,'2023-05-13 21:54:06','2023-05-13 21:54:06'),(287,10,7,'2023-05-13 21:54:06','2023-05-13 21:54:06'),(288,10,3,'2023-05-13 21:54:06','2023-05-13 21:54:06'),(289,10,10,'2023-05-13 21:54:06','2023-05-13 21:54:06'),(290,10,6,'2023-05-13 21:54:06','2023-05-13 21:54:06'),(520,11,1,'2023-06-01 22:23:12','2023-06-01 22:23:12'),(521,11,12,'2023-06-01 22:23:12','2023-06-01 22:23:12'),(522,11,13,'2023-06-01 22:23:12','2023-06-01 22:23:12'),(523,11,14,'2023-06-01 22:23:12','2023-06-01 22:23:12'),(524,11,15,'2023-06-01 22:23:12','2023-06-01 22:23:12'),(525,11,11,'2023-06-01 22:23:12','2023-06-01 22:23:12'),(526,12,3,'2023-06-01 22:23:50','2023-06-01 22:23:50'),(527,12,4,'2023-06-01 22:23:50','2023-06-01 22:23:50'),(528,12,5,'2023-06-01 22:23:50','2023-06-01 22:23:50'),(529,12,8,'2023-06-01 22:23:50','2023-06-01 22:23:50'),(530,12,9,'2023-06-01 22:23:50','2023-06-01 22:23:50'),(531,12,10,'2023-06-01 22:23:50','2023-06-01 22:23:50'),(532,12,12,'2023-06-01 22:23:50','2023-06-01 22:23:50'),(533,12,15,'2023-06-01 22:23:50','2023-06-01 22:23:50'),(534,12,11,'2023-06-01 22:23:50','2023-06-01 22:23:50'),(601,22,4,'2023-10-06 13:42:26','2023-10-06 13:42:26'),(602,22,6,'2023-10-06 13:42:26','2023-10-06 13:42:26'),(603,22,10,'2023-10-06 13:42:26','2023-10-06 13:42:26'),(604,22,9,'2023-10-06 13:42:26','2023-10-06 13:42:26'),(605,22,8,'2023-10-06 13:42:26','2023-10-06 13:42:26'),(606,22,7,'2023-10-06 13:42:26','2023-10-06 13:42:26'),(607,22,3,'2023-10-06 13:42:26','2023-10-06 13:42:26'),(608,22,1,'2023-10-06 13:42:26','2023-10-06 13:42:26'),(609,22,12,'2023-10-06 13:42:26','2023-10-06 13:42:26'),(610,22,13,'2023-10-06 13:42:26','2023-10-06 13:42:26'),(611,22,14,'2023-10-06 13:42:26','2023-10-06 13:42:26'),(612,22,15,'2023-10-06 13:42:26','2023-10-06 13:42:26'),(613,22,23,'2023-10-06 13:42:26','2023-10-06 13:42:26'),(614,22,25,'2023-10-06 13:42:26','2023-10-06 13:42:26'),(615,22,11,'2023-10-06 13:42:26','2023-10-06 13:42:26'),(638,25,3,'2023-11-09 23:24:45','2023-11-09 23:24:45'),(639,25,7,'2023-11-09 23:24:45','2023-11-09 23:24:45'),(640,25,4,'2023-11-09 23:24:45','2023-11-09 23:24:45'),(641,25,8,'2023-11-09 23:24:45','2023-11-09 23:24:45'),(660,29,4,'2023-11-18 22:47:19','2023-11-18 22:47:19'),(661,29,8,'2023-11-18 22:47:19','2023-11-18 22:47:19'),(662,29,9,'2023-11-18 22:47:19','2023-11-18 22:47:19'),(663,29,5,'2023-11-18 22:47:19','2023-11-18 22:47:19'),(664,8,1,'2023-11-18 22:48:18','2023-11-18 22:48:18'),(665,8,8,'2023-11-18 22:48:18','2023-11-18 22:48:18'),(666,8,4,'2023-11-18 22:48:18','2023-11-18 22:48:18'),(667,1,3,'2023-12-31 20:27:48','2023-12-31 20:27:48'),(668,1,7,'2023-12-31 20:27:48','2023-12-31 20:27:48'),(669,1,8,'2023-12-31 20:27:48','2023-12-31 20:27:48'),(670,1,5,'2023-12-31 20:27:48','2023-12-31 20:27:48'),(671,1,9,'2023-12-31 20:27:48','2023-12-31 20:27:48'),(672,1,6,'2023-12-31 20:27:48','2023-12-31 20:27:48'),(673,1,1,'2023-12-31 20:27:48','2023-12-31 20:27:48'),(674,1,12,'2023-12-31 20:27:48','2023-12-31 20:27:48'),(675,1,13,'2023-12-31 20:27:48','2023-12-31 20:27:48'),(676,1,14,'2023-12-31 20:27:48','2023-12-31 20:27:48'),(677,1,15,'2023-12-31 20:27:48','2023-12-31 20:27:48'),(678,1,23,'2023-12-31 20:27:48','2023-12-31 20:27:48'),(679,1,11,'2023-12-31 20:27:48','2023-12-31 20:27:48'),(680,1,10,'2023-12-31 20:27:48','2023-12-31 20:27:48'),(681,1,25,'2023-12-31 20:27:48','2023-12-31 20:27:48'),(682,1,4,'2023-12-31 20:27:48','2023-12-31 20:27:48'),(683,1,26,'2023-12-31 20:27:48','2023-12-31 20:27:48');
/*!40000 ALTER TABLE `lien_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `liens`
--

DROP TABLE IF EXISTS `liens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `liens` (
  `IDLien` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `url` varchar(255) DEFAULT NULL,
  `root` varchar(255) DEFAULT NULL,
  `nomUrl` varchar(255) DEFAULT NULL,
  `icon` varchar(255) DEFAULT NULL,
  `parent` int(11) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`IDLien`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `liens`
--

LOCK TABLES `liens` WRITE;
/*!40000 ALTER TABLE `liens` DISABLE KEYS */;
INSERT INTO `liens` VALUES (1,'/users','/users','Gestion Utilisateurs','fa fa-user-md',11,1,NULL,NULL),(3,'/planingue','/planingue','Planingue','fa fa-calendar',NULL,1,NULL,NULL),(4,'/accueil','/accueil','Accueil','fa fa-home',NULL,1,NULL,NULL),(5,'/paiement','/paiement','Paiement','fas fa-usd',NULL,1,NULL,NULL),(6,'/compte-rendu','/compte-rendu','Compte Rendu','fa fa-heartbeat ',NULL,1,NULL,NULL),(7,'/resultats','/resultats','Resultats','fa fa-folder',NULL,1,NULL,NULL),(8,'/historique','/historique','Historique','fa fa-history',NULL,1,NULL,NULL),(9,'/reporting','/reporting','Reporting','fa fa-file-word',NULL,1,NULL,NULL),(10,'/facturation','/facturation','Facturation','fa fa-calculator',NULL,1,NULL,NULL),(11,'',NULL,'Administration','fa fa-cogs',NULL,2,NULL,NULL),(12,'admin/produit','/admin/produit','Produit','fa fa-cog',11,1,NULL,NULL),(13,'/cp','/cp','Class produit','fa fa-cog',11,1,NULL,NULL),(14,'/crm','/crm','Modèles Compte Rendu','fa fa-cog',11,1,NULL,NULL),(15,'/service','/service','Service','fa fa-cog',11,1,NULL,NULL),(23,'/etude','/etude','Etude','fa fa-cog',11,1,NULL,NULL),(25,'/antecedent','/antecedent','Antecedent','fa fa-cog',11,1,NULL,NULL),(26,'/shift','/shift','Horaire des quarts','fa fa-cog',11,1,NULL,NULL);
/*!40000 ALTER TABLE `liens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'2014_10_12_000000_create_users_table',1),(2,'2014_10_12_100000_create_password_resets_table',1),(3,'2019_08_19_000000_create_failed_jobs_table',1),(4,'2019_12_14_000001_create_personal_access_tokens_table',1),(5,'2023_01_09_140950_create_antecedents_table',1),(6,'2023_01_09_141448_create_classe_produits_table',1),(7,'2023_01_09_212444_create_compte_rendus_table',1),(8,'2023_01_14_202019_create_conventions_table',1),(9,'2023_01_14_223332_create_etudes_table',1),(10,'2023_01_14_223549_create_examens_table',1),(11,'2023_01_14_224017_create_paiements_table',1),(12,'2023_01_14_224736_create_patients_table',1),(13,'2023_01_17_100148_create_prescripteurs_table',1),(14,'2023_01_17_100417_create_prix_exams_table',1),(15,'2023_01_17_101649_create_prix_produits_table',1),(16,'2023_01_17_102832_create_produits_table',1),(17,'2023_01_17_103329_create_r_d_v_s_table',1),(18,'2023_01_17_104254_create_services_table',1),(19,'2023_01_17_104536_create_wilayas_table',1),(20,'2023_01_17_105231_create_user_metiers_table',1),(21,'2023_01_17_110228_create_validation_c_r_s_table',1),(22,'2023_01_17_135141_create_clients_table',1),(23,'2023_01_17_135211_add_colume_foreign_key_convention_table',1),(24,'2023_01_17_135350_add_colume_foreign_key_users_table',1),(25,'2023_01_17_140532_add_colume_foreign_key_prix_produits_table',1),(26,'2023_01_17_141508_add_colume_foreign_key_produits_table',1),(27,'2023_01_17_141718_add_colume_foreign_key_patients_table',1),(28,'2023_01_17_141912_add_colume_foreign_key_rdv_table',1),(29,'2023_01_17_142151_add_colume_foreign_key_prix_exam_table',1),(30,'2023_01_17_142734_add_colume_foreign_key_examen_table',1),(31,'2023_01_17_144255_add_colume_foreign_key_compte_rendus_table',1),(32,'2023_01_17_145135_add_colume_foreign_key_validation_c_r_table',1),(33,'2023_01_17_145404_add_colume_foreign_key_paiements_table',1),(34,'2023_01_24_123629_create_liens_table',1),(35,'2023_01_24_123645_create_lien_users_table',1),(37,'2023_05_15_193715_create_compte_rendu_models_table',2),(38,'2023_05_29_223253_create_antecedent_examens_table',3),(41,'2023_06_01_212952_add_service_id_to_etude_table',4),(42,'2023_06_10_005241_create_antecedant_examen_table',5),(43,'2023_06_10_224948_create_caisses_table',6),(44,'2023_06_10_230220_create_versements_table',7),(45,'2023_06_10_230826_create_etat_caisses_table',7),(46,'2023_10_11_210324_create_shifts_table',8),(47,'2023_10_12_220341_add_colume_foreign_key_shift_id',8),(48,'2023_10_21_215901_create_days_table',9),(49,'2023_10_21_220234_create_hours_table',9),(50,'2023_10_21_220312_create_day_hour_shifts_table',9),(53,'2023_11_17_235005_create_mode_paiements_table',10),(54,'2024_02_03_194408_add_colume_tva_caisses_table',11),(55,'0001_01_01_000000_create_users_table',12),(56,'0001_01_01_000001_create_cache_table',12),(57,'0001_01_01_000002_create_jobs_table',13);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mode_paiements`
--

DROP TABLE IF EXISTS `mode_paiements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mode_paiements` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `etude_id` bigint(20) unsigned NOT NULL,
  `shift_id` bigint(20) unsigned NOT NULL,
  `service_id` int(11) NOT NULL,
  `pourcentage` int(11) NOT NULL,
  `pourcentageSRV` int(11) DEFAULT NULL,
  `value` int(11) NOT NULL,
  `valueSRV` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `mode_paiements_user_id_foreign` (`user_id`),
  KEY `mode_paiements_etude_id_foreign` (`etude_id`),
  KEY `mode_paiements_shift_id_foreign` (`shift_id`),
  CONSTRAINT `mode_paiements_etude_id_foreign` FOREIGN KEY (`etude_id`) REFERENCES `etudes` (`IDEtude`),
  CONSTRAINT `mode_paiements_shift_id_foreign` FOREIGN KEY (`shift_id`) REFERENCES `shifts` (`IDShift`),
  CONSTRAINT `mode_paiements_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mode_paiements`
--

LOCK TABLES `mode_paiements` WRITE;
/*!40000 ALTER TABLE `mode_paiements` DISABLE KEYS */;
INSERT INTO `mode_paiements` VALUES (13,29,39,7,1,1,1,15,15,'2023-11-18 22:47:19','2023-11-18 22:47:19'),(14,29,39,8,1,1,1,20,30,'2023-11-18 22:47:19','2023-11-18 22:47:19'),(15,29,42,7,1,0,1,600,15,'2023-11-18 22:47:19','2023-11-18 22:47:19'),(16,29,42,8,1,0,1,800,30,'2023-11-18 22:47:19','2023-11-18 22:47:19'),(17,29,43,7,1,0,1,150,15,'2023-11-18 22:47:19','2023-11-18 22:47:19'),(18,29,43,8,1,0,1,200,30,'2023-11-18 22:47:19','2023-11-18 22:47:19'),(19,29,40,7,3,1,0,20,20,'2023-11-18 22:47:19','2023-11-18 22:47:19'),(20,29,40,8,3,1,0,250,25,'2023-11-18 22:47:19','2023-11-18 22:47:19'),(21,29,41,7,4,0,0,600,600,'2023-11-18 22:47:19','2023-11-18 22:47:19'),(22,29,41,8,4,0,0,1000,1000,'2023-11-18 22:47:19','2023-11-18 22:47:19'),(23,29,45,7,4,1,0,8,600,'2023-11-18 22:47:19','2023-11-18 22:47:19'),(24,29,45,8,4,1,0,12,1000,'2023-11-18 22:47:19','2023-11-18 22:47:19'),(25,8,39,7,1,1,1,10,10,'2023-11-18 22:48:18','2023-11-18 22:48:18'),(26,8,39,8,1,1,1,15,15,'2023-11-18 22:48:18','2023-11-18 22:48:18'),(27,8,42,7,1,1,1,10,10,'2023-11-18 22:48:18','2023-11-18 22:48:18'),(28,8,42,8,1,1,1,15,15,'2023-11-18 22:48:18','2023-11-18 22:48:18'),(29,8,43,7,1,1,1,10,10,'2023-11-18 22:48:18','2023-11-18 22:48:18'),(30,8,43,8,1,1,1,15,15,'2023-11-18 22:48:18','2023-11-18 22:48:18'),(31,1,39,7,1,1,1,10,10,'2023-12-31 20:27:48','2023-12-31 20:27:48'),(32,1,39,8,1,1,1,15,15,'2023-12-31 20:27:48','2023-12-31 20:27:48'),(33,1,42,7,1,1,1,10,10,'2023-12-31 20:27:48','2023-12-31 20:27:48'),(34,1,42,8,1,1,1,20,15,'2023-12-31 20:27:48','2023-12-31 20:27:48'),(35,1,43,7,1,1,1,10,10,'2023-12-31 20:27:48','2023-12-31 20:27:48'),(36,1,43,8,1,1,1,15,15,'2023-12-31 20:27:48','2023-12-31 20:27:48');
/*!40000 ALTER TABLE `mode_paiements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `paiements`
--

DROP TABLE IF EXISTS `paiements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `paiements` (
  `IDPaiement` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `datePaiement` date DEFAULT NULL,
  `montantantVerserment` decimal(10,2) DEFAULT NULL,
  `UIPaiement` int(11) DEFAULT NULL,
  `etatPaiement` int(11) DEFAULT NULL,
  `remisePourcent` int(11) DEFAULT NULL,
  `remiseMontant` decimal(10,0) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `caisse_id` bigint(20) unsigned DEFAULT NULL,
  `examen_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`IDPaiement`),
  KEY `paiements_caisses_FK` (`caisse_id`),
  KEY `paiements_examens_FK` (`examen_id`),
  CONSTRAINT `paiements_caisses_FK` FOREIGN KEY (`caisse_id`) REFERENCES `caisses` (`IDCaisse`),
  CONSTRAINT `paiements_examens_FK` FOREIGN KEY (`examen_id`) REFERENCES `examens` (`IDExamen`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `paiements`
--

LOCK TABLES `paiements` WRITE;
/*!40000 ALTER TABLE `paiements` DISABLE KEYS */;
INSERT INTO `paiements` VALUES (39,NULL,4000.00,NULL,NULL,NULL,0,'2024-01-30 20:50:46','2024-01-30 20:50:46',37,64),(40,NULL,2600.00,NULL,NULL,NULL,500,'2024-02-01 23:36:55','2024-02-01 23:36:55',38,65),(41,NULL,4000.00,NULL,NULL,NULL,0,'2024-02-01 23:36:55','2024-02-01 23:36:55',38,66),(42,NULL,5000.00,NULL,NULL,10,500,'2024-02-02 22:41:04','2024-02-02 22:41:04',39,67),(43,NULL,7600.00,NULL,NULL,NULL,0,'2024-02-03 00:02:32','2024-02-03 00:02:32',40,68),(44,NULL,5000.00,NULL,NULL,NULL,100,'2024-02-03 00:02:32','2024-02-03 00:02:32',40,69),(45,NULL,5000.00,NULL,NULL,NULL,0,'2024-02-03 20:11:50','2024-02-03 20:11:50',41,70),(46,NULL,5000.00,NULL,NULL,NULL,0,'2024-02-14 21:16:28','2024-02-14 21:16:28',42,71),(47,NULL,6000.00,NULL,NULL,NULL,0,'2024-02-14 21:16:28','2024-02-14 21:16:28',42,72),(48,NULL,3200.00,NULL,NULL,NULL,0,'2024-09-01 10:55:53','2024-09-01 10:55:53',43,73),(49,NULL,1200.00,NULL,NULL,NULL,0,'2024-09-04 07:05:39','2024-09-04 07:05:39',44,74),(50,NULL,3000.00,NULL,NULL,NULL,0,'2024-09-04 07:06:31','2024-09-04 07:06:31',45,75),(51,NULL,6000.00,NULL,NULL,NULL,500,'2024-09-06 21:22:16','2024-09-06 21:22:16',46,76),(52,NULL,2600.00,NULL,NULL,NULL,0,'2024-11-18 19:43:43','2024-11-18 19:43:43',47,77),(53,NULL,4000.00,NULL,NULL,5,200,'2025-03-07 23:24:57','2025-03-07 23:24:57',48,78);
/*!40000 ALTER TABLE `paiements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_resets`
--

DROP TABLE IF EXISTS `password_resets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `password_resets` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_resets`
--

LOCK TABLES `password_resets` WRITE;
/*!40000 ALTER TABLE `password_resets` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_resets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patients`
--

DROP TABLE IF EXISTS `patients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patients` (
  `IDPatient` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nomP` varchar(255) DEFAULT NULL,
  `prenomP` varchar(255) DEFAULT NULL,
  `naisP` date DEFAULT NULL,
  `sexeP` int(11) DEFAULT NULL,
  `telP1` varchar(15) DEFAULT NULL,
  `telP2` varchar(15) DEFAULT NULL,
  `UIPatien` int(11) DEFAULT NULL,
  `etatP` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `wilaya_id` bigint(20) unsigned DEFAULT NULL,
  `observation` text DEFAULT NULL,
  PRIMARY KEY (`IDPatient`),
  KEY `patients_wilaya_id_foreign` (`wilaya_id`),
  CONSTRAINT `patients_wilaya_id_foreign` FOREIGN KEY (`wilaya_id`) REFERENCES `wilayas` (`IDWilaya`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patients`
--

LOCK TABLES `patients` WRITE;
/*!40000 ALTER TABLE `patients` DISABLE KEYS */;
INSERT INTO `patients` VALUES (3,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,'2023-06-09 23:38:26','2023-06-09 23:38:26',NULL,NULL),(4,'Placeat corrupti a','Sed harum illo lorem','1955-03-08',2,'0555012021',NULL,1,NULL,'2023-06-09 23:42:02','2023-06-09 23:42:02',13,'Est commodi quia iur'),(5,'Nostrum beatae ea pr','Amet sed in sit re','2013-11-12',2,'0555252525',NULL,1,NULL,'2023-06-11 21:22:05','2023-06-11 21:22:05',18,'Dolorum molestias om'),(6,'Et maiores officia i','Nisi distinctio Mol','2022-10-16',1,'+1 (128) 56',NULL,1,NULL,'2023-06-11 21:28:35','2023-06-11 21:28:35',33,'Quo possimus except'),(7,'REKIM','zaide','2019-02-05',1,'0554545401',NULL,1,NULL,'2023-06-21 21:08:18','2024-11-18 19:44:31',4,'b kjhg lkjh jhkmljh piukblkjbl kjh'),(8,'Nostrud proident qu','Voluptate voluptatem','2012-01-29',1,'571-9565',NULL,1,NULL,'2023-07-03 19:34:12','2023-07-03 19:34:12',19,'Aliqua Architecto a'),(9,'REKIM','Mohamed','1984-06-05',1,'0676902987',NULL,1,NULL,'2023-07-03 19:51:19','2024-09-06 21:23:09',18,'arf egegerg zerg ezr'),(10,'sassi','ahmed','1988-05-05',1,'0676902987',NULL,1,NULL,'2023-07-03 20:09:01','2023-07-03 20:09:01',14,'dsf qfqzef qzef'),(11,'Eveniet sunt quis q','Possimus labore fug','2002-05-27',1,'0407-6915',NULL,1,NULL,'2023-07-03 20:12:34','2023-07-03 20:12:34',11,'Quis ad aute distinc'),(12,'Culpa non in quisqu','Qui sequi fugiat par','1979-10-31',2,'0163-3156',NULL,1,NULL,'2023-07-03 20:13:37','2023-07-03 20:13:37',33,'Aliquid temporibus d'),(13,'Est deserunt volupt','Recusandae Quos qui','1976-08-15',1,'0469-3342',NULL,1,NULL,'2023-07-03 20:16:27','2023-07-03 20:16:27',1,'Odit blanditiis vel'),(14,'zoubir','zayd','1993-06-10',1,'0553448460',NULL,1,NULL,'2023-10-06 14:29:29','2024-04-19 21:48:43',11,NULL),(15,'boujemia','said','1999-05-05',1,'0653535252',NULL,1,NULL,'2024-01-26 21:30:21','2024-01-26 21:30:21',20,NULL);
/*!40000 ALTER TABLE `patients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personal_access_tokens`
--

DROP TABLE IF EXISTS `personal_access_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personal_access_tokens`
--

LOCK TABLES `personal_access_tokens` WRITE;
/*!40000 ALTER TABLE `personal_access_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `personal_access_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prescripteurs`
--

DROP TABLE IF EXISTS `prescripteurs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prescripteurs` (
  `IDPrescripteur` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nomP` varchar(255) DEFAULT NULL,
  `UIP` int(11) DEFAULT NULL,
  `etatP` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`IDPrescripteur`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prescripteurs`
--

LOCK TABLES `prescripteurs` WRITE;
/*!40000 ALTER TABLE `prescripteurs` DISABLE KEYS */;
/*!40000 ALTER TABLE `prescripteurs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prix_exams`
--

DROP TABLE IF EXISTS `prix_exams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prix_exams` (
  `IDPrixExam` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `montantPrixExam` decimal(10,2) DEFAULT NULL,
  `UIPrixExam` int(11) DEFAULT NULL,
  `etatPrixExam` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `etude_id` bigint(20) unsigned DEFAULT NULL,
  `shift_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`IDPrixExam`),
  KEY `prix_exams_etude_id_foreign` (`etude_id`),
  KEY `prix_exams_shift_id_foreign` (`shift_id`),
  CONSTRAINT `prix_exams_etude_id_foreign` FOREIGN KEY (`etude_id`) REFERENCES `etudes` (`IDEtude`),
  CONSTRAINT `prix_exams_shift_id_foreign` FOREIGN KEY (`shift_id`) REFERENCES `shifts` (`IDShift`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prix_exams`
--

LOCK TABLES `prix_exams` WRITE;
/*!40000 ALTER TABLE `prix_exams` DISABLE KEYS */;
INSERT INTO `prix_exams` VALUES (27,3000.00,1,1,'2023-10-29 21:33:36','2023-11-11 22:40:56',40,7),(28,4500.00,1,1,'2023-10-29 21:33:36','2023-11-11 22:40:56',40,8),(29,3000.00,1,1,'2023-10-29 21:34:34','2023-10-29 21:34:34',40,7),(30,4500.00,1,1,'2023-10-29 21:34:34','2023-10-29 21:34:34',40,8),(31,5000.00,1,1,'2023-10-29 21:35:00','2025-03-24 22:03:49',41,7),(32,7000.00,1,1,'2023-10-29 21:35:00','2025-03-24 22:03:49',41,8),(33,1200.00,1,1,'2023-11-17 20:35:23','2023-11-17 20:35:23',42,7),(34,4000.00,1,1,'2023-11-17 20:35:23','2023-11-17 20:35:23',42,8),(35,1000.00,1,1,'2023-11-17 20:35:53','2023-11-17 20:35:53',43,7),(36,1600.00,1,1,'2023-11-17 20:35:53','2023-11-17 20:35:53',43,8),(39,2000.00,1,1,'2023-11-17 20:39:30','2023-11-17 20:39:30',45,7),(40,3000.00,1,1,'2023-11-17 20:39:31','2023-11-17 20:39:31',45,8),(41,1200.00,NULL,NULL,'2025-03-24 21:43:07','2025-03-24 21:43:07',NULL,7),(42,2000.00,NULL,NULL,'2025-03-24 21:43:07','2025-03-24 21:43:07',NULL,8),(43,1200.00,NULL,NULL,'2025-03-24 21:43:07','2025-03-24 21:43:07',NULL,9),(47,5000.00,NULL,NULL,'2025-03-24 21:50:17','2025-03-24 21:50:17',53,7),(48,5500.00,NULL,NULL,'2025-03-24 21:50:17','2025-03-24 21:50:17',53,8),(49,6000.00,NULL,NULL,'2025-03-24 21:50:17','2025-03-24 21:50:17',53,9),(50,3000.00,1,1,'2025-03-24 22:03:49','2025-03-24 22:05:24',41,9),(51,2000.00,1,1,'2025-03-24 22:06:20','2025-03-24 22:06:20',51,7),(52,3000.00,1,1,'2025-03-24 22:06:20','2025-03-24 22:06:20',51,8),(53,1500.00,1,1,'2025-03-24 22:06:20','2025-03-24 22:06:20',51,9);
/*!40000 ALTER TABLE `prix_exams` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prix_produits`
--

DROP TABLE IF EXISTS `prix_produits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prix_produits` (
  `IDPrixProduit` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `prixP` decimal(10,2) DEFAULT NULL,
  `UIPrixP` int(11) DEFAULT NULL,
  `etatPrixP` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `produit_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`IDPrixProduit`),
  KEY `prix_produits_produit_id_foreign` (`produit_id`),
  CONSTRAINT `prix_produits_produit_id_foreign` FOREIGN KEY (`produit_id`) REFERENCES `produits` (`IDProduit`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prix_produits`
--

LOCK TABLES `prix_produits` WRITE;
/*!40000 ALTER TABLE `prix_produits` DISABLE KEYS */;
INSERT INTO `prix_produits` VALUES (4,1500.00,NULL,NULL,'2023-05-19 00:28:00','2023-05-19 00:28:00',4),(5,1200.00,NULL,NULL,'2023-05-19 00:28:11','2023-05-19 00:28:11',4),(6,1000.00,NULL,NULL,'2023-05-19 00:29:27','2023-05-19 00:29:27',4),(7,5000.00,NULL,NULL,'2023-10-06 13:49:26','2023-10-06 13:49:26',5),(8,NULL,NULL,NULL,'2025-02-23 21:42:26','2025-02-23 21:42:26',6),(9,123456.00,NULL,NULL,'2025-02-23 21:45:15','2025-02-23 21:45:15',7),(10,12500.00,NULL,NULL,'2025-02-23 21:54:06','2025-02-23 21:54:06',6),(11,2000.00,NULL,NULL,'2025-02-27 19:55:29','2025-02-27 19:55:29',4),(12,123654.00,NULL,NULL,'2025-02-27 20:19:16','2025-02-27 20:19:16',8),(13,123654.00,NULL,NULL,'2025-02-27 20:20:27','2025-02-27 20:20:27',9),(14,1252.00,NULL,NULL,'2025-02-27 20:24:32','2025-02-27 20:24:32',10),(15,3000.00,NULL,NULL,'2025-02-27 20:27:01','2025-02-27 20:27:01',4),(16,120.00,NULL,NULL,'2025-02-28 00:01:29','2025-02-28 00:01:29',11),(17,132.00,NULL,NULL,'2025-02-28 00:13:47','2025-02-28 00:13:47',12),(18,5000.00,NULL,NULL,'2025-02-28 00:24:56','2025-02-28 00:24:56',13),(19,1000.00,NULL,NULL,'2025-02-28 00:26:59','2025-02-28 00:26:59',14),(20,2000.00,NULL,NULL,'2025-02-28 00:32:54','2025-02-28 00:32:54',5),(21,2300.00,NULL,NULL,'2025-03-03 15:52:10','2025-03-03 15:52:10',4);
/*!40000 ALTER TABLE `prix_produits` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produits`
--

DROP TABLE IF EXISTS `produits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `produits` (
  `IDProduit` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `libelleProduit` varchar(255) DEFAULT NULL,
  `UIProduit` int(11) DEFAULT NULL,
  `etatProduit` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `class_produit_id` bigint(20) unsigned DEFAULT NULL,
  `prix_afficher` decimal(10,2) DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`IDProduit`),
  KEY `produits_class_produit_id_foreign` (`class_produit_id`),
  CONSTRAINT `produits_class_produit_id_foreign` FOREIGN KEY (`class_produit_id`) REFERENCES `classe_produits` (`IDClasseProduit`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produits`
--

LOCK TABLES `produits` WRITE;
/*!40000 ALTER TABLE `produits` DISABLE KEYS */;
INSERT INTO `produits` VALUES (4,'Goutte 0122',1,1,'2023-05-19 00:28:00','2025-03-06 19:36:08',3,2300.00,NULL),(5,'GADO',1,1,'2023-10-06 13:49:26','2025-02-28 00:34:27',3,2000.00,NULL),(6,'produit update',1,1,'2025-02-23 21:42:26','2025-02-24 20:37:48',12,12500.00,'2025-02-24 20:37:48'),(7,'produit 123',1,1,'2025-02-23 21:45:15','2025-02-27 20:26:37',5,123456.00,'2025-02-27 20:26:37'),(8,'rteyt',1,1,'2025-02-27 20:19:16','2025-02-27 20:22:43',3,123654.00,'2025-02-27 20:22:43'),(9,'rteyt',1,1,'2025-02-27 20:20:27','2025-02-27 20:21:20',3,123654.00,'2025-02-27 20:21:20'),(10,'dsqd',1,1,'2025-02-27 20:24:32','2025-02-27 20:24:52',5,1252.00,'2025-02-27 20:24:52'),(11,'sdfsdf',1,1,'2025-02-28 00:01:29','2025-02-28 00:01:29',5,120.00,NULL),(12,'qsdqsdqs',1,1,'2025-02-28 00:13:47','2025-03-06 19:35:58',12,132.00,NULL),(13,'mohamed rekim',1,1,'2025-02-28 00:24:56','2025-02-28 00:27:49',13,5000.00,'2025-02-28 00:27:49'),(14,'zaid',1,1,'2025-02-28 00:26:59','2025-02-28 00:27:39',8,1000.00,'2025-02-28 00:27:39');
/*!40000 ALTER TABLE `produits` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rdv`
--

DROP TABLE IF EXISTS `rdv`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rdv` (
  `IDRDV` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `dateRDV` date DEFAULT NULL,
  `heurRDV` time DEFAULT NULL,
  `obsRDV` text DEFAULT NULL,
  `UIRDV` int(11) DEFAULT NULL,
  `etatRDV` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `examen_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`IDRDV`),
  KEY `rdv_examen_id_foreign` (`examen_id`),
  CONSTRAINT `rdv_examen_id_foreign` FOREIGN KEY (`examen_id`) REFERENCES `examens` (`IDExamen`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rdv`
--

LOCK TABLES `rdv` WRITE;
/*!40000 ALTER TABLE `rdv` DISABLE KEYS */;
/*!40000 ALTER TABLE `rdv` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `services`
--

DROP TABLE IF EXISTS `services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `services` (
  `IDService` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `libelleService` varchar(255) DEFAULT NULL,
  `UIService` int(11) DEFAULT NULL,
  `etatService` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`IDService`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `services`
--

LOCK TABLES `services` WRITE;
/*!40000 ALTER TABLE `services` DISABLE KEYS */;
INSERT INTO `services` VALUES (1,'Radiologie Standard',1,1,'2023-05-19 08:11:01','2025-03-03 15:47:00'),(2,'Tomodensitométrie',1,1,'2023-05-19 08:11:51','2025-03-03 15:51:16'),(3,'Mammographie',1,1,'2023-05-19 08:11:59','2023-06-09 21:03:22'),(4,'IRM',1,1,'2023-05-19 08:12:06','2023-05-19 08:15:53'),(5,'DMO',1,1,'2023-05-19 08:12:13','2023-05-19 08:12:13'),(7,'X-Ray Angiography',1,1,'2023-05-19 08:12:31','2023-05-19 08:12:31');
/*!40000 ALTER TABLE `services` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
INSERT INTO `sessions` VALUES ('PWu31Bjh6uYWOOgtdn80XH8YbYofCRVgAtbpNb6x',1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36','YTo2OntzOjY6Il90b2tlbiI7czo0MDoiamRJNWtoekZlOG5aZ21BMTY4MVE4a1g3SDdMcmR5clpYNTdNcDBQTyI7czozOiJ1cmwiO2E6MDp7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjI3OiJodHRwOi8vMTI3LjAuMC4xOjgwMDAvZXR1ZGUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aToxO3M6MjI6IlBIUERFQlVHQkFSX1NUQUNLX0RBVEEiO2E6MDp7fX0=',1742857612);
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shifts`
--

DROP TABLE IF EXISTS `shifts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shifts` (
  `IDShift` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `libelleShift` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `etatShift` tinyint(1) DEFAULT NULL,
  `colorShift` varchar(10) NOT NULL,
  PRIMARY KEY (`IDShift`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shifts`
--

LOCK TABLES `shifts` WRITE;
/*!40000 ALTER TABLE `shifts` DISABLE KEYS */;
INSERT INTO `shifts` VALUES (7,'tarif de jour','2023-10-29 21:26:14','2025-03-16 20:33:24',1,'#1081f9'),(8,'tarif de nuit','2023-10-29 21:31:08','2025-03-08 11:25:44',1,'#1c9782'),(9,'ttttt','2024-09-01 10:59:19','2025-03-22 22:41:42',1,'#ee6dea');
/*!40000 ALTER TABLE `shifts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_metiers`
--

DROP TABLE IF EXISTS `user_metiers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_metiers` (
  `IDUserMetier` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `typeU` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`IDUserMetier`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_metiers`
--

LOCK TABLES `user_metiers` WRITE;
/*!40000 ALTER TABLE `user_metiers` DISABLE KEYS */;
INSERT INTO `user_metiers` VALUES (1,'ADMINISTRATEUR',NULL,NULL),(2,'MEDCIN',NULL,NULL),(3,'RADIOLOGUE',NULL,NULL),(4,'RECEPTIONNISTE',NULL,NULL),(5,'SECRETAIRE',NULL,NULL),(6,'TECHNICIEN',NULL,NULL);
/*!40000 ALTER TABLE `user_metiers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(255) DEFAULT NULL,
  `nom` varchar(255) DEFAULT NULL,
  `prenom` varchar(255) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `agence` varchar(255) DEFAULT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `userMeiter_id` bigint(20) unsigned DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `signature_medcin` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`),
  UNIQUE KEY `users_username_unique` (`username`),
  KEY `users_usermeiter_id_foreign` (`userMeiter_id`),
  CONSTRAINT `users_usermeiter_id_foreign` FOREIGN KEY (`userMeiter_id`) REFERENCES `user_metiers` (`IDUserMetier`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Mohamed REKIM','REKIM','1213213','admin@risv.dz',NULL,'$2y$12$IltQ8iOdKCSgF.U4BlxSrui7eihrtweH3xe4uufUPDp34ghZGDQGq',NULL,NULL,'2023-03-01 19:45:22','2025-02-02 10:27:57',NULL,2,1,NULL),(7,NULL,'mohma','rere','takab@mailinator.com',NULL,'$2y$10$Xw0azywENDUvIwFzYWHeWeUwTKIETSw86Y32yPTPLGgf4U.4qb0r2',NULL,NULL,'2023-04-28 23:24:32','2023-11-10 22:45:35',NULL,3,1,NULL),(8,NULL,'omar','omar','takab@mailisnator.com',NULL,'$2y$10$LxvCy1uV0xOHB1OAG/XXHuSGzb98A7kE6Hb0C.ETbjRTF9SkqMwMO',NULL,NULL,'2023-04-28 23:28:57','2023-11-18 22:48:18',NULL,3,1,NULL),(9,NULL,'iiiiii','In voluptates maiore','vyxipoku@mailinator.com',NULL,'$2y$10$8pnJ/szOdIyHzyyjHOBLSeooB.zw0esFAYGpAfmOM09wi7fsBDn6O',NULL,NULL,'2023-04-29 00:08:46','2023-05-13 22:14:14','2023-05-13 22:14:14',1,1,NULL),(10,NULL,'ssssss','qqqqqqq','admin2@risv.dz',NULL,'$2y$10$lxhZjKBVllIhGbxnkK54rO7R6O7uIEohQxopdQ1kdgkO2eAWW99K2',NULL,NULL,'2023-05-06 22:08:10','2023-05-13 22:14:02','2023-05-13 22:14:02',2,1,NULL),(11,NULL,'Consequuntur officii','Maiores quia magni a','hyly@mailinator.com',NULL,'$2y$10$QkF9I0mrrendMb9cpFTrx.nTsBSUbuxCtaCb5DrFfRSB4cNRVjfIG',NULL,NULL,'2023-05-12 22:15:28','2023-06-02 20:45:21',NULL,3,1,NULL),(12,NULL,'Doloribus quam quod','Eius consectetur al','xedyxu@mailinator.com',NULL,'$2y$10$cRX1Wfiwm9g0xsJJlKwNXeJ5.HpX9tepfDQL7cZc3M3UHTkJT1RGW',NULL,NULL,'2023-05-12 22:16:32','2023-06-01 22:24:16',NULL,3,1,NULL),(14,NULL,'Doloribus quam quod','Eius consectetur al','xedyxu@macilinator.com',NULL,'$2y$10$clZhKZwDGcMloZSRUCmAv.PTOeXqhzKQjAcJ0CeTcmsDqRNT0S2D.',NULL,NULL,'2023-05-12 22:17:12','2023-05-13 21:40:40',NULL,5,1,NULL),(15,NULL,'Doloribus quam quod','Eius consectetur al','xedyxu@maccator.com',NULL,'$2y$12$54UbNCBrZSgyo65PREdHp.nnRyQUtrV4B0tDEel9bdXs7UvBsrkYi',NULL,NULL,'2023-05-12 22:17:22','2025-02-20 22:53:55',NULL,3,1,NULL),(16,NULL,'Doloribus quam quod','Eius consectetur al','xedyxuc@ator.com',NULL,'$2y$10$ogVG1urtol4M72ACz0bjLOdbgvLggybDGXjUYX9PBhoH0onwdT30m',NULL,NULL,'2023-05-12 22:17:41','2023-05-12 22:17:41',NULL,NULL,1,NULL),(17,NULL,'REKIMsss','rerererssss','sg@mt.dz',NULL,'$2y$10$0FsiXkjUy0Sy4zZ3KY4QcOGyFoMdGBplEY3e5XAiyCr0C0ZWymc/K',NULL,NULL,'2023-05-13 21:00:27','2023-11-16 20:06:18',NULL,2,1,NULL),(21,NULL,'REKIM','dddddd','inf0002@cnr.dz',NULL,'$2y$12$lwMlPVflU6nyPNTKfqxfUe2QFn54ulpxFHBwImDH74SGT/TVPa/JG',NULL,NULL,'2023-05-13 21:04:34','2025-02-20 22:54:16',NULL,2,1,NULL),(22,NULL,'NACER','NACER','nacer@gmail.com',NULL,'$2y$10$7HgGE0po91lJIdOPO.2BnuUeF/de9dXRbm9XYmV.O3O9tjyqJn3Hi',NULL,NULL,'2023-10-06 13:41:04','2023-11-18 22:24:52',NULL,3,1,NULL),(25,NULL,'test 004','mohamed','takab@mailisnator22.com',NULL,'$2y$10$612HCBrKTrR1zXsdvA89du355rq895pvsFTt/bB1LW73VoWoLEuKq',NULL,NULL,'2023-11-09 23:22:13','2023-11-09 23:24:45',NULL,2,1,17),(27,NULL,'0000','0000','zay22d@risv.dz',NULL,'$2y$10$x5dU9DOMSCWxNZLBJxKcQel5fecFBVa4uyC70sD.PO2.nL5IBm18K',NULL,NULL,'2023-11-18 21:03:43','2023-11-18 22:19:16','2023-11-18 22:19:16',2,1,1),(29,NULL,'REKIM','zayd','zayd@risv.dz',NULL,'$2y$10$EfljBQMn4Tl7zvWzYaoow.OAxMSnb954y670/wYn8MNE9/oCXUQx.',NULL,NULL,'2023-11-18 22:22:02','2023-11-18 22:52:18',NULL,2,1,1);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `validationcr`
--

DROP TABLE IF EXISTS `validationcr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `validationcr` (
  `IDValidationCR` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `UIVCR` int(11) DEFAULT NULL,
  `etatVCR` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `compte_rendu_id` bigint(20) unsigned DEFAULT NULL,
  `examen_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`IDValidationCR`),
  KEY `validationcr_compte_rendu_id_foreign` (`compte_rendu_id`),
  KEY `validationcr_examen_id_foreign` (`examen_id`),
  CONSTRAINT `validationcr_compte_rendu_id_foreign` FOREIGN KEY (`compte_rendu_id`) REFERENCES `compte_rendus` (`IDCR`),
  CONSTRAINT `validationcr_examen_id_foreign` FOREIGN KEY (`examen_id`) REFERENCES `compte_rendus` (`examen_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `validationcr`
--

LOCK TABLES `validationcr` WRITE;
/*!40000 ALTER TABLE `validationcr` DISABLE KEYS */;
/*!40000 ALTER TABLE `validationcr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `versements`
--

DROP TABLE IF EXISTS `versements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `versements` (
  `IDVersement` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `versement` decimal(8,2) DEFAULT NULL,
  `UIVersement` int(11) DEFAULT NULL,
  `caisse_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`IDVersement`),
  KEY `versements_vcaisse_id_foreign` (`caisse_id`),
  CONSTRAINT `versements_vcaisse_id_foreign` FOREIGN KEY (`caisse_id`) REFERENCES `caisses` (`IDCaisse`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `versements`
--

LOCK TABLES `versements` WRITE;
/*!40000 ALTER TABLE `versements` DISABLE KEYS */;
INSERT INTO `versements` VALUES (1,5950.00,1,41,'2024-02-03 20:11:50','2024-02-03 20:11:50'),(2,3997.00,1,37,'2024-02-03 20:11:50','2024-02-03 20:11:50'),(3,6000.00,1,38,'2024-02-03 20:11:50','2024-02-03 20:11:50'),(4,4000.00,1,39,'2024-02-03 20:11:50','2024-02-03 20:11:50'),(5,12000.00,1,40,'2024-02-03 20:11:50','2024-02-03 20:11:50'),(9,100.00,1,40,'2024-02-03 22:50:55','2024-02-03 22:50:55'),(10,100.00,1,40,'2024-02-03 22:52:18','2024-02-03 22:52:18'),(11,300.00,1,40,'2024-02-03 22:52:50','2024-02-03 22:52:50'),(12,100.00,1,39,'2024-02-08 21:59:34','2024-02-08 21:59:34'),(13,100.00,1,39,'2024-02-08 21:59:47','2024-02-08 21:59:47'),(14,10000.00,1,42,'2024-02-14 21:16:28','2024-02-14 21:16:28'),(15,500.00,1,42,'2024-02-14 21:17:02','2024-02-14 21:17:02'),(16,200.00,1,42,'2024-02-14 21:17:15','2024-02-14 21:17:15'),(17,2000.00,1,42,'2024-02-14 21:17:31','2024-02-14 21:17:31'),(18,390.00,1,42,'2024-02-14 21:17:43','2024-02-14 21:17:43'),(19,3000.00,1,43,'2024-09-01 10:55:53','2024-09-01 10:55:53'),(20,200.00,1,43,'2024-09-04 06:56:47','2024-09-04 06:56:47'),(21,1100.00,1,44,'2024-09-04 07:05:39','2024-09-04 07:05:39'),(22,3500.00,1,45,'2024-09-04 07:06:31','2024-09-04 07:06:31'),(23,4000.00,1,46,'2024-09-06 21:22:16','2024-09-06 21:22:16'),(24,1500.00,1,46,'2024-09-06 21:22:29','2024-09-06 21:22:29'),(25,2000.00,1,47,'2024-11-18 19:43:43','2024-11-18 19:43:43'),(26,600.00,1,47,'2024-11-18 19:43:58','2024-11-18 19:43:58'),(27,4000.00,1,48,'2025-03-07 23:24:57','2025-03-07 23:24:57'),(28,500.00,1,48,'2025-03-07 23:25:44','2025-03-07 23:25:44'),(29,22.00,1,48,'2025-03-07 23:25:58','2025-03-07 23:25:58');
/*!40000 ALTER TABLE `versements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wilayas`
--

DROP TABLE IF EXISTS `wilayas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wilayas` (
  `IDWilaya` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nomWilaya` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `code` varchar(3) DEFAULT NULL,
  PRIMARY KEY (`IDWilaya`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wilayas`
--

LOCK TABLES `wilayas` WRITE;
/*!40000 ALTER TABLE `wilayas` DISABLE KEYS */;
INSERT INTO `wilayas` VALUES (1,'Adrar',NULL,NULL,'1'),(2,'Chlef',NULL,NULL,'2'),(3,'Laghouat',NULL,NULL,'3'),(4,'Oum El Bouaghi',NULL,NULL,'4'),(5,'Batna',NULL,NULL,'5'),(6,'Béjaïa',NULL,NULL,'6'),(7,'Biskra',NULL,NULL,'7'),(8,'Béchar',NULL,NULL,'8'),(9,'Blida',NULL,NULL,'9'),(10,'Bouira',NULL,NULL,'10'),(11,'Tamanrasset',NULL,NULL,'11'),(12,'Tébessa',NULL,NULL,'12'),(13,'Tlemcen',NULL,NULL,'13'),(14,'Tiaret',NULL,NULL,'14'),(15,'Tizi Ouzou',NULL,NULL,'15'),(16,'Alger',NULL,NULL,'16'),(17,'Djelfa',NULL,NULL,'17'),(18,'Jijel',NULL,NULL,'18'),(19,'Sétif',NULL,NULL,'19'),(20,'Saïda',NULL,NULL,'20'),(21,'Skikda',NULL,NULL,'21'),(22,'Sidi Bel Abbès',NULL,NULL,'22'),(23,'Annaba',NULL,NULL,'23'),(24,'Guelma',NULL,NULL,'24'),(25,'Constantine',NULL,NULL,'25'),(26,'Médéa',NULL,NULL,'26'),(27,'Mostaganem',NULL,NULL,'27'),(28,'M\'Sila',NULL,NULL,'28'),(29,'Mascara',NULL,NULL,'29'),(30,'Ouargla',NULL,NULL,'30'),(31,'Oran',NULL,NULL,'31'),(32,'El Bayadh',NULL,NULL,'32'),(33,'Illizi',NULL,NULL,'33'),(34,'Bordj Bou Arreridj',NULL,NULL,'34'),(35,'Boumerdès',NULL,NULL,'35'),(36,'El Tarf',NULL,NULL,'36'),(37,'Tindouf',NULL,NULL,'37'),(38,'Tissemsilt',NULL,NULL,'38'),(39,'El Oued',NULL,NULL,'39'),(40,'Khenchela',NULL,NULL,'40'),(41,'Souk Ahras',NULL,NULL,'41'),(42,'Tipaza',NULL,NULL,'42'),(43,'Mila',NULL,NULL,'43'),(44,'Aïn Defla',NULL,NULL,'44'),(45,'Naâma',NULL,NULL,'45'),(46,'Aïn Témouchent',NULL,NULL,'46'),(47,'Ghardaïa',NULL,NULL,'47'),(48,'Relizane',NULL,NULL,'48');
/*!40000 ALTER TABLE `wilayas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'risv'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-04-09 22:02:37
