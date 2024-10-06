----CREATE A NEW DATABASE----
CREATE DATABASE STUDENTS;
USE STUDENTS;

----CREATE STUDENTS TABLES---
CREATE TABLE STUDENTS 
(STUDENTID VARCHAR(15) PRIMARY KEY,
NAME  VARCHAR(255),
SURENAME VARCHAR(255),
BIRTHDATE DATE,
GENDER CHAR(10),
CLASS VARCHAR(50),
POINT VARCHAR(50));

---CONSTRAINT TO HAVE ONLY 2 POSSIBLE VALUES FOR GENDER---
ALTER TABLE STUDENTS ADD CONSTRAINT GENDER CHECK (GENDER IN('M','F'));
SELECT * FROM STUDENTS;

--- CREATE TABLE BORROWS---
CREATE TABLE BORROWS
(BORROWID VARCHAR(15) PRIMARY KEY,
STUDENTID VARCHAR(15),
BOOKID VARCHAR(15),
TAKENDATE DATE,
BROUGHTDATE DATE);

--- ADD FOREIGN KEY CONSTRAINTS TO BORROWS TABLE----
ALTER TABLE BORROWS ADD FOREIGN KEY (STUDENTID) REFERENCES STUDENTS(STUDENTID);

---CREATE BOOKS TABLE---
CREATE TABLE BOOKS
(BOOKID VARCHAR(15)PRIMARY KEY ,
BNAME VARCHAR(255),
BPAGECOUNT NUMERIC(20),
POINT VARCHAR(50),
AUTHORID VARCHAR(50),
TYPEID VARCHAR (50));


---- CREATE AUTHORS TABLE---
CREATE TABLE AUTHORS
(AUTHORID VARCHAR(50) PRIMARY KEY,
A_NAME VARCHAR(255),
SURNAME VARCHAR(255));


----CREATE TYPES TABLE---
CREATE TABLE TYPESS
(TYPEID VARCHAR(50) PRIMARY KEY,
NAME VARCHAR(50));


---- ADD FOREIGN KEY CONSTRAINTS---
ALTER TABLE BORROWS ADD FOREIGN KEY (BOOKID) REFERENCES BOOKS(BOOKID);
ALTER TABLE BOOKS ADD FOREIGN KEY (AUTHORID) REFERENCES AUTHORS(AUTHORID);
ALTER TABLE BOOKS ADD FOREIGN KEY (TYPEID) REFERENCES TYPESS(TYPEID);

----INSERT DATA----
INSERT INTO STUDENTS VALUES
('S_001','AMAN','KUMAR','03-10-92','M','BTECH','P_01'),
('S_002','AKHIL','SINGH','09-10-97','M','BCOME','P_02'),
('S_003','SONIA','VERMA','10-11-94','F','BA','P_03'),
('S_004','HARDEEP','KAUR','04-02-99','F','METCH','P_04');

INSERT INTO BORROWS VALUES
('BO_001','S_001','B_002','04-02-24','10-02-24'),
('BO_002','S_003','B_005','06-07-24','12-07-24'),
('BO_003','S_002','B_001','04-02-24','10-02-24'),
('BO_004','S_004','B_003','09-01-24','10-01-24'),
('BO_001','S_002','B_004','04-02-24','10-02-24');

SELECT * FROM BOOKS;
INSERT INTO BOOKS VALUES
('B_001','SFDC','1000','P_01','A_003','T_005'),
('B_002','CLOUD COMP','8000','P_02','A_005','T_003'),
('B_003','BIO','2500','P_03','A_002','T_001'),
('B_004','ALGEBRA','3500','P_04','A_001','T_002'),
('B_005','CLOUD COMP','8000','P_02','A_004','T_004');

INSERT INTO AUTHORS VALUES
('A_001','RAKESH','KUMAR'),
('A_002','SOBHA','DAS'),
('A_003','KIRPAL','SINGH'),
('A_004','MOHAN','RAO'),
('A_005','SIMRAN','KAUR');


INSERT INTO TYPESS VALUES
('T_001','SCIENCE'),
('T_002','MATH'),
('T_003','SQL'),
('T_004','JAVA'),
('T_005','POWER BI');

----List all the records in the student chart---
SELECT * FROM STUDENTS;

---List the name surname and class of the student in the student table----
SELECT NAME,SURENAME,CLASS FROM STUDENTS;

----List the gender Female (F) records in the student table ---
SELECT * FROM STUDENTS WHERE GENDER='F';

----List the names of each class in the way of being seen once in the student table----
SELECT DISTINCT(CLASS) FROM STUDENTS;
SELECT CLASS FROM STUDENTS GROUP BY CLASS HAVING COUNT(CLASS)=1;

----List the students with Female gender and the class 10Math in the student table ---
SELECT * FROM STUDENTS WHERE GENDER='F' AND CLASS='10MATH';

----List the names, surnames and classes of the students in the class 10Math or 10Sci in the student table---
SELECT NAME,SURENAME,CLASS FROM STUDENTS WHERE CLASS='10MATH' OR CLASS='10SCI';

----List the students name surname and school number in the student table ----
SELECT NAME,SURENAME FROM STUDENTS;

----List the students name and surname by combining them as name surname in the student table---
SELECT CONCAT(NAME,' ',SURENAME) AS NAME_OF_STUDENT FROM STUDENTS;

----List the students with the names starting with “A” letter in the student table----
SELECT * FROM STUDENTS WHERE NAME LIKE 'A%';

----List the book names and pages count with number of pages between 50 and 200 in the book table----
SELECT BNAME, BPAGECOUNT FROM BOOKS WHERE BPAGECOUNT BETWEEN 50 AND 200;

----List the students with names Emma, Sophia and Robert in the student table----
SELECT * FROM STUDENTS WHERE NAME IN ('EMMA','SOPHIA','ROBERT');

---List the students with names starting with A D and K in the student table ---
SELECT * FROM STUDENTS WHERE NAME LIKE 'A%' OR NAME LIKE'H%' OR NAME LIKE 'K%';

---List the names surnames classes and genders of males in 9Math or females in 9His in the student table ---
SELECT NAME,SURENAME,CLASS, GENDER FROM STUDENTS WHERE (CLASS='BTECH' AND GENDER='M') OR (CLASS='METCH' AND GENDER='F');

----List the males whose classes are 10Math or 10Bio----
SELECT * FROM STUDENTS WHERE GENDER='M'  AND (CLASS='BTECH' OR CLASS='BCOME');

---List the students with birth year 1989 in the student table ----
SELECT * FROM STUDENTS WHERE BIRTHDATE LIKE '1992%';

---List the female students with  student numbers between 30 and 50----
SELECT * FROM STUDENTS WHERE GENDER='F' AND STUDENTID BETWEEN 'S_002' AND 'S_004';

---List the students according to their names----
SELECT * FROM STUDENTS ORDER BY NAME;

----List the students by names for those with same names. List them by their surnames ---
SELECT NAME,SURENAME,COUNT(NAME) AS NUM_DUP  FROM STUDENTS GROUP BY NAME, SURENAME HAVING COUNT(NAME)>1;

---List the students in 10Math by decreasing school numbers---
SELECT * FROM STUDENTS WHERE CLASS='BTECH' ORDER BY STUDENTID DESC;

----List the first 10 records in the student chart ---
SELECT TOP 2 * FROM STUDENTS;
----21.	List the first 10 records name surname and date of birth information in the student table--
SELECT TOP 3 NAME,SURENAME,BIRTHDATE FROM STUDENTS;

---List the book with the most page number---
SELECT BNAME,BPAGECOUNT FROM BOOKS WHERE BPAGECOUNT=(SELECT MAX(BPAGECOUNT) FROM BOOKS); 

----List the youngest student in the student table ----
SELECT * FROM STUDENTS WHERE BIRTHDATE=(SELECT MAX(BIRTHDATE) FROM STUDENTS);

----List the oldest student in the 10Math class---
SELECT * FROM STUDENTS WHERE BIRTHDATE=(SELECT MIN(BIRTHDATE) FROM STUDENTS WHERE CLASS='BTECH');

---List the books with the second letter L---
SELECT * FROM BOOKS WHERE BNAME LIKE '_L%';

---List the students by grouping according to their classes ---
SELECT NAME,CLASS FROM STUDENTS GROUP BY CLASS,NAME;

----Pick a random student from student table---
SELECT TOP 1 * FROM STUDENTS ORDER BY NEWID();

---Bring some random student’s name, surname and number from class 10Math---
SELECT TOP 1 NAME,SURENAME,STUDENTID FROM STUDENTS WHERE CLASS='BTECH' ORDER BY NEWID();

----Add the writer named Smith Allen to the authors table ----
INSERT INTO AUTHORS VALUES ('A_006','SMITH','ALLEN');

---Add the genre of  biography to the genre table---
INSERT INTO TYPESS VALUES ('T_006','BIOGRAPHY');

---Add 10Math Class male named Thomas Nelson , 9Bio class female named Sally Allen and 11His Class female named Linda Sandra in one question---
INSERT INTO STUDENTS (STUDENTID,NAME, SURENAME,CLASS, GENDER) VALUES
('S_009','THOMAS','NELSON','10MATH','M'),
('S_010','SALLY','ALLEN','9BIO','F'),
('S_011','LINDA','SANDRA','11HIS','F');

---Change the class of the student whose school number is 3 from 10Bio to 10His --
UPDATE STUDENTS SET CLASS='MTECH' WHERE STUDENTID='S_001';

---- Transfer all the students in 9Math Class to 10Math Class---
UPDATE STUDENTS SET CLASS='BTECH';

----List the name ,surname and the dates of received books of the student---
SELECT S.NAME,S.SURENAME,BO.BROUGHTDATE FROM STUDENTS S JOIN BORROWS BO ON S.STUDENTID=BO.STUDENTID ORDER BY NAME;


