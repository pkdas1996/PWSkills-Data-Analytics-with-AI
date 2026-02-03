/*
Q1. What is a Common Table Expression (CTE), and how does it improve SQL query readability?

A CTE (Common Table Expression) is a temporary named result set.
It is defined using the WITH clause that exists only during the execution of a query.

It improves readability by breaking complex queries into logical steps.
- makes queries easier to debug
- avoids repeating the same subquery multiple times
- useful for recursive queries

Example:
WITH HighPriceProducts AS (
	SELECT ProductName, Price
    FROM Products
    WHERE Price > 1000
)
SELECT * FROM HighPriceProducts;
====================================================================================================
Q2. Why are some views updatable while others are read-only? Explain with an example.

A view is updatable if it:
- Is based on one table
- Does not contain JOIN, GROUP BY, aggregate functions (SUM,AVG), DISTINCT, Subqueries in SELECT

Examples -
I) Updatable View:
CREATE VIEW vw_SimpleProducts AS 
SELECT ProductID, ProductName, Price
FROM Products;

UPDATE vw_SimpleProducts
SET Price = 1500
WHERE ProductID = 1;

II) Read-only View:
CREATE VIEW vw_ReadOnly AS
SELECT Category, AVG(Price)
FROM Products
GROUP BY Category;
========================================================================================================
Q3. What advantages do stored procedures offer compared to writing raw SQL queries repeatedly?

- Faster execution (pre-compiled)
- Reduces network traffic
- Reusable logic
- Improves security (no direct table access)
=====================================================================================================
Q4. What is the purpose of triggers in a database? Mention one use case where a trigger is essential.

A trigger is executed automatically when an INSERT, UPDATE, or DELETE occurs.

Essential use case: Auditing / archiving deleted data
Example: Store deleted product records automatically.
======================================================================================================
Q5. Explain the need for data modelling and normalization when designing a database.

- Removes data redundancy
- Ensures data consistency
- Improves query performance
- Makes databases scalable and maintainable
=======================================================================================================
*/

-- Dataset (Use for Q6–Q9)
CREATE TABLE Products (
	ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2)
);

INSERT INTO Products VALUES
(1, 'Keyboard', 'Electronics', 1200),
(2, 'Mouse', 'Electronics', 800),
(3, 'Chair', 'Furniture', 2500),
(4, 'Desk', 'Furniture', 5500);

CREATE TABLE Sales (
	SaleID INT PRIMARY KEY,
    ProductID INT,
    Quantity INT, 
    SaleDate DATE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

INSERT INTO Sales VALUES
(1,1,4,'2024-01-05'),
(2,2,10,'2024-01-06'),
(3,3,2,'2024-01-10'),
(4,4,1,'2024-01-11');

-- verify
SELECT * FROM Products;
SELECT * FROM Sales;

-- Q6. Write a CTE to calculate the total revenue for each product.
-- (Revenues = Price × Quantity), and return only products where revenue > 3000.
WITH ProductRevenue AS (
	SELECT p.ProductID,
		p.ProductName,
        p.Price * s.Quantity AS Revenue
	FROM Products p
    JOIN Sales s ON p.ProductID = s.ProductID
)
SELECT *
FROM ProductRevenue
WHERE Revenue > 3000;

-- Q7. Create a view named vw_CategorySummary that shows: 
-- Category, TotalProducts, AveragePrice
CREATE VIEW vw_CategorySummary AS
SELECT Category,
	COUNT(*) AS TotalProducts,
	AVG(Price) AS AveragePrice
FROM Products
GROUP BY Category;

-- Display view
SELECT * FROM vw_categorysummary;

-- Q8. Create an updatable view containing ProductID, ProductName, and Price.
-- Then update the price of ProductID = 1 using the view.
CREATE VIEW vw_ProductInfo AS
SELECT ProductID, ProductName, Price
FROM Products;

-- Update view
UPDATE vw_productinfo
SET Price = 1300
WHERE ProductID = 1;

--  Display view
SELECT * FROM vw_productinfo;

-- Q9. Create a stored procedure that accepts a category name 
-- and returns all products belonging to that category.
DELIMITER $$

CREATE PROCEDURE GetProductsByCategory (IN cat_name VARCHAR(50))
BEGIN
	SELECT *
    FROM Products
    WHERE Category = cat_name;
END $$

DELIMITER ;

-- call procedure
CALL GetProductsByCategory('Electronics');

-- Q10. Create an AFTER DELETE trigger on the Products table 
-- that archives deleted product rows into a new table ProductArchive. 
-- The archive should store ProductID, ProductName, Category, Price, and DeletedAt timestamp.

-- Create Archive Table
CREATE TABLE ProductArchive (
	ProductID INT,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2),
    DeletedAt TIMESTAMP
);

-- Create Trigger
DELIMITER $$

CREATE TRIGGER trg_after_product_delete
AFTER DELETE ON Products
FOR EACH ROW
BEGIN
	INSERT INTO ProductArchive
    VALUES (
		OLD.ProductID,
        OLD.ProductName,
        OLD.Category,
        OLD.Price,
        NOW()
    );
END $$

DELIMITER ;

-- Using the Trigger
-- Products
SELECT * FROM Products;

-- Perform a DELETE on Products 
-- First deleting child rows in Sales
DELETE FROM Sales
WHERE ProductID = 1;

-- Delete from Products
DELETE FROM Products
WHERE ProductID = 1;

-- Verify that the trigger worked
SELECT * FROM ProductArchive;


