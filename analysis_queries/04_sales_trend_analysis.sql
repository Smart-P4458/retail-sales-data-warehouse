/*
-- =======================================================
Project : Retail Sales Data Warehouse

File : 04_sales_trend_analysis.sql

Author : Pam Sani George

Purpose
-------
Analyze sales performance over time using
monthly, quarterly and cumulative trends.
-- =======================================================
*/

-- ==========================================================
-- Analysis 1
-- Monthly Revenue Trend
-- ==========================================================

SELECT
    d.year,
    d.month,
    ROUND(SUM(f.revenue),2) AS monthly_revenue
FROM fact_sales f
	INNER JOIN dim_date d
	ON f.date_key = d.date_key
GROUP BY
    d.year,
    d.month
ORDER BY
    d.year,
    d.month;

    -- ===========================================================
-- Analysis 2
-- Monthly quantity sold
-- ===========================================================

SELECT
    d.year,
    d.month,
    COUNT(f.quantity) AS total_quantity
FROM fact_sales f
	INNER JOIN dim_date d
	ON f.date_key = d.date_key
GROUP BY
    d.year,
    d.month
ORDER BY
    d.year,
    d.month;

-- ===========================================================
-- Analysis 3
-- Quarterly revenue Analysis
-- ===========================================================

SELECT
    d.year,
    d.quarter,
    ROUND(SUM(f.revenue),2) AS quarterly_revenue
FROM fact_sales f
	JOIN dim_date d
	ON f.date_key = d.date_key
GROUP BY
    d.year,
    d.quarter
ORDER BY
    d.year,
    d.quarter;

-- ===========================================================
-- Analysis 4
-- The Best Sales Month
-- ===========================================================
	
	SELECT
    d.year,
    d.month,
    ROUND(SUM(f.revenue),2) AS revenue
FROM fact_sales f
    JOIN dim_date d
    ON f.date_key = d.date_key
GROUP BY
    d.year,
    d.month
ORDER BY revenue DESC
LIMIT 1;


-- ============================================
-- Analysis 5
-- Monthly Revenue by Rank
-- ============================================

SELECT
    d.year,
    d.month,
    ROUND(SUM(f.revenue),2) AS revenue,
    RANK() OVER (
        ORDER BY SUM(f.revenue) DESC
    ) AS revenue_rank
FROM fact_sales f
	JOIN dim_date d
	ON f.date_key = d.date_key
GROUP BY
    d.year,
    d.month
LIMIT 5;

-- ================================================
-- Analysis 6
-- Month-Over-Month Growth rate
-- ================================================

WITH monthly_sales AS (
SELECT
    d.year,
    d.month,
    SUM(f.revenue) AS revenue
FROM fact_sales f
JOIN dim_date d
ON f.date_key = d.date_key
GROUP BY
    d.year,
    d.month
),
growth AS (
SELECT
*,
LAG(revenue)
OVER(
ORDER BY year, month
) AS previous_month
FROM monthly_sales
)
SELECT
year,
month,
ROUND(revenue,2),
ROUND(previous_month,2),
ROUND(
((revenue-previous_month)
/
previous_month)
*100,
2
) AS growth_percent
FROM growth;

-- ==================================================
-- Analysis 7 
-- Running total Revenue
-- ==================================================

SELECT
    d.year,
    d.month,
    ROUND(SUM(f.revenue),2) AS monthly_revenue,
    ROUND(
        SUM(SUM(f.revenue))
        OVER(
            ORDER BY d.year,d.month
        ),
        2
    ) AS cumulative_revenue
FROM fact_sales f
	JOIN dim_date d
	ON f.date_key = d.date_key
GROUP BY
    d.year,
    d.month
ORDER BY
    d.year,
    d.month;

-- ======================================================
-- Analysis 8
-- Highest Growth Month 
-- ======================================================

WITH monthly_sales AS (
SELECT
d.year,
d.month,
SUM(f.revenue) AS revenue
	FROM fact_sales f
	JOIN dim_date d
ON f.date_key=d.date_key
GROUP BY
d.year,
d.month
),
growth AS (
SELECT
*,
LAG(revenue)
	OVER(
	ORDER BY year,month
) previous_revenue
FROM monthly_sales
)
SELECT
year,
month,
ROUND(
((revenue-previous_revenue)
/
previous_revenue)
*100,
2
)
AS growth_percentage
FROM growth
WHERE previous_revenue IS NOT NULL
ORDER BY growth_percentage DESC
LIMIT 5;