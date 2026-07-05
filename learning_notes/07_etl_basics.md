# ETL Basics

## What is ETL?

ETL stands for:

- Extract
- Transform
- Load

### Extract

Read data from a source system.

Example:

CSV file

### Transform

Clean, validate, remove duplicates, and prepare the data.

Examples:

- Remove duplicate customers
- Calculate year and quarter
- Standardize formats

### Load

Insert the transformed data into the data warehouse.

## Why do we load dimension tables first?

Because the fact table depends on them through foreign keys.

## Interview Tip

Question:

Why not load the fact table first?

Answer:

Because the foreign keys in the fact table must reference existing records in the dimension tables.