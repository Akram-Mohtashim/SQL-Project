-- SQL Retail Sales Analysis


-- Create Table
Drop Table If Exists retail_sales;
Create Table retail_sales
		(
				transactions_id INT PRIMARY KEY,
				sale_date DATE,
				sale_time TIME,
				customer_id INT,
				gender VARCHAR(15),
				age INT,
				category VARCHAR(20),
				quantiy INT,
				price_per_unit FLOAT,
				cogs FLOAT,
				total_sale FLOAT
			);


Select * from retail_sales


Select Count(*) from retail_sales


Select * from retail_sales
Where transactions_id IS NULL

Select * from retail_sales
Where sale_date IS NULL

Select * from retail_sales
Where transactions_id IS NULL

-- DATA CLEANING
Select * from retail_sales
Where 
	transactions_id IS NULL
	OR
	sale_date IS NULL
	OR
	sale_time IS NULL
	OR
	customer_id IS NULL
	OR
	gender IS NULL
	OR
	category IS NULL
	OR
	quantiy IS NULL
	OR
	price_per_unit IS NULL
	OR
	cogs IS NULL
	OR
	total_sale IS NULL;


--

DELETE FROM retail_sales
WHERE
	transactions_id IS NULL
	OR
	sale_date IS NULL
	OR
	sale_time IS NULL
	OR
	customer_id IS NULL
	OR
	gender IS NULL
	OR
	category IS NULL
	OR
	quantiy IS NULL
	OR
	price_per_unit IS NULL
	OR
	cogs IS NULL
	OR
	total_sale IS NULL;


-- Data Exploration

-- How many sales we have?
Select Count(*) as Total_sale from retail_sales

--How many Unique Customer we have?
Select Count(Distinct customer_Id) as Total_sales from retail_sales

Select Distinct category as Total_category from retail_sales


-- Business Key Problem & Answer (Data Anlaysis)

--1.Write a SQL query to retrieve all columns for sales made on '2022-11-05':

SELECT * 
FROM retail_sales
WHERE sale_date = '2022-11-05'

--2.Write a SQL query to retrieve all transactions where the category is 'Clothing' and 
the quantity sold is more than 4 in the month of Nov-2022:

SELECT * 
FROM retail_sales
WHERE Category = 'Clothing' 
AND 
TO_CHAR(sale_date, 'YYYY-MM') ='2022-11'
AND
quantiy >=4


--3.Write a SQL query to calculate the total sales (total_sale) for each category.:

Select 
	Category,
	Sum(total_sale) as Net_Sales
	From retail_sales
	Group BY Category


--4.Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:

Select ROUND (AVG(age), 2) As Age
From retail_sales
Where Category = 'Beauty'


--5.Write a SQL query to find all transactions where the total_sale is greater than 1000.:
Select *
From retail_sales
Where Total_sale > 1000


--6.Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:

Select
	Category,
	Gender,
	Count(*) as Total_transactions
FROM retail_sales
GROUP BY category, Gender
ORDER BY Total_transactions DESC


--7.Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:
Select year,
		month,
		avg_sale
FROM
(
Select 
	EXTRACT(YEAR FROM sale_date) as year,
	EXTRACT(MONTH FROM sale_date) as month,
	AVG(Total_sale) as Avg_sale,
	RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(Total_sale) DESC ) as Rank
From retail_sales
Group BY 1,2
) as t1
WHERE rank = 1

--8.Write a SQL query to find the top 5 customers based on the highest total sales :
Select 
		Customer_id,
		Sum(total_sale) as SUM
From retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5

--9.Write a SQL query to find the number of unique customers who purchased items from each category.

SELECT Category,
		COUNT (DISTINCT Customer_id) as CX
FROM retail_sales
GROUP BY category


--10.Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):

WITH hourly_sale
AS
(
SELECT *,
		CASE
			WHEN EXTRACT (HOUR FROM sale_time)< 12 THEN 'Morning'
			WHEN EXTRACT (HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
			ELSE 'Evening'
		END as SHIFT
FROM retail_sales
)

SELECT 
	shift,
	COUNT(*) AS total_orders
FROM hourly_sale
GROUP BY SHIFT

---END of Project



