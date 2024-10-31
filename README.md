# Retail Orders Analysis Project

## Overview
This project involves an in-depth analysis of retail orders, focusing on sales performance and product revenue generation. By utilizing Python and SQL, this project aims to derive valuable insights from a dataset of retail orders, enhancing our understanding of sales trends, product performance, and growth metrics over time.

## Table of Contents
- [Technologies Used](#technologies-used)
- [Dataset](#dataset)
- [Installation](#installation)
- [Data Processing](#data-processing)
- [SQL Queries](#sql-queries)
- [Results](#results)
- [Contributing](#contributing)
- [License](#license)

## Technologies Used
- **Python**: For data manipulation and analysis
  - Libraries: `pandas`, `sqlalchemy`, `zipfile`
- **SQL**: For querying and analyzing data stored in MySQL
- **MySQL**: Database for storing and managing the retail orders data
- **Kaggle API**: For downloading the dataset directly from Kaggle

## Dataset
The dataset used for this analysis is sourced from Kaggle and contains retail order details, including:
- Order ID
- Product ID
- Region
- City
- Order Date
- List Price
- Cost Price
- Discount Percent
- Sale Price
- Profit

The dataset can be accessed [here](https://www.kaggle.com/datasets/ankitbansal06/retail-orders).

## Installation
To run this project locally, follow these steps:

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/retail-orders-analysis.git
   cd retail-orders-analysis

2. Install the required Python libraries:
   ```bash
   pip install pandas sqlalchemy pymysql kaggle
3. Ensure you have MySQL installed and running on your machine.
4. Set up the MySQL database:
   - Create a database named orders_db.
5. Add your Kaggle API credentials to access the dataset.


## Data Processing
The data processing steps include:

1. Downloading the Dataset: Using Kaggle API to download the dataset.
   ```python
   !kaggle datasets download ankitbansal06/retail-orders -f orders.csv

2. Extracting Files: Extracting the downloaded ZIP file.
   ```python
   import zipfile
   zip_ref = zipfile.ZipFile('orders.csv.zip') 
   zip_ref.extractall()
   zip_ref.close()

3. Data Cleaning:

- Handling null values.
- Renaming columns for better readability.
- Deriving new columns: discount, sale_price, and profit.
- Converting order_date to datetime format.
- Dropping unnecessary columns.

4. Loading Data into MySQL: Using SQLAlchemy to load the cleaned DataFrame into the MySQL database.
   

## SQL Queries

### 1. Top 10 Highest Revenue Generating Products
```sql
SELECT product_id, SUM(sale_price) AS sales
FROM orders_db
GROUP BY product_id
ORDER BY sales DESC
LIMIT 10;

### 2. Top 5 Highest Selling Products in Each Region
```sql
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

### 3. Month-over-Month Growth Comparison for 2022 and 2023
```sql
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



### 4. Highest Sales by Category by Month
```sql
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


### 5. Sub-Category with Highest Growth by Profit in 2023 Compared to 2022
```sql
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


## Results

The results of the analysis provide valuable insights into sales performance, product popularity, and growth trends within the retail sector. Key findings include:

- The highest revenue-generating products and their respective sales figures.
- Monthly growth trends between 2022 and 2023, indicating patterns in consumer spending.





