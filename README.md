<# Digital Automation — Olist Ecommerce Analytics

## Project Overview
End to end analytics engineering pipeline built for Olist, a Brazilian ecommerce marketplace client of Digital Automation.

## Tech Stack
- **Snowflake** — Cloud data warehouse
- **dbt** — Data transformation and modeling
- **Power BI** — Business intelligence dashboards
- **GitHub Actions** — CI/CD automated testing

## Data Sources
- Olist Ecommerce Dataset — 100,000 orders, 9 tables
- Olist Marketing Funnel Dataset — Lead acquisition data, 2 tables

## Pipeline Architecture
Raw Data → dbt Staging → dbt Dimensions → dbt Facts → dbt Marts → Power BI

## Project Structure
- `models/staging` — Cleans and renames raw source tables
- `models/dimensions` — Kimball dimension tables with surrogate keys
- `models/facts` — Kimball fact tables with grain defined
- `models/marts` — Business ready aggregations for Power BI

## Analytics Engineer
Seyi Falope — Digital Automation
