-- Create scheme for database skolan.
-- By Khalid(khsa16) for course database.
-- 2021-01-17
--

SELECT
	SUM(lon) AS Lönesumma,
    SUM(kompetens) AS Kompetnes
FROM larare
;

SELECT * FROM larare;

-- Ingen lärare skall få lägre löneökning än 3%

-- 1. Skriv en SELECT-sats som räknar ut hur mycket pengar som ligger i lönepotten och skall fördelas ut.
SELECT SUM(lon) * 0.064 AS Lönepotten FROM larare;

-- Type SQL to make the following changes:

-- 1. Albus kompetens är nu 7 och lönen har ökat till 85 000.
UPDATE larare
	SET
		kompetens = 7,
        lon = 85000
	WHERE
		fornamn = 'Albus'
;

-- 2. Minervas lön har ökat med 4 000.
UPDATE larare
	SET
		lon = lon + 4000
	WHERE
		akronym IN ('min')
;

-- 3. Argus har fått ett risktillägg om 2 000 och kompetensen är satt till 3.
UPDATE larare
	SET
		lon = lon + 2000,
        kompetens = 3
	WHERE
		fornamn = 'Argus'
;

-- 4. Gyllenroy och Alastor har hög frånvaro och har fått ett löneavdrag med 3 000.
UPDATE larare
	SET
		lon = lon - 3000
	WHERE
		fornamn IN ('Alastor', 'Gyllenroy')
;

-- 5. Alla lärare på avdelningen DIDD fick en extra lönebonus om 2%.
UPDATE larare
	SET
		lon = lon * 1.02
	WHERE
		avdelning IN ('DIDD')
;

-- 6. Alla låglönade kvinnliga lärare, de som tjänar färre än 40 000, fick en lönejustering om extra 3%
UPDATE larare
	SET
		lon = lon * 1.03
	WHERE
		lon < 40000 AND
        kon IN ('K')
;

-- 7. Ge Snape, Minerva och Hagrid ett extra lönetillägg om 5 000 för extra arbete de utför åt Albus och öka deras kompetens med +1.
UPDATE larare
	SET
		lon = lon + 5000,
        kompetens = kompetens + 1
	WHERE
		efternamn IN ('Snape') OR
		fornamn IN ('Minerva', 'Hagrid')
;

-- 8. Ge alla lärare en ökning om 2.2% men exkludera Albus, Snape, Minerva och Hagrid som redan fått tillräckligt.
UPDATE larare
	SET
		lon = lon * 1.022
	WHERE
		fornamn NOT IN ('Albus', 'Hagrid', 'Minerva') AND
        efternamn NOT IN ('Snape')
;

-- Check the new salary sum and how much% the salary sum has increased by making reports with SELECT.

-- 1. Vilken är numer den totala lönesumman?
SELECT
	SUM(lon) AS Lönesumma
FROM
	larare
;

-- 3. Vilken är numer den totala kompetensen?
SELECT
	SUM(kompetens) AS Kompetens
FROM
	larare
;

SELECT akronym, avdelning, fornamn, efternamn, kon, lon, kompetens
FROM larare
ORDER BY lon DESC
;