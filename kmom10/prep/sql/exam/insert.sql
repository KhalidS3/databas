--
-- Khalid Safi(khsa16)
-- Prep tenta Rock
-- 2021-03-23
--

USE exam;

SET GLOBAL local_infile = 1;
SHOW VARIABLES LIKE 'local_infile';

-- Deleting tables in order
DELETE FROM spelning;
DELETE FROM speldag;
DELETE FROM artist;
DELETE FROM landskod;

-- Insert into landskod
LOAD DATA LOCAL INFILE 'landskod.csv'
INTO TABLE landskod
CHARSET utf8
FIELDS
    TERMINATED BY ','
    ENCLOSED BY '"'
LINES
    TERMINATED BY '\n'
IGNORE 1 LINES
;

SELECT * FROM landskod;

-- Insert into artist
LOAD DATA LOCAL INFILE 'artist.csv'
INTO TABLE artist
CHARSET utf8
FIELDS
    TERMINATED BY ','
    ENCLOSED BY '"'
LINES
    TERMINATED BY '\n'
IGNORE 1 LINES
;

SELECT * FROM artist;

-- Insert into speldag
LOAD DATA LOCAL INFILE 'speldag.csv'
INTO TABLE speldag
CHARSET utf8
FIELDS
    TERMINATED BY ','
    ENCLOSED BY '"'
LINES
    TERMINATED BY '\n'
IGNORE 1 LINES
;

SELECT * FROM speldag;

-- insert into spelning
LOAD DATA LOCAL INFILE 'spelning.csv'
INTO TABLE spelning
CHARSET utf8
FIELDS
    TERMINATED BY ','
    ENCLOSED BY '"'
LINES
    TERMINATED BY '\n'
IGNORE 1 LINES
(artist_id, speldag_id, klockslag)
;

SELECT * FROM spelning;
