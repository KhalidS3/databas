--
-- Example transactions
--
DROP TABLE IF EXISTS account;
CREATE TABLE account
(
    `id` CHAR(4),
    `name` VARCHAR(8),
    `balance` DECIMAL(4, 2)
);

INSERT INTO account
VALUES
    ('1111', 'Adam', 10.0),
    ('2222', 'Eva', 7.0)
;

SELECT * FROM account;

--
-- Move the money, within a transaction
--
START TRANSACTION;

UPDATE account
SET
    balance = balance + 1.5
WHERE
    id = '2222';

UPDATE account
SET
    balance = balance - 1.5
WHERE
    id = '1111';

COMMIT;

SELECT * FROM account;

--
-- Procedure move_money()
--
DROP PROCEDURE IF EXISTS move_money;

DELIMITER ;;

CREATE PROCEDURE move_money(
    from_account CHAR(4),
    to_account CHAR(4),
    amount NUMERIC(4, 2)
)
BEGIN
    SELECT from_account, to_account, amount;
END
;;

DELIMITER ;

CALL move_money('1111', '2222', 1.5);

--
-- Procedure move_money()
-- with transaction
DROP PROCEDURE IF EXISTS move_money;

DELIMITER ;;

CREATE PROCEDURE move_money(
    from_account CHAR(4),
    to_account CHAR(4),
    amount NUMERIC(4, 2)
)
BEGIN
    START TRANSACTION;

    UPDATE account
    SET
        balance = balance + amount
    WHERE
        id = to_account;

    UPDATE account
    SET
        balance = balance - amount
    WHERE
        id = to_account;

    COMMIT;

    -- SELECT from_account, to_account, amount;
    SELECT * from account;
END
;;

DELIMITER ;

CALL move_money('1111', '2222', 1.5);

--
-- Procedure move_money
-- with local variable
--
DROP PROCEDURE IF EXISTS move_money;

DELIMITER ;;

CREATE PROCEDURE move_money(
    from_account CHAR(4),
    to_account CHAR(4),
    amount NUMERIC(4, 2)
)
BEGIN
    DECLARE current_balance NUMERIC(4, 2);

    START TRANSACTION;

    SET current_balance = (SELECT balance FROM account WHERE id = from_account);
    SELECT current_balance;

    IF current_balance - amount < 0 THEN
        ROLLBACK;
        SELECT 'Amount on the account is not enough to make transaction.' AS message;
    ELSE
        UPDATE account
            SET
                balance = balance + amount
            WHERE
                id = to_account;

        UPDATE account
            SET
                balance = balance - amount
            WHERE
                id = to_account;

        COMMIT;
    END IF;


    SELECT * FROM account;
END
;;

DELIMITER ;

CALL move_money('1111', '2222', 1.5);

--
-- Define and use local variable
--
SET @answer = 42;
SELECT @answer;

--
-- Set local variable from a result
--
SET @answer = (SELECT 42);
SELECT @answer;

--
-- Select multiple into variables
--
SELECT 1, 2 INTO @a, @b;
SELECT @a, @b;

--
-- IN and OUT parameters
--
DROP PROCEDURE IF EXISTS get_money;

DELIMITER ;;

CREATE PROCEDURE get_money(
    IN a_account CHAR(4),
    OUT a_total NUMERIC(4, 2)
)
BEGIN
    SELECT balance INTO a_total FROM account WHERE id = a_account;
END
;;

DELIMITER ;

CALL get_money('1111', @sum);
SELECT @sum;

--
-- Show procedure
--
SHOW PROCEDURE STATUS LIKE '%money';

SHOW CREATE PROCEDURE move_money \G;
