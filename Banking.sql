create database Banking;
use Banking;
create table Branch
(BranchName varchar(30),BranchCity varchar(30),assets real,primary key(BranchName));

create table BankAccount
(AccNo integer,BranchName varchar(30),Balance real,primary key(AccNo),foreign key(BranchName) 
references Branch (BranchName));

create table BankCustomer(CustomerName varchar(30),CustomerStreet varchar(30),
CustomerCity varchar(30),primary key(CustomerName));

create table Depositer(CustomerName varchar(30),AccNo integer,primary key(CustomerName,AccNo),
foreign key(AccNo)references BankAccount(AccNo));

create table Loan(LoanNumber int ,BranchName varchar(30),Amount real,primary key(LoanNumber),
foreign key(BranchName) references Branch(BranchName));

insert into Branch values('SBI_Chmrajpet','Bangalore',50000);
insert into Branch values('SBI_ResidencyRoad','Bangalore',10000);
insert into Branch values('SBI_ShivajiRoad','Bombay',20000);
insert into Branch values('SBI_ParliamentRoad','Delhi',10000);
insert into Branch values('SBI_JantarMantar','Delhi',20000);

insert into Loan values(2,'SBI_ResidencyRoad',2000);
insert into Loan values(1,'SBI_Chmrajpet',1000);
insert into Loan values(3,'SBI_ShivajiRoad',3000);
insert into Loan values(4,'SBI_ParliamentRoad',4000);
insert into Loan values(5,'SBI_JantarMantar',5000);

insert into BankAccount values(2,'SBI_ResidencyRoad',1000);
insert into BankAccount values(5,'SBI_JantarMantar',1000);
insert into BankAccount values(3,'SBI_ShivajiRoad',500);
insert into BankAccount values(6,'SBI_ResidencyRoad',200);
insert into BankAccount values(4,'SBI_ParliamentRoad',300);
insert into BankAccount values(1,'SBI_Chmrajpet',100);
insert into BankAccount values(7,'SBI_JantarMantar',1000);
insert into BankAccount values(8,'SBI_JantarMantar',900);
insert into BankAccount values(9,'SBI_ParliamentRoad',888);
insert into BankAccount values(10,'SBI_ShivajiRoad',1000);
insert into BankAccount values(11,'SBI_Chmrajpet',200);

insert into BankCustomer values('Ram','abc','Delhi');
insert into BankCustomer values('Rohan','abc','Delhi');
insert into BankCustomer values('Shoaib','cde','Indore');
insert into BankCustomer values('Faizal','xyz','Patna');
insert into BankCustomer values('Aman','zy','Kota');
insert into BankCustomer values('Adesh','ajs','Ayodhya');

insert into Depositer values('Ram',1);
insert into Depositer values('Rohan',2);
insert into Depositer values('Shoaib',3);
insert into Depositer values('Faizal',4);
insert into Depositer values('Aman',5);
insert into Depositer values('Adesh',6);
commit;


select c.customername
from BankCustomer c
where exists(
select d.customername
from Depositer d, BankAccount ba
where
d.accno=ba.accno and
c.customername=d.customername and
ba.Branchname='SBI_ResidencyRoad'
group by d.customername
having count(d.customername)>=2
);

select d.customername from Depositer d,Branch b,BankAccount ba 
where b.Branchname=ba.Branchname
AND ba.accno=d.accno
and Branchcity='Delhi'
group by d.customername 
having COUNT(distinct b.Branchname)=(select  COUNT(Branchname) from  Branch where Branchcity='Delhi');

delete from BankAccount
where Branchname IN(
select Branchname
from Branch
where Branchcity='Bombay');



