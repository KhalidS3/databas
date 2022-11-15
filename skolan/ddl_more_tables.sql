--
-- Skapa fler tabeller
-- Khalid Safi
--

SET NAMES 'utf8';

-- Droping tables orderly
DROP TABLE IF EXISTS kurstillfalle;
DROP TABLE IF EXISTS kurs;

--
-- Update table larare and larare_pre to use same charset
-- and collation.
--
ALTER TABLE larare CONVERT TO CHARSET utf8 COLLATE utf8_swedish_ci;
ALTER TABLE larare_pre CONVERT TO CHARSET utf8 COLLATE utf8_swedish_ci;

--
-- Create table: kurs
--
CREATE TABLE kurs
(
    kod CHAR(6) NOT NULL,
    namm VARCHAR(40),
    poang FLOAT,
    niva CHAR(3),

    PRIMARY KEY (kod)
)
ENGINE INNODB
CHARSET utf8
COLLATE utf8_swedish_ci
;

--
-- Create table: kurstillfalle
--
CREATE TABLE kurstillfalle
(
    -- All columns and their definitions
    id INT AUTO_INCREMENT NOT NULL,
    kurskod CHAR(6) NOT NULL,
    kursansvarig CHAR(3) NOT NULL,
    lasperiod INT NOT NULL,

    PRIMARY KEY (id),
    FOREIGN KEY (kurskod) REFERENCES kurs(kod),
    FOREIGN KEY (kursansvarig) REFERENCES larare (akronym)
)
ENGINE INNODB
CHARSET utf8
COLLATE utf8_swedish_ci
;

SHOW CREATE TABLE kurs \G;

SHOW CREATE TABLE kurstillfalle \G;
