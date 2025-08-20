-- =====================================================
-- FIELDX SCHEMA SETUP
-- =====================================================

USE DATABASE DEV;

-- Create schema
CREATE SCHEMA IF NOT EXISTS FIELDX
    DATA_RETENTION_TIME_IN_DAYS = 7
    COMMENT = 'Schema for FieldX application data';

USE SCHEMA FIELDX;

-- Create internal stage
CREATE OR REPLACE STAGE FIELDX_STAGE
    COMMENT = 'Internal stage for loading FieldX data'
    DIRECTORY = (ENABLE = TRUE);

-- Create CSV file format
CREATE OR REPLACE FILE FORMAT FIELDX_CSV_FORMAT
    TYPE = 'CSV'
    FIELD_DELIMITER = ','
    SKIP_HEADER = 1
    NULL_IF = ('NULL', 'null', '')
    EMPTY_FIELD_AS_NULL = TRUE
    FIELD_OPTIONALLY_ENCLOSED_BY = '"'
    COMPRESSION = 'AUTO'
    ERROR_ON_COLUMN_COUNT_MISMATCH = FALSE;

-- Create JSON file format
CREATE OR REPLACE FILE FORMAT FIELDX_JSON_FORMAT
    TYPE = 'JSON'
    COMPRESSION = 'AUTO'
    STRIP_OUTER_ARRAY = TRUE
    DATE_FORMAT = 'AUTO'
    TIMESTAMP_FORMAT = 'AUTO';

-- Verify creation
SHOW STAGES IN SCHEMA FIELDX;
SHOW FILE FORMATS IN SCHEMA FIELDX;