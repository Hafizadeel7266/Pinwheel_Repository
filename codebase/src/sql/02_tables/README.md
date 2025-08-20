# Snowflake DEV Database Project

## Overview
This project contains the complete setup for a Snowflake DEV database with 7 schemas for different data sources and a monitoring schema.

## Database Structure
- **Database**: DEV
- **Warehouse**: DEV_WH
- **Schemas**: 
  - TYPEFORM_CHURN
  - RDS
  - FIELDX
  - CHARGIFY
  - AMAZON_SALES
  - STRIPE_FIVETRAN
  - OTHER_SOURCES
  - MONITORING

## Quick Setup

### 1. Initial Setup
```bash
# Run the complete setup
snowsql -f sql/snowflake_dev_database_setup.sql

# Or run individual components
snowsql -f sql/00_setup/01_warehouse_setup.sql
snowsql -f sql/00_setup/02_database_setup.sql
# ... continue with other files