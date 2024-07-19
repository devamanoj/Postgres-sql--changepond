use classicmodels;
drop PROCEDURE IF EXISTS GetCustomerLevel

delimiter $$
create FUNCTION GetCustomerLevel(
credit DECIMAL(10,2)
)
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN

declare CustomerLevel VARCHAR(20)

if credit > 50000 THEN
set CustomerLevel = 'PLATINUM';
ELSEIF credit <=50000 and credit > 10000 THEN
set CustomerLevel = 'GOLD';
ELSE
set CustomerLevel = 'SILVER';
END IF;
end$$
delimiter ;


use classicmodels;
DROP FUNCTION if EXISTS GetCustomerLevel;
delimiter $$
CREATE FUNCTION GetCustomerLevel(credit DECIMAL(10,2))
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN


	declare customerlevel varchar(20);
	
	if credit > 50000 THEN
		set customerlevel = "PLATINUM";
	elseif credit <= 50000 and credit > 10000 THEN
		set customerlevel = "GOLD";
	ELSE
		set customerlevel = "SILVER";
	END IF;

	RETURN(customerlevel);
END $$
delimiter ;