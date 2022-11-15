--
-- Subquery, en fråga i fråga
-- Khalid Safi
-- 2021-02-05
--

-- Struktur på subquery
SELECT (SELECT 'moped') AS 'Fordon';

--  Först skriver vi satsen som ger oss
-- alla lärare på avdelningen DIDD.
SELECT
    akronym
FROM larare
WHERE
    avdelning = 'DIDD'
;

-- Sedan tar vi satsen som ger oss alla kurstillfällen.
SELECT
    *
FROM kurstillfalle
;

-- Nu slår vi samman dessa satser till en,
-- där den ena blir en subquery som används i WHERE-villkoret.
SELECT
    *
FROM kurstillfalle
WHERE
    kursansvarig IN (
        SELECT
            akronym
        FROM larare
        WHERE
            avdelning = 'DIDD'
    )
;

-- Subqueries med UNION
(
    SELECT akronym, avdelning FROM larare WHERE avdelning = 'DIDD'
)
UNION
(
    SELECT akronym, avdelning FROM larare WHERE avdelning = 'DIPT'
)
;

-- Uppgift subquery

-- Visa detaljer om den lärare som är äldst.
-- Ta fram max ålder med en subquery och använd dess resultat i WHERE-satsen.
SELECT
    akronym,
    fornamn,
    efternamn,
    Ålder
FROM v_larare
WHERE
    Ålder = (SELECT MAX(Ålder) FROM v_larare)
;
