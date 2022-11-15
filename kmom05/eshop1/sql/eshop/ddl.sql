--
-- Creating tables
--
USE eshop;

-- Dropping tables orderly
DROP TABLE IF EXISTS logg;
DROP TABLE IF EXISTS faktura_rad;
DROP TABLE IF EXISTS faktura;
DROP TABLE IF EXISTS order_rad;
DROP TABLE IF EXISTS `order`;
DROP TABLE IF EXISTS kund;
DROP TABLE IF EXISTS produkt2lager;
DROP TABLE IF EXISTS lager;
DROP TABLE IF EXISTS produkt2kategori;
DROP TABLE IF EXISTS produkt;
DROP TABLE IF EXISTS kategori;

-- Table kategori
CREATE TABLE kategori (
    kategori VARCHAR(100),

    PRIMARY KEY (kategori)
)
ENGINE INNODB
CHARSET utf8
COLLATE utf8_swedish_ci
;

-- Table produbk
CREATE TABLE produkt (
    produktid VARCHAR(10),
    pris INT,
    namn VARCHAR(45),
    bildlank VARCHAR(45),
    beskrivning VARCHAR(200),

    PRIMARY KEY (produktid)
)
ENGINE INNODB
CHARSET utf8
COLLATE utf8_swedish_ci
;

-- Table produkt2kategori
CREATE TABLE produkt2kategori (
    produktid VARCHAR(10) NOT NULL,
    kategori VARCHAR(45) NOT NULL,

    PRIMARY KEY (produktid, kategori),
    FOREIGN KEY (produktid) REFERENCES produkt (produktid),
    FOREIGN KEY (kategori) REFERENCES kategori (kategori)
)
ENGINE INNODB
CHARSET utf8
COLLATE utf8_swedish_ci
;

-- Table lager
CREATE TABLE lager (
    hylla CHAR(5),

    PRIMARY KEY (hylla)
)
ENGINE INNODB
CHARSET utf8
COLLATE utf8_swedish_ci
;

-- Table produkt2lager
CREATE TABLE produkt2lager (
    produktid VARCHAR(10),
    antal INT,
    hylla CHAR(5),

    PRIMARY KEY (produktid, hylla),
    FOREIGN KEY (produktid) REFERENCES produkt (produktid),
    FOREIGN KEY (hylla) REFERENCES lager (hylla)
)
ENGINE INNODB
CHARSET utf8
COLLATE utf8_swedish_ci
;

-- Table kund
CREATE TABLE kund (
    kundid INT AUTO_INCREMENT,
    fornamn VARCHAR(45),
    efternamn VARCHAR(45),
    adress VARCHAR(45),
    postnummer CHAR(6),
    ort VARCHAR(45),
    land VARCHAR(45),
    telefon VARCHAR(20),

    PRIMARY KEY (kundid)
)
ENGINE INNODB
CHARSET utf8
COLLATE utf8_swedish_ci
;

-- Table `order`
CREATE TABLE `order` (
    orderid INT AUTO_INCREMENT,
    kundid INT,

    PRIMARY KEY (orderid),
    FOREIGN KEY (kundid) REFERENCES kund (kundid)
)
ENGINE INNODB
CHARSET utf8
COLLATE utf8_swedish_ci
;

-- Table order_rad
CREATE TABLE order_rad (
	orderid INT,
    produktid VARCHAR(10),
    antal INT,

    PRIMARY KEY (orderid, produktid),
    FOREIGN KEY (orderid) REFERENCES `order` (orderid),
    FOREIGN KEY (produktid) REFERENCES produkt (produktid)
)
ENGINE INNODB
CHARSET utf8
COLLATE utf8_swedish_ci
;

-- Table faktura
CREATE TABLE faktura (
    fakturanr INT AUTO_INCREMENT,
    orderid INT,
    kundid INT,
    datum TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (fakturanr),
    FOREIGN KEY (orderid) REFERENCES `order` (orderid),
    FOREIGN KEY (kundid) REFERENCES kund (kundid)
)
ENGINE INNODB
CHARSET utf8
COLLATE utf8_swedish_ci
;

-- Table faktura_rad
CREATE TABLE faktura_rad (
    fakturanr INT,
    produktid VARCHAR(10),
    antal INT,

    PRIMARY KEY (fakturanr, produktid),
    FOREIGN KEY (fakturanr) REFERENCES faktura (fakturanr),
    FOREIGN KEY (produktid) REFERENCES produkt (produktid)
)
ENGINE INNODB
CHARSET utf8
COLLATE utf8_swedish_ci
;

-- Table logg
CREATE TABLE logg (
    loggid INT AUTO_INCREMENT,
    tid TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    beskrivning VARCHAR(45),
    produkt VARCHAR(45),

    PRIMARY KEY (loggid)
)
ENGINE INNODB
CHARSET utf8
COLLATE utf8_swedish_ci
;

-- Views

-- Creating view inventory
DROP VIEW IF EXISTS v_inventory;
CREATE VIEW v_inventory
AS
    SELECT
        p.produktid,
        p.namn,
        p_l.hylla,
        p_l.antal
    FROM
        produkt AS p
    LEFT OUTER JOIN
        produkt2lager AS p_l
    ON p.produktid = p_l.produktid
GROUP BY
    p.produktid
;

--
-- Procedures
--

-- Show categories
DROP PROCEDURE IF EXISTS show_category;
DELIMITER ;;
CREATE PROCEDURE show_category()
BEGIN
    SELECT * FROM kategori;
END
;;

DELIMITER ;

-- CALL show_category();

-- Show products
DROP PROCEDURE IF EXISTS show_products;
DELIMITER ;;
CREATE PROCEDURE show_products()
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
END
;;
DELIMITER ;

-- CALL show_products();

-- Show specific product
DROP PROCEDURE IF EXISTS show_product;
DELIMITER ;;
CREATE PROCEDURE show_product(
    a_produktid VARCHAR(15)
)
BEGIN
    SELECT * FROM produkt
    WHERE
        produktid = a_produktid;
END
;;
DELIMITER ;

-- Show category with specific products
DROP PROCEDURE IF EXISTS show_kategori_products;
DELIMITER ;;
CREATE PROCEDURE show_kategori_products(
    a_produktid VARCHAR(15),
    a_kategori VARCHAR(15)
)
BEGIN
    SELECT * FROM produkt2kategori
    WHERE
        produktid = a_produktid
        OR kategori = a_kategori;
END
;;
DELIMITER ;

-- Create a new product
DROP PROCEDURE IF EXISTS create_product;
DELIMITER ;;
CREATE PROCEDURE create_product(
    a_produktid VARCHAR(15),
    a_pris INT,
    a_namn VARCHAR(50),
    a_bildlank VARCHAR(50),
    a_beskrivning VARCHAR(150)
)
BEGIN
    INSERT INTO produkt VALUES (a_produktid, a_pris, a_namn, a_bildlank, a_beskrivning);
END
;;
DELIMITER ;

-- Trigger to log for create_product
DROP TRIGGER IF EXISTS trigger_create_product;

DELIMITER ;;

CREATE TRIGGER trigger_create_product
AFTER INSERT
ON
    produkt FOR EACH ROW
        INSERT INTO logg (beskrivning, produkt)
            VALUES ("New product", NEW.produktid)
;;

DELIMITER ;

-- Edit a existing product
DROP PROCEDURE IF EXISTS edit_product;
DELIMITER ;;
CREATE PROCEDURE edit_product(
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
END
;;
DELIMITER ;

-- Trigger to log for editing existing product
DROP TRIGGER IF EXISTS trigger_edit_product;
DELIMITER ;;

CREATE TRIGGER trigger_edit_product
AFTER UPDATE
ON
    produkt FOR EACH ROW
        INSERT INTO logg (beskrivning, produkt)
            VALUES ("Uppdated product", NEW.produktid)
;;

DELIMITER ;

-- Deleting an existing a product
DROP PROCEDURE IF EXISTS delete_product;
DELIMITER ;;
CREATE PROCEDURE delete_product(
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
END
;;
DELIMITER ;

-- Trigger to log for dlete_product
DROP TRIGGER IF EXISTS trigger_delete_product;
DELIMITER ;;

CREATE TRIGGER trigger_delete_product
AFTER DELETE
ON
    produkt FOR EACH ROW
        INSERT INTO logg (beskrivning, produkt)
            VALUES ("Deleted product", OLD.produktid)
;;

DELIMITER ;

-- Show logg activity
DROP PROCEDURE IF EXISTS show_loggs;
DELIMITER ;;
CREATE PROCEDURE show_loggs(
    -- a_num INT
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
    -- LIMIT a_num;
END
;;
DELIMITER ;

-- Terminal client part

-- Show logg activity
DROP PROCEDURE IF EXISTS show_logg;
DELIMITER ;;
CREATE PROCEDURE show_logg(
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
END
;;
DELIMITER ;

-- Show product on shelf
DROP PROCEDURE IF EXISTS show_shelfs;
DELIMITER ;;
CREATE PROCEDURE  show_shelfs()
BEGIN
    SELECT * FROM lager;
END
;;
DELIMITER ;

-- Show inventory, it show where are the product
-- locations
DROP PROCEDURE IF EXISTS show_inventory;
DELIMITER ;;
CREATE PROCEDURE show_inventory()
BEGIN
    SELECT * FROM v_inventory;
END
;;
DELIMITER ;

-- Show select inventory
DROP PROCEDURE IF EXISTS show_selected_inventory;
DELIMITER ;;
CREATE PROCEDURE show_selected_inventory(
    search VARCHAR(100)
)
BEGIN
    SELECT * FROM v_inventory
        WHERE
            search = produktid
            OR search = namn
            OR search = hylla;
END
;;
DELIMITER ;

-- Add product to shelf
DROP PROCEDURE IF EXISTS add_product_to_shelf;
DELIMITER ;;
CREATE PROCEDURE add_product_to_shelf(
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
END
;;
DELIMITER ;

-- Delete product from shelf
DROP PROCEDURE IF EXISTS delete_product_from_shelf;
DELIMITER ;;
CREATE PROCEDURE delete_product_from_shelf(
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
END
;;
DELIMITER ;
