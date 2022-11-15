DROP TABLE IF EXISTS `course`;
CREATE TABLE `course`
(
    `code` CHAR(6),
    `nick` CHAR(12),
    `points` DECIMAL(3, 1),
    `name` VARCHAR(60)
);

DELETE FROM course;
INSERT INTO course
VALUES
    ('DV1531', 'python',     7.5, 'Programmering och Problemlösning med Python'),
    ('PA1439', 'htmlphp',    7.5, 'Webbteknologier'),
    ('DV1561', 'javascript', 7.5, 'Programmering med JavaScript'),
    ('PA1436', 'design',     7.5, 'Teknisk webbdesign och användbarhet'),
    ('DV1547', 'linux',      7.5, 'Programmera webbtjänster i Linux'),
    ('PA1437', 'oopython',   7.5, 'Objektorienterad design och programmering med Python'),
    ('DV1546', 'webapp',     7.5, 'Webbapplikationer för mobila enheter'),
    ('DV1506', 'webgl',      7.5, 'Spelteknik för webben'),
    ('PA1444', 'dbjs',      10.0, 'Webbprogrammering och databaser')
;

SELECT * FROM course;
EXPLAIN course;
EXPLAIN SELECT * FROM course;

SELECT * FROM course WHERE code = 'PA1444';
EXPLAIN SELECT * FROM course WHERE code = 'PA1444';

-- Adding primary key to tabale course
ALTER TABLE course ADD PRIMARY KEY(code);
EXPLAIN SELECT * FROM course WHERE code = 'PA1444';

EXPLAIN course;

-- Nytt index med Unique
EXPLAIN SELECT * FROM course WHERE nick = 'dbjs';

ALTER TABLE course ADD CONSTRAINT nick_unique UNIQUE (nick);
EXPLAIN SELECT * FROM course WHERE nick = 'dbjs';

EXPLAIN course;

-- Visa och ta bort index
SHOW INDEX FROM course;

DROP INDEX nick_unique ON course;

CREATE UNIQUE INDEX nick_unique ON course (nick);

-- Skapa index vid CREATE TABLE
SHOW CREATE TABLE course\G;

-- Index för delsökning av sträng
SELECT * FROM course WHERE name LIKE 'Webb%';
EXPLAIN SELECT * FROM course WHERE name LIKE 'Webb%';

CREATE INDEX index_name ON course(name);
EXPLAIN SELECT * FROM course WHERE name LIKE 'Webb%';

EXPLAIN course;

EXPLAIN SELECT * FROM course WHERE name LIKE '%prog%';

EXPLAIN SELECT * FROM course WHERE name LIKE '%Python';

-- Full text index
CREATE FULLTEXT INDEX full_name ON course(name);

SELECT name,
MATCH(name) AGAINST ('Program* web*' IN BOOLEAN MODE) AS score
FROM course ORDER BY score DESC;

-- Index för numeriska värden
SELECT * FROM course WHERE points > 7.5;
EXPLAIN SELECT * FROM course WHERE points > 7.5;

CREATE INDEX index_points ON course(points);
EXPLAIN SELECT * FROM course WHERE points > 7.5;

-- Visa och ta bort index
SHOW INDEX FROM course;

DROP INDEX full_name ON course;

EXPLAIN course;

-- Visa CREATE TABLE
SHOW CREATE TABLE course\G;

-- Logga långsamma frågor
SET profiling = 1;

SELECT * FROM course WHERE nick = 'dbjs';

SELECT * FROM course WHERE name LIKE 'Webb%';
SELECT name,
MATCH(name) AGAINST ('Program* web*' IN BOOLEAN MODE) AS score
FROM course ORDER BY score DESC;

SHOW PROFILES;

SHOW PROFILE FOR QUERY 3;
