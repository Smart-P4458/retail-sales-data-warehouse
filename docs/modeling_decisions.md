# Data Modeling Decisions

## Product Dimension

Originally, the Product Dimension stored:

- Stock Code
- Description
- Unit Price

During data profiling, it became clear that many products were sold at multiple prices.

To avoid duplicate product records, `unit_price` was moved to the Fact Table.

The Product Dimension now stores:

- Product Key
- Stock Code
- Description

The Fact Table stores:

- Quantity
- Unit Price
- Revenue

This design better represents transactional retail data and keeps the Product Dimension focused on product identity rather than changing sales attributes.