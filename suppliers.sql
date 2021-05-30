create database supplier;
use supplier;

create table SUPPLIERS(
sid real ,
sname varchar(20),
city varchar(20),
constraint PK_SUPPLIERS primary key(sid));

create table PARTS(
pid real,
pname varchar(30),
color varchar(30),
constraint PK_PARTS primary key(pid));


create table CATALOG(
sid real,
pid real,
cost float(6),
constraint FK_CATALOG1 foreign key(pid)
references PARTS(pid),
constraint FK_CATALOG2 foreign key(sid)
references SUPPLIERS(sid),
constraint PK_CATALOG primary key(sid,pid));

insert into SUPPLIERS values(10001,'Acme Widget','Bangalore');
insert into SUPPLIERS values(10002,'Johns','Kolkata');
insert into SUPPLIERS values(10003,'Vimal','Mumbai');
insert into SUPPLIERS values(10004,'Relaince','Delhi');
insert into SUPPLIERS values(10005,'Mahindra','Mumbai');

commit;

insert into PARTS values(20001,'Book','Red');
insert into PARTS values(20002,'Pen','Red');
insert into PARTS values(20003,'Pencil','Green');
insert into PARTS values(20004,'Mobile','Green');
insert into PARTS values(20005,'Charger','Black');
commit;

insert into CATALOG values(10001,'20001','10');
insert into CATALOG values(10001,'20002','10');
insert into CATALOG values(10001,'20003','30');
insert into CATALOG values(10001,'20004','10');
insert into CATALOG values(10001,'20005','10');
insert into CATALOG values(10002,'20001','10');
insert into CATALOG values(10002,'20002','20');
insert into CATALOG values(10003,'20003','30');
insert into CATALOG values(10004,'20003','40');


-- Find the pnames
-- of parts for which there is some supplier.

select distinct p.pname
from PARTS p, CATALOG c
where p.pid=c.pid;

-- Find
-- the snames of suppliers who supply
-- every  part.

select s.sname
from SUPPLIERS s
where not exists(
select p.pid from PARTS p where not exists(select c.sid from CATALOG c where c.sid=s.sid));

-- Find
-- the snames of suppliers who supply
-- every red part.

select s.sname
from SUPPLIERS s
where not exists(select p.pid from PARTS p where p.color='Red' and not exists(select c.sid from CATALOG c where c.sid=s.sid and c.pid=p.pid));


-- Find
-- the pnames of parts supplied by
-- Acme Widget Suppliers and by no one else.

select p.pname 
from PARTS p,CATALOG c,SUPPLIERS s
where p.pid=c.pid and
c.sid=s.sid and
s.sname='Acme Widget' and not exists(select * from CATALOG ca,SUPPLIERS su where p.pid=ca.pid and ca.sid=su.sid and su.sname<>'Acme Widget');



-- Find
-- the sids of suppliers who
-- charge more for some part than the average cost of that part (averaged over all
-- the suppliers who supply that part).
select distinct c.sid
from CATALOG c
where c.cost>(select avg(ca.cost) from CATALOG ca where ca.pid=c.pid);



-- For each part, find the sname of the supplier who charges the most for that part.

select p.pid,s.sname
from PARTS p, SUPPLIERS s, CATALOG c
where
c.pid=p.pid and
c.sid=s.sid and
c.cost=(select max(ca.cost) from CATALOG ca where ca.pid=p.pid);




