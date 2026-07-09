/*
============================================================
Project : Retail Sales Data Warehouse

File : 03_product_analysis.sql

Author : Pam Sani George

Purpose
-------
Analyze product performance, revenue contribution,
sales volume and product profitability.

============================================================
*/

-- ==========================================================
-- Analysis 1
-- Top 10 Products by Revenue
-- ==========================================================

SELECT
    p.stock_code,
    p.description,
    ROUND(SUM(f.revenue)::NUMERIC,2) AS total_revenue
FROM fact_sales f
	INNER JOIN dim_product p
	ON f.product_key = p.product_key
GROUP BY
    p.stock_code,
    p.description
ORDER BY total_revenue DESC
LIMIT 10;

-- ==========================================================
-- Analysis 2
-- Best Selling Products by Quantity
-- ==========================================================

SELECT
    p.stock_code,
    p.description,
    SUM(f.quantity) AS total_quantity_sold
FROM fact_sales f
	INNER JOIN dim_product p
	ON f.product_key = p.product_key
GROUP BY
    p.stock_code,
    p.description
ORDER BY total_quantity_sold DESC
LIMIT 10;

-- ==========================================================
-- Analysis 3
-- Average Revenue per Sale
-- ==========================================================

SELECT
    p.stock_code,
    p.description,
    ROUND(AVG(f.revenue),2) AS average_sale_value
FROM fact_sales f
    INNER JOIN dim_product p
    ON f.product_key = p.product_key
GROUP BY
    p.stock_code,
    p.description
ORDER BY average_sale_value DESC
LIMIT 10;

-- ==========================================================
-- Analysis 4
-- Product Sales Frequency
-- ==========================================================

SELECT
    p.stock_code,
    p.description,
    COUNT(DISTINCT f.invoice_no) AS invoices
FROM fact_sales f
	INNER JOIN dim_product p
	ON f.product_key = p.product_key
GROUP BY
    p.stock_code,
    p.description
ORDER BY invoices DESC
LIMIT 10;

-- ==========================================================
-- Analysis 5
-- Revenue Contribution
-- ==========================================================

SELECT
    p.description,
    ROUND(SUM(f.revenue),2) AS revenue,
    ROUND(
        SUM(f.revenue)
        /
        SUM(SUM(f.revenue)) OVER ()
        *100,
        2
    ) AS revenue_percentage
	FROM fact_sales f
	INNER JOIN dim_product p
ON f.product_key = p.product_key
GROUP BY p.description
ORDER BY revenue DESC
LIMIT 10;

-- ==========================================================
-- Product Analysis 6
-- Product Classification
-- ==========================================================

WITH product_sales AS (
SELECT
    p.description,
    SUM(f.revenue) AS revenue
FROM fact_sales f
    JOIN dim_product p
    ON f.product_key = p.product_key
GROUP BY p.description
)
SELECT
description,
ROUND(revenue,2),
    CASE
        WHEN revenue >= 100000 THEN 'Premium'
        WHEN revenue >= 50000 THEN 'Standard'
        ELSE 'Low Performer'
    END AS product_category
FROM product_sales
ORDER BY revenue DESC;

