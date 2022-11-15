--
-- Creating database for
-- eshop
--

-- Dropping database first 
DROP DATABASE IF EXISTS eshop;

-- Creating database eshop
CREATE DATABASE eshop;

DROP USER IF EXISTS 'user'@'%';
-- Creating user and password: pass
CREATE USER 'user'@'%'
	IDENTIFIED WITH mysql_native_password
    BY 'pass'
;
SHOW WARNINGS;

-- Grantting the user all privilegies on the database
GRANT ALL PRIVILEGES
	ON eshop.*
    TO 'user'@'%'
;
