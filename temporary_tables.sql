#Using the example from the lesson, create a temporary table called employees_with_departments that contains first_name, last_name, and dept_name for employees currently with that department.

USE somerville_2277;
DROP TABLE somerville_2277.employees_with_departments;


CREATE TEMPORARY TABLE somerville_2277.employees_with_departments AS 
SELECT first_name, last_name, employees.departments.dept_name AS dept_name
FROM employees.employees 
JOIN employees.dept_emp ON employees.employees.emp_no = employees.dept_emp.emp_no
JOIN employees.departments ON employees.dept_emp.dept_no = employees.departments.dept_no
WHERE employees.dept_emp.to_date > CURDATE();


SELECT * FROM somerville_2277.employees_with_departments;

#Add a column named full_name to this table. It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns.

#ALTER TABLE employees_with_departments ADD full_name VARCHAR( (CHAR_LENGTH(first_name)+ CHAR_LENGTH(last_name) );

ALTER TABLE employees_with_departments ADD full_name VARCHAR(100);

#Update the table so that the full_name column contains the correct data.
UPDATE employees_with_departments
SET full_name = CONCAT(first_name, " ", last_name);

#Remove the first_name and last_name columns from the table.
ALTER TABLE employees_with_departments DROP COLUMN first_name;
ALTER TABLE employees_with_departments DROP COLUMN last_name;

#What is another way you could have ended up with this same table? 

CREATE TEMPORARY TABLE somerville_2277.employees_with_departments AS 
SELECT CONCAT(first_name," ", last_name) AS full_name, employees.departments.dept_name AS dept_name
FROM employees.employees 
JOIN employees.dept_emp ON employees.employees.emp_no = employees.dept_emp.emp_no
JOIN employees.departments ON employees.dept_emp.dept_no = employees.departments.dept_no
WHERE employees.dept_emp.to_date > CURDATE();

#Create a temporary table based on the payment table from the sakila database.
CREATE TEMPORARY TABLE somerville_2277.payment_temp
SELECT payment_id, rental_id, amount
FROM sakila.payment;

SELECT * FROM somerville_2277.payment_temp;

#Write the SQL necessary to transform the amount column such that it is stored as an integer representing the number of cents of the payment. For example, 1.99 should become 199.
ALTER TABLE payment_temp ADD amount_cents INT;

UPDATE payment_temp
SET amount_cents = amount * 100;

ALTER TABLE payment_temp DROP COLUMN amount;

#Go back to the employees database. Find out how the current average pay in each department compares to the overall current pay for everyone at the company. For this comparison, you will calculate the z-score for each salary. In terms of salary, what is the best department right now to work for? The worst?


-- Returns the current z-scores for each salary
-- Notice that there are 2 separate scalar subqueries involved
SELECT salary,
	(salary - (SELECT AVG(salary) FROM salaries where to_date > now()))
	/
	(SELECT stddev(salary) FROM salaries where to_date > now()) AS zscore
FROM salaries
WHERE to_date > now();

USE somerville_2277;

#table with AVG and STDDEV by department for all current salaries
CREATE TEMPORARY TABLE somerville_2277.salary_department AS 
SELECT employees.dept_emp.dept_no AS department_dept_no, AVG(employees.salaries.salary) AS department_avg_salary, stddev(employees.salaries.salary) AS department_stddev_salary
FROM employees.salaries 
JOIN employees.employees ON employees.salaries.emp_no = employees.employees.emp_no
JOIN employees.dept_emp ON employees.employees.emp_no = employees.dept_emp.emp_no
where employees.dept_emp.to_date > now()
AND employees.salaries.to_date > now()
GROUP BY employees.dept_emp.dept_no;

SELECT * FROM salary_department;

DROP TABLE somerville_2277.salary_department;

#table with AVG and STDDEV for all current salaries
CREATE TEMPORARY TABLE somerville_2277.salary_all AS 
SELECT AVG(employees.salaries.salary) AS all_avg_salary, stddev(employees.salaries.salary) AS all_stddev_salary
FROM employees.salaries 
WHERE employees.salaries.to_date > now();

SELECT * FROM salary_all;

DROP TABLE somerville_2277.salary_all;

#table with All current employees joined with 
SELECT employees.emp_no, employees.first_name, employees.last_name, dept_emp.dept_no
FROM employees.employees
JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
WHERE dept_emp.to_date > CURDATE();



CREATE TEMPORARY TABLE somerville_2277.zscore_salaries AS
(SELECT AVG(salary) AS average_salary, STD(salary) AS std_salary
FROM employees.salaries
WHERE to_date > now()
);