/*
============================================================
Retail Sales Data Warehouse
Schema Creation Script
============================================================

Author  : Pam Sani George
Project : Retail Sales Data Warehouse

Description
-----------
Creates the database schema for the Retail Sales
Data Warehouse project.

This script creates:

1. Staging Table
2. Customer Dimension
3. Product Dimension
4. Date Dimension
5. Sales Fact Table

Database:
PostgreSQL 18

============================================================
*/

-- ===========================================
-- Remove Existing Tables
-- ===========================================

DROP TABLE IF EXISTS fact_sales CASCADE;
DROP TABLE IF EXISTS dim_table CASCADE;
DROP TABLE IF EXISTS dim_product CASCADE;
DROP TABLE IF EXISTS dim_customer CASCADE;
DROP TABLE IF EXISTS staging_retail CASCADE;

-- ============================================
-- Create Staging Table
-- ============================================

CREATE TABLE staging_retail(
invoice_no TEXT,
stock_code TEXT,
description VARCHAR(255),	
quantity INT,	
invoice_date TIMESTAMP,	
unit_price NUMERIC(10,2),	
customer_id	INT,
country	TEXT,
revenue NUMERIC(12,2)
);

-- Verify staging table
SELECT *
FROM staging_retail;

-- ===========================================
-- Create Dimension Tables
-- ===========================================

CREATE TABLE dim_customers (
    customer_key SERIAL PRIMARY KEY,
    customer_id INT NOT NULL,
    country VARCHAR(100) NOT NULL
);

-- Verify dim_customers
SELECT *
FROM dim_customers;

-- =============================================
-- Create Product Dimension
-- =============================================

CREATE TABLE dim_product (
    product_key SERIAL PRIMARY KEY,
    stock_code VARCHAR(50) NOT NULL,
    description VARCHAR(255),
    unit_price NUMERIC(10,2) NOT NULL
);

-- ================================================
-- Create Date Dimension
-- ================================================

CREATE TABLE dim_date (
    date_key SERIAL PRIMARY KEY,
    invoice_date TIMESTAMP NOT NULL,
    year INT,
    month INT,
    day INT,
    quarter INT
);

-- Verify Dimension Tables

SELECT *
FROM dim_customers;

SELECT *
FROM dim_product;

SELECT *
FROM dim_date;

