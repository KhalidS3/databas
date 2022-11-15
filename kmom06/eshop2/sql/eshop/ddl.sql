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

--
-- Table kategori
--
CREATE TABLE kategori (
    kategori VARCHAR(100),

    PRIMARY KEY (kategori)
)
ENGINE INNODB
CHARSET utf8
COLLATE utf8_swedish_ci
;
SHOW WARNINGS;

--
-- Table produbk
--
CREATE TABLE produkt (
    produktid VARCHAR(10),
    pris INT,
    namn VARCHAR(45),
    bildlank VARCHAR(45),
    beskrivning VARCHAR(150),

    PRIMARY KEY (produktid),
    UNIQUE KEY `unique_namn` (namn),
    KEY `index_pris` (pris)
)
ENGINE INNODB
CHARSET utf8
COLLATE utf8_swedish_ci
;
SHOW WARNINGS;

--
-- Table produkt2kategori
--
CREATE TABLE produkt2kategori (
    produktid VARCHAR(10) NOT NULL,
    kategori VARCHAR(45) NOT NULL,

    PRIMARY KEY (produktid, kategori),
    FOREIGN KEY (produktid) REFERENCES produkt (produktid) ON DELETE CASCADE,
    FOREIGN KEY (kategori) REFERENCES kategori (kategori) ON DELETE CASCADE
)
ENGINE INNODB
CHARSET utf8
COLLATE utf8_swedish_ci
;
SHOW WARNINGS;

--
-- Table lager
--
CREATE TABLE lager (
    hylla CHAR(5),

    PRIMARY KEY (hylla)
)
ENGINE INNODB
CHARSET utf8
COLLATE utf8_swedish_ci
;
SHOW WARNINGS;

--
-- Table produkt2lager
--
CREATE TABLE produkt2lager (
    produktid VARCHAR(10),
    antal INT,
    hylla CHAR(5),

    PRIMARY KEY (produktid, hylla),
    FOREIGN KEY (produktid) REFERENCES produkt (produktid) ON DELETE CASCADE,
    FOREIGN KEY (hylla) REFERENCES lager (hylla) ON DELETE CASCADE
)
ENGINE INNODB
CHARSET utf8
COLLATE utf8_swedish_ci
;
SHOW WARNINGS;

--
-- Table kund
--
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
SHOW WARNINGS;

--
-- Table `order`
--
CREATE TABLE `order` (
    orderid INT NOT NULL AUTO_INCREMENT,
    kundid INT,
    skapad TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    uppdaterad TIMESTAMP DEFAULT NULL
                                ON UPDATE CURRENT_TIMESTAMP,
    raderad TIMESTAMP DEFAULT NULL,
    bestalld TIMESTAMP DEFAULT NULL,
    skickad TIMESTAMP DEFAULT NULL,

    PRIMARY KEY (orderid),
    FOREIGN KEY (kundid) REFERENCES kund (kundid) ON DELETE CASCADE
)
ENGINE INNODB
CHARSET utf8
COLLATE utf8_swedish_ci
;
SHOW WARNINGS;

--
-- Table order_rad
--
CREATE TABLE order_rad (
	orderid INT,
    produktid VARCHAR(10),
    antal INT NOT NULL DEFAULT 1,

    PRIMARY KEY (orderid, produktid),
    FOREIGN KEY (orderid) REFERENCES `order` (orderid) ON DELETE CASCADE,
    FOREIGN KEY (produktid) REFERENCES produkt (produktid) ON DELETE CASCADE
)
ENGINE INNODB
CHARSET utf8
COLLATE utf8_swedish_ci
;
SHOW WARNINGS;

--
-- Table faktura
--
CREATE TABLE faktura (
    fakturanr INT AUTO_INCREMENT,
    orderid INT,
    kundid INT,
    datum TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (fakturanr),
    FOREIGN KEY (orderid) REFERENCES `order` (orderid) ON DELETE CASCADE,
    FOREIGN KEY (kundid) REFERENCES kund (kundid) ON DELETE CASCADE
)
ENGINE INNODB
CHARSET utf8
COLLATE utf8_swedish_ci
;
SHOW WARNINGS;

--
-- Table faktura_rad
--
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
SHOW WARNINGS;

--
-- Table logg
--
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
SHOW WARNINGS;

--
-- Views
--

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
SHOW WARNINGS;

--
-- Procedures
--

--
-- Show categories
--
DROP PROCEDURE IF EXISTS show_category;
DELIMITER ;;
CREATE PROCEDURE show_category()
BEGIN
    SELECT * FROM kategori;
END
;;

DELIMITER ;
SHOW WARNINGS;
-- CALL show_category();

--
-- Show product on shelf
--
DROP PROCEDURE IF EXISTS show_shelfs;
DELIMITER ;;
CREATE PROCEDURE  show_shelfs()
BEGIN
    SELECT * FROM lager;
END
;;
DELIMITER ;
SHOW WARNINGS;

--
-- Show orders
--
DROP PROCEDURE IF EXISTS show_orders;
DELIMITER ;;
CREATE PROCEDURE show_orders()
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
END
;;
DELIMITER ;

--
-- Show selected order
--
DROP PROCEDURE IF EXISTS show_selected_orders;
DELIMITER ;;
CREATE PROCEDURE show_selected_orders(
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
END
;;
DELIMITER ;

--
-- Show logg activity
--
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
SHOW WARNINGS;

--
-- Show inventory, it show where are the product
-- locations
--
DROP PROCEDURE IF EXISTS show_inventory;
DELIMITER ;;
CREATE PROCEDURE show_inventory()
BEGIN
    SELECT * FROM v_inventory;
END
;;
DELIMITER ;
SHOW WARNINGS;

--
-- Show all customers
--
DROP PROCEDURE IF EXISTS show_all_customers;
DELIMITER ;;
CREATE PROCEDURE show_all_customers()
BEGIN
    SELECT
        kundid,
        CONCAT(fornamn, " ", efternamn) AS namn,
        CONCAT(adress, ", ", postnummer, " ", ort, ", ", land) AS adress,
        telefon
    FROM
        kund;
END
;;
DELIMITER ;

--
-- Show select inventory
--
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
SHOW WARNINGS;

--
-- Show products
--
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
SHOW WARNINGS;
-- CALL show_products();

--
-- Show specific product
--
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
SHOW WARNINGS;

--
-- Show specific order
--
DROP PROCEDURE IF EXISTS show_an_order;
DELIMITER ;;
CREATE PROCEDURE show_an_order(
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
END
;;
DELIMITER ;

--
-- Show an order row
--

DROP PROCEDURE IF EXISTS show_an_order_row;
DELIMITER ;;
CREATE PROCEDURE show_an_order_row(
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
END
;;
DELIMITER ;

--
-- Create a new product
--
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
SHOW WARNINGS;

--
-- Trigger to log for create_product
--
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
SHOW WARNINGS;

--
-- Deleting an existing a product
--
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
SHOW WARNINGS;

--
-- Trigger to log for dlete_product
--
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
SHOW WARNINGS;

--
-- Edit a existing product
--
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
SHOW WARNINGS;

--
-- Trigger to log for editing existing product
--
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
SHOW WARNINGS;

--
-- Create an order
--
DROP PROCEDURE IF EXISTS create_an_order;
DELIMITER ;;
CREATE PROCEDURE create_an_order(
    a_kundid INT
)
BEGIN
    INSERT INTO `order` (kundid) VALUES (a_kundid);
END
;;
DELIMITER ;

--
-- Create an order row
--
DROP PROCEDURE IF EXISTS create_an_order_row;
DELIMITER ;;
CREATE PROCEDURE create_an_order_row(
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
END
;;
DELIMITER ;

--
-- Add product to shelf
--
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
SHOW WARNINGS;

--
-- Delete product from shelf
--
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
SHOW WARNINGS;

--
-- Set order status
--
DROP PROCEDURE IF EXISTS set_order_status;
DELIMITER ;;
CREATE PROCEDURE set_order_status(
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
END
;;
DELIMITER ;

--
-- Undo deleted order
--
DROP PROCEDURE IF EXISTS undo_deleted_order;
DELIMITER ;;
CREATE PROCEDURE undo_deleted_order(
    a_orderid INT
)
BEGIN
    UPDATE `order`
    SET
        raderad = NULL
    WHERE
        orderid = a_orderid;
END
;;
DELIMITER ;

--
-- Picklist
--
DROP PROCEDURE IF EXISTS picklist;
DELIMITER ;;
CREATE PROCEDURE picklist(
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
END
;;
DELIMITER ;

--
-- Functions
--

--
-- Function for order_status()
--
DROP FUNCTION IF EXISTS order_status;
DELIMITER ;;
CREATE FUNCTION order_status(
    skapad TIMESTAMP,
    uppdaterad TIMESTAMP,
    raderad TIMESTAMP,
    bestalld TIMESTAMP,
    skickad TIMESTAMP
)
RETURNS VARCHAR(50)
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
END
;;
DELIMITER ;

--
-- Show category with specific products
--
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
SHOW WARNINGS;

--
-- Show logg activity
--
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
SHOW WARNINGS;
