# K-Beauty Medallion Architecture

> What if a K-Beauty catalog went through a real data engineering pipeline?

This project transforms synthetic K-Beauty product data through a complete Medallion Architecture using Databricks, PySpark, Delta Lake and dbt.

The goal is to simulate how product catalog data can move from raw ingestion to clean analytical models, while applying data quality checks, transformations, lineage and documentation.

## Architecture

Synthetic K-Beauty Data  
↓  
Bronze Layer  
↓  
Silver Layer  
↓  
dbt Source  
↓  
Staging  
↓  
Gold Marts  
↓  
Analytics-ready models

## Tech Stack

- Databricks
- PySpark
- Delta Lake
- dbt Core
- dbt-databricks
- SQL
- Python

## Bronze Layer

The Bronze layer stores raw product records with minimal transformation.

The synthetic dataset intentionally includes inconsistencies such as:

- duplicated product IDs
- inconsistent brand capitalization
- mixed category formats
- prices stored as strings
- null values
- boolean values stored as text

This allows the Silver layer to simulate a realistic cleaning process.

## Silver Layer

The Silver layer standardizes and validates the raw data.

Transformations include:

- duplicate removal
- brand standardization
- category standardization
- BRL price normalization
- type casting
- boolean conversion
- missing-value quality flags

The final Silver table is stored as:

`kbeauty_silver_products`

## dbt Layer

dbt connects directly to the Databricks SQL Warehouse and uses the Silver table as a source.

The staging model:

`stg_kbeauty_products`

is created from:

`kbeauty_silver_products`

using dbt `source()`.

The analytical marts use `ref()` to create explicit lineage between models.

## Gold Marts

### gold_brand_summary

Brand-level analytical model including:

- total products
- average price
- average rating
- stock availability percentage

### gold_category_summary

Category-level analytical model including:

- total products
- average price
- average rating
- stock availability percentage

## Data Quality

dbt tests validate the staging and mart layers.

Examples include:

- `not_null`
- `unique`

Final test result:

**12 / 12 tests passed**

## Databricks Notebooks

The Databricks part of the project is also available directly in this repository:

- [01 — Bronze Ingestion](notebooks/01_bronze_ingestion.ipynb)
- [02 — Silver Transformation](notebooks/02_silver_transformation.ipynb)
- [03 — Gold Analytics](notebooks/03_gold_analytics.ipynb)

These notebooks show the PySpark transformations used to build the Bronze, Silver and Gold layers before integrating the analytical layer with dbt.

## Lineage

The final dbt lineage is:

```text
kbeauty_silver_products
          ↓
stg_kbeauty_products
       ↙        ↘
gold_brand_summary   gold_category_summary


