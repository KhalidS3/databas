-- Create scheme for database skolan.
-- By Khalid(khsa16) for course database.
-- 2021-01-17
--

SELECT * FROM larare;

-- WHERE

-- 1. Visa alla rader i tabellen där avdelningen är DIDD.
SELECT * FROM larare WHERE avdelning IN ('DIDD');

-- 2. Visa de rader som har en akronym som börjar med bokstaven ‘h’ (ledtråd LIKE).
SELECT * FROM larare WHERE akronym LIKE 'h%';

-- 3. Visa de rader vars lärares förnamn innehåller bokstaven ‘o’.
SELECT * FROM larare WHERE fornamn LIKE '%o%';

-- 4. Visa de rader där lärarna tjänar mellan 30 000 - 50 000.
SELECT * FROM larare WHERE lon >= 30000 AND lon <= 50000;

-- 5. Visa de rader där lärarens kompetens är mindre än 7 och lönen är större än 40 000.
SELECT * FROM larare WHERE kompetens < 7 AND lon > 40000;

-- 6. Visa rader som innehåller lärarna sna, dum, min (ledtråd IN).
SELECT * FROM larare WHERE akronym IN ('dum', 'min', 'sna');

-- 7. Visa de lärare som har lön över 80 000, tillsammans med de lärare som har en kompetens om 2 och jobbar på avdelningen ADM.
SELECT * FROM larare WHERE lon > 80000 OR kompetens = 2 AND avdelning IN ('ADM');

-- ORDER BY
-- Gör följande SELECT-frågor:

-- 1. Skriv endast ut namnen på alla lärare och vad de tjänar.
SELECT
	fornamn,
    lon
FROM
	larare
ORDER BY
	fornamn,
    lon
;

-- 2. Sortera listan på efternamnet, både i stigande och sjunkande ordning.
SELECT
	efternamn
FROM
	larare
ORDER BY
	efternamn ASC
;

SELECT
	efternamn
FROM
	larare
ORDER BY
	efternamn DESC
;

-- 3.Sortera listan på lönen, både i stigande och sjunkande ordning. Vem tjänar mest och vem tjänar minst?
-- tjänar mest
SELECT
	fornamn,
	lon
FROM
	larare
ORDER BY
	lon DESC
    LIMIT 1
;

-- tjäner minst
SELECT
	fornamn,
	lon
FROM
	larare
ORDER BY
	lon ASC
    LIMIT 1
;

-- 4. Välj ut de tre som tjänar mest och visa dem (ledtråd LIMIT).
-- tjänar mest
SELECT
	fornamn,
	lon
FROM
	larare
ORDER BY
	lon DESC
    LIMIT 3
;

--
-- Change namn of a column
--
SELECT
	avdelning AS 'Avdelning'
FROM larare;