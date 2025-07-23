 -- SQL RETAIL SALES ANALYSIS -- 
create database sql_project_p1
create TABLE RETAIL_SALES(
                     transactions_id INT primary key ,
					 sale_date date,
				     sale_time time,
					 customer_id int,
					 gender varchar(10),
					 age int,
					 category varchar(15),
					 quantiy int,
					 price_per_unit float ,
					 cogs float,
					 total_sale float);

SELECT * FROM RETAIL_SALES;


SELECT COUNT(*) FROM RETAIL_SALES;

-- DATA CLEANING --
select * from RETAIL_SALES 
WHERE
    transactions_id IS NULL
    or
    sale_date is null
    or
    sale_time is null
    or
    customer_id is null
    or
    gender is null
    or
    age is null
    or
    category is null
    or
    quantiy is null
    or
    price_per_unit is null
    or
	cogs is null
    or
    total_sale is null;


delete from RETAIL_SALES
where
    transactions_id IS NULL
    or
    sale_date is null
    or
    sale_time is null
    or
    customer_id is null
    or
    gender is null
    or
    age is null
    or
    category is null
    or
    quantiy is null
    or
    price_per_unit is null
    or
	cogs is null
    or
    total_sale is null;

-- DATA EXPLORATION --

 -- HOW MANY SALES WE HAVE?

 SELECT COUNT(*) AS total_sale from RETAIL_SALES;


 -- HOW MANY UNIQUE CUSTOMERS DO WE HAVE?

 SELECT COUNT(DISTINCT customer_id) AS total_sale from RETAIL_SALES;


 SELECT DISTINCT CATEGORY FROM RETAIL_SALES;

 -- DATA ANALYSIS  & BUSINESS KEY PROBLEMSN & ANSWERS

 -- MY ANALYSIS & FINDINGS 
 
 
 -- 01. WRITE A SQL QUERY TO RETRIEVE ALL COLUMNS FOR SALES MADE ON "2022-11-05"

select * from RETAIL_SALES where sale_date ='2022-11-05';

-- 02 . WRITE A SQL QUERY TO RETRIEVE ALL TRANSACTIONS WHERE THE CATEGORY IS "CLOTHING" AND THE QUANTITY SOLD IS MORE THAN 10 IN THE MONTH OF NOV-2022 


select 
*
FROM RETAIL_SALES 
WHERE 
    category = 'Clothing'
	and
	TO_CHAR(sale_date, 'YYYY-MM')= '2022-11'
	and 
	quantiy >= 4;

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category


select category ,sum(quantiy) as net_sales , count(*) as total_orders from retail_sales  group by 1;


-- Q.4 Write a SQL query to find the average age of the customers who purchased items from the 'Beauty' category .


select avg(age) from retail_sales where category = 'Beauty';
-- since the number is big and non-readable

select round(avg(age),2) as average_age from retail_sales where category = 'Beauty';


-- Q5 WRITE A SQL QUERY TO FIND ALL THE TRANSACTIONS WHERE THE TOTAL_SALE IS GREATER THAN 1000


select * from retail_sales where total_sale > 1000;

-- Q6 WRITE A SQL QUERY TO FIND THE TOTAL NUMBER OF TRANSACTIONS (TRANSACTION_ID ) MADE BY EACH GENDER IN EACH CATEGORY


select 
    category ,
	gender,
	count(*) as total_transaction 
from retail_sales
GROUP
    by 
	category,
	gender
ORDER BY 1;

-- Q7 WRITE A SQL TO CALCULATE THE  AVERAGE SALE FOR EACH MONTH .FIND OUT THE BEST SELLING MONTH IN EACH YEAR
select * from
(
select 
    extract(year from sale_date) as year,
	extract(month from sale_date) as month,
	avg(total_sale) as avg_sale,
	RANK() OVER (PARTITION BY EXTRACT(YEAR FROM SALE_DATE) ORDER BY AVG(TOTAL_SALE) DESC) as rank
from retail_sales
group by 1,2
) as T1
where rank = 1

--Q8. WRITE A SQL QUERY TO FIND THE TOP 5 CUSTOMERS BASED ON THE HIGHESR TOTAL SALES


select * from retail_sales

select 
    customer_id,
	sum(total_sale) as highest_sales
from retail_sales
group by 1
order by 2 desc
limit 5;


-- Q.9 write a sql query to find th number of unique customers who purchased items fron each category

select * from retail_sales


select 
    category,
	count(distinct customer_id) as unique_cust
FROM retail_sales
group by category

-- Q.10 Writ a sql query to create each shift and number of orders (example morning <=12). afternoon between 12 & 17 , evening >17)

select * from retail_sales

SELECT 
    CASE 
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS shift,
    COUNT(*) AS total_orders
FROM retail_sales
GROUP BY shift;

	