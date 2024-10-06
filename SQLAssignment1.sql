---  Create two Databases Name :- Brands , and  Products ---
CREATE DATABASE BRANDS;
CREATE DATABASE PRODUCTS;

--- ITEMS_TABLE in Brands database ---
USE BRANDS;
CREATE TABLE ITEMS_TABLE 
(ID INT IDENTITY(1,1) PRIMARY KEY,
ITEM_DESCRIPTION VARCHAR(255),
VENDOR_NOS INT,
VENDOR_NAME VARCHAR(255),
BOTTLE_SIZE INT,
BOTTLE_PRICE DECIMAL(2,2));

--- PRODUCT_TABLE  in Products database ---
USE PRODUCTS;
CREATE TABLE PRODUCT_TABLE
(
PRODUCT_ID INT IDENTITY(1,1) PRIMARY KEY,
COUNTRY VARCHAR(255),
PRODUCTS VARCHAR(255),
UNITS_SOLD DECIMAL(4,2),
MANUFACTURING_PRICE INT,
SALE_PRICE INT,
GROSS_SALES BIGINT,
SALES BIGINT,
COGS BIGINT,
PROFIT BIGINT,
DATES  DATE,
MONTH_NUMBER INT,
MONTH_NAME  VARCHAR(255),
YEARS INT);

--- RECORDS INSERTION ITEMS_TABLE----
USE BRANDS;

--- to avoid Arithmetic overflow error converting numeric to data type numeric.---
ALTER TABLE ITEMS_TABLE ALTER COLUMN BOTTLE_PRICE DECIMAL(6,2);

INSERT INTO ITEMS_TABLE
VALUES('Travis Hasse Apple Pie',305,'Mhw Ltd',750,9.77),
('D aristi Xtabentun',391,'Anchor Distilling (preiss Imports)', 750,14.12),
('Hiram Walker Preach Brandy',370,'Pernod Ricard Usa/Austin Nichols',1000,6.5),
('Oak Cross Whisky', 305, 'Mhw Ltd',750,25.33),
('Uv Red(cherry) Vodka', 380,'Philips Beverage Company',200,1.97),
('Heaven Hill Old Style White Label', 259, 'Heaven Hill Distilleries Inc.',750,6.37),
('Hyde Herbal Liqueur', 194,'Fire Tail Brands Llc',750,9.06),
('Dupont Calvados Fine Resetve',403, 'Robert Kacher Selections', 750,23.61);

SELECT * FROM ITEMS_TABLE;


--- RECORDS INSERTION PRODUCT_TABLE----
USE PRODUCTS;

ALTER TABLE PRODUCT_TABLE ALTER COLUMN UNITS_SOLD DECIMAL(6,2);

INSERT INTO PRODUCT_TABLE
Values
('Canada', 'Carretera', 1618.5,3,20,32370,32370,16185,16185,'1/1/2014',1,'January',2014),
('Germany','Carretera',1321,3,20,26420,26420,13210,13210,'1/1/2014',1,'January',2015),
('France','Carretera',2178,3,15,32670,32670,271780,10890,'6/1/2014',6,'June',2016),
('Germany','Carretera',888,3,15,13320,13320,8880,4440,'6/1/2014',6,'June',2017),
('Mexico','Carretera',2470,3,15,37050,37050,24700,12350,'6/1/2014',6,'June',2018),
('Germany','Carretera',1513,3,250,529550,529550,393380,136170,'12/1/2014',12,'December',2019),
('Germany','Montana',921,5,15,13815,13815,9210,4605,'3/1/2014',3,'March',2020),
('Germany','Montana',2518,5,12,30216,30216,7554,22662,'6/1/2014',6,'June',2020);


---- Delete those product having the Units Sold 1618.5 , 888 and 2470. ----
SELECT * FROM PRODUCT_TABLE WHERE UNITS_SOLD IN	(1618.5,888,2470);
DELETE FROM PRODUCT_TABLE WHERE UNITS_SOLD IN	(1618.5,888,2470);
SELECT * FROM PRODUCT_TABLE;

--- Select Unique Country from the product_sales table  ----
SELECT DISTINCT(COUNTRY) FROM PRODUCT_TABLE;

---- Count the number of Countries in the product_sales table----
SELECT COUNT(COUNTRY) AS NUM_OF_COUNTRIES FROM PRODUCT_TABLE;

---- How Many Countries are there which contain the sales price between 10 to 20----
SELECT COUNT(COUNTRY) AS COUNTRY_COUNT FROM PRODUCT_TABLE WHERE SALE_PRICE BETWEEN 10 AND 20;

---- Find the Total Sale Price  and  Gross Sales----
SELECT PRODUCT_ID, (UNITS_SOLD*MANUFACTURING_PRICE*SALE_PRICE) AS TOTAL_SALE_PRICE, GROSS_SALES FROM PRODUCT_TABLE;

----In which year we have got the highest sales -----
SELECT YEARS,MAX(SALES) AS YEAR_WISE_MaxSales FROM PRODUCT_TABLE GROUP BY YEARS;
SELECT YEARS FROM PRODUCT_TABLE WHERE SALES=(SELECT MAX(SALES) FROM PRODUCT_TABLE);

---- Which Product having the sales of $ 37,050.00 ------
----- Note: AS A PART OF A QUESTION A FEW ROWS WERE DELETED, I HAVE INSERTED THE DATA AGAIN AFTER TRUNCATING THE TABLE. ----
SELECT * FROM PRODUCT_TABLE;
SELECT PRODUCTS FROM PRODUCT_TABLE WHERE SALES=37050;

---- Which Countries lies between profit of $ 4,605 to $  22 , 662.00 ----
SELECT COUNTRY FROM PRODUCT_TABLE WHERE PROFIT BETWEEN 4605 AND 22662;

---- Which Product Id having the sales of $ 24 , 700.00 ----
SELECT PRODUCT_ID FROM PRODUCT_TABLE WHERE SALES=24700;

----  Find the total Units Sold for each Country. -----
SELECT COUNTRY, SUM(UNITS_SOLD) AS UNITS_SOLD FROM PRODUCT_TABLE GROUP BY COUNTRY;

---- Find the average sales for each country-----
SELECT COUNTRY, AVG(SALE_PRICE) AS AVG_SALES FROM PRODUCT_TABLE GROUP BY COUNTRY;

----  Retrieve all products sold in 2014-----
SELECT PRODUCTS FROM PRODUCT_TABLE WHERE YEARS=2014;

---- Find the maximum Profit in the product_sales table.---- 
SELECT MAX(PROFIT) AS MAX_PROFIT FROM PRODUCT_TABLE;

-----  Retrieve the records from product_sales where Profit is greater than the average Profit of all records. -----
SELECT * FROM PRODUCT_TABLE WHERE PROFIT> (SELECT AVG(PROFIT) FROM PRODUCT_TABLE);

----  Find the item_description having the bottle size of 750 ----
USE BRANDS;
SELECT * FROM ITEMS_TABLE;
SELECT ITEM_DESCRIPTION FROM ITEMS_TABLE WHERE BOTTLE_SIZE=750;

------ Find the vendor Name having the vendor_nos 305, 380, 391-----
SELECT VENDOR_NAME FROM ITEMS_TABLE WHERE VENDOR_NOS IN (305,380,391);

---- What is total Bottle_price ----
SELECT SUM(BOTTLE_PRICE) AS TOTAL_BOTTLE_PRICE FROM ITEMS_TABLE;

----Make Primary Key to Item_id -----
ALTER TABLE ITEMS_TABLE ADD PRIMARY KEY (ID);

----- Which item id having the bottle_price of $ 5.06 ----
SELECT ID FROM ITEMS_TABLE WHERE BOTTLE_PRICE=5.06;

-----  Apply INNER JOIN types on both the table ----
SELECT IT.*,PT.* FROM [BRANDS].[dbo].[ITEMS_TABLE] AS IT JOIN [PRODUCTS].[dbo].[PRODUCT_TABLE] AS PT ON IT.ID=PT.PRODUCT_ID;

-----  Apply OUTER JOIN types on both the table ----
SELECT IT.*,PT.* FROM [BRANDS].[dbo].[ITEMS_TABLE] AS IT FULL OUTER JOIN [PRODUCTS].[dbo].[PRODUCT_TABLE] AS PT ON IT.ID=PT.PRODUCT_ID;

-----  Apply LEFT JOIN types on both the table ----
SELECT IT.*,PT.* FROM [BRANDS].[dbo].[ITEMS_TABLE] AS IT LEFT JOIN [PRODUCTS].[dbo].[PRODUCT_TABLE] AS PT ON IT.ID=PT.PRODUCT_ID;

---- Find the item_description and Product having the gross sales of 13,320.00 ----
SELECT IT.*,PT.* FROM [BRANDS].[dbo].[ITEMS_TABLE] AS IT JOIN [PRODUCTS].[dbo].[PRODUCT_TABLE] AS PT ON IT.ID=PT.PRODUCT_ID WHERE PT.GROSS_SALES=13320;

---- Split the Item_description Column into Columns Item_desc1 and Item_desc2----
USE BRANDS;
SELECT LEFT(ITEM_DESCRIPTION,LEN(ITEM_DESCRIPTION)/2) AS ITEM_DESC1, RIGHT(ITEM_DESCRIPTION,LEN(ITEM_DESCRIPTION)/2) AS ITEM_DESC2 FROM ITEMS_TABLE;

----  Find the top 3 most expensive items in the bottle_info table---
SELECT  TOP 3 BOTTLE_PRICE, ITEM_DESCRIPTION FROM ITEMS_TABLE ORDER BY BOTTLE_PRICE DESC;

-----Find the total Gross Sales and Profit for each Product in each Country. -----
Use PRODUCTS;
SELECT COUNTRY, SUM(Gross_Sales) AS Total_Gross_Sales, SUM(PROFIT) AS TOTAL_PROFIT FROM PRODUCT_TABLE GROUP BY COUNTRY ORDER BY COUNTRY;

----Find the vendor_name and item_description of items with a bottle_size of 750 and bottle_price less than 10. ----
USE BRANDS;
SELECT VENDOR_NAME,ITEM_DESCRIPTION FROM ITEMS_TABLE WHERE BOTTLE_SIZE=750 AND BOTTLE_PRICE<10;

----  Find the Product with the highest Profit in 2019.----
USE PRODUCTS;
SELECT MAX(PROFIT) AS MAX_PROFIT FROM PRODUCT_TABLE WHERE YEARS=2019;

----  Retrieve the Product_Id and Country of all records where the Profit is at least twice the COGS. ----
SELECT PRODUCT_ID, COUNTRY FROM PRODUCT_TABLE WHERE PROFIT>=2*COGS;

----  Find the Country that had the highest total Gross Sales in 2018-----

SELECT COUNTRY FROM PRODUCT_TABLE WHERE GROSS_SALES=(SELECT MAX(GROSS_SALES) FROM PRODUCT_TABLE WHERE GROSS_SALES=(SELECT SUM(GROSS_SALES) FROM PRODUCT_TABLE WHERE YEARS=2018 GROUP BY YEARS ) );

---- Calculate the total Sales for each Month Name across all years. ----
SELECT MONTH_NAME , SUM(SALES) AS SUM_OF_SALES FROM PRODUCT_TABLE GROUP BY MONTH_NAME;

---- List the item_description and vendor_name for items whose vendor_nos exists more than once in the bottle_info table.-----
USE BRANDS;
SELECT VENDOR_NAME, ITEM_DESCRIPTION FROM ITEMS_TABLE WHERE VENDOR_NOS = (SELECT VENDOR_NOS AS C_VENDOR_NOS FROM ITEMS_TABLE GROUP BY VENDOR_NOS  HAVING COUNT(VENDOR_NOS)>1 );

---- Find the average Manufacturing Price for Product in each Country and only include those Country and Product combinations where the average is above 3 ----
USE PRODUCTS;
SELECT * FROM PRODUCT_TABLE;
SELECT PRODUCTS, COUNTRY, AVG(MANUFACTURING_PRICE) AS AVG_MANFACTURING_PRICE FROM PRODUCT_TABLE GROUP BY PRODUCTS, COUNTRY HAVING AVG(MANUFACTURING_PRICE)>3;

----- Find the item_description and bottle_price of items that have the same vendor_name as items with Item_Id 1 -----
USE BRANDS;
SELECT ITEM_DESCRIPTION, BOTTLE_PRICE FROM ITEMS_TABLE WHERE VENDOR_NAME=(SELECT VENDOR_NAME FROM ITEMS_TABLE WHERE ID=1) AND ID!=1;

----Create a stored procedure to retrieve all records from the bottle_info table where bottle_price is greater than a given value---
CREATE PROCEDURE BOTTLE_INFO @BOTTLEPRICE DECIMAL(6,2)
AS
SELECT * FROM ITEMS_TABLE WHERE BOTTLE_PRICE>@BOTTLEPRICE
GO

EXEC BOTTLE_INFO @BOTTLEPRICE=2.00

---Create a stored procedure to insert a new record into the product_sales table. ---
USE PRODUCTS;

CREATE PROCEDURE PRODUCT_NEW_RCD
@COUNTRY  NVARCHAR(255)=NULL,
@PRODUCTS NVARCHAR(255)=NULL,
@UNITSolds DECIMAL(6,2)=NULL,
@MFG_PRICE  INT=NULL,
@SALEPrice INT=NULL,
@GROSSSales BIGINT=NULL,
@SALE   BIGINT=NULL,
@COGS BIGINT=NULL,
@PROFIT BIGINT=NULL
AS
SET NOCOUNT ON
INSERT INTO [dbo].[PRODUCT_TABLE]
([COUNTRY],[PRODUCTS],[UNITS_SOLD],[MANUFACTURING_PRICE],[SALE_PRICE],[GROSS_SALES],[SALES],[COGS],[PROFIT])
VALUES
(
@COUNTRY, @PRODUCTS, @UNITSolds, @MFG_PRICE, @SALEPrice, @GROSSSales, @SALE, @COGS, @PROFIT)
GO

EXEC PRODUCT_NEW_RCD @COUNTRY ='USA', @PRODUCTS='MONTANA', @UNITSolds=245.00, @MFG_PRICE=2, @SALEPrice=10, @GROSSSales=54389, @SALE=54389, @COGS=1239, @PROFIT=7894

---Create a trigger to automatically update the Gross_Sales field in the product_sales table whenever Units_Sold or Sale_Price is updated.---
CREATE TRIGGER UPDATE_GROSS_SALES
ON [dbo].[PRODUCT_TABLE]
AFTER UPDATE
AS BEGIN 
SET NOCOUNT ON;
IF (SUBSTRING(COLUMNS_UPDATED(),4,1) & CAST (0x20 AS int)=0*20)
BEGIN
UPDATE [dbo].[PRODUCT_TABLE]
SET [GROSS_SALES]= (I.[UNITS_SOLD] * I.[SALE_PRICE])
FROM [dbo].[PRODUCT_TABLE]  P INNER JOIN INSERTED I 
ON  P.PRODUCT_ID=I.PRODUCT_ID
WHERE CHECKSUM(P.UNITS_SOLD,P.SALE_PRICE)<> CHECKSUM(I.UNITS_SOLD,I.SALE_PRICE)
END
END

SELECT * FROM [dbo].[PRODUCT_TABLE];
UPDATE [dbo].[PRODUCT_TABLE]
SET [UNITS_SOLD]=7, [SALE_PRICE]=3 
WHERE PRODUCT_ID=9;



-----Write a query to find all item_description in the bottle_info table that contain the word "Whisky" regardless of case. -----
USE BRANDS;
SELECT * FROM [dbo].[ITEMS_TABLE] WHERE ITEM_DESCRIPTION LIKE '%Whisky%';

----Write a query to find the Country and Product where the Profit is greater than the average Profit of all products.---
USE PRODUCTS;
SELECT COUNTRY,PRODUCTS FROM PRODUCT_TABLE WHERE PROFIT> (SELECT AVG(PROFIT) FROM PRODUCT_TABLE);
SELECT * FROM PRODUCT_TABLE


----Write a query to join the bottle_info and product_sales tables on a common field (e.g., vendor_nos) and select relevant fields from both tables.---
SELECT * FROM [PRODUCTS].[dbo].[PRODUCT_TABLE] AS P JOIN [BRANDS].[dbo].[ITEMS_TABLE] AS I ON P.PRODUCT_ID=I.ID;

---Write a query to combine item_description and vendor_name into a single string for each record in the bottle_info table, separated by a hyphen. ---
USE BRANDS;
SELECT  [ITEM_DESCRIPTION]+' - '+[VENDOR_NAME] AS NAME FROM [dbo].[ITEMS_TABLE];

----Write a query to display the bottle_price rounded to one decimal place for each record in the bottle_info table.---
SELECT  CAST(ROUND(BOTTLE_PRICE,1,1) AS decimal(6,1)) AS BOTTLE_PRICE FROM [dbo].[ITEMS_TABLE];

----Write a query to calculate the number of days between the current date and the Date field for each record in the product_sales table.---
USE PRODUCTS;
SELECT DATEDIFF(DAY,DATES,GETDATE()) as Days_Diff FROM [dbo].[PRODUCT_TABLE];