SHOW DATABASES;
USE albums_db;
SELECT database();
SHOW TABLES;
SHOW DATABASES;
USE employees;
SELECT database();
SHOW TABLES;

/* #10 emp_no int PK, birth_date date, first_name varchar(14), 
last_name varchar(16), gender enum('M','F') ,hire_date date */

/* #11 Which table(s) do you think contain a numeric type column?
Table Salaries */

/* #12 Which table(s) do you think contain a string type column?
Departments, dept_emp, `dept_manager`, `employees`, `titles` */

/* #13 Which table(s) do you think contain a date type column?
dept_emp, dept_manager, employees, salaries, titles */

/* #14 What is the relationship between the employees and the departments tables? 
Tthere is no relationship...? not so sure about this one. I see a relationship between employees and dept_manager. */
 
SHOW CREATE TABLE dept_manager;