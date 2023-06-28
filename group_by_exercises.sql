#In your script, use DISTINCT to find the unique titles in the titles table. How many unique titles have there ever been? Answer that in a comment in your SQL file.
SELECT DISTINCT(title)
FROM titles;

#Write a query to to find a list of all unique last names of all employees that start and end with 'E' using GROUP BY.
Select last_name
FROM employees
Where last_name LIKE "e%e"
Group BY last_name;
#Write a query to to find all unique combinations of first and last names of all employees whose last names start and end with 'E'.
SELECT first_name, last_name
FROM employees
Where last_name LIKE "e%e"
Group BY last_name, first_name;
#Write a query to find the unique last names with a 'q' but not 'qu'. Include those names in a comment in your sql code.
Select last_name
FROM employees
Where last_name LIKE "%q%" and last_name NOT LIKE "%qu%"
Group BY last_name;
#Add a COUNT() to your results (the query above) to find the number of employees with the same last name.
Select last_name, count(last_name) as number
FROM employees
Where last_name LIKE "%q%" and last_name NOT LIKE "%qu%"
Group BY last_name;
#Find all all employees with first names 'Irena', 'Vidya', or 'Maya'. Use COUNT(*) and GROUP BY to find the number of employees for each gender with those names.
Select first_name, gender, count(*) as number
FROM employees
Where first_name IN ('Irena', 'Vidya', 'Maya')
Group BY first_name, gender;

#Using your query that generates a username for all of the employees, generate a count employees for each unique username.
SELECT 
	CONCAT(
		LOWER(SUBSTR(first_name, 1,1)),
        LOWER(SUBSTR(last_name,1,4)),
        "_",
        SUBSTR(birth_date,6,2),
		SUBSTR(birth_date,3,2)
        )
    AS username, count(*) as number_username
FROM employees
GROUP BY username;
#From your previous query, are there any duplicate usernames? What is the higest number of times a username shows up? Bonus: How many duplicate usernames are there from your previous query?
SELECT 
	CONCAT(
		LOWER(SUBSTR(first_name, 1,1)),
        LOWER(SUBSTR(last_name,1,4)),
        "_",
        SUBSTR(birth_date,6,2),
		SUBSTR(birth_date,3,2)
        )
    AS username, count(*) as number_username
FROM employees
GROUP BY username
ORDER BY number_username DESC;

