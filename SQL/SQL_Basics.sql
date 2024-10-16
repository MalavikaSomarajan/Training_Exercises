   create database Claysysdb;

   use Claysysdb;

create table student(
ID int,
StudName varchar(200),
Age int,
Department varchar(200)
);

insert into student(ID, StudName, Age, Department)
values('1','Jack','17','computer'),
      ('2','Emma','18','English'),
      ('3','Jane','16','Physis'),
	  ('4','David','18','computer'),
	  ('5','Will','20','History'),
	  ('6','Kate','15','Physis');

 select * from student;

 select ID,Age from student;

select distinct Department from student;

select StudName from student where Age=20;

select * from student where StudName='Jack';

select * from student where Age>=17;

select * from student order by StudName;

select * from student order by StudName DESC; 

select * from student order by Age,Department; 

select * from student where Age=17 AND Department='computer';

select * from student where Age=17 or Age=15;

select * from student where not Department='english';

select * from student where Department IN ('History','English');

select * from student where StudName NOT IN ('Jack','Kate');

select * from student where Age BETWEEN 17 AND 20;

select * from student where Age NOT BETWEEN 17 AND 20;

select * from student where StudName LIKE ('J%');

select * from student where StudName LIKE ('%e');

select * from student where StudName LIKE ('_a%');

select * from student where StudName NOT LIKE ('J%');

select max(Age) from student;

select min(Age) from student;
 
select sum(Age) from student;

select sum(Age) from student where Age>= 17;

select avg(Age) from student;

select count(StudName) from student;
 
select count(StudName) from student where Age>= 17;

 alter table student
 add Mark int;

 alter table student
 drop column Mark;

 UPDATE student set Age =19
 where ID=2;

 select StudName from student;

 --ALIAS--
 select StudName  AS result from student;

 --STORED PROCEDURE--
 create procedure records
 AS 
 select * from student
 GO;

 exec records;

 --WITH 1 PARAMETER--
 create procedure records2 @Age int
 AS 
 select * from student where Age=@Age;

 exec records2 @Age=19;

 --WITH MULTIPLE PARAMETERS--
 create procedure records3 @Age int, @StudName varchar(200)
 AS 
 select * from student where Age=@Age AND StudName=@StudName;

 exec records3 @Age=19, @StudName='Emma';

 --SELECT TOP--
  select top 2 * from student;

  select top 50 percent * from student;

