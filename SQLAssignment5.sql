CREATE DATABASE CUSTOMER_ORDERS_PRODUCTS;
USE CUSTOMER_ORDERS_PRODUCTS;

---CREATE CUSTOMERS TABLES---
CREATE TABLE Customers ( 
CustomerID INT PRIMARY KEY, 
Name VARCHAR(50), 
Email VARCHAR(100) 
); 

---INSERT INTO CUSTOMERS TABLE---
INSERT INTO Customers (CustomerID, Name, Email) 
VALUES 
(1, 'John Doe', 'johndoe@example.com'), 
(2, 'Jane Smith', 'janesmith@example.com'), 
(3, 'Robert Johnson', 'robertjohnson@example.com'), 
(4, 'Emily Brown', 'emilybrown@example.com'), 
(5, 'Michael Davis', 'michaeldavis@example.com'), 
(6, 'Sarah Wilson', 'sarahwilson@example.com'), 
(7, 'David Thompson', 'davidthompson@example.com'), 
(8, 'Jessica Lee', 'jessicalee@example.com'), 
(9, 'William Turner', 'williamturner@example.com'), 
(10, 'Olivia Martinez', 'oliviamartinez@example.com'); 

----CREATE ORDERS TABLE---
CREATE TABLE Orders ( 
OrderID INT PRIMARY KEY, 
CustomerID INT, 
ProductName VARCHAR(50), 
OrderDate DATE, 
Quantity INT 
); 

---INSERT INTO ORDERS TABLE----
INSERT INTO Orders (OrderID, CustomerID, ProductName, OrderDate, Quantity) 
VALUES 
(1, 1, 'Product A', '2023-07-01', 5), 
(2, 2, 'Product B', '2023-07-02', 3), 
(3, 3, 'Product C', '2023-07-03', 2), 
(4, 4, 'Product A', '2023-07-04', 1), 
(5, 5, 'Product B', '2023-07-05', 4), 
(6, 6, 'Product C', '2023-07-06', 2), 
(7, 7, 'Product A', '2023-07-07', 3), 
(8, 8, 'Product B', '2023-07-08', 2), 
(9, 9, 'Product C', '2023-07-09', 5), 
(10, 10, 'Product A', '2023-07-10', 1);

----CREATE PRODUCTS TABLE---
CREATE TABLE Products ( 
ProductID INT PRIMARY KEY, 
ProductName VARCHAR(50), 
Price DECIMAL(10, 2) 
); 
---INSERT INTO PRODUCTS TABLE---
INSERT INTO Products (ProductID, ProductName, Price) 
VALUES 
(1, 'Product A', 10.99), 
(2, 'Product B', 8.99), 
(3, 'Product C', 5.99), 
(4, 'Product D', 12.99), 
(5, 'Product E', 7.99), 
(6, 'Product F', 6.99), 
(7, 'Product G', 9.99), 
(8, 'Product H', 11.99), 
(9, 'Product I', 14.99), 
(10, 'Product J', 4.99);

---Write a query to retrieve all records from the Customers table---
SELECT * FROM Customers;

---Write a query to retrieve the names and email addresses of customers whose names start with 'J'---
SELECT * FROM Customers WHERE NAME LIKE 'J%';

---Write a query to retrieve the order details (OrderID, ProductName, Quantity) for all orders.---
SELECT OrderID, ProductName, Quantity FROM ORDERS;

---Write a query to calculate the total quantity of products ordered---
SELECT SUM(QUANTITY) AS TOTAL_QUANTITY FROM Orders;

---Write a query to retrieve the names of customers who have placed an order---
SELECT C.NAME,O.PRODUCTNAME FROM Customers C JOIN Orders O ON C.CustomerID=O.CustomerID;

---Write a query to retrieve the products with a price greater than $10.00---
SELECT * FROM PRODUCTS WHERE Price>10;

----Write a query to retrieve the customer name and order date for all orders placed on or after '2023-07-05'---
SELECT C.NAME, O.ORDERDATE FROM Customers C JOIN Orders O ON C.CustomerID=O.CustomerID WHERE O.OrderDate >='2023-07-05';

---Write a query to calculate the average price of all products---
SELECT AVG(PRICE) AS AVG_PRICE FROM PRODUCTS;

----Write a query to retrieve the customer names along with the total quantity of products they have ordered---
SELECT C.NAME, O.QUANTITY FROM Customers C JOIN Orders O ON C.CustomerID=O.CustomerID;

--- Write a query to retrieve the products that have not been ordered---
SELECT P.ProductName FROM PRODUCTS P WHERE NOT EXISTS (SELECT O.ProductName FROM Orders O WHERE O.ProductName=P.ProductName);

---Write a query to retrieve the top 5 customers who have placed the highest total quantity of orders---
SELECT TOP 5 C.NAME,O.Quantity,DENSE_RANK()OVER(ORDER BY O.Quantity DESC) AS QUANITY_RANK   FROM Customers C JOIN Orders O ON C.CustomerID=O.CustomerID;

----Write a query to calculate the average price of products for each product category. -----
SELECT ROUND(AVG(O.QUANTITY * P.PRICE),2) AS AVG_PRICE, O.ProductName FROM Orders AS O JOIN Products AS P ON O.ProductName=P.ProductName GROUP BY O.ProductName;

----Write a query to retrieve the customers who have not placed any orders. ----
SELECT C.NAME, C.CustomerID FROM CUSTOMERS C WHERE NOT EXISTS (SELECT O.CustomerID FROM Orders O WHERE C.CustomerID = O.CustomerID);

----Write a query to retrieve the order details (OrderID, ProductName, Quantity) for orders placed by customers whose names start with 'M'.----
SELECT C.Name,O.ORDERID, P.PRODUCTNAME,O.QUANTITY FROM Customers C JOIN Orders O ON C.CustomerID=O.CustomerID JOIN Products P ON O.ProductName=P.ProductName WHERE C.Name LIKE 'M%';

----Write a query to calculate the total revenue generated from all orders. ----
SELECT SUM(SUM_PRICE) AS TOTAL_REVENUE FROM (SELECT SUM(O.QUANTITY * P.PRICE) AS SUM_PRICE, O.ProductName FROM Orders AS O JOIN Products AS P ON O.ProductName=P.ProductName GROUP BY O.ProductName) AS INNER_QUERY;

----Write a query to retrieve the customer names along with the total revenue generated from their orders. -----
SELECT SUM(O.QUANTITY * P.PRICE) AS REV_GEN, C.NAME FROM CUSTOMERS C JOIN ORDERS O ON C.CUSTOMERID=O.CUSTOMERID JOIN PRODUCTS P ON O.PRODUCTNAME=P.PRODUCTNAME GROUP BY C.Name;

----Write a query to retrieve the customers who have placed at least one order for each product category. ----
SELECT O.CustomerID FROM Customers C JOIN Orders O ON C.CustomerID=O.CustomerID GROUP BY O.ProductName,O.CustomerID HAVING COUNT(O.CUSTOMERID)>=1;

---Write a query to retrieve the customers who have placed orders on consecutive days.---
SELECT O1.CUSTOMERID FROM Orders O1, ORDERS O2 WHERE O1.CustomerID=O2.CustomerID AND ABS(DATEDIFF(DAY,O1.OrderDate,O2.OrderDate))=1;

----Write a query to retrieve the top 3 products with the highest average quantity ordered.----
SELECT TOP 3 AVG(O1.QUANTITY) AS AVG_QTY, O1.ProductName FROM Orders O1 JOIN  ORDERS O2  ON  O1.OrderID=O2.OrderID GROUP BY O1.ProductName;

----Write a query to calculate the percentage of orders that have a quantity greater than the average quantity.----
SELECT (Quantity*100)/(SELECT SUM(QUANTITY) FROM Orders) AS PERCENTAGE_QTY FROM ORDERS O1 WHERE Quantity>(SELECT AVG(Quantity) AS AVG_QUANTITY FROM Orders O2 WHERE O1.OrderID=O2.OrderID);
