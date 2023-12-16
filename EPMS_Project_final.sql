##create database (Employee Payroll Management System - EPMS)

CREATE database EPMS;

USE EPMS;

##CREATE AND POPULATE EMPLOYEE TABLE 
Create table EPMS.Employee(
Employee_ID VARCHAR(50) NOT NULL,
First_Name VARCHAR(25) NOT NULL,
Last_Name VARCHAR(25) NOT NULL,
Hire_Date DATE NOT NULL,
City VARCHAR(25) NOT NULL,
State VARCHAR(25),
CONSTRAINT EMPLOYEE_PK PRIMARY KEY (Employee_ID));

INSERT INTO EPMS.Employee 
(Employee_ID,First_Name,Last_Name,Hire_Date,City,State)
VALUES
('E001','John','Doe','2023-01-15','New York','NY'),
('E002','Alice','Smith','2022-05-20','San Francisco','CA'),
('E003','James','Johnson','2022-09-08','Chicago','IL'),
('E004','Emily','Brown','2023-03-12','Los Angeles','CA'),
('E005','Michael','Davis','2022-11-02','Houston','TX'),
('E006','Sophia','Wilson','2023-02-28','Seattle','WA'),
('E007','William','Miller','2022-07-14','Boston','MA'),
('E008','Olivia','Jones','2022-12-10','Atlanta','GA'),
('E009','Benjamin','Taylor','2022-04-05','Denver','CO'),
('E010','Ava','Martinez','2023-06-18','Miami','FL');

#select * from Employee;

##CREATE AND POPULATE DEPARTMENT TABLE
CREATE TABLE EPMS.Department(
Dept_ID VARCHAR(25) NOT NULL,
Dept_Name VARCHAR(25) NOT NULL,
CONSTRAINT DEPARTMENT_PK PRIMARY KEY (Dept_ID));

#select * from department;

##CREATE AND POPULATE ACCOUNT DETAILS TABLE
CREATE TABLE EPMS.AccountDetails(
Account_ID VARCHAR(50) NOT NULL,
Bank_Name VARCHAR(50) NOT NULL,
Account_Number VARCHAR(50) NOT NULL,
Employee_ID VARCHAR(50) NOT NULL,
CONSTRAINT Account_PK PRIMARY KEY (Account_ID),
FOREIGN KEY (Employee_ID)
REFERENCES Employee(Employee_ID));

INSERT INTO EPMS.AccountDetails 
(Account_ID,Bank_Name,Account_Number,Employee_ID)
VALUES
('A001','Bank of XYZ',1234567890,'E001'),
('A002','National Bank',9876543210,'E002'),
('A003','FinanceCorp','5678901234','E003'),
('A004','City Savings',4567890123,'E004'),
('A005','Metro Bank',3456789012,'E005'),
('A006','Capital One',7890123456,'E006'),
('A007','United Trustee',6543210987,'E007'),
('A008','Prosper Bank',8901234567,'E008'),
('A009','Harmony Finance',2345678901,'E009'),
('A010','Liberty Savings',6789012345,'E010');

#select * from AccountDetails;

##CREATE AND POPULATE SALARY TABLE
CREATE TABLE EPMS.Salary(
Salary_ID VARCHAR(10) NOT NULL,
Gross_Salary DECIMAL(10, 2) NOT NULL,
Hourly_Pay DECIMAL(10, 2) NOT NULL,
Income_Tax DECIMAL(10, 2) NOT NULL,
NI DECIMAL(10, 2) NOT NULL,
Account_ID VARCHAR(50) NOT NULL,
CONSTRAINT SALARY_PK PRIMARY KEY (Salary_ID),
FOREIGN KEY (Account_ID)
REFERENCES AccountDetails(Account_ID));

INSERT INTO EPMS.Salary 
(Salary_ID,Gross_Salary,Hourly_Pay,Income_Tax,NI,Account_ID)
VALUES
('S001',60000.00,30.00,15000.00,5000.00,'A001'),
('S002',70000.00,35.00,17500.00,5500.00,'A002'),
('S003',55000.00,27.00,13750.00,4500.00,'A003'),
('S004',50000.00,25.00,12500.00,4000.00,'A004'),
('S005',65000.00,32.00,16250.00,4800.00,'A005'),
('S006',60000.00,30.00,15000.00,5000.00,'A006'),
('S007',70000.00,35.00,17500.00,5500.00,'A007'),
('S008',75000.00,37.00,18750.00,6000.00,'A008'),
('S009',52000.00,26.00,13000.00,4200.00,'A009'),
('S010',58000.00,29.00,14500.00,4600.00,'A010');

#select * from salary;

##CREATE AND POPULATE WORKLOCATION TABLE

CREATE TABLE EPMS.Work_Location(
Location_ID VARCHAR(10) NOT NULL,
Location VARCHAR(25) NOT NULL,
Employee_ID VARCHAR(50) NOT NULL,
City VARCHAR(25) NOT NULL,
State VARCHAR(25) NOT NULL,
CONSTRAINT Loc_PK PRIMARY KEY (Location_ID),
FOREIGN KEY (Employee_ID)
REFERENCES Employee(Employee_ID));

INSERT INTO EPMS.Work_Location 
(Location_ID,Location,Employee_ID,City,State)
VALUES
('L001','Main Office','E001','New York','NY'),
('L002','Tech Park','E002','San Francisco','CA'),
('L003','Financial Center','E003','Chicago','IL'),
('L004','Marketing Hub','E004','Los Angeles','CA'),
('L005','Operations Center','E005','Houston','TX'),
('L006','Development Lab','E006','Seattle','WA'),
('L007','Sales Branch','E007','Boston','MA'),
('L008','Customer Service Hub','E008','Atlanta','GA'),
('L009','Legal Office','E009','Denver','CO'),
('L010','Admin Center','E010','Miami','FL');

#select * from work_location;

##CREATE A STORED PROCEDURE TO ADD NEW EMPLOYEES TO EMPLOYEE TABLE
Use EPMS;
## Change Delimiter
DELIMITER //
## CREATE STORED PROCEDURE
CREATE PROCEDURE add_new_employee (
	IN Employee_ID VARCHAR(50), 
    IN First_Name VARCHAR(25), 
    IN Last_Name VARCHAR(25), 
    IN Hire_Date DATE, 
    IN City VARCHAR(25), 
    IN State VARCHAR(2)
)
BEGIN
   INSERT INTO Employee(Employee_ID, First_Name, Last_Name, Hire_Date, City, State)
   VALUES (Employee_ID, First_Name, Last_Name, Hire_Date, City, State);
 END//
## Change Delimiter again
DELIMITER ; 

USE epms;
#CALL add_new_employee ('E011','Adio','Anike','2021-07-16','Houston','TX');

##DISPLAY THE STORED PROCEDURE
#SELECT * FROM epms.employee;

##QUERY TO DELETE STORED PROCEDURE RESULTS
#DELETE FROM Employee
#WHERE Employee_ID='E011';

##DROP THE STORED PROCEDURE
##DROP PROCEDURE add_new_employee;

##EXAMPLE QUERY
SELECT Salary_ID, AVG(Gross_Salary) AS Average_Gross_Salary
FROM Salary
GROUP BY Salary_ID
HAVING AVG(Gross_Salary) > 60000;

