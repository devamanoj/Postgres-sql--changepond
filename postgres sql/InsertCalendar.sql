use classicmodels;

drop PROCEDURE IF EXISTS InsertCalendar;
delimiter $$
create PROCEDURE InsertCalendar(
currentDate DATE
)
BEGIN
insert into calendars(date,month,quarter,year)
VALUES
(
currentDate,month(currentDate),
quarter(currentDate), year(currentDate)
);

end$$
delimiter ;

