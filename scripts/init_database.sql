/*
=============================================================
Create Database and Schemas
=============================================================

Script Purpose:
    This script creates a new database named 'DataWarehouse'
    after checking if it already exists.

    If the database exists, it is dropped and recreated.
    Additionally, the script creates three schemas:
        - bronze : Raw source data
        - silver : Cleaned and transformed data
        - gold   : Business-ready data for reporting

Warning:
    Running this script will drop the existing
    'DataWarehouse' database if it exists.

    All data within the database will be permanently
    deleted. Proceed with caution and ensure proper
    backups are available before execution.

=============================================================
*/

USE master;
GO

-- Check if the database exists
IF EXISTS (
    SELECT 1
    FROM sys.databases
    WHERE name = 'DataWarehouse'
)
BEGIN
    ALTER DATABASE DataWarehouse
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE;

    DROP DATABASE DataWarehouse;
END;
GO

-- Create the database
CREATE DATABASE DataWarehouse;
GO

-- Switch to the database
USE DataWarehouse;
GO

-- Create schemas
CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO
