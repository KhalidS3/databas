--
-- Teckenkodning
-- Khalid Safi
--

SET NAMES 'utf8';

DROP TABLE IF EXISTS person;
CREATE TABLE person
(
    fornamn VARCHAR(10)
);

INSERT INTO person VALUES
("Örjan"), ("Börje"), ("Bo"), ("Øjvind"),
("Åke"), ("Åkesson"), ("Arne"), ("Ängla"),
("Ægir")
;

SELECT * FROM person;

SELECT * FROM person
ORDER BY fornamn;

-- Visa collation
SHOW CREATE TABLE person;

-- Vi tittar noggrannare på vad character set latin1 innebär för collation.
SHOW CHARSET LIKE 'latin1';

-- Låt oss kika på vilka andra collations som finns i charset latin1.
SHOW COLLATION WHERE Charset = 'latin1';

-- Ändra till UTF8

SHOW CHARSET LIKE 'utf8';

SELECT HEX("©");

-- uppdaterar jag min tabell till utf8 och utf8_general_ci.
ALTER TABLE person CONVERT TO CHARSET utf8 COLLATE utf8_unicode_ci;

SELECT * FROM person
ORDER BY fornamn;

SHOW COLLATION WHERE Charset = 'utf8';

ALTER TABLE person CONVERT TO CHARSET utf8 COLLATE utf8_swedish_ci;

SELECT * FROM person
ORDER BY fornamn;
