-- q6) Create and Populate a sales table
-- Task: Create a table sales to track sales data:
/*
sale_id		customer_name		amount		sale_date
1			Aditi				1500		2024-08-01
2			Rohan				2200		2024-08-03
3			Aditi				3500		2024-09-05
4			Meena				2700		2024-09-15
5			Rohan				4500		2024-09-25
*/

CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    amount INT,
    sale_date DATE
);

INSERT INTO sales VALUES
(1, 'Aditi', 1500, '2024-08-01'),
(2, 'Rohan', 2200, '2024-08-03'),
(3, 'Aditi', 3500, '2024-09-05'),
(4, 'Meena', 2700, '2024-09-15'),
(5, 'Rohan', 4500, '2024-09-25');

-- q7)  Display All Sales Records Sorted by Amount (Highest → Lowest)
-- Hint: Use ORDER BY amount DESC.

SELECT *
FROM sales
ORDER BY amount DESC;

-- q8) Show All Sales Made by Customer “Aditi”
-- Hint: Use WHERE customer_name = "Aditi"

SELECT *
FROM sales
WHERE customer_name = 'Aditi';

-- q9) What is the Difference Between a Primary Key and a Foreign Key?

/*
- Primary Key uniquely identifies each record in a table whereas foreign key refers to a primary key in another table (useful when joining tables together)
- Only one primary key allowed per table while multiple foreign keys are allowed.
- Primary keys cannot contain NULL values while foreign keys can.

Example of Primary vs Foreign Key:

CREATE TABLE department (
   dept_id INT PRIMARY KEY,
   dept_name VARCHAR(50)
);

CREATE TABLE employees (
   emp_id INT PRIMARY KEY,
   dept_id INT,
   FOREIGN KEY (dept_id) REFERENCES department(dept_id)
);

*/

-- q10) What are constraints in SQL and Why are they used?

/*
Constraints are rules applied to table columns to maintain accuracy, consistency, and integrity of data.
Constraints help prevent invalid or duplicate data entry and enforce database and business rules.

Common SQL constraints:
- PRIMARY KEY (uniquely identifies each record)
- FOREIGN KEY (links two tables)
- NOT NULL (prevent NULL values)
- UNIQUE (ensures unique values)
- CHECK (validates condition)
- DEFAULT (assigns default value)

Example:

CREATE TABLE students (
    student_id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    age INT CHECK (age >= 18),
    email VARCHAR(50) UNIQUE
);

*/



