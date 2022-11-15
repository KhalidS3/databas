--
-- Vyer.
-- By Khalid(khsa16) for course database.
-- 2021-01-27
--

SELECT
    CONCAT(fornamn, ' ', efternamn, ' (', LOWER(avdelning), ')') AS Namn,
    TIMESTAMPDIFF(YEAR, fodd, CURDATE()) AS Ålder
FROM
    larare
;

-- Nu skapar vi en vy av samma SELECT.
DROP VIEW IF EXISTS v_name_alder;
-- Skapa vyn
CREATE VIEW v_name_alder
AS
SELECT
    CONCAT(fornamn, ' ', efternamn, ' (', LOWER(avdelning), ')') AS Namn,
    TIMESTAMPDIFF(YEAR, fodd, CURDATE()) AS Ålder
FROM
    larare
;

-- Använd vyn
SELECT * FROM v_name_alder;

-- Som vanligt kan vi begränsa urvalet med WHERE, ORDER BY och LIMIT.
SELECT * FROM v_name_alder
WHERE Namn LIKE '%di%'
ORDER BY Ålder DESC
LIMIT 3;

-- Vy med Larare.* och Ålder

-- 1. Skapa en vy “v_larare” som innehåller samtliga kolumner från tabellen Lärare
-- inklusive en ny kolumn med lärarens ålder.
DROP VIEW IF EXISTS v_larare;

CREATE VIEW v_larare
AS
    SELECT *,
    TIMESTAMPDIFF(YEAR, fodd, CURDATE()) AS Ålder
FROM
    larare
;

-- vyn används
SELECT * FROM v_larare;

-- 2, Gör en SELECT-sats mot vyn som beräknar medelåldern på respektive avdelning.
-- Visa avdelningens namn och medelålder sorterad på medelåldern.
SELECT
    avdelning,
    ROUND(AVG(Ålder)) AS Medelåldern
FROM v_larare
GROUP BY avdelning
ORDER BY Ålder DESC;
