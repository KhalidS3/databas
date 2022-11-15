-- Create scheme for database skolan.
-- By Khalid(khsa16) for course database.
-- 2021-01-17
--

--
-- Update a column value
--
UPDATE larare SET lon = 30000 WHERE akronym = 'gyl';

UPDATE larare
	SET
		lon = 30000
	WHERE
		lon IS NULL
;

SELECT SUM(lon) AS 'Lönesumma', SUM(kompetens) AS Kompetens FROM larare;

SELECT akronym, avdelning, fornamn, kon, lon, kompetens
FROM larare
ORDER BY lon DESC;