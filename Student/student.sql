create database student;
use student;

create table student(
snum int,
sname varchar(20),
lvl varchar(10),
age int);

alter table student add primary key(snum);
alter table student add column major varchar(10);


create table class(
cname varchar(20) primary key,
meets_at time,
room varchar(10),
fid int);

create table enrolled(
snum int ,
cname varchar(20),
primary key(snum,cname),
foreign key(snum) references student(snum),
foreign key (cname) references class(cname)
);

create table faculty(
fid int primary key,
fname varchar(20),
deptid int );

alter table class add foreign key(fid) references faculty(fid);

insert into student values(1,'Jhon','Sr',19,'CS');
insert into student values(2,'Smith','Jr',20,'CS');
insert into student values(3,'Jacob','Sr',20,'CV');
insert into student values(4,'Tom','Jr',20,'CS');
insert into student values(5,'Rahul','Jr',20,'CS');
insert into student values(6,'Rita','Sr',21,'CS');

insert into faculty values(11,'Harish',1000);
insert into faculty values(12,'MV',1000);
insert into faculty values(13,'Mira',1001);
insert into faculty values(14,'Shiva',1002);
insert into faculty values(15,'Nupur',1000);

insert into class values('class1','10:15:16','R1',14);
insert into class values('class2','10:15:20','R2',12);
insert into class values('class3','10:15:25','R3',12);
insert into class values('class4','20:15:20','R4',14);
insert into class values('class5','20:15:20','R3',15);
insert into class values('class6','13:20:20','R2',14);
insert into class values('class7','10:10:10','R3',14);

update  class set fid=11 where room='R3' and cname='class3';

insert into enrolled values(1,'class1');
insert into enrolled values(2,'class1');
insert into enrolled values(3,'class3');
insert into enrolled values(4,'class3');
insert into enrolled values(5,'class4');
insert into enrolled values(1,'class5');
insert into enrolled values(2,'class5');
insert into enrolled values(3,'class5');
insert into enrolled values(4,'class5');
insert into enrolled values(5,'class5');

-- Find the names of all Juniors
--  (level(lvl) = Jr) who are enrolled in a class taught by Harish.
select sname from student where snum in 
(select snum from enrolled where cname in 
( select cname from class where fid = (select fid from faculty where fname='Harish'))) and lvl='Jr';


-- Find the names of all classes that either meet in room R2 or have five or more Students enrolled.
  select C.cname from class C where C.room='R2' or C.cname in(
  select cname from enrolled group by cname having count(*)>4); 
  
--   Find
-- the names of all students who are enrolled in two classes that meet at the same
-- time.

select distinct s.sname
from student s
where s.snum in(select e1.snum 

               from enrolled e1,enrolled e2,class c1, class c2
			   where e1.snum=e2.snum and e1.cname<>e2.cname
			   and e1.cname=c1.cname
               and e2.cname=c2.cname
               and c1.meets_at=c2.meets_at);

--  Find
-- the names of faculty members who teach in every room in which some class is
-- taught.  

select f.fname
from faculty f
where f.fid in (select fid from class
			    group by fid having count(*)=(select count(distinct room) from class) );
                
	
-- Find
-- the names of faculty members for whom the combined enrollment of the courses
-- that they teach is less than five.


select distinct f.fname
from faculty f
where 5>(select count(e.snum) from class c, enrolled e where c.cname=e.cname and c.fid=f.fid);


-- Find
-- the names of students who are not enrolled in any class.

select distinct s.sname
from student s
where s.snum not in(select e.snum from enrolled e);


-- For
-- each age value that appears in Students, find the level value that appears most
-- often. For example, if there are more FR level students aged 18 than SR, JR, or
-- SO students aged 18, you should print the pair (18, FR).

select s.age, s.lvl
from student s
group by s.age,s.lvl
having s.lvl in(select s1.lvl from student s1 
			where s1.age=s.age
            group by s1.lvl,s1.age
            having count(*)>=all(select count(*) from student s2 where s1.age=s2.age group by s2.lvl,s2.age));


