-- Create scheme for database skolan.
-- By Khalid(khsa16) for course database.
-- 2021-01-17
--
SELECT * FROM larare;
-- Add column to table
-- 1. Lägg till kolumnen kompetens (integer) i tabellen lärare med hjälp av kommandot ALTER TABLE.
ALTER TABLE larare ADD COLUMN kompetens INT;

-- 2. Ta bort samma kolumn med kommandot ALTER TABLE DROP COLUMN
ALTER TABLE larare DROP COLUMN kompetens;

-- 3. Lägg till samma kolumn igen, modifiera så att kolumnen definieras med default-värdet 1 (DEFAULT) 
-- och att den inte kan innehålla NULL-värden (NOT NULL).
ALTER TABLE larare ADD COLUMN kompetens INT DEFAULT 1 NOT NULL;

SELECT akronym, fornamn, kompetens FROM larare;

SHOW COLUMNS FROM larare;