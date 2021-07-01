create database book_dealer;
use book_dealer;


create table author(
author_id int,
author_name varchar(20),
author_city varchar(20),
author_country varchar(20),
primary key(author_id));


create table publisher(
publisher_id int,
publisher_name varchar(20),
publisher_city varchar(20),
publisher_country varchar(20),
primary key(publisher_id));


create table category(
category_id int,
category_desc varchar(30),
primary key(category_id));


create table catalog(
book_id int,
book_title varchar(30),
author_id int,
publisher_id int,
category_id int,
year int,
price int,
primary key(book_id),
foreign key(author_id) references author(author_id),
foreign key(publisher_id) references publisher(publisher_id),
foreign key(category_id) references category(category_id));


create table order_details(
order_id int,
book_id int,
quantity int,
primary key(order_id),
foreign key(book_id) references catalog(book_id));
	

insert into author values(1001,'Robin Sharma','London','England');
insert into author values(1002,'Chetan Bhagat','Delhi','India');
insert into author values(1003,'Ruskin Bond','Kasauli','India');
insert into author values(1004,'Agatha Christie','Torquay','UK');
insert into author values(1005,'Paulo Coelho ','Rio de Janeiro','Brazil');
commit;
select * from author;

insert into publisher values(2001,'Harper','London','England');
insert into publisher values(2002,'Scholastic','Washington','USA');    
insert into publisher values(2003,'Pearson','London','England');  
insert into publisher values(2004,'Penguin','Delhi','India'); 
insert into publisher values(2005,'Rupa','Delhi','India');  
commit;
select * from publisher;

insert into category values(3001,'Fiction');
insert into category values(3002,'Non-Fiction');
insert into category values(3003,'Thriller');
insert into category values(3004,'Action');
insert into category values(3005,'Fiction');
commit;
select * from category;

insert into catalog values(4001,'THe Monk who sold his ferrari',1001,2001,3001,2002,600);
insert into catalog values(4002,'The Mysterious Mr Quin',1004,2001,3001,2003,500);
insert into catalog values(4003,'The Room on the roof',1003,2005,3001,2000,250);
insert into catalog values(4004,'3 Mistakes of my life',1002,2004,3001,2007,55);
insert into catalog values(4005,'The Alchemist',1005,2004,3003,2000,450);
insert into catalog values(4006,'Eleven Minutes',1005,2004,3003,2002,350);
commit;
update catalog set price=200 where book_title='3 Mistakes of my life';
select * from catalog;

insert into order_details values(5001,4001,5);
insert into order_details values(5002,4002,7);
insert into order_details values(5003,4003,15);
insert into order_details values(5004,4004,11);
insert into order_details values(5005,4005,9);
insert into order_details values(5006,4006,8);
insert into order_details values(5008,4004,3);
commit;
select * from order_details;


--  Give the details of the authors who have 2 or more books in the catalog and the price of the books in the 
-- catalog and the year of publication is after 2000.

select * from author where author_id in (select author_id from catalog where year>2000 group by author_id having count(*)>1);

-- Find the author of the book which has maximum sales.

select author_name from author A,catalog C
where A.author_id=C.author_id and
book_id in (select book_id from order_details where quantity=(select max(quantity) from order_details));

--  Demonstrate how you increase the price of books published by a specific publisher by 10%.
update catalog set price =1.1*price where
 publisher_id=(select publisher_id from publisher where publisher_name ='Harper');
 
 select * from catalog;