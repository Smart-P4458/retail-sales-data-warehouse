# Modeling Decisions

Not every attribute belongs in a Dimension Table.

Ask yourself:

Is this describing the entity?

or

Is this describing the transaction?

Examples

Customer

- Country ✅

Product

- Description ✅

Sales

- Quantity ✅
- Revenue ✅
- Unit Price ✅

Good data models separate descriptive information from transactional measures.