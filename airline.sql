create database airline;
use airline;

create table flights(
flno int,
fro varchar(15),
too varchar(15),
distance int,
departs time,
arrives time,
price int,
primary key(flno)
);

create table aircraft(
aid int primary key,
aname varchar(10),
crange integer
);

 desc certified;

create table employees(
eid integer primary key,
ename varchar(20),
salary integer
);

create table certified(
eid int not null,
aid int not null,
primary key(eid,aid),
foreign key(eid) references employees(eid),
foreign key(aid) references aircraft(aid)
);

commit;

insert into aircraft values(101,'747',3000);

insert into aircraft values(102,'Boeing',900);

insert into aircraft values(103,'647',800);

insert into aircraft values(104,'Dreamliner',10000);

insert into aircraft values(105,'Boeing',3500);

insert into aircraft values(106,'707',1500);

insert into aircraft values(107,'Dream',12000);

-- inserting into employees table
insert into employees values(701,'A',50000);
 
insert into employees values(702,'B',100000);
  
insert into employees values(703,'C',150000);

insert into employees values(704,'D',90000);
 
insert into employees values(705,'E',40000);
  
insert into employees values(706,'F',60000);
   
insert into employees values(707,'G',90000);

-- inserting values into certified table

insert into certified values(701,101);

insert into certified values(701,102);

insert into certified values(701,106);

insert into certified values(701,105);

insert into certified values(702,104);

insert into certified values(703,104);

insert into certified values(704,104);

insert into certified values(702,107);

insert into certified values(703,107);

insert into certified values(704,107);

insert into certified values(702,101);

insert into certified values(703,105);

insert into certified values(704,105);

insert into certified values(705,103);


insert into flights values(101,'Bangalore','Delhi',2500,'07:15:31','10:15:31',5000);

insert into flights values(102,'Bangalore','Lucknow',3000,'07:15:31','11:15:31',6000);

insert into flights values(103,'Lucknow','Delhi',2500,'12:15:31','13:17:31',3000);

insert into flights values(107,'Bangalore','Frankfurt',8000,'07:15:31','22:15:31',60000);

insert into flights values(104,'Bangalore','Frankfurt',8500,'07:15:31','23:15:31',75000);

insert into flights values(105,'Kolkata','Delhi',3400,'07:15:31','09:15:31',7000);


-- Find
-- the names of aircraft such that all pilots certified to operate them have
-- salaries more than Rs.80,000.

select aname from aircraft where aid in
(select aid from certified where eid in (select eid from employees where salary>80000));



-- For
-- each pilot who is certified for more than three aircrafts, find the eid and the
-- maximum cruisingrange of the aircraft for which she or he is certified.


select C.eid,max(A.crange) from  certified C,aircraft A where (C.aid=A.aid) 
group by C.eid having count(*)>3;

-- Find
-- the names of pilots whose salary is less than the price of the cheapest route
-- from Bengaluru to Frankfurt.

select ename from employees where salary <(select min(price) from flights where fro='Bangalore'and too='Frankfurt' );


-- For
-- all aircraft with cruisingrange over 1000 Kms, find the name of the aircraft
-- and the average salary of all pilots certified for this aircraft.
select A.aname, avg(E.salary) from aircraft A,employees E,certified C
where A.aid=C.aid and C.eid=E.eid and A.crange >1000
group by A.aname;

-- Find
-- the names of pilots certified for some Boeing aircraft.
 select ename from employees where eid in
 (select eid from certified where aid in (select aid from aircraft where aname like '%Boeing%') );


-- Find
-- the aids of all aircraft that can be used on routes from Bengaluru to New
-- Delhi.
 select aid from aircraft where crange >(select distance from flights where fro='Bangalore' and too='Delhi');







