# Loading CSV into PostgreSQL

## Purpose

The staging table is the landing area for raw data.

Raw data should never be loaded directly into a data warehouse.

## Workflow

CSV

↓

staging_retail

↓

Data Cleaning

↓

Dimension Tables

↓

Fact Table

## Why?

The staging table allows us to:

- inspect data
- validate data
- clean data
- remove duplicates
- fix errors

before loading the warehouse.

## Interview Tip

Question:

Why use a staging table?

Answer:

A staging table provides a safe place to validate and clean raw data before it is transformed and loaded into the data warehouse.