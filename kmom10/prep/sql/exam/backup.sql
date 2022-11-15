-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: exam
-- ------------------------------------------------------
-- Server version	8.0.19

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
-- Current Database: `exam`
--

/*!40000 DROP DATABASE IF EXISTS `exam`*/;

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `exam` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `exam`;

--
-- Table structure for table `artist`
--

DROP TABLE IF EXISTS `artist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `artist` (
  `artist_id` varchar(15) COLLATE utf8_swedish_ci NOT NULL,
  `artist_namn` varchar(45) COLLATE utf8_swedish_ci DEFAULT NULL,
  `artist_ort` varchar(100) COLLATE utf8_swedish_ci DEFAULT NULL,
  `artist_landskod` varchar(15) COLLATE utf8_swedish_ci DEFAULT NULL,
  PRIMARY KEY (`artist_id`),
  KEY `artist_landskod` (`artist_landskod`),
  CONSTRAINT `artist_ibfk_1` FOREIGN KEY (`artist_landskod`) REFERENCES `landskod` (`kod`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `artist`
--

LOCK TABLES `artist` WRITE;
/*!40000 ALTER TABLE `artist` DISABLE KEYS */;
INSERT INTO `artist` VALUES ('bc','Browsing Collection','Skövde','SE'),('dbh','Death By Horse','Skåne','SE'),('el','Elden','Karlstad','SE'),('hb','Honeburst','Halmstad','SE'),('mw','Mass Worship','Stockholm','SE');
/*!40000 ALTER TABLE `artist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `landskod`
--

DROP TABLE IF EXISTS `landskod`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `landskod` (
  `kod` varchar(15) COLLATE utf8_swedish_ci NOT NULL,
  `lands_namn` varchar(45) COLLATE utf8_swedish_ci DEFAULT NULL,
  PRIMARY KEY (`kod`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `landskod`
--

LOCK TABLES `landskod` WRITE;
/*!40000 ALTER TABLE `landskod` DISABLE KEYS */;
INSERT INTO `landskod` VALUES ('DEN','Danmark'),('SE','Sverige'),('US','USA');
/*!40000 ALTER TABLE `landskod` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `speldag`
--

DROP TABLE IF EXISTS `speldag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `speldag` (
  `speldag_id` int NOT NULL,
  `speldag_namn` varchar(45) COLLATE utf8_swedish_ci DEFAULT NULL,
  `speldag_datum` varchar(45) COLLATE utf8_swedish_ci DEFAULT NULL,
  PRIMARY KEY (`speldag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `speldag`
--

LOCK TABLES `speldag` WRITE;
/*!40000 ALTER TABLE `speldag` DISABLE KEYS */;
INSERT INTO `speldag` VALUES (1,'Onsdag Prepare','2020-06-03'),(2,'Torsdag Hardtime','2020-06-04'),(3,'Fredag Laidback','2020-06-05'),(4,'Lördag All-In','2020-06-06');
/*!40000 ALTER TABLE `speldag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spelning`
--

DROP TABLE IF EXISTS `spelning`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `spelning` (
  `artist_id` varchar(30) COLLATE utf8_swedish_ci DEFAULT NULL,
  `speldag_id` int NOT NULL,
  `klockslag` varchar(40) COLLATE utf8_swedish_ci DEFAULT NULL,
  KEY `artist_id` (`artist_id`),
  KEY `speldag_id` (`speldag_id`),
  CONSTRAINT `spelning_ibfk_1` FOREIGN KEY (`artist_id`) REFERENCES `artist` (`artist_id`),
  CONSTRAINT `spelning_ibfk_2` FOREIGN KEY (`speldag_id`) REFERENCES `speldag` (`speldag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spelning`
--

LOCK TABLES `spelning` WRITE;
/*!40000 ALTER TABLE `spelning` DISABLE KEYS */;
INSERT INTO `spelning` VALUES ('dbh',1,'15:00'),('dbh',2,'15:00'),('dbh',3,'15:00'),('bc',2,'19:00'),('bc',3,'19:00'),('mw',1,'21:00'),('mw',2,'21:00'),('el',3,'21:00');
/*!40000 ALTER TABLE `spelning` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'exam'
--
/*!50003 DROP PROCEDURE IF EXISTS `search_spelning` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`user`@`%` PROCEDURE `search_spelning`(
    search VARCHAR(50)
)
BEGIN
    SELECT
        sp.artist_id AS Artist_id,
        art.artist_namn AS Artist_namn,
        sp.speldag_id AS Speldag_id,
        sd.speldag_namn AS Speldag_namn,
        art.artist_ort As Ort,
        art.artist_landskod AS Landskod,
        sd.speldag_datum AS Spelning,
        sp.klockslag AS Klockslag
    FROM
        spelning AS sp
    JOIN
        artist AS art
    ON
        sp.artist_id = art.artist_id
    JOIN
        speldag AS sd
    ON
        sp.speldag_id = sd.speldag_id
    WHERE
        sp.artist_id LIKE search
        OR art.artist_namn LIKE search
        OR sp.speldag_id LIKE search
        OR sd.speldag_namn LIKE search
        OR art.artist_ort LIKE search
        OR art.artist_landskod LIKE search
        OR sd.speldag_datum LIKE search;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `show_artists_info` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`user`@`%` PROCEDURE `show_artists_info`()
BEGIN
    SELECT
        sp.artist_id AS Artist_id,
        art.artist_namn AS Artist_namn,
        sp.speldag_id AS Speldag_id,
        sd.speldag_namn AS Speldag_namn,
        art.artist_ort As Ort,
        art.artist_landskod AS Landskod,
        sd.speldag_datum AS Spelning,
        sp.klockslag AS Klockslag
    FROM
        spelning AS sp
    JOIN artist AS art
        ON
            sp.artist_id = art.artist_id
    JOIN
        speldag AS sd
        ON
            sp.speldag_id = sd.speldag_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-03-23 23:14:54
