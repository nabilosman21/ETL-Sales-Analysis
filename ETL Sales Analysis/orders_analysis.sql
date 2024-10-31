-- find top 10 highest reveue generating products -- 
SELECT product_id, SUM(sale_price) AS sales
FROM orders_db
GROUP BY product_id
ORDER BY sales DESC
LIMIT 10;

-- --find top 5 highest selling products in each region

WITH cte AS (
    SELECT region, product_id, SUM(sale_price) AS sales
    FROM orders_db
    GROUP BY region, product_id
)
SELECT *
FROM (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY region ORDER BY sales DESC) AS rn
    FROM cte
) AS A
WHERE rn <= 5;



-- Find month-over-month growth comparison for 2022 and 2023 sales
WITH cte AS (
    SELECT 
        YEAR(order_date) AS order_year,
        MONTH(order_date) AS order_month,
        SUM(sale_price) AS sales
    FROM orders_db
    GROUP BY YEAR(order_date), MONTH(order_date)
)
SELECT 
    order_month,
    SUM(CASE WHEN order_year = 2022 THEN sales ELSE 0 END) AS sales_2022,
    SUM(CASE WHEN order_year = 2023 THEN sales ELSE 0 END) AS sales_2023
FROM cte 
GROUP BY order_month
ORDER BY order_month;



-- For each category, which month had the highest sales
WITH cte AS (
    SELECT 
        category,
        DATE_FORMAT(order_date, '%Y%m') AS order_year_month,
        SUM(sale_price) AS sales
    FROM orders_db
    GROUP BY category, DATE_FORMAT(order_date, '%Y%m')
)
SELECT *
FROM (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY category ORDER BY sales DESC) AS rn
    FROM cte
) AS a
WHERE rn = 1;


-- Which sub-category had the highest growth by profit in 2023 compared to 2022
WITH cte AS (
    SELECT 
        sub_category,
        YEAR(order_date) AS order_year,
        SUM(sale_price) AS sales
    FROM orders_db
    GROUP BY sub_category, YEAR(order_date)
),
cte2 AS (
    SELECT 
        sub_category,
        SUM(CASE WHEN order_year = 2022 THEN sales ELSE 0 END) AS sales_2022,
        SUM(CASE WHEN order_year = 2023 THEN sales ELSE 0 END) AS sales_2023
    FROM cte 
    GROUP BY sub_category
)
SELECT 
    *,
    (sales_2023 - sales_2022) AS profit_growth
FROM cte2
ORDER BY profit_growth DESC
LIMIT 1;  


