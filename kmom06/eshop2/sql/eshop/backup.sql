-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: eshop
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
-- Current Database: `eshop`
--

/*!40000 DROP DATABASE IF EXISTS `eshop`*/;

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `eshop` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `eshop`;

--
-- Table structure for table `faktura`
--

DROP TABLE IF EXISTS `faktura`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `faktura` (
  `fakturanr` int NOT NULL AUTO_INCREMENT,
  `orderid` int DEFAULT NULL,
  `kundid` int DEFAULT NULL,
  `datum` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`fakturanr`),
  KEY `orderid` (`orderid`),
  KEY `kundid` (`kundid`),
  CONSTRAINT `faktura_ibfk_1` FOREIGN KEY (`orderid`) REFERENCES `order` (`orderid`) ON DELETE CASCADE,
  CONSTRAINT `faktura_ibfk_2` FOREIGN KEY (`kundid`) REFERENCES `kund` (`kundid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `faktura`
--

LOCK TABLES `faktura` WRITE;
/*!40000 ALTER TABLE `faktura` DISABLE KEYS */;
/*!40000 ALTER TABLE `faktura` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `faktura_rad`
--

DROP TABLE IF EXISTS `faktura_rad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `faktura_rad` (
  `fakturanr` int NOT NULL,
  `produktid` varchar(10) COLLATE utf8_swedish_ci NOT NULL,
  `antal` int DEFAULT NULL,
  PRIMARY KEY (`fakturanr`,`produktid`),
  KEY `produktid` (`produktid`),
  CONSTRAINT `faktura_rad_ibfk_1` FOREIGN KEY (`fakturanr`) REFERENCES `faktura` (`fakturanr`),
  CONSTRAINT `faktura_rad_ibfk_2` FOREIGN KEY (`produktid`) REFERENCES `produkt` (`produktid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `faktura_rad`
--

LOCK TABLES `faktura_rad` WRITE;
/*!40000 ALTER TABLE `faktura_rad` DISABLE KEYS */;
/*!40000 ALTER TABLE `faktura_rad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kategori`
--

DROP TABLE IF EXISTS `kategori`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kategori` (
  `kategori` varchar(100) COLLATE utf8_swedish_ci NOT NULL,
  PRIMARY KEY (`kategori`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kategori`
--

LOCK TABLES `kategori` WRITE;
/*!40000 ALTER TABLE `kategori` DISABLE KEYS */;
INSERT INTO `kategori` VALUES ('bth'),('dbwebb'),('kaffe'),('mugg'),('porslin'),('skiva'),('spellista'),('te');
/*!40000 ALTER TABLE `kategori` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kund`
--

DROP TABLE IF EXISTS `kund`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kund` (
  `kundid` int NOT NULL AUTO_INCREMENT,
  `fornamn` varchar(45) COLLATE utf8_swedish_ci DEFAULT NULL,
  `efternamn` varchar(45) COLLATE utf8_swedish_ci DEFAULT NULL,
  `adress` varchar(45) COLLATE utf8_swedish_ci DEFAULT NULL,
  `postnummer` char(6) COLLATE utf8_swedish_ci DEFAULT NULL,
  `ort` varchar(45) COLLATE utf8_swedish_ci DEFAULT NULL,
  `land` varchar(45) COLLATE utf8_swedish_ci DEFAULT NULL,
  `telefon` varchar(20) COLLATE utf8_swedish_ci DEFAULT NULL,
  PRIMARY KEY (`kundid`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kund`
--

LOCK TABLES `kund` WRITE;
/*!40000 ALTER TABLE `kund` DISABLE KEYS */;
INSERT INTO `kund` VALUES (1,'Mikael','Roos','Centrumgatan 1','564 00','Bankeryd','Sverige','070 42 42 42'),(2,'John','Doe','Skogen 1','555 55','Landet','Sverige','070 555 555'),(3,'Jane','Doe','Skogen 1','555 55','Landet','Sverige','070 556 556'),(4,'Mumintrollet','Mumin','Blå hus 1','111 11','Mumindalen','Finland','070 111 111'),(5,'Kalle','Anka','Paradisäppelvägen 111','313 13','Ankeborg','Sverige','070 313 313');
/*!40000 ALTER TABLE `kund` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lager`
--

DROP TABLE IF EXISTS `lager`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lager` (
  `hylla` char(5) COLLATE utf8_swedish_ci NOT NULL,
  PRIMARY KEY (`hylla`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lager`
--

LOCK TABLES `lager` WRITE;
/*!40000 ALTER TABLE `lager` DISABLE KEYS */;
INSERT INTO `lager` VALUES ('A:101'),('B:101'),('C:101'),('D:101'),('E:101');
/*!40000 ALTER TABLE `lager` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `logg`
--

DROP TABLE IF EXISTS `logg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `logg` (
  `loggid` int NOT NULL AUTO_INCREMENT,
  `tid` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `beskrivning` varchar(45) COLLATE utf8_swedish_ci DEFAULT NULL,
  `produkt` varchar(45) COLLATE utf8_swedish_ci DEFAULT NULL,
  PRIMARY KEY (`loggid`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logg`
--

LOCK TABLES `logg` WRITE;
/*!40000 ALTER TABLE `logg` DISABLE KEYS */;
INSERT INTO `logg` VALUES (1,'2021-03-11 19:37:12','New product','kaffe1'),(2,'2021-03-11 19:37:12','New product','te1'),(3,'2021-03-11 19:37:12','New product','kaffemix1'),(4,'2021-03-11 19:37:12','New product','skiva1'),(5,'2021-03-11 19:37:12','New product','kaffemix2');
/*!40000 ALTER TABLE `logg` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order`
--

DROP TABLE IF EXISTS `order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order` (
  `orderid` int NOT NULL AUTO_INCREMENT,
  `kundid` int DEFAULT NULL,
  `skapad` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `uppdaterad` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `raderad` timestamp NULL DEFAULT NULL,
  `bestalld` timestamp NULL DEFAULT NULL,
  `skickad` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`orderid`),
  KEY `kundid` (`kundid`),
  CONSTRAINT `order_ibfk_1` FOREIGN KEY (`kundid`) REFERENCES `kund` (`kundid`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order`
--

LOCK TABLES `order` WRITE;
/*!40000 ALTER TABLE `order` DISABLE KEYS */;
INSERT INTO `order` VALUES (1,1,'2021-03-11 19:37:12','2021-03-11 19:43:04',NULL,'2021-03-11 19:43:04',NULL),(2,1,'2021-03-11 19:37:12','2021-03-11 19:41:19',NULL,NULL,NULL),(3,2,'2021-03-11 19:37:12',NULL,NULL,NULL,NULL),(4,3,'2021-03-11 19:37:12',NULL,NULL,NULL,NULL),(5,4,'2021-03-11 19:37:12',NULL,NULL,NULL,NULL),(6,4,'2021-03-11 19:37:12',NULL,NULL,NULL,NULL),(7,5,'2021-03-11 19:37:12',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_rad`
--

DROP TABLE IF EXISTS `order_rad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_rad` (
  `orderid` int NOT NULL,
  `produktid` varchar(10) COLLATE utf8_swedish_ci NOT NULL,
  `antal` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`orderid`,`produktid`),
  KEY `produktid` (`produktid`),
  CONSTRAINT `order_rad_ibfk_1` FOREIGN KEY (`orderid`) REFERENCES `order` (`orderid`) ON DELETE CASCADE,
  CONSTRAINT `order_rad_ibfk_2` FOREIGN KEY (`produktid`) REFERENCES `produkt` (`produktid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_rad`
--

LOCK TABLES `order_rad` WRITE;
/*!40000 ALTER TABLE `order_rad` DISABLE KEYS */;
INSERT INTO `order_rad` VALUES (1,'kaffe1',3),(1,'te1',2),(2,'kaffemix1',30),(2,'kaffemix2',2),(2,'skiva1',2),(2,'te1',5),(3,'te1',1),(4,'kaffe1',2),(4,'kaffemix2',1),(5,'kaffemix2',3),(5,'skiva1',10),(6,'te1',8),(7,'kaffe1',1);
/*!40000 ALTER TABLE `order_rad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produkt`
--

DROP TABLE IF EXISTS `produkt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `produkt` (
  `produktid` varchar(10) COLLATE utf8_swedish_ci NOT NULL,
  `pris` int DEFAULT NULL,
  `namn` varchar(45) COLLATE utf8_swedish_ci DEFAULT NULL,
  `bildlank` varchar(45) COLLATE utf8_swedish_ci DEFAULT NULL,
  `beskrivning` varchar(150) COLLATE utf8_swedish_ci DEFAULT NULL,
  PRIMARY KEY (`produktid`),
  UNIQUE KEY `unique_namn` (`namn`),
  KEY `index_pris` (`pris`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produkt`
--

LOCK TABLES `produkt` WRITE;
/*!40000 ALTER TABLE `produkt` DISABLE KEYS */;
INSERT INTO `produkt` VALUES ('kaffe1',69,'Kaffemugg med dbwebb-tryck','/img/eshop/kaffekopp.png','En vacker snövit keramisk kaffemugg med högupplöst flerfärgstryck från dbwebb.'),('kaffemix1',49,'Kaffeblandning med dbwebb-krydda','/img/eshop/kaffe.png','En egenbryggd kaffeblandning för aktiva studiedagara, utan paus, spetsad med dbwebb-krydda.'),('kaffemix2',39,'Kaffeblandning utan krydda','/img/eshop/kaffeblandning.png','Gott att dricka'),('skiva1',199,'Skiva där BTHs lärarkår sjunger sånger','/img/eshop/bth-skiva.png','BTHs samlade lärarkår sjunger studiemotiverande sångar, inkluderar länk till online spellista.'),('te1',79,'Temugg med dbwebb-tryck','/img/eshop/temugg.png','En ståtlig matt helsvart temugg, extra stor, med grön dbwebb-logo, för sköna stunder framför datorn.');
/*!40000 ALTER TABLE `produkt` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`user`@`%`*/ /*!50003 TRIGGER `trigger_create_product` AFTER INSERT ON `produkt` FOR EACH ROW INSERT INTO logg (beskrivning, produkt)
            VALUES ("New product", NEW.produktid) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`user`@`%`*/ /*!50003 TRIGGER `trigger_edit_product` AFTER UPDATE ON `produkt` FOR EACH ROW INSERT INTO logg (beskrivning, produkt)
            VALUES ("Uppdated product", NEW.produktid) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`user`@`%`*/ /*!50003 TRIGGER `trigger_delete_product` AFTER DELETE ON `produkt` FOR EACH ROW INSERT INTO logg (beskrivning, produkt)
            VALUES ("Deleted product", OLD.produktid) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `produkt2kategori`
--

DROP TABLE IF EXISTS `produkt2kategori`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `produkt2kategori` (
  `produktid` varchar(10) COLLATE utf8_swedish_ci NOT NULL,
  `kategori` varchar(45) COLLATE utf8_swedish_ci NOT NULL,
  PRIMARY KEY (`produktid`,`kategori`),
  KEY `kategori` (`kategori`),
  CONSTRAINT `produkt2kategori_ibfk_1` FOREIGN KEY (`produktid`) REFERENCES `produkt` (`produktid`) ON DELETE CASCADE,
  CONSTRAINT `produkt2kategori_ibfk_2` FOREIGN KEY (`kategori`) REFERENCES `kategori` (`kategori`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produkt2kategori`
--

LOCK TABLES `produkt2kategori` WRITE;
/*!40000 ALTER TABLE `produkt2kategori` DISABLE KEYS */;
INSERT INTO `produkt2kategori` VALUES ('kaffe1','dbwebb'),('kaffemix1','dbwebb'),('te1','dbwebb'),('kaffemix1','kaffe'),('kaffemix2','kaffe'),('kaffe1','mugg'),('kaffe1','porslin'),('skiva1','skiva');
/*!40000 ALTER TABLE `produkt2kategori` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produkt2lager`
--

DROP TABLE IF EXISTS `produkt2lager`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `produkt2lager` (
  `produktid` varchar(10) COLLATE utf8_swedish_ci NOT NULL,
  `antal` int DEFAULT NULL,
  `hylla` char(5) COLLATE utf8_swedish_ci NOT NULL,
  PRIMARY KEY (`produktid`,`hylla`),
  KEY `hylla` (`hylla`),
  CONSTRAINT `produkt2lager_ibfk_1` FOREIGN KEY (`produktid`) REFERENCES `produkt` (`produktid`) ON DELETE CASCADE,
  CONSTRAINT `produkt2lager_ibfk_2` FOREIGN KEY (`hylla`) REFERENCES `lager` (`hylla`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produkt2lager`
--

LOCK TABLES `produkt2lager` WRITE;
/*!40000 ALTER TABLE `produkt2lager` DISABLE KEYS */;
INSERT INTO `produkt2lager` VALUES ('kaffe1',7,'A:101'),('kaffemix1',8,'D:101'),('kaffemix2',2,'D:101'),('skiva1',4,'C:101'),('skiva1',10,'D:101'),('te1',12,'B:101');
/*!40000 ALTER TABLE `produkt2lager` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `v_inventory`
--

DROP TABLE IF EXISTS `v_inventory`;
/*!50001 DROP VIEW IF EXISTS `v_inventory`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_inventory` AS SELECT 
 1 AS `produktid`,
 1 AS `namn`,
 1 AS `hylla`,
 1 AS `antal`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping routines for database 'eshop'
--
/*!50003 DROP FUNCTION IF EXISTS `order_status` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`user`@`%` FUNCTION `order_status`(
    skapad TIMESTAMP,
    uppdaterad TIMESTAMP,
    raderad TIMESTAMP,
    bestalld TIMESTAMP,
    skickad TIMESTAMP
) RETURNS varchar(50) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
    IF raderad IS NOT NULL THEN
        RETURN 'Raderad';
    ELSEIF skickad IS NOT NULL THEN
        RETURN 'Skickat';
    ELSEIF bestalld IS NOT NULL THEN
        RETURN 'Beställd';
    END IF;
    RETURN 'Skapad';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_product_to_shelf` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`user`@`%` PROCEDURE `add_product_to_shelf`(
    a_produktid VARCHAR(10),
    a_hylla CHAR(5),
    a_antal INT
)
BEGIN
    IF EXISTS (
        SELECT * FROM produkt2lager
        WHERE
            produktid = a_produktid
            AND hylla = a_hylla
    ) THEN
        UPDATE produkt2lager
        SET
            antal = antal + a_antal
        WHERE
            produktid = a_produktid AND hylla = a_hylla;
    ELSE
        INSERT INTO produkt2lager
        VALUES (a_produktid, a_antal, a_hylla);
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `create_an_order` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`user`@`%` PROCEDURE `create_an_order`(
    a_kundid INT
)
BEGIN
    INSERT INTO `order` (kundid) VALUES (a_kundid);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `create_an_order_row` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`user`@`%` PROCEDURE `create_an_order_row`(
    a_orderid INT,
    a_produktid VARCHAR(15),
    a_antal INT
)
BEGIN
    INSERT INTO order_rad
        (orderid, produktid, antal)
    VALUES
        (a_orderid, a_produktid, a_antal)
    ON DUPLICATE KEY UPDATE antal = antal + a_antal;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `create_product` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`user`@`%` PROCEDURE `create_product`(
    a_produktid VARCHAR(15),
    a_pris INT,
    a_namn VARCHAR(50),
    a_bildlank VARCHAR(50),
    a_beskrivning VARCHAR(150)
)
BEGIN
    INSERT INTO produkt VALUES (a_produktid, a_pris, a_namn, a_bildlank, a_beskrivning);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_product` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`user`@`%` PROCEDURE `delete_product`(
    a_produktid VARCHAR(15)
)
BEGIN
    DELETE FROM
        produkt2kategori
    WHERE
        produktid = a_produktid;
    DELETE FROM
        produkt2lager
    WHERE
        produktid = a_produktid;
    DELETE FROM
        produkt
    WHERE
        produktid = a_produktid;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_product_from_shelf` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`user`@`%` PROCEDURE `delete_product_from_shelf`(
    a_produktid VARCHAR(10),
    a_hylla CHAR(5),
    a_antal INT
)
BEGIN
    IF (a_antal <= (SELECT antal FROM produkt2lager
                    WHERE
                        produktid = a_produktid
                        AND hylla = a_hylla)
        ) THEN
        UPDATE produkt2lager
        SET
            antal = antal - a_antal
        WHERE
            produktid = a_produktid AND hylla = a_hylla;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `edit_product` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`user`@`%` PROCEDURE `edit_product`(
    a_produktid VARCHAR(15),
    a_pris INT,
    a_namn VARCHAR(50),
    a_bildlank VARCHAR(50),
    a_beskrivning VARCHAR(150)
)
BEGIN
    UPDATE produkt
    SET
        pris = a_pris,
        namn = a_namn,
        bildlank = a_bildlank,
        beskrivning = a_beskrivning
    WHERE
        produktid = a_produktid;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `picklist` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`user`@`%` PROCEDURE `picklist`(
    a_orderid INT
)
BEGIN
    SELECT
        o_r.produktid,
        o_r.antal,
        GROUP_CONCAT(p2l.hylla) AS hylla,
        IF ((SUM(p2l.antal) >= o_r.antal), "OK", "EJ OK!") AS "tillräckligt"
    FROM order_rad AS o_r
        INNER JOIN produkt2lager AS p2l
            ON o_r.produktid = p2l.produktid
    WHERE
        o_r.orderid = a_orderid
    GROUP BY o_r.produktid;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `set_order_status` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`user`@`%` PROCEDURE `set_order_status`(
    a_orderid INT,
    a_status VARCHAR(50)
)
BEGIN
    IF (a_status = "beställd") THEN
        UPDATE `order`
        SET
            bestalld = CURRENT_TIMESTAMP
        WHERE
            orderid = a_orderid;
    ELSEIF (a_status = "skickad") THEN
        UPDATE `order`
        SET
            skickad = CURRENT_TIMESTAMP
        WHERE
            orderid = a_orderid;
    ELSEIF (a_status = "raderad") THEN
        UPDATE `order`
        SET
            raderad = CURRENT_TIMESTAMP
        WHERE
            orderid = a_orderid;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `show_all_customers` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`user`@`%` PROCEDURE `show_all_customers`()
BEGIN
    SELECT
        kundid,
        CONCAT(fornamn, " ", efternamn) AS namn,
        CONCAT(adress, ", ", postnummer, " ", ort, ", ", land) AS adress,
        telefon
    FROM
        kund;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `show_an_order` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`user`@`%` PROCEDURE `show_an_order`(
    a_orderid INT
)
BEGIN
    SELECT
        *,
        CONCAT(fornamn, " ", efternamn) AS namn
    FROM `order` AS o
    INNER JOIN kund AS k
    ON o.kundid = k.kundid
    WHERE
        orderid = a_orderid;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `show_an_order_row` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`user`@`%` PROCEDURE `show_an_order_row`(
    a_orderid INT
)
BEGIN
    SELECT
        *
        FROM order_rad AS o_r
    INNER JOIN produkt AS p
        ON o_r.produktid = p.produktid
    WHERE
        o_r.orderid = a_orderid;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `show_category` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`user`@`%` PROCEDURE `show_category`()
BEGIN
    SELECT * FROM kategori;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `show_inventory` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`user`@`%` PROCEDURE `show_inventory`()
BEGIN
    SELECT * FROM v_inventory;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `show_kategori_products` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`user`@`%` PROCEDURE `show_kategori_products`(
    a_produktid VARCHAR(15),
    a_kategori VARCHAR(15)
)
BEGIN
    SELECT * FROM produkt2kategori
    WHERE
        produktid = a_produktid
        OR kategori = a_kategori;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `show_logg` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`user`@`%` PROCEDURE `show_logg`(
    a_num INT
)
BEGIN
    SELECT
        DATE_FORMAT(tid, "%Y-%m-%d %H:%i:%s")"Tidstämple",
        beskrivning,
        produkt
    FROM
        logg
    ORDER BY
        loggid DESC
    LIMIT a_num;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `show_loggs` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`user`@`%` PROCEDURE `show_loggs`(
    
)
BEGIN
    SELECT
        DATE_FORMAT(tid, "%Y-%m-%d %H:%i:%s")tid,
        beskrivning,
        produkt
    FROM
        logg
    ORDER BY
        loggid DESC;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `show_orders` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`user`@`%` PROCEDURE `show_orders`()
BEGIN
    SELECT
        o.orderid,
        DATE_FORMAT(skapad, "%Y-%m-%d %H:%i:%s") AS skapad,
        k.kundid,
        CONCAT(fornamn, " ", efternamn) AS namn,
        COUNT(o_r.orderid) AS rader,
        order_status(
            skapad,
            uppdaterad,
            raderad,
            bestalld,
            skickad
        ) AS status
    FROM `order` AS o
        LEFT OUTER JOIN order_rad AS o_r
            ON o.orderid = o_r.orderid
        INNER JOIN kund AS k
            ON o.kundid = k.kundid
    GROUP BY o.orderid
    ORDER BY skapad ASC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `show_product` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`user`@`%` PROCEDURE `show_product`(
    a_produktid VARCHAR(15)
)
BEGIN
    SELECT * FROM produkt
    WHERE
        produktid = a_produktid;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `show_products` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`user`@`%` PROCEDURE `show_products`()
BEGIN
    SELECT
        p.produktid,
        GROUP_CONCAT(p_k.kategori) AS kategori,
        p.namn,
        p.pris,
        p_l.antal
    FROM produkt AS p
        LEFT OUTER JOIN produkt2lager AS p_l
            ON p.produktid = p_l.produktid
        LEFT OUTER JOIN produkt2kategori AS p_k
            ON p.produktid = p_k.produktid
    GROUP BY p.produktid;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `show_selected_inventory` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`user`@`%` PROCEDURE `show_selected_inventory`(
    search VARCHAR(100)
)
BEGIN
    SELECT * FROM v_inventory
        WHERE
            search = produktid
            OR search = namn
            OR search = hylla;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `show_selected_orders` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`user`@`%` PROCEDURE `show_selected_orders`(
    a_str VARCHAR(100)
)
BEGIN
    SELECT
        o.orderid,
        DATE_FORMAT(skapad, "%Y-%m-%d %H:%i:%s") AS skapad,
        k.kundid,
        CONCAT(fornamn, " ", efternamn) AS namn,
        COUNT(o_r.orderid) AS rader,
        order_status(
            skapad,
            uppdaterad,
            raderad,
            bestalld,
            skickad
        ) AS status
    FROM `order` AS o
        LEFT OUTER JOIN order_rad AS o_r
            ON o.orderid = o_r.orderid
        INNER JOIN kund AS k
            ON o.kundid = k.kundid
    WHERE
        a_str = o.orderid
        OR a_str = k.kundid
    GROUP BY o.orderid
    ORDER BY skapad ASC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `show_shelfs` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`user`@`%` PROCEDURE `show_shelfs`()
BEGIN
    SELECT * FROM lager;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `undo_deleted_order` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`user`@`%` PROCEDURE `undo_deleted_order`(
    a_orderid INT
)
BEGIN
    UPDATE `order`
    SET
        raderad = NULL
    WHERE
        orderid = a_orderid;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Current Database: `eshop`
--

USE `eshop`;

--
-- Final view structure for view `v_inventory`
--

/*!50001 DROP VIEW IF EXISTS `v_inventory`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`user`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `v_inventory` AS select `p`.`produktid` AS `produktid`,`p`.`namn` AS `namn`,`p_l`.`hylla` AS `hylla`,`p_l`.`antal` AS `antal` from (`produkt` `p` left join `produkt2lager` `p_l` on((`p`.`produktid` = `p_l`.`produktid`))) group by `p`.`produktid` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-03-11 20:46:56
