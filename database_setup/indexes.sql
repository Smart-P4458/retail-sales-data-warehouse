/*
============================================================
Retail Sales Data Warehouse

Indexes Script

Author  : Pam Sani George

Purpose
-------
Creates indexes to improve query performance.

Indexes are created after tables exist
and before analytical queries are executed.

============================================================
*/


-- =========================================================
-- Customer Dimension Index
-- =========================================================

CREATE INDEX idx_dim_customers_customer_id
ON dim_customers(customer_id);

-- =========================================================
-- Product Dimension Index
-- =========================================================

CREATE INDEX idx_dim_product_stock_code
ON dim_product(stock_code);

-- =========================================================
-- Date Dimension Index
-- =========================================================

CREATE INDEX idx_dim_date_invoice_date
ON dim_date(invoice_date);

-- =========================================================
-- Fact Table Indexes
-- =========================================================

CREATE INDEX idx_fact_sales_invoice_no
ON fact_sales(invoice_no);

CREATE INDEX idx_fact_sales_customer_key
ON fact_sales(customer_key);

CREATE INDEX idx_fact_sales_product_key
ON fact_sales(product_key);

CREATE INDEX idx_fact_sales_date_key
ON fact_sales(date_key);