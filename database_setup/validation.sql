-- ============================================
-- Warehouse Validation Queries
-- ============================================

-- Row Counts
SELECT COUNT(*) FROM staging_retail;
SELECT COUNT(*) FROM dim_customers;
SELECT COUNT(*) FROM dim_product;
SELECT COUNT(*) FROM dim_date;
SELECT COUNT(*) FROM fact_sales;

-- Referential Integrity Checks
-- Customer
SELECT COUNT(*)
FROM fact_sales f
LEFT JOIN dim_customers c
ON f.customer_key = c.customer_key
WHERE c.customer_key IS NULL;

-- Product
SELECT COUNT(*)
FROM fact_sales f
LEFT JOIN dim_product p
ON f.product_key = p.product_key
WHERE p.product_key IS NULL;

-- Date
SELECT COUNT(*)
FROM fact_sales f
LEFT JOIN dim_date d
ON f.date_key = d.date_key
WHERE d.date_key IS NULL;

-- Duplicate Customer Check
SELECT customer_id, COUNT(*)
FROM dim_customers
GROUP BY customer_id
HAVING COUNT(*) > 1;

-- Duplicate Product Check
SELECT stock_code, COUNT(*)
FROM dim_product
GROUP BY stock_code
HAVING COUNT(*) > 1;

-- Revenue Validation
SELECT
    ROUND(SUM(revenue), 2) AS total_revenue
FROM fact_sales;