--
-- Setup a user, create a database and grant
-- privileges to it
DROP DATABASE IF EXISTS dbwebb;
DROP USER IF EXISTS 'use'@'%';

CREATE USER IF NOT EXISTS 'use'@'%'
	IDENTIFIED WITH mysql_native_password
    BY 'pass'
;

-- Granting privilegies on the database
GRANT ALL PRIVILEGES
	ON dbwebb.*
    TO 'user'@'%'
;

-- creating the database
CREATE DATABASE IF NOT EXISTS dbwebb;
