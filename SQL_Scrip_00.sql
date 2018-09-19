select contactLastName, contactFirstName, count(orderNumber) 
   from customers c join orders o
   on c.customerNumber = o.customerNumber
   group by o.customerNumber
   order by 3;
   
select contactLastName, contactFirstName, count(orderNumber) as ocount
   from customers c join orders o
   on c.customerNumber = o.customerNumber
   group by o.customerNumber
   order by ocount;
   
select c.contactLastName, c.contactFirstName, count(o.orderNumber) as ocount
   from customers c inner join orders o
   on c.customerNumber = o.customerNumber
   group by o.customerNumber
   order by ocount;
   
select c.contactLastName, c.contactFirstName, count(o.orderNumber) as ocount
   from customers c inner join orders o
   on c.customerNumber = o.customerNumber
   group by o.customerNumber
   having ocount >= 5 and ocount <= 10 
   order by ocount;
   
select c.contactLastName, c.contactFirstName, count(o.orderNumber) as ocount
   from customers c inner join orders o
   on c.customerNumber = o.customerNumber
   group by o.customerNumber
   having ocount between 5 and 10 
   order by ocount;
   
select c.customerName, sum(p.amount) as total_payments
   from customers c inner join payments p
   on c.customerNumber = p.customerNumber
   where p.paymentDate > '2004-01-01'
   group by c.customerNumber
   having total_payments > 0 
   order by c.customerName;
   
select c.customerName, sum(p.amount) as total_payments
   from customers c inner join payments p
   using (customerNumber)
   where p.paymentDate > '2004-01-01'
   group by c.customerNumber
   having total_payments = 0 
   order by c.customerName;
   
describe customers;
select * from customers;

SELECT TABLE_SCHEMA, TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE LOWER(TABLE_SCHEMA) = 'mysql' and LOWER(TABLE_NAME) IN 
 ('catalogs', 'character_sets', 'collations', 'column_type_elements', 'columns', 'events',
 'foreign_key_column_usage', 'foreign_keys', 'index_column_usage', 'index_partitions',
 'index_stats', 'indexes', 'parameter_type_elements', 'parameters', 'routines',
 'schemata', 'st_spatial_reference_systems', 'table_partition_values',
 'table_partitions', 'table_stats', 'tables', 'tablespace_files',
 'tablespaces', 'triggers', 'version', 'view_routine_usage', 'view_table_usage');
 
SELECT CONSTRAINT_SCHEMA, TABLE_NAME, CONSTRAINT_NAME
  FROM INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS
  WHERE LENGTH(CONSTRAINT_NAME) > 64;
  
create database company;
create database `my_contacts`;
use company;
use `my_contacts`;

select database();

show databases;

SHOW VARIABLES LIKE 'datadir';

CREATE TABLE IF NOT EXISTS `company`.`customers` (
`id` int unsigned AUTO_INCREMENT PRIMARY KEY,
`first_name` varchar(20),
`last_name` varchar(20),
`country` varchar(20)
) ENGINE=InnoDB;

describe company.customers;

show engines; 

CREATE TABLE `company`.`payments`(
`customer_name` varchar(20) PRIMARY KEY,
`payment` float
);

show tables;

use company;
SHOW CREATE TABLE customers;

DESC customers;

CREATE TABLE new_customers LIKE customers;

show create table new_customers;

INSERT IGNORE INTO `company`.`customers`(first_name, last_name,country)
VALUES 
('Mike', 'Christensen', 'USA'),
('Andy', 'Hollands', 'Australia'),
('Ravi', 'Vedantam', 'India'),
('Rajiv', 'Perera', 'Sri Lanka');


show warnings;

UPDATE customers SET first_name='Rajiv', country='UK' WHERE id=4;

select * from customers;

DELETE FROM customers WHERE id=4 AND first_name='Rajiv';

select * from customers;

REPLACE INTO customers VALUES (1,'Mike','Christensen','America');
INSERT INTO payments VALUES('Mike Christensen', 200)
 ON DUPLICATE KEY UPDATE payment=payment+VALUES(payment);

INSERT INTO payments VALUES('Ravi Vedantam',500) 
 ON DUPLICATE KEY UPDATE payment=payment+VALUES(payment);

select * from payments;

INSERT INTO payments VALUES('Mike Christensen', 300)
 ON DUPLICATE KEY UPDATE payment=payment+VALUES(payment);
select * from payments;

TRUNCATE TABLE customers;
select * from customers;

show tables;

SELECT * FROM mysql.user WHERE user='dbadmin'

SELECT @@global.log_error_services;

