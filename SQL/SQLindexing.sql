USE CompanyDB;

CREATE TABLE Employ(
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10, 2),
    HireDate DATE
);

--create index single column--

CREATE INDEX idx_lastname
ON Employ (LastName);

--multiple column--
CREATE INDEX idx_lastname_department
ON Employ (LastName, Department);

--unique index--
CREATE UNIQUE INDEX idx_employeeid
ON Employ (EmployeeID);

--delete index--
DROP INDEX idx_lastname ON Employ;










