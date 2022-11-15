-- Create scheme for database skolan.
-- By Khalid(khsa16) for course database.
-- 2021-01-17
--
select * from larare;
--
-- Delete rows from table
--

-- 1. Radera Hagrid (1 rad)
DELETE FROM larare WHERE fornamn = 'Hagrid';

-- 2. Radera alla som jobbar på avdelningen DIPT (3 rader).
DELETE FROM larare WHERE avdelning = 'DIPT';

-- 3. Radera alla som har en lön, men begränsa antalet rader
-- som får raderas till 2 (LIMIT) (2 rader påverkas).
DELETE FROM larare WHERE lon LIMIT 2;

-- 4. Radera samtliga återstående lärare.
DELETE FROM larare WHERE lon;