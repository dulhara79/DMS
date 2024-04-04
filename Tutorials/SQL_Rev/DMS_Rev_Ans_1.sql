/*
						Emp( eid: integer, ename: string, age: integer, salary: real)
						Works (eid: integer, did: string, pct-time: integer)
						Dept( did: string, budget: real, managerid: integer)
*/
--1. Create the Emp table with following conditions
--a. Name of the employees cannot be null
--b. Employee’s salary should be greater than zero
			create table Emp (
				eid int primary key,
				ename varchar(50) not null,
				age int,
				salary float check (salary > 0)
			);

--2. Create the dept table as given in the schema
			create table Dept (
				did varchar(50) primary key,
				budget float,
				managerId int
			);

--3. Create the work table with the required foreign key constraints
			create table Work (
				eid int,
				did varchar(50),
				pct_time int,
	
				constraint pk_eiddid_Work primary key(eid, did),
				constraint fk_eid_Emp foreign key (eid) references Emp(eid),
				constraint fk_did_Dept foreign key (did) references Dept(did)
			);

--4. Insert the following row to the Emp table
--eid Ename age Salary
--1000 Ruwan 33 40000
			insert into Emp values (1000, 'Ruwan', 33, 40000);
			----or----
		--	insert into Emp(eid, ename, age, salary) values (1000, 'Ruwan', 33, 40000);

--5. Add a column named hireDate to the employee table. Default value for t`he hireDate is the
--current date.
			alter table Emp add hireDate date;

--6. Update the hireDate of the above employee to 1st January 2010.
			update Emp set hireDate = '01/01/2010' where eid = 1000;

--7. Delete the row inserted in question 4.
			delete from emp where eid = 1000;
			
--8. Delete the hire date column from the Emp table
			alter table Emp drop column hireDate;

--9. Delete the Emp table from the database
			--before drop the table drop the constraints
			alter table Work drop constraint fk_eid_Emp;
			drop table Emp;
			