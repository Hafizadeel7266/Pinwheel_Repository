SELECT
  CURRENT_ORGANIZATION_NAME() || '-' || CURRENT_ACCOUNT_NAME()             AS org_account,
  CURRENT_ACCOUNT()                                                        AS account,
  CURRENT_USER()                                                           AS user_name,
  CURRENT_ROLE()                                                           AS role_name,
  CURRENT_REGION()                                                         AS region,
  SPLIT_PART(CURRENT_REGION(), '_', 1)                                     AS cloud_provider,
  CURRENT_WAREHOUSE()                                                      AS warehouse,
  CURRENT_DATABASE()                                                       AS database_name,
  CURRENT_SCHEMA()                                                         AS schema_name,
  CURRENT_TIME()                                                           AS current_time,
  current_client()                                                         As Current_client,
  'Check contract or ACCOUNT_USAGE views for edition'                      AS snowflake_edition
;


  --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

SELECT 
  'Org-Account: ' || CURRENT_ORGANIZATION_NAME() || '-' || CURRENT_ACCOUNT_NAME() || ' | ' ||
  'Account: ' || CURRENT_ACCOUNT() || ' | ' ||
  'User: ' || CURRENT_USER() || ' | ' ||
  'Role: ' || CURRENT_ROLE() || ' | ' ||
  'Region: ' || CURRENT_REGION() || ' | ' ||
  'Cloud Provider: ' || SPLIT_PART(CURRENT_REGION(), '_', 1) || ' | ' ||
  'Warehouse: ' || CURRENT_WAREHOUSE() || ' | ' ||
  'Database: ' || CURRENT_DATABASE() || ' | ' ||
  'Schema: ' || CURRENT_SCHEMA() || ' | ' ||
  'Time: ' || CURRENT_TIME() || ' | ' ||
   'Current_Client:' || current_client() || '|' ||
  'Edition: ' || 'Check contract or ACCOUNT_USAGE views'
  AS session_info;

  
  --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


  SELECT 
   CURRENT_ORGANIZATION_NAME() || '-' || CURRENT_ACCOUNT_NAME() as Account_Identifier;

   ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


   
-- snowsql -a ZRCKPFV-HBB98285 -u TYANG -o log_level=DEBUG;
-- create a connection profile in ~/.snowsql/config
-- [connections.my_example_connection]
-- snowsql -c my_example_connection


   --after that 
   --pawwsord: 19011556-165Uog

   !exit;                     

   ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--fro vs code 

SELECT 
  CURRENT_ACCOUNT() AS account_name,
  CURRENT_REGION() AS region_name,
  SPLIT_PART(CURRENT_REGION(), '_', 1) AS region_prefix,
  CURRENT_ACCOUNT() || '.' || CURRENT_REGION() || '.' || SPLIT_PART(CURRENT_REGION(), '_', 1) AS Account_Identifier;


