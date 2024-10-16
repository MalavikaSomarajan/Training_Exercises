create database Taskdb;
use Taskdb;

create table Employee(
ID int,
Empname varchar(200),
City varchar(200),
Department varchar(200),
Salary int);

insert into Employee(ID, Empname, City, Department,Salary)
values('1','John','Kochi','Sales','7500');
 
 insert into Employee(ID, Empname, City, Department,Salary)
values('2','Will','Chennai','Sales','7000'),
	  ('3','Emma','Delhi','Manager','9500'),
	  ('4','James','Mumbai','Sales','7500'),
	  ('5','Kate','Kochi','Manager','9000'),
	  ('6','Anna','Kolkata','Sales','8000');     

select * from Employee;

--Second Highest Salary--
select max(Salary) as SecondHighSalary
from Employee
where Salary < (select max(Salary) from Employee);

--Number of Employee--
select Department,count(*) from Employee
group by Department;

--JOIN--
--table 1--
create table student (
    StudId int primary key,
    StudName varchar(100),
    DepartmentId int,
    Salary int);

insert into student(StudId, StudName, DepartmentId, Salary)
VALUES 
(1, 'Alice', 1, 50),
(2, 'Bob',2 , 60),
(3, 'Charlie',1, 55),
(4, 'David',3, 70),
(5, 'Eve',1, 45);

select * from student;

--table 2--

create table department (
    DepartmentId int,
	DepartmentName varchar(100));

insert into department( DepartmentId, DepartmentName)
VALUES 
( 1, 'English'),
(2 ,'Computer' ),
(3, 'Physics');

select * from department;

--INNER JOIN--
select student.StudName, Department.DepartmentName
from student
INNER JOIN Department
on student.DepartmentId = Department.DepartmentId;


--LEFT JOIN--
select student.StudName, Department.DepartmentName
from student
LEFT JOIN Department
on student.DepartmentId = Department.DepartmentId;

--RIGHT JOIN--
select student.StudName, Department.DepartmentName
from student
RIGHT JOIN Department
on student.DepartmentId = Department.DepartmentId;

--FULL OUTER JOIN--
select student.StudName, Department.DepartmentName
from student
FULL OUTER JOIN Department
on student.DepartmentId = Department.DepartmentId
order by StudName DESC;

--CRUD OPERATIONS--
create table Users (
    Username VARCHAR(50),
    Password VARCHAR(256));

--create(insert new user)--
create procedure CreateUser
    @Username VARCHAR(50),
    @Password VARCHAR(50)
AS
    insert into Users (Username, Password)
    values (@Username, @Password);

EXEC CreateUser @Username = 'john', @Password = 'abcd';
EXEC CreateUser @Username = 'Clarie', @Password = 'efg';
EXEC CreateUser @Username = 'Mike', @Password = 'xyz';
EXEC CreateUser @Username = 'Hopper', @Password = 'mno';

select * from Users;

--read/select--
create procedure GetUserByName
    @User varchar(50)
as
begin
    select  Username from Users
    where Username = @User;
end;
   
EXEC GetUserByName @User = 'Mike';

--update--
create procedure UpdateUserPassword
    @Username VARCHAR(50),
	@Password varchar(50)
as
begin
    update  Users
    set Password = @Password
    where Username = @Username;
end;
EXEC UpdateUserPassword @Username = 'John', @Password = 'newpass';


select * from Users;

--delete--
create procedure DeleteUser
    @Username varchar(50)
as
begin
    delete from Users
    where Username = @Username;
END;

EXEC DeleteUser @Username = 'Mike';

--NORMALIZATION--

--1NF--
CREATE TABLE Students (
    StudentId INT PRIMARY KEY,
    StudentName NVARCHAR(100)
);

CREATE TABLE StudentSubjects (
    StudentId INT,
    Subject NVARCHAR(100),
    PRIMARY KEY (StudentId, Subject),
    FOREIGN KEY (StudentId) REFERENCES Students(StudentId)
);


INSERT INTO Students (StudentId, StudentName) VALUES (1, 'John'), (2, 'Alice');
INSERT INTO StudentSubjects (StudentId, Subject) VALUES (1, 'Math'), (1, 'Science'), (2, 'Math'), (2, 'History');

SELECT * FROM Students;
SELECT * FROM StudentSubjects;

--2NF--

CREATE TABLE StudentsCourses (
    StudentId INT,
    CourseId INT,
    PRIMARY KEY (StudentId, CourseId),
    FOREIGN KEY (StudentId) REFERENCES Students(StudentId)
);

CREATE TABLE Courses (
    CourseId INT PRIMARY KEY,
    CourseName NVARCHAR(100),
    Instructor NVARCHAR(100)
);

INSERT INTO StudentsCourses (StudentId, CourseId) VALUES (1, 101), (1, 102), (2, 101);
INSERT INTO Courses (CourseId, CourseName, Instructor) VALUES (101, 'Math', 'Smith'), (102, 'History', 'Green');

SELECT * FROM StudentsCourses;
SELECT * FROM Courses;

--3NF--

CREATE TABLE Courses (
    CourseId INT PRIMARY KEY,
    CourseName NVARCHAR(100),
    Instructor NVARCHAR(100)
);

CREATE TABLE Departments (
    CourseName NVARCHAR(100) PRIMARY KEY,
    Department NVARCHAR(100)
);

INSERT INTO Courses (CourseId, CourseName, Instructor) VALUES (101, 'Math', 'Smith'), (102, 'History', 'Green');
INSERT INTO Departments (CourseName, Department) VALUES ('Math', 'Mathematics'), ('History', 'Humanities');

--4NF--

CREATE TABLE TeacherSubjects (
    TeacherId INT,
    Subject VARCHAR(100),
    PRIMARY KEY (TeacherId, Subject)
);

CREATE TABLE Subjects (
    Subject VARCHAR(100) PRIMARY KEY,
    Department VARCHAR(100)
);

INSERT INTO TeacherSubjects (TeacherId, Subject) VALUES (1, 'Math'), (1, 'History'), (2, 'Science');
INSERT INTO Subjects (Subject, Department) VALUES ('Math', 'Mathematics'), ('History', 'Humanities'), ('Science', 'Science');

--PIVOT & UNPIVOT--
CREATE TABLE Sales (
    SalesPerson NVARCHAR(50),
    Product NVARCHAR(50),
    SalesAmount INT
);

INSERT INTO Sales (SalesPerson, Product, SalesAmount)
VALUES
('John', 'Apples', 100),
('John', 'Bananas', 150),
('Alice', 'Apples', 200),
('Alice', 'Bananas', 50);

SELECT * FROM Sales;

--PIVOT--
SELECT SalesPerson, [Apples], [Bananas]
FROM (
    SELECT SalesPerson, Product, SalesAmount
    FROM Sales
) AS SourceTable
PIVOT (
    SUM(SalesAmount)
    FOR Product IN ([Apples], [Bananas])
) AS PivotTable;

--UNPIVOT--
SELECT SalesPerson, Product, SalesAmount
FROM (
    SELECT *
    FROM(
	 SELECT SalesPerson, Product, SalesAmount
    FROM Sales
) AS SourceTable
PIVOT (
    SUM(SalesAmount)
    FOR Product IN ([Apples], [Bananas])
) AS PivotTable

) AS PivotedTable
UNPIVOT (
    SalesAmount FOR Product IN ([Apples], [Bananas])
) AS UnpivotedTable;

--MERGE--
-- Target table--
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    Department NVARCHAR(50)
);

-- Source table--
CREATE TABLE EmployeeUpdates (
    EmployeeID INT,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    Department NVARCHAR(50)
);

INSERT INTO Employees (EmployeeID, FirstName, LastName, Department)
VALUES 
(1, 'John', 'Doe', 'HR'),
(2, 'Alice', 'Green', 'Sales'),
(3, 'Bob', 'White', 'IT');

INSERT INTO EmployeeUpdates (EmployeeID, FirstName, LastName, Department)
VALUES 
(1, 'John', 'Doe', 'HR'),         
(2, 'Alice', 'Brown', 'Marketing'),
(4, 'Carol', 'Smith', 'IT');    

MERGE INTO Employees AS target
USING EmployeeUpdates AS source
ON target.EmployeeID = source.EmployeeID
WHEN MATCHED THEN
    -- Update record in Employees if EmployeeID matches
    UPDATE SET 
        target.FirstName = source.FirstName,
        target.LastName = source.LastName,
        target.Department = source.Department
WHEN NOT MATCHED THEN
    -- Insert new record into Employees if EmployeeID doesn't exist
    INSERT (EmployeeID, FirstName, LastName, Department)
    VALUES (source.EmployeeID, source.FirstName, source.LastName, source.Department)
WHEN NOT MATCHED BY SOURCE THEN
    -- Optionally, delete rows from Employees if they don't exist in EmployeeUpdates
    DELETE;

select * from Employees;