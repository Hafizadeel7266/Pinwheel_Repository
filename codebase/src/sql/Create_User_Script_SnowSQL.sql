-- Use the system administrator role
USE ROLE sysadmin;

-- Create or replace the database
CREATE OR REPLACE DATABASE sanowsql_db;

-- Use the default schema
USE SCHEMA sanowsql_db.public;

-- Switch to the accountadmin role for user creation
USE ROLE accountadmin;

-- Create a new user for data engineering
CREATE USER IDENTIFIER('"DATAENGINEER01"')
  COMMENT             = 'This is data engineer account'
  PASSWORD            = '1901166-165Uog'
  MUST_CHANGE_PASSWORD = false
  LOGIN_NAME          = 'dataengineer01'
  FIRST_NAME          = 'DE'
  LAST_NAME           = 'ENGINEER'
  DISPLAY_NAME        = 'DE-ENGINEER'
  EMAIL               = 'hafizadeelarif7266@gmail.com'
  DEFAULT_WAREHOUSE   = 'COMPUTE_WH'
  DEFAULT_NAMESPACE   = 'sanowsql_db.public'
  DEFAULT_ROLE        = 'SYSADMIN';

-- Grant the SYSADMIN role to the new user
GRANT ROLE sysadmin TO USER IDENTIFIER('"DATAENGINEER01"');
------------------------------------------------------------------------------------

select * from snowflake.account_usage.login_history
where user_name = upper('DATAENGINEER01');
