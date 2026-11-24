-- Project: E-commerce Database Analysis Using SQL--
-- Project Title: E-commerce Sales and Customer Analysis Using SQL --

-- Objective: --
-- To analyze an e-commerce company's sales, customer behavior, product performance, and order trends using SQL --
-- The project aims to extract meaningful business insights that help improve sales performance and customer satisfaction  --  

create database ecommerce_analysis_new;

use ecommerce_analysis_new;

show databases;

-- create database tables --
-- table 1 : customers --
create table Customers (
    customer_id int primary key,
    customer_name varchar(100) not null,
    email varchar(100) unique,
    city varchar(50),
    gender varchar(10),
    registration_date date
);

-- table 2 : products --
create table Products (
product_id int primary key,
product_name varchar(100) not null,
category varchar(50),
price decimal(10,2),
stock int
);

-- table 3: orders --
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    order_status VARCHAR(30),
    
    FOREIGN KEY (customer_id)
    REFERENCES Customers(customer_id)
);

-- table 4 :order items --
create table order_items (
item_id int primary key,
order_id int,
product_id int,
quantity int,
foreign key (order_id)
references Orders(order_id),
foreign key (product_id)
references products(product_id)
);

-- table 5: payments --
create table payments (
payment_id int primary key,
order_id int,
payment_date date,
payment_method varchar(50),
payment_status varchar(30),
amount decimal(10,2),
foreign key (order_id)
references orders(order_id)
);

-- inserting data --
-- insert customers --
insert into Customers values
(1,'Amit Sharma','amit@gmail.com','Pune','Male','2025-01-10'),
(2,'Priya Mehta','priya@gmail.com','Mumbai','Female','2025-02-15'),
(3,'Rahul Patil','rahul@gmail.com','Nashik','Male','2025-03-20'),
(4,'Sneha Joshi','sneha@gmail.com','Pune','Female','2025-04-12'),
(5,'Neha Desai','neha@gmail.com','Delhi','Female','2025-05-18'),
(6,'Rohan Shah','rohan@gmail.com','Mumbai','Male','2025-06-22'),
(7,'Pooja Kulkarni','pooja@gmail.com','Nashik','Female','2025-07-10'),
(8,'Karan Verma','karan@gmail.com','Delhi','Male','2025-08-15');

-- insert products --
insert into Products values
(101,'Laptop','Electronics',55000,20),
(102,'Mobile','Electronics',20000,50),
(103,'Headphones','Accessories',1500,100),
(104,'Keyboard','Accessories',1000,80),
(105,'Smart Watch','Electronics',5000,30),
(106,'Shoes','Fashion',2500,60),
(107,'T-Shirt','Fashion',800,100),
(108,'Office Chair','Furniture',7000,25);



-- insert orders --
INSERT INTO Orders VALUES
(1001,1,'2025-09-01','Delivered'),
(1002,2,'2025-09-05','Delivered'),
(1003,3,'2025-09-10','Shipped'),
(1004,4,'2025-09-15','Delivered'),
(1005,5,'2025-10-01','Cancelled'),
(1006,6,'2025-10-05','Delivered'),
(1007,7,'2025-10-10','Pending'),
(1008,8,'2025-10-15','Delivered'),
(1009,1,'2025-11-01','Delivered'),
(1010,2,'2025-11-05','Shipped');

-- insert order_items --
insert into order_items values
(1,1001,101,1),
(2,1001,103,2),
(3,1002,102,1),
(4,1003,104,2),
(5,1004,106,1),
(6,1005,105,1),
(7,1006,108,1),
(8,1007,107,3),
(9,1008,102,2),
(10,1009,101,1),
(11,1010,103,3);

-- insert payments --
insert into payments values
(1,1001,'2025-09-01','UPI','Completed',58000),
(2,1002,'2025-09-05','Credit Card','Completed',20000),
(3,1003,'2025-09-10','UPI','Completed',2000),
(4,1004,'2025-09-15','Debit Card','Completed',2500),
(5,1005,'2025-10-01','UPI','Refunded',5000),
(6,1006,'2025-10-05','Credit Card','Completed',7000),
(7,1007,'2025-10-10','UPI','Pending',2400),
(8,1008,'2025-10-15','Debit Card','Completed',40000),
(9,1009,'2025-11-01','Credit Card','Completed',55000),
(10,1010,'2025-11-05','UPI','Completed',4500); 

select * from Customers;
select * from Products;
select * from orders;
select * from order_items;
select * from payments;

-- project tasks --
-- display all customers --
select * from Customers;

-- display customers names only --
select customer_name from Customers;

-- find customers from pune --
 select * from Customers where city = 'Pune';
 
 -- find products costing more than 5000 --
 select * from Products where price > 5000;

-- find products between costing between 1000 and 10000 --
select * from Products where price between 1000 and 10000;

-- dislay unique cities -
select distinct city from Customers;

-- display products from hifhest to lowest price --
select * from Products order by price desc;

-- display the top 3 expensive products --
select * from Products order by price desc limit 3;

-- AGGREGATE FUNCTIONS --

-- count total customers --
select count(*) as total_customers from Customers;

-- count total products --
select count(*) as total_products from Products;

-- calculate average product price --
select avg(price) as average_price from Products;

-- find the most expensive product --
select max(price) as highest_price from Products;

-- find the cheapest product --
select min(price) as lowest_price from Products;

-- calcculate total available stock --
select sum(stock) as total_stock from Products;

-- GROUP BY and HAVING --

-- count customers city wise --
select city,
count(*) as total_customers 
from Customers
group by city;

-- count products category wise --
select category,
count(*) as total_products
from Products 
group by category;

-- counts order by status --
select order_status,
count(*) as total_orders
from orders
group by order_status;

-- find categories with average product price above 3000 --
select category,
avg(price) as average_price 
from Products
group by category 
having avg(price) > 3000;

-- JOINS --

-- Display customer names with their orders --
select 
c.customer_name,
o.order_id,
o.order_date,
o.order_status
from Customers c
inner join orders o 
on c.customer_id = o.customer_id;

-- Display product names with order quantities --
SELECT
    P.product_name,
    OI.order_id,
    OI.quantity,
    P.price
FROM Products P
INNER JOIN Order_Items OI
ON P.product_id = OI.product_id;

-- Find customers who never placed orders --
select c.customer_name
from Customers c
left join orders o
on c.customer_id = o.customer_id
where o.order_id is null;

-- Display complete order and payment details --
select 
o.order_id,
o.order_date,
o.order_status,
p.payment_method,
p.payment_status,
p.amount 
from orders o 
inner join payments p
on o.order_id = p.order_id;

-- SUBQUERIES --

-- find products above average price --
select * 
from Products
where price >(
select avg(price)
from Products
);

-- find the second highest product price --
select max(price) as second_highest_price 
from Products
where price <(
select max(price)
from Products
);

-- create CTE for products sales --
with Product_Sales as (
    select
        P.product_name,
        sum(OI.quantity) as Total_Quantity
  from Products P
   join Order_Items OI
    on P.product_id = OI.product_id
    group by P.product_name
)
select *
from Product_Sales;




