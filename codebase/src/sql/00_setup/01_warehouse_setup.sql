-- =====================================================
-- WAREHOUSE SETUP
-- =====================================================

USE ROLE ACCOUNTADMIN;

-- Create warehouse for DEV operations
CREATE WAREHOUSE IF NOT EXISTS DEV_WH
    WITH WAREHOUSE_SIZE = 'SMALL'
    WAREHOUSE_TYPE = 'STANDARD'
    AUTO_SUSPEND = 60
    AUTO_RESUME = TRUE
    MIN_CLUSTER_COUNT = 1
    MAX_CLUSTER_COUNT = 1
    INITIALLY_SUSPENDED = TRUE
    COMMENT = 'Warehouse for DEV database operations';

-- Set as current warehouse
USE WAREHOUSE DEV_WH;

-- Verify warehouse creation
SHOW WAREHOUSES LIKE 'DEV_WH';