#Find all the current employees with the same hire date as employee 101010 using a subquery.
USE employees;

SELECT hire_date
FROM employees
WHERE emp_no = "101010";

Select *
FROM employees
JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
WHERE hire_date = (
	SELECT hire_date
	FROM employees
	WHERE emp_no = "101010"
)
AND to_date = "9999-01-01";

#2 Find all the titles ever held by all current employees with the first name Aamod.
SELECT tbl_title.title
FROM employees
JOIN (
	SELECT title, emp_no
	FROM titles)
AS tbl_title ON employees.emp_no = tbl_title.emp_no
JOIN (
	SELECT to_date
    FROM dept_emp
) AS tbl_dept_emp
WHERE first_name = "Aamod"
AND tbl_dept_emp.to_date > CURDATE()
GROUP BY tbl_title.title
;

SELECT title 
FROM titles
WHERE emp_no IN
    (
    SELECT emp_no
    FROM employees
    WHERE first_name = 'Aamod'
    AND emp_no IN
        (
        SELECT emp_no
        FROM dept_emp
        WHERE to_date >= CURDATE()
        )
    )
GROUP BY title;

/*
employees emp_no
titles emp_no
*/

#How many people in the employees table are no longer working for the company? Give the answer in a comment in your code.
#91479

SELECT COUNT(employees.emp_no)
FROM employees
JOIN (
	SELECT *
    FROM dept_emp
    WHERE to_date < CURDATE()
) AS curEmp ON employees.emp_no = curEmp.emp_no;

#Find all the current department managers that are female. List their names in a comment in your code.
SELECT CONCAT(first_name, " ", last_name) AS Names
FROM employees
JOIN (
	SELECT emp_no
    FROM dept_manager
) AS Manager ON employees.emp_no = Manager.emp_no
WHERE gender = "F";

/*
'Hilary Kambil'
'Isamu Legleitner'
'Karsten Sigstam'
'Krassimir Wegerle'
'Leon DasSarma'
'Marjo Giarratana'
'Peternela Onuegbe'
'Rosine Cools'
'Rutger Hofmeyr'
'Sanjoy Quadeer'
'Shirish Ossenbruggen'
'Tonny Butterworth'
'Xiaobin Spinelli'
*/

#5 Find all the employees who currently have a higher salary than the companies overall, historical average salary.

SELECT AVG(salary)
FROM salaries;

SELECT *
FROM employees
JOIN (
	SELECT *
    FROM salaries) AS emp_salary
WHERE emp_salary.salary > (
	SELECT AVG(salary)
    FROM salaries);    
    
SELECT emp_no, CONCAT(first_name, " ", last_name)
FROM employees
WHERE emp_no IN (
	SELECT emp_no
	FROM salaries
	WHERE salary > (
		SELECT AVG(salary)
		FROM salaries
	)
)
AND emp_no IN (
	SELECT emp_no
	FROM dept_emp
	WHERE to_date = "9999-01-01"
);

#6 How many current salaries are within 1 standard deviation of the current highest salary? (Hint: you can use a built in function to calculate the standard deviation.) What percentage of all salaries is this?
SELECT STDDEV(salary)
FROM salaries;

SELECT MAX(salary)
FROM salaries
WHERE to_date > CURDATE();


/* Hint You will likely use multiple subqueries in a variety of ways
Hint It's a good practice to write out all of the small queries that you can. Add a comment above the query showing the number of rows returned. You will use this number (or the query that produced it) in other, larger queries.*/
        
