DROP USER IF EXISTS 'dbwebb'@'%';

CREATE USER 'dbwebb'@'%'
IDENTIFIED
WITH mysql_native_password -- Only MySQL > 8.0.4
BY 'password'
;

GRANT ALL PRIVILEGES
ON *.*
TO 'dbwebb'@'%'
WITH GRANT OPTION
;

SHOW VARIABLES LIKE "%version%";

--
-- Check the status for users root, dbwebb and user.
--
SELECT
	User,
    Host,
    Grant_priv,
    plugin
FROM mysql.user
WHERE
	User IN ('root', 'dbwebb', 'user')
ORDER BY USER
;