-- Switch to the ACCOUNTADMIN role and select the correct warehouse for operations
USE ROLE ACCOUNTADMIN;
USE WAREHOUSE Compute_WH;
use database snowpark;
use schema snowpark;




-- Create a schema within the Integrations database specifically for GitHub-related operations
CREATE OR REPLACE SCHEMA Github;
USE SCHEMA Github;

-- Create a secret to securely store GitHub credentials (username and personal access token)
CREATE OR REPLACE SECRET Github.github_secret
  TYPE = PASSWORD
  USERNAME = 'Hafizadeel7266'  -- Replace with your GitHub username
  PASSWORD = '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';  -- Replace with your GitHub personal access token

-- Verify that the secret was created successfully by showing the stored secrets
SHOW SECRETS;

-- Create the API integration for GitHub, allowing Snowflake to interact with GitHub repositories
CREATE OR REPLACE API INTEGRATION git_api_integration
  API_PROVIDER = 'GIT_HTTPS_API'
  API_ALLOWED_PREFIXES = ('https://github.com/Hafizadeel7266/')  -- Replace with your GitHub URL
  ALLOWED_AUTHENTICATION_SECRETS = ('github_secret')  -- The secret created earlier for authentication
  ENABLED = TRUE;

-- Verify the created API integration by listing all available API integrations
SHOW API INTEGRATIONS;

-- Create a Git repository integration, linking it to the previously defined API integration
CREATE OR REPLACE GIT REPOSITORY github_repo
  API_INTEGRATION = git_api_integration
  GIT_CREDENTIALS = github_secret  -- Credentials for authenticating with GitHub
  ORIGIN = 'https://github.com/Hafizadeel7266/snowflake-snowpark-pipeline.git';  -- Replace with your GitHub repository URL

-- List all Git repositories in Snowflake to verify that the integration has been successfully created
SHOW GIT REPOSITORIES;

-- Query the INFORMATION_SCHEMA to check the registered Git repositories and their metadata
SELECT * FROM INFORMATION_SCHEMA.GIT_REPOSITORIES;

-- Show the branches available in the Git repository
SHOW GIT BRANCHES IN GIT REPOSITORY github_repo;

-- List all files available under a specific branch in the GitHub repository (replace 'main' with your branch name)
LS @my_github_repo/branches/main;

-- Fetch the latest code from the GitHub repository to ensure Snowflake has the most recent updates
ALTER GIT REPOSITORY my_github_repo FETCH;

-- Add a useful comment to the GitHub repository integration for better context and traceability
ALTER GIT REPOSITORY my_github_repo SET COMMENT = 'This is my useful code';

-- Show all available tags in the Git repository
SHOW GIT TAGS IN GIT REPOSITORY my_github_repo;

-- List all files under a specific tag in the Git repository (replace 'tags_name' with your tag name)
LS @my_github_repo_tags/tags_name;

-- Fetch files based on a specific commit hash (replace 'hash_code' with the actual commit hash)
LS @my_github_repo_commits/hash_code;

-- Execute a SQL script or query directly from a file in a specific branch (replace 'Git Worksheet.sql' with your file name)
EXECUTE IMMEDIATE FROM @my_github_repo/branches/main/Git_Worksheet.sql;