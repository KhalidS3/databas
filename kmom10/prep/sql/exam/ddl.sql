--
-- Khalid Safi(khsa16)
-- Prep tenta Rock
-- 2021-03-23
--

USE exam;

-- Dropping databases in order
DROP TABLE IF EXISTS spelning;
DROP TABLE IF EXISTS speldag;
DROP TABLE IF EXISTS artist;
DROP TABLE IF EXISTS landskod;

-- Creating table for landskod
CREATE TABLE landskod
(
    kod VARCHAR(15),
    lands_namn VARCHAR(45),

    PRIMARY KEY (kod)
)
ENGINE INNODB
CHARSET utf8
COLLATE utf8_swedish_ci
;

-- Creating table for artist
CREATE TABLE artist
(
    artist_id VARCHAR(15),
    artist_namn VARCHAR(45),
    artist_ort VARCHAR(100),
    artist_landskod VARCHAR(15),

    PRIMARY KEY (artist_id),
    FOREIGN KEY (artist_landskod) REFERENCES landskod (kod)
)
ENGINE INNODB
CHARSET utf8
COLLATE utf8_swedish_ci
;

-- Creating table for speldag
CREATE TABLE speldag
(
    speldag_id INT NOT NULL,
    speldag_namn VARCHAR(45),
    speldag_datum VARCHAR(45),

    PRIMARY KEY (speldag_id)
)
ENGINE INNODB
CHARSET utf8
COLLATE utf8_swedish_ci
;

-- Creating table for spelning
CREATE TABLE spelning
(
    artist_id VARCHAR(30),
    speldag_id INT NOT NULL,
    klockslag VARCHAR(40),

    FOREIGN KEY (artist_id) REFERENCES artist (artist_id),
    FOREIGN KEY (speldag_id) REFERENCES speldag (speldag_id)
)
ENGINE INNODB
CHARSET utf8
COLLATE utf8_swedish_ci
;

--
-- PROCEDURES
--
DROP PROCEDURE IF EXISTS show_artists_info;
DELIMITER ;;
CREATE PROCEDURE show_artists_info()
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
END
;;
DELIMITER ;

--
-- Procedure search spelningar
--
DROP PROCEDURE IF EXISTS search_spelning;
DELIMITER ;;
CREATE PROCEDURE search_spelning(
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
END
;;
DELIMITER ;
