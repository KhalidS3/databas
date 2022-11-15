--
-- Khalid Safi (khsa16)
-- 2021-03-23
-- setup for a user, creating a database and granting access
-- for the user to the database.
--

DROP DATABASE IF EXISTS exam;

-- Create the user 'user' with a backward compatible password algorithm
-- and the password 'pass'
CREATE USER IF NOT EXISTS 'user'@'%'
    IDENTIFIED WITH mysql_native_password
    BY 'pass'
;

-- Grant the user all privilegies on the database.
GRANT ALL PRIVILEGES
    ON *.*
    TO 'user'@'%'
;


-- create database for sapo
CREATE DATABASE exam;
