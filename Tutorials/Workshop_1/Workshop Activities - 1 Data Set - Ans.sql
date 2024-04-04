--Consider the following schema and write SQL statements for the following questions.
/*
			Employees(EmployeeID ,FirstName,LastName ,Place,Country ,PhoneNo)
			Rooms(RoomID,RoomName,Capacity )
			Meetings(MeetingID,TimeFrom,TimeTo,RoomID,MeetingTitle,MeetingDate)
			EmployeesMeetings(EmployeeID,MeetingID)
*/

--1. Find the first name of employees from India whose last name start with K
			select FirstName, LastName
			from Employees
			where LastName = any (select LastName
								  from Employees
								  where LastName like 'K%' )
			
--2. Find the names of Rooms with a capacity over 50.
			select RoomName
			from Rooms
			where Capacity > 50

--3. Find the IDs of meeting with a duration more than 3 hours.
			select MeetingID
			from Meetings
			where DATEDIFF(hour, TimeFrom, TimeTo) > 3 ;

--4. Find the titles and IDs of meetings held in meeting rooms with a capacity over 50
			select RoomID
			from Rooms
			where Capacity > 50

--5. Find the first name and last name of employees who participated in Appraisal meeting on 18th August 2016.


select *
from Meetings
select *
from EmployeesMeetings
select *
from Employees
--6. For each employee find the titles of the meetings he/she had attended.
--7. Display the highest and the lowest capacities among rooms.
--8. Find the number of employees from India.
--9. Find the number of employees who had participated in Appraisal Meetings in August.
--10. Find the number of employees from different countries.
--11. Find the meeting rooms which did not have any meetings in August.
--12. For each type of meetings, display the total number of employees who had participated.
--(Note that there can be several meetings with the same title)
--13. Find the number of meetings held in each room in august 2016. Display the room Name and
--number of meetings.
--14. Find the country which has more than 20 employees from.
--15. Find the meetings which are attended by more than 5 employees
--16. Find the country which has most employees are from.

select * from Meetings
select * from EmployeesMeetings
select * from Rooms
select * from Employees 