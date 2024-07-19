use classicmodels;
drop PROCEDURE IF EXISTS GetCustomerShipping;

delimiter $$
create PROCEDURE GetCustomerShipping(
in pcustomernumber int,
 out pshipping varchar(60)
)
BEGIN

declare customercountry varchar(100);
select country into customercountry
from customers where customernumber = pcustomernumber;

CASE customercountry	
WHEN 'USA' THEN
SET pshipping = '2-DAY SHIPPING';

WHEN 'canada' THEN
SET pshipping = '3-DAY SHIPPING';

WHEN 'Belgium' or 'Italy' THEN
SET pshipping = '4-DAY SHIPPING';

ELSE
SET pshipping = '5-DAY SHIPPING';
END CASE;
end$$
delimiter ;