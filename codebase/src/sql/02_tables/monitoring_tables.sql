-- =====================================================
-- MONITORING TABLES
-- =====================================================

USE DATABASE DEV;
USE SCHEMA MONITORING;

-- Load history tracking table
CREATE OR REPLACE TABLE LOAD_HISTORY (
    load_id NUMBER AUTOINCREMENT START 1 INCREMENT 1,
    schema_name VARCHAR(100),
    table_name VARCHAR(100),
    stage_name VARCHAR(100),
    file_name VARCHAR(500),
    file_size_bytes NUMBER,
    rows_loaded NUMBER,
    rows_failed NUMBER,
    load_status VARCHAR(50),
    error_message VARCHAR(5000),
    load_start_time TIMESTAMP_NTZ,
    load_end_time TIMESTAMP_NTZ,
    duration_seconds NUMBER AS (TIMESTAMPDIFF(SECOND, load_start_time, load_end_time)),
    created_by VARCHAR(100) DEFAULT CURRENT_USER(),
    created_at TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP(),
    PRIMARY KEY (load_id)
)
COMMENT = 'Tracks all data load operations';

-- Data quality checks table
CREATE OR REPLACE TABLE DATA_QUALITY_CHECKS (
    check_id NUMBER AUTOINCREMENT START 1 INCREMENT 1,
    schema_name VARCHAR(100),
    table_name VARCHAR(100),
    check_type VARCHAR(100),
    check_name VARCHAR(200),
    check_query VARCHAR(5000),
    expected_result VARCHAR(1000),
    actual_result VARCHAR(1000),
    check_result VARCHAR(5000),
    passed BOOLEAN,
    severity VARCHAR(20) DEFAULT 'INFO', -- INFO, WARNING, ERROR, CRITICAL
    check_timestamp TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP(),
    created_by VARCHAR(100) DEFAULT CURRENT_USER(),
    PRIMARY KEY (check_id)
)
COMMENT = 'Tracks data quality validation checks';

-- Schema change history
CREATE OR REPLACE TABLE SCHEMA_CHANGE_HISTORY (
    change_id NUMBER AUTOINCREMENT START 1 INCREMENT 1,
    schema_name VARCHAR(100),
    object_type VARCHAR(50), -- TABLE, VIEW, PROCEDURE, etc.
    object_name VARCHAR(200),
    change_type VARCHAR(50), -- CREATE, ALTER, DROP
    change_description VARCHAR(2000),
    ddl_statement VARCHAR(10000),
    executed_by VARCHAR(100) DEFAULT CURRENT_USER(),
    executed_at TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP(),
    PRIMARY KEY (change_id)
)
COMMENT = 'Tracks all DDL changes in the database';

-- Create indexes for better query performance
CREATE OR REPLACE INDEX idx_load_history_schema_table 
    ON LOAD_HISTORY(schema_name, table_name);

CREATE OR REPLACE INDEX idx_load_history_status 
    ON LOAD_HISTORY(load_status);

CREATE OR REPLACE INDEX idx_quality_checks_schema_table 
    ON DATA_QUALITY_CHECKS(schema_name, table_name);

CREATE OR REPLACE INDEX idx_quality_checks_passed 
    ON DATA_QUALITY_CHECKS(passed);