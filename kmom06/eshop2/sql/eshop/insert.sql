USE eshop;

SET GLOBAL local_infile = 1;
SHOW VARIABLES LIKE 'local_inflie';

-- DELETE FROM logg;
-- DELETE FROM faktura_rad;
-- DELETE FROM faktura;
DELETE FROM order_rad;
DELETE FROM `order`;
DELETE FROM kund;
DELETE FROM produkt2lager;
DELETE FROM lager;
DELETE FROM produkt2kategori;
DELETE FROM produkt;
DELETE FROM kategori;

--
-- Insert into kategori
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

--
-- Insert into produkt
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

--
-- Insert into produkt2kategori
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

--
-- Insert into lager
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

--
-- Insert into produkt2lager
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

--
-- Insert into kund
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

--Insert into order


INSERT INTO `order`
    (kundid)
    VALUES
        (1),
        (1),
        (2),
        (3),
        (4),
        (4),
        (5);

--insert into order_rad

--DELETE FROM order_rad;

INSERT INTO order_rad
    (orderid, produktid, antal)
    VALUES
    (1, "te1", 2),
    (1, "kaffe1", 3),
    (2, "skiva1", 2),
    (2, "kaffemix1", 30),
    (2, "kaffemix2", 2),
    (2, "te1", 5),
    (3, "te1", 1),
    (4, "kaffe1", 2),
    (4, "kaffemix2", 1),
    (5, "kaffemix2", 3),
    (5, "skiva1", 10),
    (6, "te1", 8),
    (7, "kaffe1", 1);


SELECT * FROM kund;
SELECT * FROM produkt2lager;
SELECT * FROM lager;
SELECT * FROM produkt2kategori;
SELECT * FROM produkt;
SELECT * FROM kategori;
