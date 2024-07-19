USE classicmodels;

DROP PROCEDURE IF EXISTS CreateEmailLists;
DELIMITER $$

CREATE PROCEDURE CreateEmailLists(
    INOUT email_list TEXT
)
BEGIN
    DECLARE email_address VARCHAR(100) DEFAULT "";
    DECLARE done BOOL DEFAULT FALSE;
    DECLARE email_count INT DEFAULT 0;
    DECLARE email_index INT DEFAULT 0;

    -- Temporary table to store email addresses
    CREATE TEMPORARY TABLE temp_emails AS
    SELECT email FROM employees;

    -- Get the number of email addresses
    SELECT COUNT(*) INTO email_count FROM temp_emails;

    SET email_list = '';

    -- WHILE loop to concatenate email addresses
    WHILE email_index < email_count DO
        -- Fetch email address
        SELECT email INTO email_address
        FROM temp_emails
        LIMIT email_index, 1;

        -- Concatenate the email address to the email_list
        SET email_list = CONCAT(email_address, ";", email_list);

        -- Increment the index
        SET email_index = email_index + 1;
    END WHILE;

    -- Drop the temporary table
    DROP TEMPORARY TABLE IF EXISTS temp_emails;

END$$

DELIMITER ;
