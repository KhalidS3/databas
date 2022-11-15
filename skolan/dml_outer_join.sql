--
-- Outer join, rader som inte matchar
-- Khalid Safi
-- 2021-02-05
--

-- Lärare som inte undervisar
SELECT DISTINCT
    akronym AS Akronym,
    CONCAT(fornamn, " ", efternamn) AS Namn
FROM
    v_planering
ORDER BY
    akronym
;

--
-- Outer join, inkludera lärare utan undervisning
-- Lefter outer join
SELECT DISTINCT
    L.akronym AS Akronym,
    CONCAT(L.fornamn, " ", L.efternamn) AS Namn,
    L.avdelning AS Avdelning,
    Kt.kurskod AS kurskod
FROM larare AS L
    LEFT OUTER JOIN kurstillfalle AS Kt
        ON L.akronym =Kt.kursansvarig
;

--
-- Outer join, inkludera lärare utan undervisning
-- righter outer join
SELECT DISTINCT
    L.akronym AS Akronym,
    CONCAT(L.fornamn, " ", L.efternamn) AS Namn,
    L.avdelning AS Avdelning,
    Kt.kurskod AS kurskod
FROM larare AS L
    RIGHT OUTER JOIN kurstillfalle AS Kt
        ON L.akronym =Kt.kursansvarig
;

-- Kurser utan kurstillfällen
SELECT DISTINCT
    K.kod AS kurskod,
    K.namn AS Kursnamn,
    Kt.lasperiod AS Lasperiod
FROM
    kurs AS K
LEFT OUTER JOIN kurstillfalle AS Kt
ON Kt.kurskod = K.kod
WHERE
    Lasperiod IS NULL
;
