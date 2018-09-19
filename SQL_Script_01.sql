USE classicmodels;
SELECT * FROM customers;

SELECT customerName AS 'Customer Name', CONCAT(e.lastName, ', ', e.firstname) AS 'Sales Rep'
   FROM customers c
   INNER JOIN
        employees e
	 ON c.SalesRepEmployeeNumber = e.EmployeeNumber
   ORDER BY customerName ASC; 

SELECT p.productName AS 'Product Name', od.quantityOrdered  AS 'Total # Ordered',
   CAST(od.quantityOrdered * p.buyPrice AS DECIMAL) AS 'Total Sale'
   FROM orders o  
   INNER JOIN orderdetails od
      ON o.orderNumber = od.orderNumber
   INNER JOIN products p
      ON p.productCode = od.productCode
   ORDER BY 3 DESC;  

SELECT o.status AS 'Order Status', 
               SUM(od.quantityOrdered) AS '# Orders'
   FROM orders o
   INNER JOIN orderdetails od
      ON o.orderNumber = od.orderNumber
   GROUP BY  o.status
   ORDER BY o.status ASC; 
   

SELECT pl.productLine AS 'Product Line', SUM(od.quantityOrdered) AS '# Sold'
   FROM productlines pl
   INNER JOIN products p
      ON pl.productLine = p.productLine
   INNER JOIN orderdetails od
      ON p.productCode = od.productCode
   GROUP BY  pl.productLine
   ORDER BY 2 DESC; 

SELECT CONCAT_WS(', ',e. lastName, e.firstname) AS 'Sales Rep',
               COUNT(o.orderNumber) AS '# Orders',
             IFNULL(SUM(od.quantityOrdered), 0.00) AS '# Total Sales'
   FROM employees e
   INNER JOIN customers c
      ON c.salesRepEmployeeNumber = e.employeeNumber
   INNER JOIN orders o
      ON c.customerNumber = o.customerNumber
   INNER JOIN orderdetails od
      ON o.orderNumber = od.orderNumber
   WHERE e.jobTitle = 'Sales Rep'
   GROUP BY o.orderNumber
   ORDER BY 3 ASC; 
