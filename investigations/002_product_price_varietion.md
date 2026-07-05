# Investigation 002 – Product Price Variation

## Objective

Investigate why the Product Dimension contained significantly more rows than expected.

---

## Background

Initial ETL results:

| Metric | Value |
|--------|------:|
| Unique Stock Codes | 3,665 |
| Records loaded into dim_product | 8,881 |

---

## Investigation Query

```sql
SELECT
    stock_code,
    COUNT(*) AS records
FROM dim_product
GROUP BY stock_code
HAVING COUNT(*) > 1
ORDER BY records DESC;
```

---

## Findings

Approximately 1,000 stock codes appeared multiple times.

Some stock codes appeared over 100 times.

Further investigation showed that many repeated records had:

- identical Stock Code
- identical Product Description
- different Unit Prices

Example:

Stock Code:

MANUAL

Description:

Manual

Observed across hundreds of sales transactions with varying prices.

---

## Business Interpretation

The product itself did not change.

Only the selling price changed between transactions.

This indicates that Unit Price is a transactional attribute rather than a descriptive product attribute.

---

## Design Decision

The Product Dimension was redesigned.

Previous design:

- Stock Code
- Description
- Unit Price

Improved design:

- Stock Code
- Description

Unit Price was moved into the Fact Table because it belongs to individual sales transactions.

This change reduced the Product Dimension from:

8,881 rows

to

3,665 rows.

---

## Benefits

- One product per Stock Code
- Cleaner Star Schema
- Better normalization
- Easier reporting
- Easier maintenance

---

## Lesson Learned

Not every changing value belongs in a Dimension Table.

Always determine whether an attribute describes the entity or the transaction.