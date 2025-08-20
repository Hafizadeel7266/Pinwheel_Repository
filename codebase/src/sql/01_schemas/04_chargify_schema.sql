-- =====================================================
-- CHARGIFY SCHEMA SETUP
-- =====================================================

USE DATABASE DEV;

-- Create schema
CREATE SCHEMA IF NOT EXISTS CHARGIFY
    DATA_RETENTION_TIME_IN_DAYS = 7
    COMMENT = 'Schema for Chargify billing data';

USE SCHEMA CHARGIFY;

-- Create internal stage
CREATE OR REPLACE STAGE CHARGIFY_STAGE
    COMMENT = 'Internal stage for loading Chargify data'
    DIRECTORY = (ENABLE = TRUE);

-- Create CSV file format
CREATE OR REPLACE FILE FORMAT CHARGIFY_CSV_FORMAT
    TYPE = 'CSV'
    FIELD_DELIMITER = ','
    SKIP_HEADER = 1
    NULL_IF = ('NULL', 'null', '')
    EMPTY_FIELD_AS_NULL = TRUE
    FIELD_OPTIONALLY_ENCLOSED_BY = '"'
    COMPRESSION = 'AUTO'
    ERROR_ON_COLUMN_COUNT_MISMATCH = FALSE;

-- Create JSON file format
CREATE OR REPLACE FILE FORMAT CHARGIFY_JSON_FORMAT
    TYPE = 'JSON'
    COMPRESSION = 'AUTO'
    STRIP_OUTER_ARRAY = TRUE
    DATE_FORMAT = 'AUTO'
    TIMESTAMP_FORMAT = 'AUTO';

-- Verify creation
SHOW STAGES IN SCHEMA CHARGIFY;
SHOW FILE FORMATS IN SCHEMA CHARGIFY;