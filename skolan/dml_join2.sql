--
-- Joina tabeller
-- Khalid Safi
-- 2021-02-05
--

--
-- A crossjoin
--
SELECT * FROM kurs, kurstillfalle;

--
-- Join using WHERE, use alias AS to shorten the statement
--
SELECT *
FROM kurs AS K, kurstillfalle AS Kt
WHERE K.kod = Kt.kurskod;

--
-- Join using JOIN..ON
--
SELECT *
FROM kurs AS K
    JOIN kurstillfalle AS Kt
        ON K.kod = Kt.kurskod
;

--
-- JOIN three tables
--
SELECT *
FROM kurs AS K
    JOIN kurstillfalle AS Kt
        ON K.kod = Kt.kurskod
    JOIN larare AS l
        ON l.akronym = Kt.kursansvarig
;

-- Skapa en vy och sedan bygga anpassade rapport
DROP VIEW IF EXISTS v_planering;

CREATE
    VIEW v_planering
AS SELECT *
FROM
    kurs AS K
JOIN
    kurstillfalle AS Kt
ON
    K.kod = Kt.kurskod
JOIN
    larare AS l
ON
    l.akronym = Kt.kursansvarig
;

SELECT * FROM v_planering;

-- Lärares arbetsbelastning
SELECT
    akronym AS "Akronym",
    CONCAT(fornamn, " ", efternamn) AS Namn,
    COUNT(*) AS "Tillfallen"
FROM
    v_planering
GROUP BY
    kursansvarig
ORDER BY
    Tillfallen DESC,
    akronym ASC
;

-- Du behöver de tre äldsta lärarna som
-- också undervisar på kurser
SELECT
    akronym,
    fornamn,
    efternamn,
    fodd,
    TIMESTAMPDIFF(YEAR, fodd, CURDATE()) AS "Ålder"
FROM
    larare
ORDER BY
    Ålder DESC
LIMIT 3
;

SELECT
    CONCAT(namn, " (", kod, ")") AS "Kursnamn",
    CONCAT(L.fornamn, " ", L.efternamn, " (", L.akronym, ")") AS "Larare",
    TIMESTAMPDIFF(YEAR, L.fodd, CURDATE()) AS "Ålder"
FROM
    v_planering AS Plan
JOIN
    v_larare AS L
ON
    Plan.akronym = L.akronym
ORDER BY
    Ålder DESC
LIMIT 6
;
