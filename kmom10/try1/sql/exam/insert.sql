--
-- Khalid Safi(khsa16)
-- Prep tenta Rock
-- 2021-03-23
--

USE exam;

SET GLOBAL local_infile = 1;
SHOW VARIABLES LIKE 'local_infile';

-- Deleting tables in order
DELETE FROM medlem2hund;
DELETE FROM medlem;
DELETE FROM hund;
DELETE FROM ras;

-- Insert into ras
LOAD DATA LOCAL INFILE 'ras.csv'
INTO TABLE ras
CHARSET utf8
FIELDS
    TERMINATED BY ','
    ENCLOSED BY '"'
LINES
    TERMINATED BY '\n'
IGNORE 1 LINES
;

SELECT * FROM ras;

-- Insert into hund
LOAD DATA LOCAL INFILE 'hund.csv'
INTO TABLE hund
CHARSET utf8
FIELDS
    TERMINATED BY ','
    ENCLOSED BY '"'
LINES
    TERMINATED BY '\n'
IGNORE 1 LINES
;

SELECT * FROM hund;

-- Insert into medlem
LOAD DATA LOCAL INFILE 'medlem.csv'
INTO TABLE medlem
CHARSET utf8
FIELDS
    TERMINATED BY ','
    ENCLOSED BY '"'
LINES
    TERMINATED BY '\n'
IGNORE 1 LINES
;

SELECT * FROM medlem;

-- insert into medlem2hund
LOAD DATA LOCAL INFILE 'medlem2hund.csv'
INTO TABLE medlem2hund
CHARSET utf8
FIELDS
    TERMINATED BY ','
    ENCLOSED BY '"'
LINES
    TERMINATED BY '\n'
IGNORE 1 LINES
-- (med2hund_id, medlem_id, hund_id, med2hund_registrerad)
;

SELECT * FROM medlem2hund;
