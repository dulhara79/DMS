/*
						Emp( eid: integer, ename: string, age: integer, salary: real)
						Works (eid: integer, did: string, pct-time: integer)
						Dept( did: string, budget: real, managerid: integer)
*/

/*
--Drop all the tables
	drop table Dept
	drop table Emp; 
	drop table Work
*/

--In 09 th question we drop the emp table
		/*	create table Emp
			(
				eid integer primary key,
				ename varchar(50) not null,
				age int,
				salary float check (salary > 0)
			)  */

		/*	insert into Emp values(1000,'Lakmal',33,90000)
			insert into Emp values(1001,'Nadeeka',24,28000)
			insert into Emp values(1002,'Amila',26,35000)
			insert into Emp values(1003,'Nishani',28,60000)
			insert into Emp values(1004,'Krishan',36,95000)
			insert into Emp values(1005,'Surangi',37,22000)
			insert into Emp values(1006,'Shanika',24,18000)
			insert into Emp values(1007,'Amali',21,20000)
			insert into Emp values(1008,'Charith',28,35000)
			insert into Emp values(1009,'Prasad',40,95000)  */

--add removed constraint from work table
		--	alter table Work add constraint fk_eid_Emp foreign key (eid) references Emp(eid);

--insert values to Dept table
		/*	insert into Dept values('Academic',900000,1002)
			insert into Dept values('Admin',120000,1000)
			insert into Dept values('Finance',3000000,1008)
			insert into Dept values('ITSD',4500000,1000)
			insert into Dept values('Maintenance',40000,1004)
			insert into Dept values('SESD',20000,1004)
			insert into Dept values('Marketing',90000,1008)  */

--insert values to Work table
		/*	insert into Work values(1000,'Admin',40)
			insert into Work values(1000,'ITSD',50)
			insert into Work values(1001,'Admin',100)
			insert into Work values(1002,'Academic',100)
			insert into Work values(1003,'Admin',20)
			insert into Work values(1003,'Academic',30)
			insert into Work values(1003,'ITSD',45)
			insert into Work values(1004,'Admin',60)
			insert into Work values(1004,'Finance',30)
			insert into Work values(1006,'Finance',45)
			insert into Work values(1006,'Maintenance',52)
			insert into Work values(1008,'Maintenance',30)
			insert into Work values(1008,'ITSD',30)
			insert into Work values(1008,'Finance',35)
			insert into Work values(1009,'Admin',100)  */
			
			select * from Emp
			select * from Dept
			select * from Work

--10. Display the name and the salary of all employees
			select ename, eid
			from Emp;

--11. List the name and the salary of all employees in the descending order of his/her salary.
			select ename, salary
			from Emp
			order by salary desc;

--12. Display the name and the salary of all employees who obtain a salary greater than 50000.
			select ename, salary
			from Emp
			where salary > 50000;

--13. Display the name of all employees whose name starts with a letter ‘S’
			select ename
			from Emp
			where ename like 'S%';

--14. For each department display the department name and the name of the manager.
			select d.did, e.ename
			from Emp e, Dept d
			where d.managerId = e.eid;

--15. For each employee who is earning more than 75000 display the name of the employee and the id of the manager.
			select e.ename, d.managerId
			from Emp e, Dept d
			where e.eid = d.managerId and e.salary > 75000;

--16. Display the names of employees who are not assigned to any department yet.
			select eid, ename
			from Emp
			where eid not in (select w.eid
							from Work w, Dept d
							where w.did = d.did );
               
--17. Display the names and the ages of each employee who works in either ‘ITSD’ or ‘Academic’ departments.
			select eid , ename, age
			from Emp
			where eid in (select w.eid
						 from Work w
						 where w.did in ('ITSD', 'Academic'));

--18. Display the names and the ages of each employee who works in both ‘ITSD’ and ‘Academic’ departments.
			select e.eid , e.ename, e.age
			from Emp e, Work w
			where e.eid = w.eid and w.did = 'Academic' and e.eid in (select w.eid
																	 from Work w
																	 where w.did in ('ITSD'));

--19. For all departments, display the name of the department and the names of the employees working in it.
			select d.did, e.ename
			from Dept d, Work w , Emp e
			where d.did = w.did and w.eid = e.eid
			order by d.did;

--20. Display the minimum and maximum salary of employees.
			select max(salary) as Max_Salary, min(salary) as Min_Salary
			from Emp;

--21. Display the employees’ name and the total percentage he/she has worked in total.
			select e.ename, sum(w.pct_time) as Time_pct
			from Emp e, Work w
			where e.eid = w.eid
			group by e.ename
			order by e.ename;

--22. Display the department name and the number of employees in each department.
			select did, count(eid) as NumOfEmp
			from Work
			group by did
			order by did;

--23. Display the names of the employee who work more than 90%.
			select e.ename, sum(w.pct_time)
			from Emp e, Work w 
			where e.eid = w.eid
			group by e.ename
			having sum(w.pct_time) > 90;

--24. Display the name of departments who have the total of salary exceeding 100000 LKR.
			select did
			from Dept
			where budget > 100000;

--25. Display the name of each employee whose salary exceeds the budget of all 
--departments that he or she work in.
------not sure-----
			select e.ename
			from Emp e
			where e.salary > all (
				select d.budget
				from Dept d
				where d.did in (
					select w.did
					from Work w
					where w.eid = e.eid));

--26. Find the manager ids of managers who manage only departments with budgets 
--greater than 1000000 LKR.
			select managerId
			from Dept
			where budget > 1000000;

--27. Find the name of the manager who manages the departments with the largest 
--budget.
			select e.ename
			from Emp e
			where e.eid = (select d.managerId
							from Dept d
							where d.budget = (select max(budget)
											   from Dept));

--28. If a manager manages more than one department, he or she controls the sum 
--of all the budgets for those departments.
--Find the manager id of the managers who control more than 5,000,000 LKR.
			select managerId
			from Dept
			group by managerId
			having sum(budget) > 500000 and count(managerId) > 1;

--29. Find the manager id of manager who controls the largest amount.
			select TOP 1 managerId
			from Dept
			group by managerId
			order by sum(budget) desc;		