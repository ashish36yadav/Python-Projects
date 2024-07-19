# This SQL file is part of Sales Analysis Using SQL and Python.

-- Q) Find top 10 highest revenue generating products
SELECT product_id, SUM(sale_price) AS sales
FROM df_orders
GROUP BY product_id
ORDER BY sales DESC
LIMIT 10;



-- Q) Find top 5 highest selling products in each region
WITH cte AS (
    -- Calculate total sales per product per region
    SELECT region, product_id, SUM(sale_price) AS sales
    FROM df_orders
    GROUP BY region, product_id
)
SELECT * 
FROM (
    -- Rank products within each region based on sales
    SELECT *, DENSE_RANK() OVER(PARTITION BY region ORDER BY sales DESC) AS rnk
    FROM cte
) A
WHERE rnk <= 5;  -- Select top 5 products in each region



-- Q) Find month-over-month growth comparison for 2022 and 2023 sales (e.g., Jan 2022 vs Jan 2023)
WITH cte AS (
    -- Extract year and month from order_date and calculate total sales per month per year
    SELECT EXTRACT(YEAR FROM order_date) AS order_year,
           EXTRACT(MONTH FROM order_date) AS order_month, 
           SUM(sale_price) AS sales
    FROM df_orders
    GROUP BY order_year, order_month
)
SELECT order_month, 
       -- Calculate sales for 2022
       SUM(CASE WHEN order_year = 2022 THEN sales ELSE 0 END) AS sales_2022,
       -- Calculate sales for 2023
       SUM(CASE WHEN order_year = 2023 THEN sales ELSE 0 END) AS sales_2023
FROM cte 
GROUP BY order_month
ORDER BY order_month;



-- Q) For each category, find which month had the highest sales
WITH cte AS (
    -- Group sales by category and year-month
    SELECT category, TO_CHAR(order_date, 'YYYYMM') AS order_year_month, SUM(sale_price) AS sales 
    FROM df_orders
    GROUP BY category, TO_CHAR(order_date, 'YYYYMM')
),
cte2 AS (
    -- Rank sales within each category by month
    SELECT *,
           ROW_NUMBER() OVER(PARTITION BY category ORDER BY sales DESC) AS rn
    FROM cte
)
SELECT * 
FROM cte2
WHERE rn = 1;  -- Select the month with the highest sales for each category



-- Q) Determine which subcategory had the highest growth in profit in 2023 compared to 2022
WITH cte AS (
    -- Calculate total sales per subcategory per year
    SELECT sub_category, EXTRACT(YEAR FROM order_date) AS order_year, SUM(sale_price) AS sales
    FROM df_orders
    GROUP BY sub_category, order_year
),
cte2 AS (
    -- Aggregate sales for 2022 and 2023 for each subcategory
    SELECT sub_category,
           SUM(CASE WHEN order_year = 2022 THEN sales ELSE 0 END) AS sales_2022,
           SUM(CASE WHEN order_year = 2023 THEN sales ELSE 0 END) AS sales_2023
    FROM cte 
    GROUP BY sub_category
)
SELECT *, 
       -- Calculate growth percentage
       ROUND((sales_2023 - sales_2022) * 100 / sales_2022, 2) AS highest_growth_percentage
FROM cte2
ORDER BY highest_growth_percentage DESC;  -- Order by highest growth percentage
