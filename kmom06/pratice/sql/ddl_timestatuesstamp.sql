-- Dropping user table
DROP TABLE IF EXISTS user;
-- Creating user table
CREATE TABLE user (
    `acronym` CHAR(5) PRIMARY KEY,
    `name` VARCHAR(20),
    `created` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated` TIMESTAMP DEFAULT NULL
                ON UPDATE CURRENT_TIMESTAMP,
    `activated` TIMESTAMP DEFAULT NULL,
    `deleted` TIMESTAMP DEFAULT NULL
);

INSERT INTO user
    (`acronym`, `name`)
VALUES
    ('doe', 'John/Jane Doe'),
    ('mos', 'MegaMos'),
    ('mum', 'Mumintrollet')
;

SELECT * FROM user;

-- Update row
UPDATE `user`
SET
    `name` = 'Mega Mos'
WHERE
    `acronym` = 'mos'
;

SELECT * FROM user;

SELECT
    CONCAT(`name`, ' (', `acronym`, ')') AS User,
    IF(`created` IS NOT NULL, 'Created', '') AS Created,
    IF(`updated` IS NOT NULL, 'Updated', '') AS Updated
FROM user
;

-- Activate user
UPDATE `user`
SET
    `activated` = CURRENT_TIMESTAMP
WHERE
    `acronym` = 'mos'
;

SELECT
    CONCAT(`name`, ' (', `acronym`, ')') AS User,
    `updated`,
    `activated`,
    `deleted`
FROM user
;

SELECT
    CONCAT(`name`, ' (', `acronym`, ')') AS User,
    IF(`created` IS NOT NULL, 'Created', '') AS Created,
    IF(`updated` IS NOT NULL, 'Updated', '') AS Updated,
    IF(`activated` IS NOT NULL, 'Activated', '') AS Activated
FROM `user`
;

-- Delete user
UPDATE `user`
SET
    `deleted` = CURRENT_TIMESTAMP
WHERE
    `acronym` = 'doe'
;

SELECT
    CONCAT(`name`, ' (', `acronym`, ')') AS User,
    `updated`,
    `activated`,
    `deleted`
FROM `user`
;

SELECT
    CONCAT(`name`, ' (', `acronym`, ')') AS User,
    IF(`created` IS NOT NULL, 'Created', '') AS Created,
    IF(`updated` IS NOT NULL, 'Updated', '') AS Updated,
    IF(`activated` IS NOT NULL, 'Activated', '') AS Activated,
    IF(`deleted` IS NOT NULL, 'Deleted', '') AS Deleted
FROM `user`
;
