USE join_example_db;
#1 Use the join_example_db. Select all the records from both the users and roles tables.
SELECT *
FROM roles;

SELECT *
FROM users;

#2 Use join, left join, and right join to combine results from the users and roles tables as we did in the lesson. Before you run each query, guess the expected number of results.
SELECT *
FROM users
INNER JOIN roles ON users.role_id = roles.id;

SELECT *
FROM users
LEFT JOIN roles ON users.role_id = roles.id;

SELECT *
FROM users
RIGHT JOIN roles ON users.role_id = roles.id;

#3 Although not explicitly covered in the lesson, aggregate functions like count can be used with join queries. Use count and the appropriate join type to get a list of roles along with the number of users that has the role. Hint: You will also need to use group by in the query.
SELECT roles.name, COUNT(*)
FROM roles
INNER JOIN users ON users.role_id = roles.id
GROUP BY roles.name;

#Using the example in the Associative Table Joins section as a guide, write a query that shows each department along with the name of the current manager for that department.
USE employees;

SELECT departments.dept_name AS "Department Name", CONCAT(employees.first_name, " ",employees.last_name) As "Department Manager"
FROM dept_manager
INNER JOIN departments ON dept_manager.dept_no = departments.dept_no
INNER JOIN employees ON dept_manager.emp_no = employees.emp_no
INNER JOIN dept_manager ON dept_manager.emp_no = dept_manager.emp_no 
WHERE dept_manager.to_date > CURDATE()
ORDER BY departments.dept_name ASC;

#Find the name of all departments currently managed by women.
SELECT departments.dept_name, CONCAT(employees.first_name, " ", employees.last_name) As emp_names
FROM dept_manager
INNER JOIN departments ON dept_manager.dept_no = departments.dept_no
INNER JOIN employees ON dept_manager.emp_no = employees.emp_no
WHERE employees.gender = "F"
AND dept_manager.to_date = "9999-01-01";

#Find the current titles of employees currently working in the Customer Service department.
SELECT titles.title, COUNT(employees.first_name)
FROM titles
INNER JOIN employees ON titles.emp_no = employees.emp_no
INNER JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
INNER JOIN departments ON dept_emp.dept_no = departments.dept_no
WHERE dept_emp.dept_no = "d009"
AND titles.to_date > CURDATE()
AND dept_emp.to_date > CURDATE()
GROUP BY titles.title
ORDER BY titles.title ASC;

#5 Find the current salary of all current managers.
SELECT departments.dept_name AS "Department Name", CONCAT(employees.first_name, " ", employees.last_name) AS Name, salaries.salary AS Salary
FROM employees
INNER JOIN salaries ON employees.emp_no = salaries.emp_no
INNER JOIN dept_manager ON employees.emp_no = dept_manager.emp_no
INNER JOIN departments ON dept_manager.dept_no = departments.dept_no
WHERE salaries.to_date > now()
AND dept_manager.to_date > now()
ORDER BY departments.dept_name ASC;
/* NOTES
salaries.emp_no salary to_date
employees.emp_no first_name last_name
dept_manager.emp_no dept_no to_date
departments.dept_no dept_name
*/

#6 Find the number of current employees in each department.
SELECT departments.dept_no AS dept_no, departments.dept_name AS dept_name, COUNT(employees.emp_no) AS num_employees
FROM departments
INNER JOIN dept_emp ON departments.dept_no = dept_emp.dept_no
INNER JOIN employees ON dept_emp.emp_no = employees.emp_no
WHERE dept_emp.to_date > CURDATE()
GROUP BY dept_no, dept_name
ORDER BY dept_no;
/*
dept_no dept_name num_employees 

employees emp_no 
departments dept_no dept_name
dept_emp emp_no dept_no
*/

#7 Which department has the highest average salary? Hint: Use current not historic information.
SELECT departments.dept_name AS department_name, AVG(salaries.salary) AS average_salary
FROM departments
JOIN dept_emp ON departments.dept_no = dept_emp.dept_no
JOIN salaries ON dept_emp.emp_no = salaries.emp_no
WHERE salaries.to_date > now()
AND dept_emp.to_date > now()
GROUP BY department_name
ORDER BY average_salary DESC
LIMIT 1;

/* Highest average salary for current employees
department_name average_salary

departments.dept_name dept_no
dept_emp.emp_no dept_no to_date
salaries.emp_no salary to_date
*/


#8 Who is the highest paid employee in the Marketing department?
SELECT employees.first_name AS first_name, employees.last_name AS last_name
FROM employees
INNER JOIN salaries ON employees.emp_no = salaries.emp_no
INNER JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
INNER JOIN departments ON dept_emp.dept_no = departments.dept_no
WHERE departments.dept_name = "Marketing"
AND  salaries.to_date > now()
AND dept_emp.to_date > now()
ORDER BY salaries.salary DESC
LIMIT 1;

/* first_name | last_name 
employees.emp_no, 
departments.dept_no dept_name
dept_emp.emp_no dept_no
salaries.emp_no salary
*/

#9 Which current department manager has the highest salary?

SELECT departments.dept_name AS "Department Name", CONCAT(employees.first_name, " ", employees.last_name) AS Name, salaries.salary AS Salary
FROM employees
LEFT JOIN salaries ON employees.emp_no = salaries.emp_no
JOIN dept_manager ON employees.emp_no = dept_manager.emp_no
JOIN departments ON dept_manager.dept_no = departments.dept_no
WHERE salaries.to_date > now()
AND dept_manager.to_date > now()
ORDER BY Salary DESC
LIMIT 1;
/* NOTES
salaries.emp_no salary to_date
employees.emp_no first_name last_name
dept_manager.emp_no dept_no to_date
departments.dept_no dept_name
*/

#Determine the average salary for each department. Use all salary information and round your results.
SELECT departments.dept_name AS department_name, ROUND(AVG(salaries.salary)) AS average_salary
FROM departments
JOIN dept_emp ON departments.dept_no = dept_emp.dept_no
JOIN salaries ON dept_emp.emp_no = salaries.emp_no
GROUP BY department_name
ORDER BY average_salary DESC;

/* Highest average salary for current employees
department_name average_salary

departments.dept_name dept_no
dept_emp.emp_no dept_no to_date
salaries.emp_no salary to_date
*/

#Bonus Find the names of all current employees, their department name, and their current manager's name.
SELECT 
	CONCAT(employees.first_name, " ", employees.last_name) AS "Employee Name",
	departments.dept_name AS "Department Name",
	(SELECT CONCAT(employees.first_name, " ", employees.last_name) AS "Employee Name"
		FROM employees
        
        WHERE dept_emp.emp_no = departments.dept_no)
FROM employees
LEFT JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
LEFT JOIN departments ON dept_emp.dept_no = departments.dept_no
LEFT JOIN dept_manager on departments.dept_no  = dept_manager.dept_no
WHERE dept_emp.to_date > CURDATE();


/*
employees.emp_no first_name last_name 
dept_emp.emp_no dept_no departments
departments.dept_no dept_name
dept_manager.emp_no dept_no to_date
*/
