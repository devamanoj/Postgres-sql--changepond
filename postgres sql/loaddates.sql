use classicmodels;

drop PROCEDURE IF EXISTS loadDates;
delimiter $$
create PROCEDURE loadDates(
startDate Date,day int
)
BEGIN

declare counter int DEFAULT 0;
declare currentDate Date DEFAULT startDate;

WHILE counter <=day DO
call InsertCalendar(currentDate);
set counter = counter+1;
set currentDate = date_add(currentDate,INTERVAL 1 day);
end WHILE;

end$$
delimiter ;

call loadDates('2024-01-01', 365)