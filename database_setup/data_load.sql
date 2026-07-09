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

-- dim_customers
INSERT INTO dim_customers (
    customer_id,
    country
)
SELECT customer_id, country
FROM (
    SELECT
        customer_id,
        country,
        ROW_NUMBER() OVER (
            PARTITION BY customer_id
            ORDER BY COUNT(*) DESC
        ) AS rn
    FROM staging_retail
    WHERE customer_id IS NOT NULL
    GROUP BY customer_id, country
) ranked
WHERE rn = 1;

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

-- ================================================
-- Load Fact Sales Table
-- ================================================

INSERT INTO fact_sales (
    invoice_no,
    customer_key,
    product_key,
    date_key,
    quantity,
    unit_price,
    revenue
)

SELECT
    s.invoice_no,
    c.customer_key,
    p.product_key,
    d.date_key,
    s.quantity,
    s.unit_price,
    s.revenue

FROM staging_retail s

INNER JOIN dim_customers c
    ON s.customer_id = c.customer_id

INNER JOIN dim_product p
    ON s.stock_code = p.stock_code

INNER JOIN dim_date d
    ON s.invoice_date = d.invoice_date;

    