# Investigation 001 – Customer Country Inconsistency

## Objective

Investigate why the number of records in the Customer Dimension exceeded the expected number of unique customers.

---

## Background

During ETL validation, the following results were observed:

| Metric | Value |
|--------|------:|
| Unique Customer IDs in staging table | 4,338 |
| Records loaded into dim_customers | 4,346 |

Difference:

8 additional records.

---

## Investigation Query

```sql
SELECT
    customer_id,
    COUNT(DISTINCT country) AS country_count
FROM staging_retail
GROUP BY customer_id
HAVING COUNT(DISTINCT country) > 1;
```

---

## Findings

Eight customer IDs were associated with more than one country.

Example:

| Customer ID | Country | Transactions |
|-------------|----------|-------------:|
|12370|Austria|8|
|12370|Cyprus|158|

This indicates inconsistent country information for a small number of customers.

---

## Business Discussion

Possible reasons include:

- Customer relocation
- Billing address changes
- Data entry errors
- System migration inconsistencies

Without additional business rules, it is impossible to determine the absolute correct country.

---

## Design Decision

For this portfolio project, the Customer Dimension stores one record per customer.

The selected country is the one that appears most frequently for that customer in the staging data.

This approach:

- Produces one customer record
- Removes duplicate customer entries
- Preserves the most representative country

---

## Lesson Learned

Data quality issues should be investigated before loading warehouse dimensions.

Unexpected row counts often reveal business rules rather than software bugs.