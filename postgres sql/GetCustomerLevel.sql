describe customers;
drop PROCEDURE GetCustomerLevel
delimiter $$
create PROCEDURE GetCustomerLevel(
in pcustomernumber int,
out pcustomerlevel varchar(20)
)
BEGIN

declare credit DECIMAL(10,2) DEFAULT 0;
select creditlimit into credit
from customers where customernumber = pcustomernumber;

if credit > 50000 THEN
set pcustomerlevel = 'PLATINUM';
END IF;
end$$
delimiter ;

describe customers;
use classicmodels;
drop PROCEDURE IF EXISTS GetCustomerLevel
delimiter $$
create PROCEDURE GetCustomerLevel(
in pcustomernumber int,
out pcustomerlevel varchar(20)
)
BEGIN

declare credit DECIMAL(10,2) DEFAULT 0;
select creditlimit into credit
from customers where customernumber = pcustomernumber;

if credit > 50000 THEN
set pcustomerlevel = 'PLATINUM';
ELSE
set pcustomerlevel = 'NON-PLATINUM';
END IF;
end$$
delimiter ;

describe customers;
drop PROCEDURE IF EXISTS GetCustomerLevel
delimiter $$
create PROCEDURE GetCustomerLevel(
in pcustomernumber int,
out pcustomerlevel varchar(20)
)
BEGIN

declare credit DECIMAL(10,2) DEFAULT 0;
select creditlimit into credit
from customers where customernumber = pcustomernumber;

if credit > 50000 THEN
set pcustomerlevel = 'PLATINUM';
ELSEIF credit <=50000 and credit > 10000 THEN
set pcustomerlevel = 'GOLD';
ELSE
set pcustomerlevel = 'SILVER';
END IF;
end$$
delimiter ;

call GetCustomerLevel(484,@level);