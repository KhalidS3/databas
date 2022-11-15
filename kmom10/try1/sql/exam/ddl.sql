--
-- Khalid Safi(khsa16)
-- Prep tenta Rock
-- 2021-03-24
--
USE exam;

-- Dropping tables in order
DROP TABLE IF EXISTS medlem2hund;
DROP TABLE IF EXISTS medlem;
DROP TABLE IF EXISTS hund;
DROP TABLE IF EXISTS ras;

-- Creating table for ras
CREATE TABLE ras
(
    ras_id VARCHAR(15),
    ras_namn VARCHAR(50),
    ras_godkand VARCHAR(15),

    PRIMARY KEY (ras_id)
)
ENGINE INNODB
CHARSET utf8
COLLATE utf8_swedish_ci
;

-- Creating table for hund
CREATE TABLE hund
(
    hund_id INT NOT NULL,
    hund_namn VARCHAR(50),
    hund_url VARCHAR(70),
    ras_id VARCHAR(15),

    PRIMARY KEY (hund_id),
    FOREIGN KEY (ras_id) REFERENCES ras (ras_id)
)
ENGINE INNODB
CHARSET utf8
COLLATE utf8_swedish_ci
;

-- Creating table for medlem
CREATE TABLE medlem
(
    medlem_id INT NOT NULL,
    medlem_fornamn VARCHAR(50),
    medlem_alias VARCHAR(50),
    medlem_efternamn VARCHAR(50),
    medlem_ort VARCHAR(45),

    PRIMARY KEY (medlem_id)
)
ENGINE INNODB
CHARSET utf8
COLLATE utf8_swedish_ci
;

-- Creating table for medlem2hund
CREATE TABLE medlem2hund
(
    med2hund_id INT NOT NULL, -- medhund = medlem2hund
    medlem_id INT NOT NULL,
    hund_id INT NOT NULL,
    med2hund_registrerad INT NOT NULL,

    PRIMARY KEY (med2hund_id, medlem_id, hund_id),
    FOREIGN KEY (medlem_id) REFERENCES medlem (medlem_id),
    FOREIGN KEY (hund_id) REFERENCES hund (hund_id)
)
ENGINE INNODB
CHARSET utf8
COLLATE utf8_swedish_ci
;

--
-- Procedures
--

--
-- En rapport över samtliga medlemmar
--
DROP PROCEDURE IF EXISTS visa_medlems_alla_info;
DELIMITER ;;
CREATE PROCEDURE visa_medlems_alla_info(
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
END
;;
DELIMITER ;

--
-- Show specific dog
--
DROP PROCEDURE IF EXISTS visa_hunden;
DELIMITER ;;
CREATE PROCEDURE visa_hunden(
    a_hund_namn VARCHAR(50)
)
BEGIN
    SELECT * FROM hund
    WHERE
        hund_namn = a_hund_namn;
END
;;
DELIMITER ;

--
-- Procedure search for specific info
--
DROP PROCEDURE IF EXISTS sok_info;
DELIMITER ;;
CREATE PROCEDURE sok_info(
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
END
;;
DELIMITER ;
