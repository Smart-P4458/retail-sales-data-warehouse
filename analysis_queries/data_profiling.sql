/*
=========================================================
Retail Sales Data Warehouse

Data Profiling

Purpose

Understand the quality of raw data before loading
the warehouse.

Author:
Pam Sani George

=========================================================
*/

SELECT COUNT(*) AS total_rows
FROM staging_retail;

SELECT COUNT(DISTINCT customer_id)
AS unique_customers
FROM staging_retail;

SELECT COUNT(DISTINCT stock_code)
AS unique_products
FROM staging_retail;

SELECT COUNT(DISTINCT country)
AS unique_countries
FROM staging_retail;

--- Checking missing customers
SELECT COUNT(*) 
FROM staging_retail
WHERE customer_id IS NULL;

--- Checking Duplicates 
SELECT
invoice_no,
COUNT(*)
FROM staging_retail
GROUP BY invoice_no
HAVING COUNT(*) > 1
ORDER BY COUNT(*) DESC;