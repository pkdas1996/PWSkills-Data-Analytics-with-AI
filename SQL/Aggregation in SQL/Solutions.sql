-- Use “ ” Database to solve the following questions 
-- (Hint : World Database is inbuilt in SQL Workbench so use code “USE world;” to make use of the database)
 
USE world;

-- Tables used: city, country, countrylanguage
-- check tables
SELECT * FROM city;
SELECT * FROM country;
SELECT * FROM countrylanguage;

-- Question 1 : Count how many cities are there in each country?
SELECT c.Name AS Country,
	COUNT(ci.ID) AS CityCount
FROM country c 
LEFT JOIN city ci
ON c.Code = ci.CountryCode
GROUP BY c.Name;

-- Question 2 : Display all continents having more than 30 countries.
SELECT Continent, COUNT(*) AS CountryCount
FROM country
GROUP BY Continent
HAVING COUNT(*) > 30;

-- Question 3 : List regions whose total population exceeds 200 million.
SELECT Region, SUM(Population) AS TotalPopulation
FROM country
GROUP BY Region
HAVING SUM(Population) > 200000000;

-- Question 4 : Find the top 5 continents by average GNP per country.
SELECT Continent, AVG(GNP) as AvgGNPperCountry
FROM country
GROUP BY Continent
ORDER BY AvgGNPperCountry DESC
LIMIT 5;

-- Question 5 : Find the total number of official languages spoken in each continent.
SELECT c.Continent, COUNT(cl.Language) AS OfficialLanguages
FROM Country c
JOIN countrylanguage cl
ON c.Code = cl.CountryCode
WHERE cl.IsOfficial = 'T'
GROUP BY c.Continent;

-- Question 6 : Find the maximum and minimum GNP for each continent.
SELECT Continent,
	MAX(GNP) AS MaxGNP,
    MIN(GNP) AS MinGNP
FROM country
GROUP BY Continent;

-- Question 7 : Find the country with the highest average city population.
SELECT c.Name AS Country, AVG(ci.Population) AS AvgCityPopulation
FROM country c
JOIN city ci
ON c.Code = ci.CountryCode
GROUP BY c.Name
ORDER BY AvgCityPopulation DESC
LIMIT 1;

-- Question 8 : List continents where the average city population is greater than 200,000.
SELECT c.Continent, AVG(ci.Population) AS AvgCityPopulation
FROM country c
JOIN city ci
ON c.Code = ci.CountryCode
GROUP BY c.Continent
HAVING AVG(ci.Population) > 200000;

-- Question 9 : Find the total population and average life expectancy for each continent, ordered by average life expectancy descending.
SELECT Continent,
	SUM(Population) AS TotalPopulation,
    AVG(LifeExpectancy) AS AvgLifeExpectancy
FROM country
GROUP BY Continent
ORDER BY AvgLifeExpectancy DESC;

-- Question 10 : Find the top 3 continents with the highest average life expectancy, but only include those where the total population is over 200 million.
SELECT Continent,
	AVG(LifeExpectancy) AS AvgLifeExpectancy,
    SUM(Population) AS TotalPopulation
FROM country
GROUP BY Continent
HAVING SUM(Population) > 200000000
ORDER BY AvgLifeExpectancy DESC
Limit 3;

