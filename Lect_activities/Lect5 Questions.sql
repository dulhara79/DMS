--Emp (eid, ename, age, salary) 
--Dept (did, budget,mangerId)
--Works (eid, did, pct_time)

----Connect with DMS_Revision database

--Create a view named dept_info that contains name of the department, budget and  manager’s name

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

--create a procedure that outputs statistics of salary (min, max) for a given department.
			create procedure getSalaryInfo(@did varchar(12), @minS real output, @maxS real output)
			as
				begin
					select @minS = min(e.salary), @maxS = max(e.salary)
					from Emp e inner join Work w on e.eid = w.eid inner join Dept d on d.did = w.did
					where /*e.eid = w.eid and d.did = w.did and*/ d.did = @did
				end
			declare @min real, @max real
			exec getSalaryInfo 'Admin', @min output, @max output
			print @min
			print @max

--drop procedure getSalaryInfo


--Create a procedure that outputs the name of the manager and his salary in a given department.
			create procedure managerInfo(@did varchar(12), @mName varchar(25) output, @mSal real output)
			as
				begin
					select @mName = e.ename, @mSal = e.salary
					from Emp e inner join Dept d on d.managerId = e.eid
					where d.did = @did
				end

			declare @name varchar(25), @sal real
			exec managerInfo 'Academic', @name output, @sal output
			print @name
			print @sal


-- Create Account table
CREATE TABLE Account (
    accountNo INT PRIMARY KEY,
    custId INT,
    branch VARCHAR(50),
    balance FLOAT
);

-- Create AccountAudit table
CREATE TABLE AccountAudit (
    accountNo INT primary key,
    balance FLOAT,
    date DATE,
    CONSTRAINT fk_accountNo_AccountAudit FOREIGN KEY (accountNo) REFERENCES Account(accountNo)
);

drop table AccountAudit

-- Insert demo data into Account table
INSERT INTO Account VALUES
(1, 101, 'Main Branch', 50000.00),
(2, 102, 'Downtown Branch', 75000.00),
(3, 103, 'West Branch', 30000.00);

-- Insert demo data into AccountAudit table
/*INSERT INTO AccountAudit (accountNo, balance, date) VALUES
(1, 50000.00, '2023-01-01'),
(2, 75000.00, '2023-01-01'),
(3, 30000.00, '2023-01-01'); */

select * from Account
select * from AccountAudit

insert into Account values (4, 104, 'Colombo', 50000)
--inserted  (accountNo, custId, branch, balance)
--		    (4, 104, 'Colombo', 50000)



--Create a trigger to track all inserts/updates done to the balance field of an Account table at a bank in the AccountAudit table
			create trigger trackaccount
			on Account
			for insert, update
			as
			begin
				declare @accNo int, @balane real
				select @accNo = accountNo, @balane = balance
				from inserted

				insert into  AccountAudit values (@accNo, @balane, GETDATE()) 
			end

insert into Account values (4, 104, 'Colombo', 50000)

select * from Account
select * from AccountAudit
-----------------------------------------
create trigger trackaccountUsingInsteadOf
	on Account
	instead of insert, update
	as
	begin
		declare @accNo int, @balane real
		select @accNo = accountNo, @balane = balance
		from inserted

		insert into  AccountAudit values (@accNo, @balane, GETDATE()) 
	end

insert into Account values (5, 105, 'Malabe', 55000)

select * from Account
select * from AccountAudit

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