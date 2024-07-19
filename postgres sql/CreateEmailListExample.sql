use classicmodels;

DROP PROCEDURE IF EXISTS CreateEmailList;
delimiter $$
CREATE PROCEDURE CreateEmailList(IN porderNumber INT, OUT pshipping VARCHAR(60))
BEGIN
    DECLARE date1 DATE;
    DECLARE date2 DATE;
    DECLARE dateof INT;

    SELECT orderDate, shippedDate INTO date1, date2
    FROM orders
    WHERE orderNumber = porderNumber;

    SET dateof = DATEDIFF(date2, date1);

    CASE
        WHEN dateof < 0 THEN
            SET pshipping = 'Early';
        WHEN dateof = 0 THEN
            SET pshipping = 'On-Time';
        WHEN dateof > 0 THEN
            SET pshipping = 'very late';
        ELSE
            SET pshipping = 'Not enough data';
    END CASE;
END $$

delimiter ;