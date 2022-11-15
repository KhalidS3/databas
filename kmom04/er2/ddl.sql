--
-- Creating tables
--
USE eshop;

-- Dropping tables orderly
DROP TABLE IF EXISTS logg; -- done
DROP TABLE IF EXISTS faktura_rad; -- done
DROP TABLE IF EXISTS faktura; -- done
DROP TABLE IF EXISTS order_rad; -- done
DROP TABLE IF EXISTS `order`; -- done
DROP TABLE IF EXISTS kund; -- done
DROP TABLE IF EXISTS inventering; -- done
DROP TABLE IF EXISTS lager_hylla; -- done
DROP TABLE IF EXISTS produkt2kategori; -- done
DROP TABLE IF EXISTS produkt; -- done
DROP TABLE IF EXISTS produkt_kategori; -- done

-- Creating tables orderly

-- produkt_kategori table
CREATE TABLE produkt_kategori (
    id INT AUTO_INCREMENT,
    kategori VARCHAR(25),

    PRIMARY KEY (id)
)
;

-- produkt table
CREATE TABLE produkt (
    id INT AUTO_INCREMENT, -- produkt_id
    produkt_namn VARCHAR(50),
    pris INT,

    PRIMARY KEY (id)
)
;

-- produkt2kategori table
CREATE TABLE produkt2kategori (
    prod_id INT NOT NULL, -- produkt_id
    kate_id INT NOT NULL, -- kategori_id

    PRIMARY KEY (prod_id, kate_id),
    FOREIGN KEY (prod_id) REFERENCES produkt_kategori (id),
    FOREIGN KEY (kate_id) REFERENCES produkt (id)
)
;
SHOW WARNINGS;

-- lager_hylla table
CREATE TABLE lager_hylla (
    id CHAR(10), -- lager_hylla_id
    plats VARCHAR(50),

    PRIMARY KEY (id)
)
;

-- inventering table
CREATE TABLE inventering (
    h_id CHAR(10), -- hylla_id
    prod_id INT, -- produkt_id
    antal INT,

    PRIMARY KEY (h_id, prod_id),
    FOREIGN KEY (h_id) REFERENCES lager_hylla (id),
    FOREIGN KEY (prod_id) REFERENCES produkt (id)
)
;

-- kund table
CREATE TABLE kund (
    k_id INT AUTO_INCREMENT, -- kund_id
    fornamn VARCHAR(50),
    efternamn VARCHAR(55),
    tel_nr VARCHAR(50),
    adress VARCHAR(50),

    PRIMARY KEY (k_id)
)
;

-- `order` table
-- order is a keyword
-- so i am using it
-- in this formate
-- `order`
CREATE TABLE `order` (
    o_id INT AUTO_INCREMENT, -- order_id
    kd_id INT, -- kund_id

    PRIMARY KEY (o_id),
    FOREIGN KEY (kd_id) REFERENCES kund (k_id)
)
;

-- order_rad table
CREATE TABLE order_rad (
    od_id INT, -- order_id
    pdt_id INT, -- produkt_id
    antal INT,

    PRIMARY KEY (od_id, pdt_id),
    FOREIGN KEY (od_id) REFERENCES `order` (o_id),
    FOREIGN KEY (pdt_id) REFERENCES produkt (id)
)
;

-- faktura table
CREATE TABLE faktura (
    fakt_nr INT, -- faktura_nr
    order_id INT,
    kund_id INT,
    datum DATE,

    PRIMARY KEY (fakt_nr),
    FOREIGN KEY (order_id) REFERENCES `order` (o_id),
    FOREIGN KEY (kund_id) REFERENCES kund (k_id)
)
;

-- faktura_rad table
CREATE TABLE faktura_rad (
    faktura_nr INT,
    produkt_id INT,
    antal INT,

    PRIMARY KEY (faktura_nr, produkt_id),
    FOREIGN KEY (faktura_nr) REFERENCES faktura (fakt_nr),
    FOREIGN KEY (produkt_id) REFERENCES produkt (id)
)
;

-- logg table
CREATE TABLE logg (
    l_id INT AUTO_INCREMENT, -- logg_id
    beskrivning VARCHAR(100),
    tid TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- records the time
    -- of activity

    PRIMARY KEY (l_id)
)
;


--
-- Views
--

-- Inventory
-- DROP VIEW IF EXISTS v_inventory;
-- CREATE VIEW v_inventory
-- AS
--     SELECT
--         p.produkt_id,
--         p.namn,
--         p_l.hylla,
--         p_l.antal
--     FROM produkt AS p
--         LEFT OUTER JOIN produkt2lager AS p_l
--             ON p.produkt_id = p_l.produkt_id;

-- --
-- -- Procedures
-- --

-- -- Show categories
-- DROP PROCEDURE IF EXISTS show_category;
-- DELIMITER ;;
-- CREATE PROCEDURE show_category()
-- BEGIN
--     SELECT * FROM kategori;
-- END
-- ;;
-- DELIMITER ;

-- -- Show shelfs
-- DROP PROCEDURE IF EXISTS show_shelfs;
-- DELIMITER ;;
-- CREATE PROCEDURE show_shelfs()
-- BEGIN
--     SELECT * FROM lager;
-- END
-- ;;
-- DELIMITER ;

-- -- Show logg
-- DROP PROCEDURE IF EXISTS show_logg;
-- DELIMITER ;;
-- CREATE PROCEDURE show_logg(
--     a_num INT
-- )
-- BEGIN
--     SELECT
--         DATA_FORMAT(tid, "%Y-%m-%d %H:%i:%s")tid,
--         beskrivning,
--         produkt
--     FROM logg
--     ORDER BY logg_id DESC
--     LIMIT a_num;
-- END
-- ;;
-- DELIMITER ;

-- -- Show inventory
-- DROP PROCEDURE IF EXISTS show_inventory;
-- DELIMITER ;;
-- CREATE PROCEDURE show_inventory()
-- BEGIN
--     SELECT * FROM v_inventory;
-- END
-- ;;
-- DELIMITER ;

-- -- Show selected inventory
-- DROP PROCEDURE IF EXISTS show_selected_inventory;
-- DELIMITER ;;
-- CREATE PROCEDURE show_selected_inventory(
--     a_str VARCHAR(100)
-- )
-- BEGIN
--     SELECT * FROM v_inventory
--         WHERE
--             a_str = produkt_id
--             OR a_str = namn
--             OR a_str = hylla;
-- END
-- ;;
-- DELIMITER ;

-- -- Show products
-- DROP PROCEDURE IF EXISTS show_products;
-- DELIMITER ;;
-- CREATE PROCEDURE show_products()
-- BEGIN
--     SELECT
--         p.produkt_id,
--         GROUP_CONCAT(p_k.kategori) AS kategori,
--         p.namn,
--         p.pris,
--         p_l.antal
--     FROM produkt AS p
--         LEFT OUTER JOIN produkt2lager AS p_l
--             ON p.produkt_id = p_l.produkt_id
--         LEFT OUTER JOIN produkt2kategori AS p_k
--             ON p.produkt_id = p_k.produkt_id
--         GROUP BY p.produkt_id
-- ;
-- END
-- ;;
-- DELIMITER ;

-- -- Show product
-- DROP PROCEDURE IF EXISTS show_product;
-- DELIMITER ;;
-- CREATE PROCEDURE show_product(
--     a_produkt_id VARCHAR(10)
-- )
-- BEGIN
--     SELECT * FROM produkt
--     WHERE
--         produkt_id = a_produkt_id;
-- END
-- ;;
-- DELIMITER ;

-- -- Create product
-- DROP PROCEDURE create_product;
-- DELIMITER ;;
-- CREATE PROCEDURE create_product(
--     a_produkt_id VARCHAR(10),
--     a_pris INT,
--     a_namn VARCHAR (45),
--     a_bildlank VARCHAR(45),
--     a_beskrivning VARCHAR(100)
-- )
-- BEGIN
--     INSERT INTO produkt VALUES (a_produkt_id, a_pris, a_namn, a_bildlank, a_beskrivning);
-- END
-- ;;
-- DELIMITER ;

-- -- Trigger log create_product
-- DROP TRIGGER IF EXISTS trigger_create_product;
-- DELIMITER ;;
-- CREATE TRIGGER trigger_create_product
-- AFTER INSERT
-- ON produkt FOR EACH ROW
--     INSERT INTO logg (beskrivning, produkt)
--         VALUES ("Ny produkt", NEW.produkt_id)
-- ;;

-- DELIMITER ;

-- -- Delete Product
-- DROP PROCEDURE IF EXISTS delete_product;
-- DELIMITER ;;
-- CREATE PROCEDURE delete_product(
--     a_produkt_id VARCHAR(10)
-- )
-- BEGIN
--     DELETE FROM produkt2kategori
--         WHERE produkt_id = a_produkt_id;
--     DELETE FROM produkt2lager
--         WHERE produkt_id = a_produkt_id;
--     DELETE FROM produkt
--         WHERE produkt_id = a_produkt_id;
-- END
-- ;;
-- DELIMITER ;

-- -- Trigger log delete_product
-- DROP TRIGGER IF EXISTS trigger_delete_product;
-- DELIMITER ;;

-- CREATE TRIGGER trigger_delete_product
-- AFTER DELETE
-- ON produkt FOR EACH ROW
--     INSERT INTO logg (beskrivning, produkt)
--         VALUES ("Raderad produkt", OLD.produkt_id)
-- ;;
-- DELIMITER ;

-- -- Edit product
-- DROP PROCEDURE IF EXISTS edit_product;
-- DELIMITER ;;
-- CREATE PROCEDURE edit_product(
--     a_produkt_id VARCHAR(10),
--     a_pris INT,
--     a_namn VARCHAR(45),
--     a_bildlank VARCHAR(45),
--     a_beskrivning VARCHAR(100)
-- )
-- BEGIN
--     UPDATE produkt
--     SET
--         pris = a_pris,
--         namn = a_namn,
--         bildlank = a_bildlank,
--         beskrivning = a_beskrivning
--     WHERE
--         produkt = a_produkt_id;
-- END
-- ;;
-- DELIMITER ;

-- -- Trigger log edit_product
-- DROP TRIGGER IF EXISTS trigger_edit_product;
-- DELIMITER ;;

-- CREATE TRIGGER trigger_edit_product
-- AFTER UPDATE
-- ON produkt FOR EACH ROW
--     INSERT INTO logg (beskrivning, produkt)
--         VALUES ("Uppdaterad produkt", NEW.produkt_id)
-- ;;

-- DELIMITER ;

-- -- Add product to shelf
-- DROP PROCEDURE IF EXISTS add_product_to_shelf;
-- DELIMITER ;;
-- CREATE PROCEDURE add_product_toshelf(
--     a_produkt_id VARCHAR(10),
--     a_hylla CHAR(5),
--     a_antal INT
-- )
-- BEGIN
--     IF EXISTS (
--         SELECT * FROM produkt2lager
--         WHERE_
--             produkt_id = a_produkt_id
--             AND hylla = a_hylla
--     ) THEN
--         UPDATE produkt2lager
--         SET
--             antal = antal + a_antal
--         WHERE
--             produkt_id = a_produkt_id AND hylla = a_hylla;
--     ELSE
--         INSERT INTO produkt2lager
--         VALUES (a_produkt_id, a_antal, a_hylla);
--     END IF;
-- END
-- ;;
-- DELIMITER ;

-- DROP PROCEDURE IF EXISTS delete_product_from_shelf;
-- DELIMITER ;;
-- CREATE PROCEDURE delete_product_from_shelf(
--     a_produkt_id VARCHAR(10),
--     a_hylla CHAR(5),
--     a_antal INT
-- )
-- BEGIN
--     IF (a_antal <= (SELECT antal FROM produkt2lager
--                     WHERE
--                         produkt_id = a_produkt_id
--                         AND hylla = a_hylla)
--         ) THEN
--         UPDATE produkt2lager
--         SET
--             antal = antal - a_antal
--         WHERE
--             produkt_id = a_produkt_id AND hylla = a_hylla;

--     END IF;
-- END
-- ;;
-- DELIMITER ;

