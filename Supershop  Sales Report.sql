
show variables like "secure_file_priv";
set sql_safe_update = 0;
create database if not exists supershop;
drop database if exists supershop;
use supershop;
show databases;

drop table if exists retail_sales;
CREATE TABLE retail_sales (
    transactions_id INT PRIMARY KEY not null,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(15),
    age INT,
    category VARCHAR(20),
    quantity INT,
    price_per_unit FLOAT,
    cogs FLOAT,
    total_sale FLOAT
);

 show tables;
 SELECT * FROM retail_sales;
 
 
SELECT 
    COUNT(transactions_id)
FROM
    retail_sales;
 
 
 
 -- at first chcek all column if any null there 
 
 SELECT * FROM retail_sales
WHERE
    transactions_id IS NULL
        OR sale_date IS NULL
        OR sale_time IS NULL
        OR customer_id IS NULL
        OR gender IS NULL
        OR age IS NULL
        OR category IS NULL
        OR quantity IS NULL
        OR price_per_unit IS NULL
        OR cogs IS NULL
        OR total_sale IS NULL;
  
 -- delete empty data if exist
 DELETE FROM retail_sales 
WHERE
    transactions_id IS NULL
    OR sale_date IS NULL
    OR sale_time IS NULL
    OR customer_id IS NULL
    OR gender IS NULL
    OR age IS NULL
    OR category IS NULL
    OR quantity IS NULL
    OR price_per_unit IS NULL
    OR cogs IS NULL
    OR total_sale IS NULL;



-- 

-- How many sales we have?
SELECT COUNT(*) FROM retail_sales;






-- How many uniuque customers we have ?
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;


-- Business Key Problems and Data Analysis Solutions


-- Q.1 Write a SQL query to retrieve all columns for sales made on November 5, 2022.

SELECT 
    *
FROM
    retail_sales
WHERE
    sale_date = '2022-11-05'
    limit 10;




-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022

SELECT 
    *
FROM
    retail_sales
WHERE
    category = 'Clothing'
        AND DATE_FORMAT(sale_date, '%Y-%m') = '2022-11'
        AND quantity >= 4;



-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.


SELECT 
    category, SUM(total_sale), COUNT(*) AS total_orders
FROM
    retail_sales
GROUP BY 1;


-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.


SELECT 
    ROUND(AVG(age))
FROM
    retail_sales
WHERE
    category = 'Beauty';


-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000 limit 5.


SELECT 
    *
FROM
    retail_sales
WHERE
    total_sale > 1000 limit 5;


-- Q.6 Write a SQL query to find the total number of transactions (transactions_id) made by each gender in each category.


SELECT 
    category, gender, COUNT(transactions_id) AS total_number
FROM
    retail_sales
GROUP BY 1 , 2 -- category, gender replcae 1,2 
ORDER BY 1;



-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

SELECT * 
FROM (
    SELECT 
        YEAR(sale_date) AS yearly_sale,
        MONTH(sale_date) AS monthly_sale, 
        AVG(total_sale) AS total,
        RANK() OVER (PARTITION BY YEAR(sale_date) ORDER BY AVG(total_sale) DESC) AS ranking
    FROM 
        retail_sales
    GROUP BY 
        YEAR(sale_date), MONTH(sale_date)
) AS sale
WHERE ranking = 1;



-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 


SELECT 
    customer_id, SUM(total_sale) AS total_sales
FROM
    retail_sales
GROUP BY customer_id
ORDER BY 2 DESC
LIMIT 5;



-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.


SELECT 
    category, COUNT(DISTINCT customer_id) as unique_customer
FROM
    retail_sales
GROUP BY category;



-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)

SELECT 
    CASE
        WHEN HOUR(sale_time) < 12 THEN 'Morning'
        WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS shift,
    COUNT(*) AS number_of_orders
FROM 
    retail_sales
GROUP BY 
    shift;






 
 
 
 