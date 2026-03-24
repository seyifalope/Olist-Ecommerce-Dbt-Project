# Olist Ecommerce Analytics Platform
### Built by Seyi Falope — Analytics Engineer, Digital Automation

![dbt](https://img.shields.io/badge/dbt-1.11.7-orange)
![Snowflake](https://img.shields.io/badge/Snowflake-DIGITAL__AUTOMATION__DB-blue)
![CI](https://github.com/seyifalope/Olist-Ecommerce-Dbt-Project/actions/workflows/dbt_ci.yml/badge.svg)

---

## Project Overview

End to end analytics engineering platform built for Olist, a Brazilian ecommerce marketplace. The platform transforms raw transactional data into trusted business ready models serving Finance, Marketing and Operations teams.

---

## Tech Stack

| Tool | Purpose |
|------|---------|
| Snowflake | Cloud data warehouse — RAW, DEV and PROD schemas |
| dbt Core | Data transformation and modeling |
| dbt-utils | Surrogate key generation, date spine macro |
| dbt-expectations | Advanced data quality testing |
| GitHub Actions | CI/CD — automated dbt testing on every Pull Request |
| Power BI | Business intelligence layer connected to PROD schema |

---

## Data Sources

**Olist Ecommerce Dataset** — 100,000+ orders across 9 tables

**Olist Marketing Funnel Dataset** — Lead acquisition data across 2 tables

Total: 11 raw tables loaded into Snowflake RAW schema.

---

## Pipeline Architecture
```
Snowflake RAW (11 source tables)
        ↓
Staging Layer (views — standardise and clean)
        ↓
Dimension Tables (Kimball — surrogate keys)
        ↓
Fact Tables (Kimball — grain defined)
        ↓
Snowflake PROD (Power BI connects here)
```

---

## Data Model

**Dimensions:**
- `dim_customers` — Customer dimension with surrogate key
- `dim_products` — Product catalogue with English category translation
- `dim_sellers` — Seller dimension with surrogate key
- `dim_dates` — Date dimension covering 2016-2018. Pre-calculates day, week, month, quarter, year attributes.
- `dim_geolocation` — Brazilian postcode to lat/long mapping

**Facts:**
- `fct_orders` — Core order fact table. Grain: one row per order. Combines orders, payments and items.
- `fct_marketing` — Marketing funnel fact table. Grain: one row per qualified lead. Tracks full funnel from first contact to seller conversion.

---

## Data Quality and Testing

Every model is tested using dbt built-in tests and dbt-expectations:

- Uniqueness and not-null on all primary and foreign keys
- Referential integrity between all facts and dimensions
- Value range validation on all financial columns
- Row count validation on all dimension tables
- Accepted values on all status and category columns

---

## CI/CD

GitHub Actions workflow triggers on every Pull Request to main:
1. Installs dbt and dependencies
2. Connects to Snowflake using encrypted GitHub Secrets
3. Runs dbt compile — catches syntax errors
4. Runs dbt test — verifies data quality
5. Red X blocks merge if anything fails. Green tick required to merge.

---

## Project Structure
```
models/
├── staging/        # Standardises raw source tables
├── dimensions/     # Kimball dimension tables
└── facts/          # Fact tables with grain defined. Consumed directly by Power BI.
```




