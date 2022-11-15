-- Skapa databasen eshop
CREATE DATABASE IF NOT EXISTS eshop;

-- Skapa en användare user med lösenorder pass och ge tillgång oavsett hostnamn.
CREATE USER IF NOT EXISTS 'user'@'%'
    IDENTIFIED BY 'pass'
;

-- Ge användaren user alla rättigheter på databasen.
GRANT ALL PRIVILEGES
    ON eshop.*
    TO 'user'@'%'
;
