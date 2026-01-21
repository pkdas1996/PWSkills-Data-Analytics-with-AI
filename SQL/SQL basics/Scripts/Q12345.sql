-- q1) Create a new Database and Table for Employees
-- Task: Create a new database named company_db and 
-- create a table named employees with the following columns:
/*
Column Name		Data Type		Constraint
employee_id		INT				PRIMARY KEY	
first_name		VARCHAR(50)
last_name		VARCHAR(50)
department		VARCHAR(50)
salary			INT
hire_date		DATE
*/

CREATE DATABASE company_db;

USE company_db;

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department VARCHAR(50),
    salary INT,
    hire_date DATE
);

-- q2) Insert Data into employees Table
-- Task: Insert the following sample records into the employees table.
/*
employee_id		first_naame		last_name		department		salary		hire_date		
101				Amit			Sharma			HR				50000		2020-01-15
102				Riya			Kapoor			Sales			75000		2019-03-22
103				Raj				Mehta			IT				90000		2018-07-11
104				Neha			Verma			IT				85000		2021-09-01
105				Arjun			Singh			Finance			60000		2022-02-10
*/

INSERT INTO employees VALUES
(101, 'Amit', 'Sharma', 'HR', 50000, '2020-01-15'),
(102, 'Riya', 'Kapoor', 'Sales', 75000, '2019-03-22'),
(103, 'Raj', 'Mehta', 'IT', 90000, '2018-07-11'),
(104, 'Neha', 'Verma', 'IT', 85000, '2021-09-01'),
(105, 'Arjun', 'Singh', 'Finance', 60000, '2022-02-10');

-- q3) Display All Employee Records Sorted by Salary (Lowest to Highest)
-- Hint: Use the ORDER BY clause on the salary column

SELECT * 
FROM employees
ORDER BY salary ASC;

-- q4) Show Employees Sorted by Department (A–Z) and Salary (High → Low)

SELECT * 
FROM employees
ORDER BY department ASC, salary DESC;

-- q5) List All Employees in the IT Department, Ordered by Hire Date (Newest First)

SELECT * 
FROM employees
WHERE department = 'IT'
ORDER BY hire_date DESC;




