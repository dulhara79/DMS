create table Emp
(
	eid integer primary key,
	ename varchar(25),
	age int,
	salary float
)

insert into Emp values(1000,'Lakmal',33,90000)
insert into Emp values(1001,'Nadeeka',24,28000)
insert into Emp values(1002,'Amila',26,35000)
insert into Emp values(1003,'Nishani',28,60000)
insert into Emp values(1004,'Krishan',36,95000)
insert into Emp values(1005,'Surangi',37,22000)
insert into Emp values(1006,'Shanika',24,18000)
insert into Emp values(1007,'Amali',21,20000)
insert into Emp values(1008,'Charith',28,35000)
insert into Emp values(1009,'Prasad',40,95000)

create table Dept
(
did char(12) primary key,
budget float,
managerId int foreign key references Emp
)

insert into Dept values('Academic',900000,1002)
insert into Dept values('Admin',120000,1000)
insert into Dept values('Finance',3000000,1008)
insert into Dept values('ITSD',4500000,1000)
insert into Dept values('Maintenance',40000,1004)
insert into Dept values('SESD',20000,1004)
insert into Dept values('Marketing',90000,1008)

create table Works
(
eid int foreign key references Emp,
did char(12) foreign key references Dept,
pct_time int,
primary key(eid,did)
)

alter table Works drop constraint FK__Works__did__5BE2A6F2
drop table Works

insert into Works values(1000,'Admin',40)
insert into Works values(1000,'ITSD',50)
insert into Works values(1001,'Admin',100)
insert into Works values(1002,'Academic',100)
insert into Works values(1003,'Admin',20)
insert into Works values(1003,'Academic',30)
insert into Works values(1003,'ITSD',45)
insert into Works values(1004,'Admin',60)
insert into Works values(1004,'Finance',30)
insert into Works values(1006,'Finance',45)
insert into Works values(1006,'Maintenance',52)
insert into Works values(1008,'Maintenance',30)
insert into Works values(1008,'ITSD',30)
insert into Works values(1008,'Finance',35)
insert into Works values(1009,'Admin',100)


select * from Emp
select * from Dept
select * from Works