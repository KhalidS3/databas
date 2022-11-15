--
-- LOAD DATA INFILE
-- Khalid Safi
--
USE eshop;

--
-- Delete tables, in order
--
DELETE FROM kund;
DELETE FROM produkt2lager;
DELETE FROM lager;
DELETE FROM produkt2kategori;
DELETE FROM produkt;
DELETE FROM kategori;

--
-- Enable LOAD DATA LOCAL INFILE on the server.
--
SET GLOBAL local_infile = 1;
SHOW VARIABLES LIKE 'local_inflie';

--
-- Insert into the kategori
--
DELETE FROM kategori;

LOAD DATA LOCAL INFILE 'kategori.csv'
INTO TABLE kategori
CHARSET utf8
FIELDS
    TERMINATED BY ','
    ENCLOSED BY '"'
LINES
    TERMINATED BY '\n'
IGNORE 1 LINES
;

SELECT * FROM kategori;

--
-- Insert into the produkt
--
DELETE FROM produkt;

LOAD DATA LOCAL INFILE 'produkt.csv'
INTO TABLE produkt
CHARSET utf8
FIELDS
    TERMINATED BY ','
    ENCLOSED BY '"'
LINES
    TERMINATED BY '\n'
IGNORE 1 LINES
;

SELECT * FROM produkt;

--
-- Insert into the produkt2kategori
--
DELETE FROM produkt2kategori;

LOAD DATA LOCAL INFILE 'produkt2kategori.csv'
INTO TABLE produkt2kategori
CHARSET utf8
FIELDS
    TERMINATED BY ','
    ENCLOSED BY '"'
LINES
    TERMINATED BY '\n'
IGNORE 1 LINES
;

SELECT * FROM produkt2kategori;

--
-- Insert into the lager
--
DELETE FROM lager;

LOAD DATA LOCAL INFILE 'lager.csv'
INTO TABLE lager
CHARSET utf8
FIELDS
    TERMINATED BY ','
    ENCLOSED BY '"'
LINES
    TERMINATED BY '\n'
IGNORE 1 LINES
;

SELECT * FROM lager;

--
-- Insert into the produkt2lager
--
DELETE FROM produkt2lager;

LOAD DATA LOCAL INFILE 'produkt2lager.csv'
INTO TABLE produkt2lager
CHARSET utf8
FIELDS
    TERMINATED BY ','
    ENCLOSED BY '"'
LINES
    TERMINATED BY '\n'
IGNORE 1 LINES
;

SELECT * FROM produkt2lager;

--
-- Insert into the kund
--
DELETE FROM kund;

LOAD DATA LOCAL INFILE 'kund.csv'
INTO TABLE kund
CHARSET utf8
FIELDS
    TERMINATED BY ','
    ENCLOSED BY '"'
LINES
    TERMINATED BY '\n'
IGNORE 1 LINES
    (fornamn, efternamn, adress, postnummer, ort, land, telefon)
;

SELECT * FROM kund;
