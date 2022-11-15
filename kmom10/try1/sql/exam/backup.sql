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
-- Table structure for table `hund`
--

DROP TABLE IF EXISTS `hund`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hund` (
  `hund_id` int NOT NULL,
  `hund_namn` varchar(50) COLLATE utf8_swedish_ci DEFAULT NULL,
  `hund_url` varchar(70) COLLATE utf8_swedish_ci DEFAULT NULL,
  `ras_id` varchar(15) COLLATE utf8_swedish_ci DEFAULT NULL,
  PRIMARY KEY (`hund_id`),
  KEY `ras_id` (`ras_id`),
  CONSTRAINT `hund_ibfk_1` FOREIGN KEY (`ras_id`) REFERENCES `ras` (`ras_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hund`
--

LOCK TABLES `hund` WRITE;
/*!40000 ALTER TABLE `hund` DISABLE KEYS */;
INSERT INTO `hund` VALUES (1,'Båtsman','https://sv.wikipedia.org/wiki/Vi_p%C3%A5_Saltkr%C3%A5kan','sb'),(2,'Bo','https://sv.wikipedia.org/wiki/Bo_(hund)','pv'),(3,'Arleekin','https://sv.wikipedia.org/wiki/Pavlovs_hundar','br'),(4,'Laska','https://sv.wikipedia.org/wiki/Pavlovs_hundar','br'),(5,'Zloday','https://sv.wikipedia.org/wiki/Pavlovs_hundar','br'),(6,'Sunny','https://sv.wikipedia.org/wiki/Bo_(hund)','pv'),(7,'Lajka','https://sv.wikipedia.org/wiki/Lajka','br'),(8,'Skeppshunden Bamse','https://sv.wikipedia.org/wiki/Skeppshunden_Bamse','sb');
/*!40000 ALTER TABLE `hund` ENABLE KEYS */;
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
-- Table structure for table `medlem`
--

DROP TABLE IF EXISTS `medlem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `medlem` (
  `medlem_id` int NOT NULL,
  `medlem_fornamn` varchar(50) COLLATE utf8_swedish_ci DEFAULT NULL,
  `medlem_alias` varchar(50) COLLATE utf8_swedish_ci DEFAULT NULL,
  `medlem_efternamn` varchar(50) COLLATE utf8_swedish_ci DEFAULT NULL,
  `medlem_ort` varchar(45) COLLATE utf8_swedish_ci DEFAULT NULL,
  PRIMARY KEY (`medlem_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medlem`
--

LOCK TABLES `medlem` WRITE;
/*!40000 ALTER TABLE `medlem` DISABLE KEYS */;
INSERT INTO `medlem` VALUES (1,'Barrack','\"the president\"','Obama','Washington'),(2,'Ivan','\"the scientist\"','Pavlov','Sankt Petersburg'),(3,'Millan','\"the whisperer\"','Cesar','Santa Clarita'),(4,'Hafto','\"the captain\"','Erling','Honningsvåg'),(5,'Tjorven','\"tjorven\"','Grankvist','Saltkråkan');
/*!40000 ALTER TABLE `medlem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `medlem2hund`
--

DROP TABLE IF EXISTS `medlem2hund`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `medlem2hund` (
  `med2hund_id` int NOT NULL,
  `medlem_id` int NOT NULL,
  `hund_id` int NOT NULL,
  `med2hund_registrerad` int NOT NULL,
  PRIMARY KEY (`med2hund_id`,`medlem_id`,`hund_id`),
  KEY `medlem_id` (`medlem_id`),
  KEY `hund_id` (`hund_id`),
  CONSTRAINT `medlem2hund_ibfk_1` FOREIGN KEY (`medlem_id`) REFERENCES `medlem` (`medlem_id`),
  CONSTRAINT `medlem2hund_ibfk_2` FOREIGN KEY (`hund_id`) REFERENCES `hund` (`hund_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medlem2hund`
--

LOCK TABLES `medlem2hund` WRITE;
/*!40000 ALTER TABLE `medlem2hund` DISABLE KEYS */;
INSERT INTO `medlem2hund` VALUES (1,1,2,2008),(2,1,6,2013),(3,2,3,1922),(4,2,4,1922),(5,2,5,1923),(6,4,8,1937),(7,5,1,1964);
/*!40000 ALTER TABLE `medlem2hund` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ras`
--

DROP TABLE IF EXISTS `ras`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ras` (
  `ras_id` varchar(15) COLLATE utf8_swedish_ci NOT NULL,
  `ras_namn` varchar(50) COLLATE utf8_swedish_ci DEFAULT NULL,
  `ras_godkand` varchar(15) COLLATE utf8_swedish_ci DEFAULT NULL,
  PRIMARY KEY (`ras_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ras`
--

LOCK TABLES `ras` WRITE;
/*!40000 ALTER TABLE `ras` DISABLE KEYS */;
INSERT INTO `ras` VALUES ('br','Blandras','nej'),('pv','Portugisisk vattenhund','ja'),('sb','Sankt bernhardshund','ja'),('sc','Schäfer','ja');
/*!40000 ALTER TABLE `ras` ENABLE KEYS */;
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
/*!50003 DROP PROCEDURE IF EXISTS `sok_info` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`user`@`%` PROCEDURE `sok_info`(
    search VARCHAR(50)
)
BEGIN
    SELECT
        m2h.medlem_id AS Medlem_id,
        CONCAT(m.medlem_fornamn, " ", m.medlem_efternamn) AS Namn,
        m.medlem_alias As Alias,
        m.medlem_ort AS Ort,
        m2h.hund_id AS Hund_id,
        h.hund_namn AS Hund_namn,
        h.ras_id AS Ras_id,
        r.ras_namn AS Ras_namn,
        r.ras_godkand AS Godkand
    FROM
        medlem2hund AS m2h
    JOIN
        medlem AS m
    ON
        m2h.medlem_id = m.medlem_id
    JOIN
        hund AS h
    ON
        m2h.hund_id = h.hund_id
    JOIN
        ras AS r
    ON
        h.ras_id = r.ras_id
    WHERE
        m.medlem_fornamn LIKE search
        OR m.medlem_efternamn LIKE search
        OR m.medlem_alias LIKE search
        OR m.medlem_ort LIKE search
        OR h.hund_namn LIKE search
        OR r.ras_namn LIKE search
        OR r.ras_godkand LIKE search;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `visa_hunden` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`user`@`%` PROCEDURE `visa_hunden`(
    a_hund_namn VARCHAR(50)
)
BEGIN
    SELECT * FROM hund
    WHERE
        hund_namn = a_hund_namn;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `visa_medlems_alla_info` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`user`@`%` PROCEDURE `visa_medlems_alla_info`(
)
BEGIN
    SELECT
        m2h.medlem_id AS Medlem_id,
        CONCAT(m.medlem_fornamn, " ", m.medlem_efternamn) AS Namn,
        m.medlem_alias As Alias,
        m.medlem_ort AS Ort,
        m2h.hund_id AS Hund_id,
        h.hund_namn AS Hund_namn,
        h.ras_id AS Ras_id,
        r.ras_namn AS Ras_namn,
        r.ras_godkand AS Godkand
    FROM
        medlem2hund AS m2h
    JOIN
        medlem AS m
    ON
        m2h.medlem_id = m.medlem_id
    JOIN
        hund AS h
    ON
        m2h.hund_id = h.hund_id
    JOIN
        ras AS r
    ON
        h.ras_id = r.ras_id
    ORDER BY m2h.medlem_id;
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

-- Dump completed on 2021-03-24 14:01:03
