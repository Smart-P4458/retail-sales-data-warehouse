# Indexing Strategy

The Retail Sales Data Warehouse uses indexes to optimize analytical query performance.

## Customer Dimension

Indexed Column

- customer_id

Purpose

Speed up customer lookups and joins.

---

## Product Dimension

Indexed Column

- stock_code

Purpose

Improve product searches and joins.

---

## Date Dimension

Indexed Column

- invoice_date

Purpose

Improve date filtering and reporting.

---

## Fact Table

Indexed Columns

- invoice_no
- customer_key
- product_key
- date_key

Purpose

Improve JOIN performance and analytical queries.

---

Indexes were created after the schema design was finalized and before running business analysis queries.