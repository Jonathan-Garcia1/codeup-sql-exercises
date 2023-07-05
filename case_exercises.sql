#Write a query that returns all employees, their department number, their start date, their end date, and a new column 'is_current_employee' that is a 1 if the employee is still with the company and 0 if not. DO NOT WORRY ABOUT DUPLICATE EMPLOYEES.
USE employees;

SELECT employees.first_name, employees.last_name, dept_emp.dept_no, dept_emp.from_date, dept_emp.to_date, 
	IF(dept_emp.to_date > CURDATE(), TRUE, FALSE) AS is_current_employee
FROM employees
INNER JOIN dept_emp ON employees.emp_no = dept_emp.emp_no;


#Write a query that returns all employee names (previous and current), and a new column 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' depending on the first letter of their last name.
SELECT first_name, last_name, 
	CASE
    WHEN SUBSTR(last_name,1,1) BETWEEN 'A' AND 'H' THEN 'A-H' 
    WHEN SUBSTR(last_name,1,1) BETWEEN 'I' AND 'Q' THEN 'I-Q'
    WHEN SUBSTR(last_name,1,1) BETWEEN 'R' AND 'Z' THEN 'R-Z'
    END AS alpha_group
    FROM employees;

#How many employees (current or previous) were born in each decade?
#'1950s','182886'
#'1960s','117138'

SELECT
	CASE
    WHEN SUBSTR(birth_date,1,4) BETWEEN 1950 and 1959 THEN '1950s'
    WHEN SUBSTR(birth_date,1,4) BETWEEN 1960 and 1969 THEN '1960s'
    END AS birth_decade,
    COUNT(emp_no)
FROM employees
GROUP BY birth_decade;

#What is the current average salary for each of the following department groups: R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?

SELECT
	CASE 
	WHEN departments.dept_name IN ('Development', 'Research') THEN 'R&D'
	WHEN departments.dept_name IN ('Marketing', 'sales') THEN 'Sales & Marketing'
	WHEN departments.dept_name IN ('Production', 'Quality Management') THEN 'Prod & QM'
	WHEN departments.dept_name IN ('Finance', 'Human Resources') THEN 'Finance & HR'
	ELSE departments.dept_name
	END AS 'Department Group',
    AVG(salaries.salary)
FROM departments
INNER JOIN dept_emp ON departments.dept_no = dept_emp.dept_no
INNER JOIN salaries ON dept_emp.emp_no = salaries.emp_no
WHERE salaries.to_date > CURDATE()
GROUP BY departments.dept_name;

