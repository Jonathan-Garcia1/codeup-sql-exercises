#1 '10200' '10397' '10610'

USE employees;
SELECT *
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya');

# 2 Does not, '10397' '10610' '10821'

SELECT *
FROM employees
WHERE first_name = 'Irena' OR first_name = 'Vidya' OR first_name = 'Maya';

#3
SELECT *
FROM employees
WHERE first_name IN ('Irena' , 'Vidya' , 'Maya') 
AND gender = "M";

#4
SELECT DISTINCT last_name
FROM employees
WHERE last_name LIKE "E%";

#5
SELECT DISTINCT last_name
FROM employees
WHERE last_name LIKE "E%"
OR last_name LIKE "%E";

#6
SELECT DISTINCT last_name
FROM employees
WHERE last_name NOT LIKE "E%"
AND last_name LIKE "%E";

#7
SELECT DISTINCT last_name
FROM employees
WHERE last_name LIKE "E%"
AND last_name LIKE "%E";

#8 10008 10011 10012
SELECT *
FROM employees
WHERE hire_date LIKE "199%";

#9 10078 10115 10261
SELECT *
FROM employees
WHERE birth_date LIKE "%-12-25";

#10 10261 10438 10681
SELECT *
FROM employees
WHERE birth_date LIKE "%-12-25"
AND hire_date LIKE "199%";

#11
SELECT DISTINCT last_name
FROM employees
WHERE last_name LIKE "%q%";

#12
SELECT DISTINCT last_name
FROM employees
WHERE last_name NOT LIKE "%qu%"
AND last_name LIKE "%q%";
