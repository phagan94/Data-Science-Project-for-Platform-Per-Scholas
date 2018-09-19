use classicmodels;

select * from orders;

select * from orderdetails
   where quantityOrdered is null;
   
select * from employees;

select * from customers;

SELECT CONCAT_WS(', ',e. lastName, e.firstname) AS 'Sales Rep',
               COUNT(o.orderNumber) AS '# Orders',
               SUM(IFNULL(od.quantityOrdered, 0.00)) AS '# Total Sales'
   FROM employees e
   LEFT OUTER JOIN customers c
      ON c.salesRepEmployeeNumber = e.employeeNumber
   INNER JOIN orders o
      ON c.customerNumber = o.customerNumber
   INNER JOIN orderdetails od
      ON o.orderNumber = od.orderNumber
   WHERE e.jobTitle = 'Sales Rep'
   GROUP BY 1
   ORDER BY 3 DESC; 

SELECT CONCAT_WS(', ',e. lastName, e.firstname) AS 'Sales Rep',
               o.orderNumber AS '# Orders',
               od.quantityOrdered AS '# Total Sales'
   FROM employees e
   LEFT OUTER JOIN customers c
      ON c.salesRepEmployeeNumber = e.employeeNumber
   INNER JOIN orders o
      ON c.customerNumber = o.customerNumber
   INNER JOIN orderdetails od
      ON o.orderNumber = od.orderNumber
   WHERE e.jobTitle = 'Sales Rep'
   GROUP BY o.orderNumber
   ORDER BY 3 DESC; 
   
select paymentDate, amount from payments;
  
SELECT MONTHNAME(paymentDate) AS 'MONTH', YEAR(PaymentDate) AS 'Year', SUM(amount) AS 'Payments Received'
    FROM payments
    GROUP BY (PaymentDate)
    ORDER BY paymentDate ASC;
  
SELECT MONTHNAME(paymentDate) AS 'MONTH', YEAR(paymentDate) AS 'Year', FORMAT(SUM(amount), 2) AS 'Payments Received'
    FROM payments
    GROUP BY (CONCAT(YEAR(paymentDate), MONTH(paymentDate)))
    ORDER BY paymentDate ASC;
    
SELECT * FROM cdw_sapp_branch;

SELECT * FROM cdw_sapp_creditcard;

SELECT * FROM cdw_sapp_customer;

