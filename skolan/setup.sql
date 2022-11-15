-- Creating the database skolan
-- DROP DATABASE dbwebb;
CREATE DATABASE IF NOT EXISTS skolan;

-- Välj vilken databas du vill använda
USE skolan;

-- Ta bort en användare
-- DROP USER 'user'@'%';
-- DROP USER IF EXISTS 'user'@'%';

-- Create the user with a backward compatible password algorithm
CREATE USER IF NOT EXISTS 'user'@'%'
IDENTIFIED
WITH mysql_native_password -- MYSQL with version > 8.0.4
BY 'pass'
;

-- Give the user all the rights to all databases.
GRANT ALL PRIVILEGES
	ON *.*
    TO 'user'@'%'
;

-- show database
-- SHOW DATABASES;

-- Show what a user can do against which database.
SHOW GRANTS FOR 'user'@'%';

-- Show for current users
-- SHOW GRANTS FOR CURRENT_USER;
-- 
-- View which databases are available
-- called something like *skolan*
SHOW DATABASES LIKE "%skolan%";
