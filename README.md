# Project Overview: Enexis Case Implementation
## 1. AWS & Data Ingestion
### AWS Account configured and used to host example data.
### Data is stored in an S3 bucket.
## 2. Snowflake Integration
The S3 bucket is integrated into Snowflake as an external stage.
Data is copied from the external stage to an internal stage.
Snowpipe is used to automatically load data into tables.
### This process is defined in: sql_creating_external_st.sql.
## 3. Development Environment
VS Code is configured to connect to Snowflake:
Using Python (via Snowpark).
Using the SQL extension.
### Example of Python-based interaction is in: notebook_snowpark_NG.ipynb.
## 4. Data Modeling
Data Vault modeling is simulated.
Fact and Dimension tables are built using Snowflake Tasks.
### Task definitions are in: create_tasks.sql.

