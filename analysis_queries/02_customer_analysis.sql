/*
============================================================
Project : Retail Sales Data Warehouse

File : 02_customer_analysis.sql

Author : Pam Sani George

Purpose
-------
Analyze customer purchasing behaviour,
customer value, retention and segmentation.

============================================================
*/

-- ==========================================================
-- Analysis 1
-- Top 10 Customers by Lifetime Revenue
-- ==========================================================

SELECT
    c.customer_id,
    c.country,
    ROUND(SUM(f.revenue)::NUMERIC,2) AS lifetime_revenue
FROM fact_sales f
	INNER JOIN dim_customers c
	ON f.customer_key = c.customer_key
GROUP BY
    c.customer_id,
    c.country
ORDER BY lifetime_revenue DESC
LIMIT 10;

-- ==========================================================
-- Analysis 2
-- Customer Order Frequency
-- ==========================================================

SELECT
    c.customer_id,
    COUNT(DISTINCT f.invoice_no) AS total_orders
FROM fact_sales f
	INNER JOIN dim_customers c
	ON f.customer_key = c.customer_key
GROUP BY c.customer_id
ORDER BY total_orders DESC;

-- ==========================================================
-- Analysis 3
-- Repeat vs One-Time Customers
-- ==========================================================

WITH customer_orders AS (
SELECT
    c.customer_id,
    COUNT(DISTINCT invoice_no) AS order_count
FROM fact_sales f
	INNER JOIN dim_customers c
	ON f.customer_key = c.customer_key
GROUP BY c.customer_id
)
SELECT
CASE
WHEN order_count = 1 THEN 'One-Time'
ELSE 'Repeat'
END AS customer_type,
COUNT(*) AS total_customers
FROM customer_orders
GROUP BY customer_type
ORDER BY total_customers DESC;

-- ==========================================================
-- Analysis 4
-- Average Revenue per Customer
-- ==========================================================

SELECT
    c.customer_id,
    ROUND(SUM(f.revenue)::NUMERIC,
	2
	) AS customer_revenue
FROM fact_sales f
	INNER JOIN dim_customers c
	ON f.customer_key = c.customer_key
GROUP BY c.customer_id
ORDER BY customer_revenue DESC;

-- ==========================================================
-- Analysis 5
-- Revenue by Country
-- ==========================================================

SELECT
    c.country,
    ROUND(SUM(f.revenue)::NUMERIC,
	2
	) AS total_revenue
FROM fact_sales f
	INNER JOIN dim_customers c
	ON f.customer_key = c.customer_key
GROUP BY c.country
ORDER BY total_revenue DESC;

-- ==========================================================
-- Analysis 6
-- Customer Segmentation
-- ==========================================================

WITH customer_revenue AS (
SELECT
    c.customer_id,
    ROUND(SUM(f.revenue),2) AS revenue
FROM fact_sales f
	INNER JOIN dim_customers c
	ON f.customer_key = c.customer_key
GROUP BY c.customer_id
)
SELECT
customer_id,
revenue,
	CASE
		WHEN revenue >= 10000 THEN 'High Value'
		WHEN revenue >= 5000 THEN 'Medium Value'
		ELSE 'Low Value'
	END AS customer_segment
FROM customer_revenue
ORDER BY revenue DESC;

