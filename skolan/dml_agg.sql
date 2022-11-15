--
-- By Khalid(khsa16) for course database.
-- 2021-01-26
--
SELECT SUM(lon) FROM larare;

-- Uppgifter MIN och MAX

-- Hur mycket är den högsta lönen som en lärare har?
SELECT akronym, efternamn, MAX(lon) FROM larare;

-- Hur mycket är den lägsta lönen som en lärare har?
SELECT akronym, efternamn, MIN(lon) FROM larare;

-- Om GROUP BY
SELECT AVG(kompetens) FROM larare;

SELECT
    avdelning,
    AVG(kompetens)
FROM larare
GROUP BY avdelning
;

SELECT avdelning, kompetens, SUM(lon) AS Summa
FROM larare
GROUP BY avdelning, kompetens
ORDER BY Summa DESC
;

-- Uppgifter GROUP BY

-- 1.Hur många lärare jobbar på de respektive avdelning?
SELECT
    avdelning,
    COUNT(*)
FROM larare
GROUP BY avdelning
;

-- 2.Hur mycket betalar respektive avdelning ut i lön varje månad?
SELECT
    avdelning,
    SUM(lon) AS "Respektive avdelning lön/månad"
FROM larare
GROUP BY avdelning
;

-- 3.Hur mycket är medellönen för de olika avdelningarna?
SELECT
    avdelning,
    AVG(lon) AS "Medellön"
FROM larare
GROUP BY avdelning
;

-- 4.Hur mycket är medellönen för kvinnor kontra män?
SELECT
    kon AS "Kön",
    AVG(lon) AS "Medellön"
FROM larare
GROUP BY kon
;

-- Visa snittet på kompetensen för alla avdelningar, sortera på kompetens i sjunkande ordning
-- och visa enbart den avdelning som har högst kompetens.
SELECT
    avdelning,
    AVG(kompetens)
FROM larare
GROUP BY avdelning
ORDER BY avdelning ASC
LIMIT 1
;

-- Visa den avrundade snittlönen (ROUND()) grupperad per avdelning och per kompetens,
-- sortera enligt avdelning och snittlön.
-- Visa även hur många som matchar i respektive gruppering.
SELECT
    avdelning,
    kompetens,
    ROUND(AVG(lon)) AS "Snittlön",
    COUNT(*) AS Antal
FROM larare
GROUP BY avdelning, kompetens, lon
ORDER BY avdelning, lon ASC
;

-- Om HAVING
SELECT
    avdelning,
    ROUND(AVG(lon)) AS Snittlon,
    COUNT(lon) AS Antal
FROM larare
GROUP BY
    avdelning
ORDER BY
    Snittlon DESC
;


-- 1. Vi vill se snittlön per avdelning (och antal), men bara om snittlönen är större än 35000.
SELECT
    avdelning,
    ROUND(AVG(lon)) AS Snittlon,
    COUNT(lon) AS Antal
FROM larare
GROUP BY
    avdelning
HAVING
    Snittlon > 35000
ORDER BY
    Snittlon DESC
;

-- 2. Vi vill se snittlönen per avdelning (och antal), men bara om det är 3 eller fler personer
-- på den avdelningen.
SELECT
    avdelning,
    ROUND(AVG(lon)) AS Snittlon,
    COUNT(lon) AS Antal
FROM larare
GROUP BY
    avdelning
HAVING
    Antal >= 3
ORDER BY
    Snittlon DESC
;

-- Om WHERE kontra HAVING
SELECT
    avdelning,
    ROUND(AVG(lon)) AS Snittlon,
    COUNT(lon) AS Antal
FROM larare
WHERE
    kompetens = 1
GROUP BY
    avdelning
ORDER BY
    avdelning
;

SELECT
    avdelning,
    ROUND(AVG(lon)) AS Snittlon,
    COUNT(lon) AS Antal
FROM larare
WHERE
    kompetens = 1
GROUP BY
    avdelning
HAVING
    Snittlon < 30000
ORDER BY
    avdelning
;

-- För att dubbelkolla vilka det är så tjuvkikar vi med en SELECT-sats.
SELECT
    akronym,
    avdelning,
    lon
FROM larare
WHERE
    kompetens = 1
    AND avdelning = 'DIPT'
;

-- Upgifter HAVING
-- Gör nu en egen rapport med GROUP BY och HAVING.

-- 1. Visa per avdelning hur många anställda det finns, gruppens snittlön,
-- sortera per avdelning och snittlön.
SELECT
    avdelning,
    ROUND(AVG(lon)) AS Snittlon,
    COUNT(lon) AS Antal
FROM larare
GROUP BY
    avdelning
HAVING
    Snittlon
ORDER BY
    Snittlon DESC
;

-- 2. Visa samma sak som i 1), men visa nu även de kompetenser som finns.
-- Du behöver gruppera på avdelning och per kompetens, sortera per avdelning
-- och per kompetens.
SELECT
    avdelning,
    kompetens,
    ROUND(AVG(lon)) AS Snittlon,
    COUNT(lon) AS Antal
FROM larare
GROUP BY
    avdelning,
    kompetens
HAVING
    kompetens
ORDER BY
    avdelning,
    kompetens DESC
;

-- 3. Visa samma sak som i 2), men ignorera de kompetenser som är större än 3.
SELECT
    avdelning,
    kompetens,
    ROUND(AVG(lon)) AS Snittlon,
    COUNT(lon) AS Antal
FROM larare
GROUP BY
    avdelning,
    kompetens
HAVING
    kompetens < 3
ORDER BY
    avdelning,
    kompetens DESC
;

-- 4. Visa samma sak som i 3), men exkludera de grupper som har fler än 1 deltagare
-- och inkludera de som har snittlön mellan 30 000 - 45 000. Sortera per snittlön.
SELECT
    avdelning,
    kompetens,
    ROUND(AVG(lon)) AS Snittlon,
    COUNT(lon) AS Antal
FROM larare
WHERE
    lon >= 1
GROUP BY
    avdelning,
    kompetens
HAVING
    Snittlon >= 30000
    AND
    Snittlon <= 45000
ORDER BY
    lon DESC
;
