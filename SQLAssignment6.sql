CREATE DATABASE EmployeeDetail;
USE EmployeeDetail;

CREATE TABLE EmployeeDetail 
(EMPLOYEEID INT,
FIRSTNAME VARCHAR(100),
LASTNAME VARCHAR(100),
SALARY BIGINT,
JOININGDATE DATE,
DEPARTMENT VARCHAR(25),
GENDER VARCHAR(10));

ALTER TABLE EMPLOYEEDETAIL ADD CONSTRAINT GENDER CHECK (GENDER IN ('MALE','FEMALE'));

INSERT INTO EmployeeDetail VALUES
(1,'VIKAS','AHLAWAT',600000,'2/12/2012','IT','MALE'),
(2,'NIKITA','JAIN',530000,'2/14/2013','HR','FEMALE'),
(3,'ASHISH','KUMAR',1000000,'2/14/2013','IT','MALE'),
(4,'NIKHIL','SHARMA',480000,'2/15/2013','HR','MALE'),
(5,'ANISH','KADIAN',500000,'2/16/2013','PAYROLL','MALE');

----Write a query to get all employee detail from "EmployeeDetail" Table ----
SELECT * FROM EmployeeDetail;

----Write a query to get only "FirstName" column from "EmployeeDetail" table ----
SELECT FIRSTNAME FROM EmployeeDetail;

---Write a query to get FirstName in upper case as "First Name"---
SELECT UPPER(FIRSTNAME) AS FIRSTNAME FROM EmployeeDetail;

--- Write a query to get FirstName in LOWER case as "First Name"---
SELECT LOWER(FIRSTNAME) AS FIRSTNAME FROM EmployeeDetail;

---Write a query for combine FirstName and LastName and display it as "Name" (also include white space between first name & last name) ---
SELECT CONCAT(FIRSTNAME,' ',LASTNAME) AS NAME FROM EmployeeDetail;

---Select employee detail whose name is "Vikas---
SELECT * FROM EmployeeDetail WHERE FIRSTNAME='VIKAS';

----Get all employee detail from EmployeeDetail table whose "FirstName" start with latter 'a'.----
SELECT * FROM EmployeeDetail WHERE FIRSTNAME LIKE 'A%';

---Get all employee detail from EmployeeDetail table whose "LAStName" start with latter 'a'
SELECT * FROM EmployeeDetail WHERE LASTNAME LIKE 'A%';

---Get all employee details from EmployeeDetail table whose "FirstName" end with 'h' ---
SELECT * FROM EmployeeDetail WHERE FIRSTNAME LIKE '%H';

----Get all employee detail from EmployeeDetail table whose "FirstName" start with any single character between 'a-p'---
SELECT * FROM EmployeeDetail WHERE FIRSTNAME LIKE '[A-P]%';

----Get all employee detail from EmployeeDetail table whose "FirstName" not start with any single character between 'a-p'---
SELECT * FROM EmployeeDetail WHERE FIRSTNAME NOT LIKE '[A-P]%';

----Get all employee detail from EmployeeDetail table whose "Gender" end with 'le' and contain 4 letters. The Underscore(_) Wildcard Character represents any single character ---
SELECT * FROM EmployeeDetail WHERE GENDER LIKE '__LE';

----Get all employee detail from EmployeeDetail table whose "FirstName" start with 'A' and contain 5 letters ----
SELECT * FROM EmployeeDetail WHERE FIRSTNAME LIKE 'A____';

----Get all employee detail from EmployeeDetail table whose "FirstName" containing '%'. Ex:-"Vik%as".----
SELECT * FROM EmployeeDetail WHERE FIRSTNAME LIKE 'VIK%AS';

---Get all unique "Department" from EmployeeDetail table ----
SELECT DISTINCT DEPARTMENT FROM EmployeeDetail;

---Get the highest "Salary" from EmployeeDetail table. ---
SELECT TOP 1 SALARY FROM EmployeeDetail;

----Get the lowest "Salary" from EmployeeDetail table----
SELECT MIN(SALARY) AS LOWEST_SALARY FROM EmployeeDetail;

----Show "JoiningDate" in "dd mmm yyyy" format, ex- "15 Feb 2013---
SELECT FORMAT(JOININGDATE, 'dd MM yyyy')  as formatted_date FROM EmployeeDetail;

----Show "JoiningDate" in "yyyy/mm/dd" format, ex- "2013/02/15" ----
SELECT FORMAT(JOININGDATE, 'yyyy/mm/dd')  as formatted_date FROM EmployeeDetail;

----Show only time part of the "JoiningDate"----
SELECT CONVERT(datetime,JOININGDATE,108)  FROM EmployeeDetail;

----Get only Year part of "JoiningDate"
SELECT FORMAT(JOININGDATE,'yyyy') AS YEAR FROM EmployeeDetail;

----Get only Month part of "JoiningDate”----
SELECT FORMAT(JOININGDATE,'MM') AS MONTH FROM EmployeeDetail;

----Get system date ---
SELECT GETDATE() AS SYSTEMDATE;

---Get the first name, current date, joiningdate and diff between current date and joining date in months. ---
SELECT FIRSTNAME, GETUTCDATE() AS CURRENTDATE, JOININGDATE,DATEDIFF(month,JOININGDATE,GETUTCDATE()) as diff_Joining_CurrentDates FROM EmployeeDetail;

----Get UTC date.----
SELECT GETUTCDATE() AS UTC_DATE;

----Get all employee details from EmployeeDetail table whose joining year is 2013 ---
SELECT * FROM EmployeeDetail WHERE JOININGDATE LIKE '2013%';

----Get all employee details from EmployeeDetail table whose joining month is Jan(1)---
SELECT * FROM EmployeeDetail WHERE FORMAT(JOININGDATE,'MM')='01';

---- Select only one/top 1 record from "EmployeeDetail" table ----
SELECT TOP 1 * FROM EmployeeDetail;

----Select all employee detail with First name "Vikas","Ashish", and "Nikhil"--
SELECT * FROM EmployeeDetail WHERE FIRSTNAME IN ('VIKAS','ASHISH','NIKHIL');

----Select all employee detail with First name not in "Vikas","Ashish", and "Nikhil" ---
SELECT * FROM EmployeeDetail WHERE FIRSTNAME NOT IN ('VIKAS','ASHISH','NIKHIL');

--- Select first name from "EmployeeDetail" table after removing white spaces from right side ---
SELECT  RTRIM(FIRSTNAME) AS FNAME_RTRIM FROM EmployeeDetail;

----Select first name from "EmployeeDetail" table after removing white spaces from left side---
SELECT  LTRIM(FIRSTNAME) AS FNAME_LTRIM FROM EmployeeDetail;

----Display first name and Gender as M/F.(if male then M, if Female then F)----
SELECT FIRSTNAME, CASE WHEN GENDER='MALE' THEN 'M' WHEN GENDER='FEMALE' THEN 'F' END FROM EmployeeDetail;

---Select first name from "EmployeeDetail" table prifixed with "Hello"---
SELECT 'HELLO'+' '+FIRSTNAME FROM EmployeeDetail;

----Get employee details from "EmployeeDetail" table whose Salary greater than 600000 ---
SELECT * FROM EmployeeDetail WHERE SALARY>600000;

----Get employee details from "EmployeeDetail" table whose Salary less than 700000---
SELECT * FROM EmployeeDetail WHERE SALARY<700000;

----CREATE ProjectDetail table---
CREATE TABLE ProjectDetail 
(PROJECTDETAILID INT,
EMPLOYEEID INT,
PROJECTNAME VARCHAR(255));

---INSERT DATA IN ProjectDetail table---
INSERT INTO ProjectDetail VALUES
(1,1,'TASK TRACK'),
(2,1,'CLP'),
(3,1,'SURVEY MANAGEMENT'),
(4,2,'HR MANAGEMENT'),
(5,3,'TASK TRACK'),
(6,3,'GRS'),
(7,3,'DDS'),
(8,4,'HR MANAGEMENT'),
(9,6,'GL MANAGEMENT');


----Give records of ProjectDetail table ----
SELECT * FROM ProjectDetail;

----Write the query to get the department and department wise total(sum) salary from "EmployeeDetail" table.----
SELECT DEPARTMENT,SUM(SALARY) AS DEPT_WISE_TOTAL_SALARY FROM EmployeeDetail GROUP BY DEPARTMENT;

----Write the query to get the department and department wise total(sum) salary, display it in ascending order according to salary.---
SELECT DEPARTMENT,SUM(SALARY) AS DEPT_WISE_TOTAL_SALARY FROM EmployeeDetail GROUP BY DEPARTMENT ORDER BY DEPT_WISE_TOTAL_SALARY;

---Write the query to get the department and department wise total(sum) salary, display it in descending order according to salary ---
SELECT DEPARTMENT,SUM(SALARY) AS DEPT_WISE_TOTAL_SALARY FROM EmployeeDetail GROUP BY DEPARTMENT ORDER BY DEPT_WISE_TOTAL_SALARY DESC;

----Write the query to get the department, total no. of departments, total(sum) salary with respect to department from "EmployeeDetail" table.---
SELECT DEPARTMENT,COUNT (DEPARTMENT) AS Dept_Count, SUM(SALARY) AS DEPT_WISE_TOTAL_SALARY FROM EmployeeDetail GROUP BY DEPARTMENT;

----Get department wise average salary from "EmployeeDetail" table order by salary ascending----
SELECT DEPARTMENT, AVG(SALARY) AS Dept_Avg_Salary from EmployeeDetail GROUP BY DEPARTMENT ORDER BY Dept_Avg_Salary;

----Get department wise maximum salary from "EmployeeDetail" table order by salary ascending----
SELECT DEPARTMENT, MAX(SALARY) AS Dept_MAX_Salary from EmployeeDetail GROUP BY DEPARTMENT ORDER BY Dept_MAX_Salary;

---Get department wise minimum salary from "EmployeeDetail" table order by salary ascending. ---
SELECT DEPARTMENT, MIN(SALARY) AS Dept_MIN_Salary from EmployeeDetail GROUP BY DEPARTMENT ORDER BY Dept_MIN_Salary;

----Get department wise minimum salary from "EmployeeDetail" table order by salary Descending----
SELECT DEPARTMENT, MIN(SALARY) AS Dept_MIN_Salary from EmployeeDetail GROUP BY DEPARTMENT ORDER BY Dept_MIN_Salary DESC;

----Join both the table that is Employee and ProjectDetail based on some common parameter---
SELECT * FROM EmployeeDetail AS E JOIN ProjectDetail AS P ON E.EMPLOYEEID=P.EMPLOYEEID;

----Get employee name, project name order by firstname from "EmployeeDetail" and "ProjectDetail" for those employee which have assigned project already. ---
SELECT E.FIRSTNAME,P.PROJECTNAME FROM EmployeeDetail AS E JOIN ProjectDetail AS P ON E.EMPLOYEEID=P.EMPLOYEEID ORDER BY E.FIRSTNAME;

----Get employee name, project name order by firstname from "EmployeeDetail" and "ProjectDetail" for all employee even they have not assigned project.---
SELECT E.FIRSTNAME,P.PROJECTNAME FROM EmployeeDetail AS E  LEFT JOIN ProjectDetail AS P ON E.EMPLOYEEID=P.EMPLOYEEID ORDER BY E.FIRSTNAME;

----Get employee name, project name order by firstname from "EmployeeDetail" and "ProjectDetail" for all employee if project is not assigned then display "-No Project Assigned" ---
SELECT E.FIRSTNAME,ISNULL(P.PROJECTNAME, 'NO PROJECT ASSIGNED') AS PROJECT_ASSIGNED FROM EmployeeDetail AS E  LEFT JOIN ProjectDetail AS P ON E.EMPLOYEEID=P.EMPLOYEEID ORDER BY E.FIRSTNAME;

----Get all project name even they have not matching any employeeid, in left table, order by firstname from "EmployeeDetail" and "ProjectDetail---
SELECT E.EMPLOYEEID,P.PROJECTNAME FROM EmployeeDetail AS E  RIGHT JOIN ProjectDetail AS P ON E.EMPLOYEEID=P.EMPLOYEEID ORDER BY E.FIRSTNAME;

----Get complete record (employeename, project name) from both tables ([EmployeeDetail],[ProjectDetail]), if no match found in any table then show NULL---
SELECT E.FIRSTNAME,P.PROJECTNAME FROM EmployeeDetail AS E  FULL OUTER JOIN ProjectDetail AS P ON E.EMPLOYEEID=P.EMPLOYEEID;

----Write down the query to fetch EmployeeName & Project who has assign more than one project----
SELECT E.EMPLOYEEID,E.FIRSTNAME, P.PROJECTNAME FROM EmployeeDetail AS E,ProjectDetail AS P WHERE E.EMPLOYEEID=P.EMPLOYEEID 
AND E.EMPLOYEEID IN (SELECT P.EMPLOYEEID FROM ProjectDetail P GROUP BY P.EMPLOYEEID HAVING COUNT(*)>1);


----Write down the query to fetch ProjectName on which more than one employee are working along with EmployeeName ----
SELECT E.FIRSTNAME, P.PROJECTNAME FROM EmployeeDetail AS E,ProjectDetail AS P WHERE E.EMPLOYEEID=P.EMPLOYEEID 
AND P.PROJECTNAME IN (SELECT P.PROJECTNAME FROM ProjectDetail P GROUP BY P.PROJECTNAME HAVING COUNT(P.EMPLOYEEID)>1);

---Apply Cross Join in Both the tables---
SELECT *  FROM EmployeeDetail CROSS JOIN ProjectDetail;


