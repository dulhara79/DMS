--Emp (eid, ename, age, salary) 
--Dept (did, budget,mangerId)
--Works (eid, did, pct_time)

--Create a view named dept_info that contains name of the department, budget and  managerís name

			--1st step
			select d.did, d.budget, e.ename
			from Dept d, Emp e
			where d.managerId = e.eid;

			--2nd step
			create view dept_info(dname, dbudget, managerName)
			as
			select d.did, d.budget, e.ename
			from Dept d, Emp e
			where d.managerId = e.eid;

			--3rd step
			select *
			from dept_info;

			--perform like normal table
			select *
			from dept_info
			where dbudget > 100000;

			update dept_info --Original table values are also change
			set managerName = 'Sirisena'
			where dname = 'Academic';

-- Create a view named emp_info which contains eid, name, salary and total percentage of time.

			--1st step
			select e.eid, e.ename, e.salary, sum(w.pct_time) as 'total_pct_time'
			from Emp e, Work w
			where e.eid = w.eid
			group by e.eid, e.ename, e.salary;

			--2nd step
			create view emp_info(eid, ename, esalary, total_pct_time)
			as
			select e.eid, e.ename, e.salary, sum(w.pct_time)
			from Emp e, Work w
			where e.eid = w.eid
			group by e.eid, e.ename, e.salary;

			--3rd step
			select *
			from emp_info;

			--delete view
			/*drop view emp_info*/

			select max(salary) as 'max salary', min(salary) as 'min salary', max(salary) - min(salary) as 'min-max salary'
			from Emp

			select *
			from Emp

--Create a function that returns the number of employees in a given department
			--input --> given department
			--output --> number of employees

			--function creation
			create function getEmpCount(@did char(12)) returns int
			as
				begin
					declare @ecount int
					select @ecount = count(*)
					from Work
					where did = @did
					return @ecount
				end

			--execute function
			declare @retEcount int --declare variable to store return value
			exec @retEcount = getEmpCount 'Admin'
			print @retEcount

			select count(*)
			from Work
			where did = 'Admin'

--Create a function to return the total percentage of time a person works given the employee id.
			--input --> employee id
			--output --> total percentage of time

			--function creation
			create function getTotalpctWork(@empid int) returns int
			as
				begin 
					declare @totalpctWork int
					select @totalpctWork = sum(pct_time)
					from Work
					where eid = @empid
					return @totalpctWork
				end

			--function execution
			declare @totalTime int
			exec @totalTime = getTotalpctWork 1000
			print @totalTime

			select sum(pct_time)
			from Work
			where eid = 1000

--Create a procedure to give a salary increment to all the employee by a given percentage from their existing salary
			--input para --> precentage
			select *
			from Emp

			--create procedure
			create procedure incSalary(@pct float)
			as
				begin
					update Emp
					set salary = salary + salary * (@pct / 100)
				end

			--execute procedure
			exec incSalary 10

			select *
			from Emp

			---To drop procedure---
--			drop procedure incSalary  
------------------------------------------------------------------------------------------------------------------------------------------

----variable declaration-----
			declare @eid int
			set @eid = 1000

---get the salary and asign to the another variable
			declare @esal real

			select @esal = salary
			from Emp
			where eid = @eid

			print @esal

----if condition-----
			if @esal > 50000
				begin
					print 'inside if condition'
					print 'salary greater than 50000'
				end
			else
					print 'salary less than 50000'


----while loop----
	declare @count int
	set @count = 0
	while(@count <= 10)
	begin
		set @count = @count + 1

		if @count = 1
			print 'Hello, SQL'

		if @count = 2
			select eid from Emp

		if @count = 3
			select ename from Emp 

		if @count = 4
			begin
				print 'Continue statement'
				continue
			end

		if @count = 5
			print @count
	
		if @count = 6
			print 'Bye SQL' 

		if @count = 7
			begin
				print 'break statement'
				break
			end
		print @count
	end

--IF statement
	if(select eid from Emp) > 1000
	begin
		--select eid from Emp
		print 'age'
	end
	else
		print 'age not > 35'

----create function without parameter 
--**Function should have return type and value**--
	create function withoutPara() returns int
	as
		begin
			declare @i int set @i = 0
			return @i
		end

	declare @j int
	exec @j = withoutPara
	print @j

---------delete all the roes in Emp table------
declare @i int set @i = 0
declare @empid int set @empid = 1000
--alter table Work drop constraint fk_eid_Emp
while (@i < 10)
	begin
		delete from Emp where eid = @empid
		print @empid
		print @i
		set @empid = @empid + 1
		set @i = @i + 1
	end

select *
from Emp

--add deleted foreign key in 
--alter table Work add constraint fk_eid_Emp foreign key (eid) references Emp(eid)