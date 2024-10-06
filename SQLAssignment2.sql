CREATE DATABASE EMPLOYEE_ASSIGNMNT;
USE EMPLOYEE_ASSIGNMNT;

---- CREATE TABLE EMPLOYEEDETAILS----
CREATE TABLE EMPLOYEEDETAILS 
(EMPID INT PRIMARY KEY,
FULLNAME VARCHAR(255),
MANAGERID INT,
DATEOFJOINING DATE,
CITY VARCHAR(255));

---- CREATE EMPLOYEESALARY----
CREATE TABLE EMPLOYEESALARY
(EMPID INT PRIMARY KEY,
PROJECT VARCHAR(20),
SALARY BIGINT,
VARIABLE INT);

--- CONNECTING BOTH TABLES---
ALTER TABLE EMPLOYEESALARY ADD FOREIGN KEY(EMPID) REFERENCES EMPLOYEEDETAILS(EMPID);


--- Insert data in EMPLOYEEDETAILS----
SET DATEFORMAT mdy;
INSERT INTO EMPLOYEEDETAILS VALUES
(121,'John Snow',321,'01/31/2019','Toronto'),
(321,'Walter White',986,'01/30/2020','Calfornia'),
(421,'Kuldeep Rana',876,'07/11/2021','New Delhi');
INSERT INTO EMPLOYEEDETAILS VALUES
(521,'Aniket Verma',745,'03/30/2022','Chandigarh'),
(621,'Rohit Sharma',952,'12/14/2023','Pune');
INSERT INTO EMPLOYEEDETAILS VALUES
(721,'Melinda Flores',321,'03/30/2022','New York'),
(821,'Eli Smith',745,'12/14/2023','Dublin');

--- Insert data in EMPLOYEESALARY----
INSERT INTO EMPLOYEESALARY VALUES
(121,'P1',8000,500),
(321,'P2',10000,1000),
(421,'P1',12000,0);

ALTER TABLE EMPLOYEESALARY DROP CONSTRAINT [PK__EMPLOYEE__14CCD97DFEBAE72C];
ALTER TABLE EMPLOYEESALARY ALTER COLUMN EMPID INT NULL;

INSERT INTO EMPLOYEESALARY (PROJECT,SALARY,VARIABLE) VALUES
('P3',9000,650),
('P2',6000,400);



---- SQL Query to fetch records that are present in one table but not in another table.----
---- SQL query to fetch all the employees who are not working on any project.----
SELECT ED.*,ES.* FROM EMPLOYEEDETAILS AS ED LEFT JOIN EMPLOYEESALARY AS ES ON ED.EMPID=ES.EMPID WHERE ES.EMPID IS NULL;
SELECT * FROM EMPLOYEEDETAILS WHERE NOT EXISTS (SELECT * FROM EMPLOYEESALARY WHERE [dbo].[EMPLOYEESALARY].EMPID=[dbo].[EMPLOYEEDETAILS].EMPID);

----SQL query to fetch all the Employees from EmployeeDetails who joined in the Year 2020. ----
SELECT * FROM EMPLOYEEDETAILS WHERE YEAR(DATEOFJOINING)=2020;

----Fetch all employees from EmployeeDetails who have a salary record in EmployeeSalary. ----
SELECT ED.*,ES.* FROM EMPLOYEEDETAILS AS ED JOIN EMPLOYEESALARY AS ES ON ED.EMPID=ES.EMPID;

----Fetch employee names and salaries even if the salary value is not present for the employee. -----
SELECT ED.*,ES.* FROM EMPLOYEEDETAILS AS ED LEFT JOIN EMPLOYEESALARY AS ES ON ED.EMPID=ES.EMPID;

---Write an SQL query to fetch all the Employees who are also managers.----
SELECT E1.* FROM EMPLOYEEDETAILS E1, EMPLOYEEDETAILS E2 WHERE E1.EMPID=E2.MANAGERID;

----Write an SQL query to fetch a project-wise count of employees.----
SELECT COUNT(EMPID) AS EMP_COUNT,PROJECT FROM EMPLOYEESALARY GROUP BY PROJECT;

----Write an SQL query to fetch duplicate records from EmployeeDetails.----
SELECT MANAGERID,COUNT(*) FROM EMPLOYEEDETAILS GROUP BY MANAGERID HAVING COUNT(*)>1;

----Write an SQL query to fetch only odd rows from the table. ----
SELECT * FROM (SELECT *,ROW_NUMBER() OVER( ORDER BY EMPID ASC) AS ROW_NUM FROM EMPLOYEEDETAILS) AS A WHERE ROW_NUM %2<>0;

----Write a query to find the 3rd highest salary from a table without top or limit keyword. ---
SELECT TOP 1 * FROM (SELECT TOP 3 * FROM EMPLOYEESALARY ORDER BY SALARY DESC) AS EMP ORDER BY SALARY ASC;
SELECT * FROM (SELECT *, DENSE_RANK() OVER(ORDER BY SALARY DESC) AS SAL FROM EMPLOYEESALARY) AS ES WHERE  SAL=3;

----Write an SQL query to fetch the EmpId and FullName of all the employees working under the Manager with id – 986----
SELECT EMPID,FULLNAME FROM EMPLOYEEDETAILS WHERE MANAGERID=986;

----Write an SQL query to fetch the different projects available from the EmployeeSalary table.----
SELECT DISTINCT(PROJECT) FROM EMPLOYEESALARY;

---- Write an SQL query to fetch the count of employees working in project P1. ----
SELECT COUNT(EMPID) AS COUNT_EMP FROM EMPLOYEESALARY WHERE PROJECT='P1';

----Write an SQL query to find the maximum, minimum, and average salary of the employees.----
SELECT MAX(SALARY) AS MAX_SALARY,MIN(SALARY) AS MIN_SALARY, AVG(SALARY) AS AVG_SALARY FROM EMPLOYEESALARY;

----Write an SQL query to find the employee id whose salary lies in the range of 9000 and 15000.----
SELECT EMPID FROM EMPLOYEESALARY WHERE SALARY BETWEEN 9000 AND 15000;

----Write an SQL query to fetch those employees who live in Toronto and work under the manager with ManagerId – 321.----
SELECT EMPID, FULLNAME FROM EMPLOYEEDETAILS WHERE MANAGERID=321 AND CITY='TORONTO';

---- Write an SQL query to fetch all the employees who either live in California or work under a manager with ManagerId – 321. ----
SELECT * FROM EMPLOYEEDETAILS WHERE CITY='Calfornia' or MANAGERID=321;

---- Write an SQL query to fetch all those employees who work on Projects other than P1.-----
SELECT * FROM EMPLOYEESALARY WHERE PROJECT!='P1';

----Write an SQL query to display the total salary of each employee adding the Salary with Variable value. ----
SELECT EMPID,(SALARY+VARIABLE)AS TOTAL_SALARY FROM EMPLOYEESALARY;

---Write an SQL query to fetch the employees whose name begins with any two characters, followed by a text “hn” and ends with any sequence of characters.---
SELECT * FROM EMPLOYEEDETAILS WHERE FULLNAME LIKE '__hn%';

---Write an SQL query to fetch all the EmpIds which are present in either of the tables – "EmployeeDetails" and "EmployeeSalary". ---
select ed.empid from EMPLOYEEDETAILS ed full outer join EMPLOYEESALARY es on ed.EMPID=es.EMPID;

--- Write an SQL query to fetch common records between two tables. ---
select ed.empid from EMPLOYEEDETAILS ed inner join EMPLOYEESALARY es on ed.EMPID=es.EMPID;

----Write an SQL query to fetch records that are present in one table but not in another table.-----
select ed.empid from EMPLOYEEDETAILS ed left join EMPLOYEESALARY es on ed.EMPID=es.EMPID;

----Write an SQL query to fetch the employee's full names and replace the space ----
select replace(FULLNAME,' ','') as FullName from EMPLOYEEDETAILS;

----Write an SQL query to fetch the position of a given character(s) in a field. ---
select FullName,charindex('a', FullName) as Char_Index_A from EMPLOYEEDETAILS;

----Count the occurrence of a character in a string----
select FullName,LEN(replace(FULLNAME,' ',''))-LEN(replace(replace(FULLNAME,' ',''),'a','')) as Count_Char_A  from EMPLOYEEDETAILS;

--- Write an SQL query to display both the EmpId and ManagerId together. ---
select concat(EMPID,MANAGERID) as Emp_manager_id from EMPLOYEEDETAILS;

---Write a query to fetch only the first name(string before space) from the FullName column of the EmployeeDetails table.---
select FULLNAME, LEFT(FULLNAME, CHARINDEX(' ',FULLNAME)-1) as FIRST_NAME from EMPLOYEEDETAILS;

----Write an SQL query to uppercase the name of the employee and lowercase the city values.----
select UPPER(FullName) as FULLNAME, lower(city) as CITY from EMPLOYEEDETAILS;

----Write an SQL query to find the count of the total occurrences of a particular character – 'n' in the FullName field----
select FullName,LEN(replace(FULLNAME,' ',''))-LEN(replace(replace(FULLNAME,' ',''),'n','')) as Count_Char_n  from EMPLOYEEDETAILS;

----Write an SQL query to update the employee names by removing leading and trailing spaces. ----
select replace(FULLNAME,' ','') as FullName from EMPLOYEEDETAILS;

---Fetch all the employees who are not working on any project.----
select EMPID from EMPLOYEESALARY where PROJECT is null;

----Write an SQL query to fetch employee names having a salary greater than or equal to 5000 and less than or equal to 10000.-----
select ed.fullname from EMPLOYEEDETAILS ed join  EMPLOYEESALARY es on ed.EMPID=es.EMPID where es.SALARY>=5000 and es.SALARY<=10000;

--- Write an SQL query to find the current date-time---
select GETDATE();

---Write an SQL query to fetch all the Employee details from the EmployeeDetails table who joined in the Year 2020.---
select * from EMPLOYEEDETAILS where YEAR(dateofjoining)=2020;

----Write an SQL query to fetch all employee records from the EmployeeDetails table who have a salary record in the EmployeeSalary table.----
select ed.*, es.salary from EMPLOYEEDETAILS ed join EMPLOYEESALARY es on ed.EMPID=es.EMPID where es.SALARY is not null;

----Write an SQL query to fetch the project-wise count of employees sorted by project's count in descending order.----
select project, count(empid) as count_empid from EMPLOYEESALARY where project is not null and EMPID is not null group by project;

----Write a query to fetch employee names and salary records. Display the employee details even if the salary record is not present for the employee. ---
select ed.*, es.* from EMPLOYEEDETAILS ed full outer join EMPLOYEESALARY es on ed.empid=es.empid;