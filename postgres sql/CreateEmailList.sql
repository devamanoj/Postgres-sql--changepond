use classicmodels;

drop PROCEDURE IF EXISTS CreateEmailList;
delimiter $$
create PROCEDURE CreateEmailList(
inout email_list TEXT
)
BEGIN
declare email_address varchar(100) default "";
declare done bool default false;
declare cur_email_list cursor for select email from employees;
declare CONTINUE HANDLER
FOR NOT FOUND SET done = true;

OPEN cur_email_list;

set email_list = '';

process_email: LOOP
FETCH cur_email_list into email_address;
if done = true THEN
LEAVE process_email;
END IF;
SET email_list = CONCAT(email_address,";",email_list);
END LOOP;
CLOSE cur_email_list;

end$$
delimiter ;

