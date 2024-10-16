CREATE DATABASE CompanyDB;
USE CompanyDB;

CREATE SCHEMA HR;
CREATE SCHEMA Finance;

USE CompanyDB;

CREATE TABLE HR.Departments(
      DepartmentID INT PRIMARY KEY,
	  DepartmentName VARCHAR(100)
);
CREATE TABLE HR.Employees (
     EmployeesID INT PRIMARY KEY,
	 FirstName VARCHAR (50),
	 LastName VARCHAR(50),
	 DepartmentID INT,
     FOREIGN KEY (DepartmentID) REFERENCES HR.Departments (DepartmentID)
);

SELECT * FROM HR.Employees;
SELECT * FROM HR.Departments;

--SCHEMA CONSTRAINTS&DATA TYPE--

ALTER TABLE HR.Employees
ADD EmailAddress VARCHAR(100) UNIQUE,
    DateOfBirth DATE NOT NULL,
    Salary DECIMAL(10, 2) DEFAULT 3000,
	JobTitle VARCHAR(50);

--RELATIONSHIP BETWEEN SCHEMA--
CREATE TABLE Finance.Salaries (
     SalaryID INT PRIMARY KEY,
     EmployeeID INT,
     MonthlySalary DECIMAL (10, 2),
     PayDate DATE,
     FOREIGN KEY (EmployeeID) REFERENCES HR.Employees(EmployeesID) 
);

--Sample data--

INSERT INTO HR.Departments (DepartmentID, DepartmentName)
VALUES (1, 'IT'), (2, 'HR');

INSERT INTO HR. Employees (EmployeesID, FirstName, LastName, DepartmentID, DateOfBirth, EmailAddress)
VALUES (1, 'John', 'Doe', 1, '1990-01-01', 'john.doe@example.com'),
       (2, 'Jane', 'Smith', 2, '1985-05-05', 'jane.smith@example.com');
	   
INSERT INTO Finance.Salaries (SalaryID, EmployeeID, MonthlySalary, PayDate) 
VALUES (1, 1, 5000, '2023-01-01'),
       (2, 2, 4000, '2023-01-01');

--SCHEMA DIGNITY & NORMALIZATION--

CREATE TABLE HR.JobTitles ( 
     JobTitleID INT PRIMARY KEY, 
	 JobTitle VARCHAR (50)
);

--Update Employees table to reference JobTitleID--

ALTER TABLE HR.Employees
ADD JobTitleID INT,
    FOREIGN KEY (JobTitleID) REFERENCES HR.JobTitles (JobTitleID);

--Insert sample job titles--

INSERT INTO HR.JobTitles (JobTitleID, JobTitle)
VALUES (1, 'Developer'), (2, 'HR Manager');

--Update Employees table with JobTitleID--

UPDATE HR.Employees
SET JobTitleID = 1 WHERE EmployeesID = 1;

UPDATE HR. Employees
SET JobTitleID =2 WHERE EmployeesID= 2;

--CREATE VIEWS--
CREATE VIEW HR.EmployeeSalaryView AS

SELECT e.EmployeesID, e.FirstName, e.LastName, jt.JobTitle, s.MonthlySalary

FROM HR.Employees e

JOIN Finance.Salaries s ON e.EmployeesID = s.EmployeeID

JOIN HR.JobTitles jt ON e.JobTitleID = jt.JobTitleID;


--ADVANCED SQL--

CREATE TABLE HR. EmployeeAudit (
      AuditID INT PRIMARY KEY,
      EmployeeID INT,
      ChangedDate DATETIME DEFAULT GETDATE(),
      ChangeDescription VARCHAR(255),
      FOREIGN KEY (EmployeeID) REFERENCES HR.Employees (EmployeesID)
);

--Create a trigger to insert into EmployeeAudit after an update

CREATE TRIGGER AuditEmployeeChanges

ON HR.Employees

AFTER UPDATE

AS
BEGIN

INSERT INTO HR. EmployeeAudit (EmployeeID, ChangeDescription)

SELECT inserted. EmployeesID, 'Employee record updated' 

FROM inserted;

END;

--PARTITIONING TABLES--

--Create partition function--

CREATE PARTITION FUNCTION TransactionDateRange (DATE) 
AS RANGE LEFT FOR VALUES ('2023-01-01');

--Create partition scheme--

CREATE PARTITION SCHEME TransactionScheme 
AS PARTITION TransactionDateRange 
TO ( [PRIMARY], [SECONDARY] );

--Create partitioned table--

CREATE TABLE Finance.Transactions ( 
      TransactionID INT PRIMARY KEY, 
	  TransactionDate DATE, 
	  Amount DECIMAL (10, 2)
)
ON TransactionScheme (TransactionDate);

--ON DELETE CASCADE--
--Drop existing foreign key--

ALTER TABLE HR. Employees

DROP CONSTRAINT FK_Employees_Departments;

--Create new foreign key with ON DELETE CASCADE--

ALTER TABLE HR. Employees

ADD CONSTRAINT FK_Employees_Departments

FOREIGN KEY (DepartmentID) REFERENCES HR. Departments (DepartmentID) ON DELETE CASCADE;

--INDEXED VIEW--

--indexed view for total salary by department

CREATE VIEW Finance.DepartmentMonthlySalarySummary

WITH SCHEMABINDING

AS

SELECT d.DepartmentID, SUM(s.MonthlySalary) AS TotalSalary 

FROM HR.Employees e

JOIN Finance. Salaries s ON e.EmployeesID = s.EmployeeID

JOIN HR. Departments d ON e. DepartmentID = d. DepartmentID

GROUP BY d.DepartmentID;

--Create clustered index on the view

CREATE UNIQUE CLUSTERED INDEX IDX_DepartmentSalarySummary 

ON Finance.DepartmentMonthlySalarySummary (DepartmentID);