USE employees;
SELECT *
FROM employees
INNER JOIN dept_emp ON employees.emp_no = dept_emp.emp_no;