#create database project;
use project;
#1) CUSTOMER TABLE
create table customer(
cid int,
custname varchar(30),
email varchar(30),
pword varchar(10),
phno varchar(10),
address varchar(50));

ALTER TABLE `customer`
	ADD PRIMARY KEY (`cid`);
ALTER TABLE `customer`    
	MODIFY `cid` int NOT NULL AUTO_INCREMENT;

#2) EMPLOYEE TABLE

create table employee(
eid varchar(10),
vid varchar(10),
empname varchar(30),
phno varchar(10),
email varchar(30),
pword varchar(10));
ALTER TABLE `employee`
	ADD PRIMARY KEY (`eid`);
ALTER TABLE `employee`    
	MODIFY `eid` int NOT NULL AUTO_INCREMENT;
 
#3) PRODUCTS TABLE
#drop table products;
create table products(
pid varchar(10),
prodname varchar(20),
prod_desc varchar(50),
price int);   
ALTER TABLE `products`
	ADD PRIMARY KEY (`pid`);     

#4) ORDERS TABLE
#drop table orders;
create table orders(
oid varchar(10),
pid varchar(10),
cid int,
vid varchar(10),
odate date,
price int,
quantity int,
deliverystatus int NOT NULL DEFAULT 0, #0:not delivered 1:delivered 
vehicleno varchar(10),
address varchar(50));
ALTER TABLE `orders`
	ADD PRIMARY KEY (`oid`);    
ALTER TABLE orders
	ADD FOREIGN KEY (cid) REFERENCES customer(cid);   
ALTER TABLE orders
	ADD FOREIGN KEY (pid) REFERENCES products(pid);   
ALTER TABLE orders
	ADD FOREIGN KEY (vid) REFERENCES vehicle(vid);       
    
#5) VEHICLE TABLE
create table vehicle(
vid varchar(10),
vehiclenumber varchar(20)); 
ALTER TABLE `vehicle`
	ADD PRIMARY KEY (`vid`);   
#############################    

########################################  
#INSERTING VALUES
INSERT INTO customer(cid,custname,email,pword,phno,address) values
(1001,'A','A@gmail.com','a1','8907463782','Bengaluru');
INSERT INTO customer(cid,custname,email,pword,phno,address) values
(1002,'B','B@gmail.com','b2','6378902133','Chennai'),
(1003,'C','C@gmail.com','c3','7463325122','Chennai'),
(1004,'D','D@gmail.com','d4','9000745362','Bengaluru'),
(1005,'E','E@gmail.com','e5','7781234456','Vizag'),
(1006,'F','F@gmail.com','f6','9845673421','Chennai'),
(1007,'G','G@gmail.com','g7','9084325644','Mumbai'),
(1008,'H','H@gmail.com','h8','8342009745','Bengaluru'),
(1009,'I','I@gmail.com','i9','6790456782','Sikkim'),
(10010,'J','J@gmail.com','j10','9043567223','Chennai');


INSERT INTO employee(eid,vid,empname,phno,email,pword) values
('E001','V1','Amy','8576903342','amy@gmail.com','amy1'),
('E002','V2','Charles','6903412289','charles@gmail.com','charles2'),
('E003','V3','Gina','7599043221','gina@gmail.com','gina3');
ALTER TABLE employee
	ADD FOREIGN KEY (vid) REFERENCES vehicle(vid); 

#alter table products
#modify column pid varchar(5);
#alter table orders
#modify column oid varchar(5);
#alter table orders
#modify column pid varchar(5);


INSERT INTO products(pid,prodname,prod_desc,price) values
('P001','milk','dairy',20);
INSERT INTO products(pid,prodname,prod_desc,price) values
('P002','curd','dairy',30),
('P003','flour','basic',50),
('P004','oil','basic',100),
('P005','veggies','basic',200),
('P006','soap','bath',150),
('P007','shampoo','bath',150),
('P008','chips','snacks',50),
('P009','chocolates','snacks',50),
('P0010','cola','drinks',50),
('P0011','water','drinks',20);

#drop table orders;
INSERT INTO orders(oid,pid,cid,vid,odate,price,quantity,deliverystatus,address) values
('Ord100','P008',1001,'V1','2022-10-20',50,2,1,'Bengaluru');
INSERT INTO orders(oid,pid,cid,vid,odate,price,quantity,deliverystatus,address) values
('Ord110','P006',10010,'V1','2022-10-20',150,1,1,'Chennai'),
('Ord120','P0010',1009,'V2','2022-10-10',50,5,1,'Sikkim'),
('Ord130','P006',1004,'V3','2022-10-25',150,1,1,'Bengaluru'),
('Ord140','P0011',1004,'V3','2022-10-15',20,2,1,'Bengaluru'),
('Ord160','P001',1003,'V2','2022-10-12',20,1,0,'Chennai'),
('Ord170','P007',1008,'V2','2022-10-12',150,1,0,'Bengaluru');
select * from orders;


INSERT INTO vehicle(vid,vehiclenumber) values 
('V1','KA4568'),
('V2','KA3245'),
('V3','KA0987');

#4a.1)Nested queries:
select cid,custname,phno
from customer
where address='Bengaluru';

#4a.2)correlated query
#select cid,oid,pid
#from orders
#where oid in (select oid from orders
				#where deliverystatus = 0);

select C.cid,C.custname,C.phno
from customer as C
where cid in (select cid from orders
				where deliverystatus = 0);

#4b)set operations
SELECT pid FROM orders
union
SELECT pid FROM products
ORDER BY pid;



#4c)Aggregate function
#count of the number of orders vehicleno KA3245 has
select cid
from orders 
where vehicleno = 'KA3245';

#4d)order by clause
SELECT * FROM orders
ORDER BY pid ASC;

SELECT * FROM products
ORDER BY prodname;

#5)function

#6)trigger
DELIMITER $$
CREATE FUNCTION totalamt(ordid varchar(10))
RETURNS INT
DETERMINISTIC
BEGIN
	#DECLARE price int;
    #DECLARE quantity int;
	DECLARE amount int;
    
	SELECT price,quantity
	FROM orders
    where oid = ordid;
    set amount = (price * quantity);
    return amount;
END$$
DELIMITER ;