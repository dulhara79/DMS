--Consider the following schema and write SQL statements for the following questions.
/*
			Employees(EmployeeID ,FirstName,LastName ,Place,Country ,PhoneNo)
			Rooms(RoomID,RoomName,Capacity )
			Meetings(MeetingID,TimeFrom,TimeTo,RoomID,MeetingTitle,MeetingDate)
			EmployeesMeetings(EmployeeID,MeetingID)
*/

			select * from Meetings
			select * from EmployeesMeetings
			select * from Rooms
			select * from Employees 

--1. Find the first name of employees from India whose last name start with K
			select FirstName
			from Employees
			where Country = 'India' and LastName = any (  select LastName
														  from Employees
														  where LastName like 'K%' );
										----or----
			select FirstName
			from Employees
			where Country = 'India' and LastName like 'K%';
			
--2. Find the names of Rooms with a capacity over 50.
			select RoomName
			from Rooms
			where Capacity > 50;

--3. Find the IDs of meeting with a duration more than 3 hours.
			select MeetingID
			from Meetings
			where DATEDIFF(hour, TimeFrom, TimeTo) > 3 ;

--4. Find the titles and IDs of meetings held in meeting rooms with a capacity over 50
			select m.MeetingTitle, r.RoomID
			from Rooms r, Meetings m
			where r.RoomID = m.RoomID and r.Capacity > 50;

--5. Find the first name and last name of employees who participated in Appraisal meeting on 18th August 2016.
			select e.FirstName, e.LastName
			from Meetings m, EmployeesMeetings em, Employees e
			where m.MeetingID = em.MeetingID and em.EmployeeID = e.EmployeeID and 
				  m.MeetingTitle = 'Appraisal meeting' and m.MeetingDate = '18-Aug-2016';

--6. For each employee find the titles of the meetings he/she had attended.
/*select e.EmployeeID, m.MeetingTitle
from Meetings m, EmployeesMeetings em, Employees e
where m.MeetingID = em.MeetingID and em.EmployeeID = e.EmployeeID

select e.EmployeeID, m.MeetingTitle
from Employees e left outer join EmployeesMeetings em on e.EmployeeID = em.EmployeeID
	 left outer join Meetings m on em.MeetingID = m.MeetingID
--where m.MeetingID = em.MeetingID and em.EmployeeID = e.EmployeeID

SELECT 
	e.EmployeeID,
    m.MeetingTitle
FROM 
    Employees e
JOIN 
    EmployeesMeetings em ON e.EmployeeID = em.EmployeeID
JOIN 
    Meetings m ON em.MeetingID = m.MeetingID; */


--7. Display the highest and the lowest capacities among rooms.
			select min(Capacity) as 'MinCapacity' , max(Capacity) as 'MaxCapacity'
			from Rooms;

--8. Find the number of employees from India.
			select count(*) as 'No. of employees from India'
			from Employees
			where Country = 'India';

--9. Find the number of employees who had participated in Appraisal Meetings in August.
			select count(*)as 'No of number of employees participated in Appraisal Meetings in August'
			from EmployeesMeetings e, Meetings m
			where e.MeetingID = m.MeetingID and m.MeetingTitle = 'Appraisal Meeting' and DATEPART(month,m.MeetingDate) = 8;

			select count(*)as 'No of number of employees participated in Appraisal Meetings in August'
			from Meetings m inner join EmployeesMeetings e on e.MeetingID = m.MeetingID
			where m.MeetingTitle = 'Appraisal Meeting' and DATEPART(month,m.MeetingDate) = 8;

			select count(*)as 'No of number of employees participated in Appraisal Meetings in August'
			from Meetings m left outer join EmployeesMeetings e on e.MeetingID = m.MeetingID
			where m.MeetingTitle = 'Appraisal Meeting' and DATEPART(month,m.MeetingDate) = 8;

--10. Find the number of employees from different countries.
			select count(*) as 'No of employees from countries'
			from Employees
			group by Country;

--11. Find the meeting rooms which did not have any meetings in August.
			select r.RoomName
			from Rooms r
			where r.RoomID not in (select m.RoomID
									from Meetings m
									where datepart(month, m.MeetingDate) = 8 );

--12. For each type of meetings, display the total number of employees who had participated.
--(Note that there can be several meetings with the same title)
			select m.MeetingTitle, COUNT(*) as 'total number of employees'
			from Meetings m, EmployeesMeetings em
			where m.MeetingID = em.MeetingID
			group by m.MeetingTitle;
/*
select m.MeetingTitle, COUNT(*) as 'total number of employees'
from Meetings m left outer join EmployeesMeetings em on m.MeetingID = em.MeetingID
group by m.MeetingTitle

select m.MeetingTitle, COUNT(*) as 'total number of employees'
from Meetings m inner join EmployeesMeetings em on m.MeetingID = em.MeetingID
group by m.MeetingTitle
*/

--13. Find the number of meetings held in each room in august 2016. Display the room Name and
--number of meetings.
			select r.RoomName, count(*)
			from Meetings m, Rooms r
			where r.RoomID = m.RoomID and datepart(month,m.MeetingDate) = 8
			group by r.RoomName;

--14. Find the country which has more than 20 employees from.
			select Country, count(*)
			from Employees
			group by Country
			having count(*) > 20;

--15. Find the meetings which are attended by more than 5 employees
			select m.MeetingTitle, count(*)
			from EmployeesMeetings em, Meetings m
			group by MeetingTitle
			having count(*) > 5;

--16. Find the country which has most employees are from.
			select Country
			from Employees
			group by Country
			having count(*) >= all (select count(*)
									from Employees
									group by Country);