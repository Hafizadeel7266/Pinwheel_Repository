-- =====================================================
-- DATABASE SETUP
-- =====================================================

USE WAREHOUSE DEV_WH;

-- Create the DEV database
CREATE DATABASE IF NOT EXISTS DEV
    DATA_RETENTION_TIME_IN_DAYS = 7
    COMMENT = 'Development database with multiple source schemas';

-- Set as current database
USE DATABASE DEV;

-- Verify database creation
SHOW DATABASES LIKE 'DEV';