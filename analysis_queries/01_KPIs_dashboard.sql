/*
============================================================
Project: Retail Sales Data Warehouse

File: 01_kpi_dashboard.sql

Author: Pam Sani George

Purpose:
Provides Executive-Level KPIs from the Retail Sales Data Warehouse.

Data Source:
fact_sales
dim_customers
dim_product

Created:
Smart-P Analytics Mentorship Program

============================================================
*/

-- ============================================
-- KPI 1: Total Revenue
-- ============================================

SELECT
    ROUND(SUM(revenue), 2) AS total_revenue
FROM fact_sales;

-- ============================================
-- KPI 2: Total Orders
-- ============================================

SELECT
    COUNT(DISTINCT invoice_no) AS total_orders
FROM fact_sales;

-- ============================================
-- KPI 3: Total Customers
-- ============================================

SELECT
    COUNT(*) AS total_customers
FROM dim_customers;

-- ============================================
-- KPI 4: Total Products
-- ============================================

SELECT 
    COUNT(*) AS total_ptoducts
FROM dim_product

-- ============================================
-- KPI 5: Total Quantity Sold
-- ============================================

SELECT
    SUM(quantity) AS total_quantity_sold
FROM fact_sales;

-- ============================================
-- KPI 6: Average Order Value
-- ============================================

SELECT
    ROUND(
        SUM(revenue) /
        COUNT(DISTINCT invoice_no),
        2
    ) AS average_order_value
FROM fact_sales;

-- =============================================
-- KPI 7: Revenue Per Customer
-- =============================================

SELECT
    ROUND(
        SUM(revenue)/
        COUNT(DISTINCT customer_key),
        2
    ) AS average_revenue_per_customer
FROM fact_sales;

-- =============================================
-- KPI 8: Average Item Per Order
-- =============================================

SELECT