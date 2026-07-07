# Changelog

All notable changes to this project will be documented in this file.

This project follows a milestone-based development approach.

---

## [Unreleased]

- Business Analytics Queries
- Power BI Integration
- ER Diagram Improvements

---

## [Milestone 6] - ETL Pipeline

### Added
- Staging table
- Customer Dimension
- Product Dimension
- Date Dimension
- Fact Sales table
- Database indexes
- Validation scripts

### Changed
- Moved `unit_price` from Product Dimension to Fact Sales.
- Improved Customer Dimension to keep one country per customer.
- Improved Product Dimension to store one row per Stock Code.

### Fixed
- Removed duplicate customer records.
- Removed duplicate product records caused by varying prices.

---

## [Milestone 5]

### Added
- Initial Star Schema design
- Primary Keys
- Foreign Keys

---

## [Milestone 4]

### Added
- GitHub repository
- Project structure
- Documentation