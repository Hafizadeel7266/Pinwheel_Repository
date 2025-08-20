-- =====================================================
-- MONITORING SCHEMA SETUP
-- =====================================================

USE DATABASE DEV;

-- Create monitoring schema
CREATE SCHEMA IF NOT EXISTS MONITORING
    DATA_RETENTION_TIME_IN_DAYS = 30
    COMMENT = 'Schema for monitoring and logging data operations';

USE SCHEMA MONITORING;

-- No stage needed for monitoring schema as it's for internal tracking only