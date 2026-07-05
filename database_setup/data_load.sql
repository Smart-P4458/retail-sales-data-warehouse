/*
============================================================
Retail Sales Data Warehouse
Data Loading Script
============================================================

Author  : Pam Sani George
Project : Retail Sales Data Warehouse

Description
-----------
Loads data from the staging table into
the dimension tables and fact table.

Load Order

1. Customers
2. Products
3. Dates
4. Sales Facts

============================================================
*/

INSERT INTO dim_customers (
    customer_id,
    country
)
SELECT DISTINCT
    customer_id,
    country
FROM staging_retail
WHERE customer_id IS NOT NULL;

-- dim_products table
INSERT INTO dim_product (
    stock_code,
    description
)
SELECT
    stock_code,
    MAX(description) AS description
FROM staging_retail
GROUP BY stock_code;

--- dim_date table
INSERT INTO dim_date (
    invoice_date,
    year,
    month,
    day,
    quarter
)
SELECT DISTINCT
    invoice_date,
    EXTRACT(YEAR FROM invoice_date)::INT,
    EXTRACT(MONTH FROM invoice_date)::INT,
    EXTRACT(DAY FROM invoice_date)::INT,
    EXTRACT(QUARTER FROM invoice_date)::INT
FROM staging_retail;