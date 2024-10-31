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

Please go the file to the see the remaining queries

Results
The results of the analysis provide valuable insights into sales performance, product popularity, and growth trends within the retail sector. Key findings include:

- The highest revenue-generating products and their respective sales figures.
- Monthly growth trends between 2022 and 2023, indicating patterns in consumer spending.





