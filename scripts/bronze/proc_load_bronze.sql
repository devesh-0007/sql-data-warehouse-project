EXEC bronze.load_bronze

CREATE OR ALTER procedure bronze.load_bronze AS

BEGIN

    DECLARE @batch_start_time DATETIME, @batch_end_time DATETIME;
    SET @batch_start_time = GETDATE();
    DECLARE @start_time DATETIME, @end_time DATETIME;
    BEGIN TRY

        PRINT '=====================================';
        PRINT 'LOADING BRONZE LAYER';
        PRINT '=====================================';

        PRINT '-------------------------------------';
        PRINT 'LOADING CRM TABLE';
        PRINT '-------------------------------------';  
        SET @start_time = GETDATE();

/*
=============================================================
DDL Script: Create CRM Customer Information Table
=============================================================

Script Purpose:
    This table stores customer master data imported from the CRM system.
    It contains customer identifiers, names, demographic details,
    and account creation information.

=============================================================
*/
        PRINT '>> TRUNCATING TABLE : BRONZE.CRM_CUST_INFO ';
        TRUNCATE TABLE bronze.crm_cust_info;
        PRINT 'inserting data into: BRONZE.CRM_CUST_INFO';
        BULK INSERT bronze.crm_cust_info
        FROM '/var/opt/mssql/cust_info.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @end_time = GETDATE();
        PRINT '>> Load duration '+ cast(DATEDIFF(second, @start_time, @end_time) as NVARCHAR) + 'seconds';
        PRINT'-----------------------'

          /*
=============================================================
DDL Script: Create CRM Product Information Table
=============================================================

Script Purpose:
    This table stores product master data imported from the CRM system.
    It includes product identifiers, categories, pricing details,
    and product lifecycle information.

=============================================================
*/
        SET @start_time = GETDATE();
        PRINT '>> TRUNCATING TABLE : bronze.crm_prd_info ';
        TRUNCATE TABLE bronze.crm_prd_info;
        PRINT 'inserting data into: bronze.crm_prd_info';
        BULK INSERT bronze.crm_prd_info
        FROM '/var/opt/mssql/prd_info.csv'
        WITH (
            firstrow = 2,
            FIELDTERMINATOR = ',',
            tablock
        );
        SET @end_time = GETDATE();
        PRINT'>> Load duration ' + CAST(DATEDIFF(second, @start_time, @end_time) as NVARCHAR) + 'seconds';
        PRINT'-----------------------';

/*
=============================================================
DDL Script: Create CRM Sales Details Table
=============================================================

Script Purpose:
    This table stores sales transaction data imported from the CRM system.
    It contains order information, customer references, product references,
    quantities, sales amounts, and transaction dates.

=============================================================
*/
        SET @start_time = GETDATE();
        PRINT '>> TRUNCATING TABLE : bronze.crm_sales_dateils';
        TRUNCATE TABLE bronze.crm_sales_dateils;
        PRINT 'inserting data into: bronze.crm_sales_dateils';
        BULK INSERT bronze.crm_sales_dateils
        FROM '/var/opt/mssql/sales_details.csv'
        WITH (
            firstrow = 2,
            FIELDTERMINATOR = ',',
            tablock
        );
        SET @end_time = GETDATE() ;
        PRINT'>> Load duration ' + CAST(DATEDIFF(second, @start_time, @end_time) as NVARCHAR) + 'seconds';
        PRINT'-----------------------';
/*
=============================================================
DDL Script: Create ERP Customer Table
=============================================================

Script Purpose:
    This table stores customer-related data imported from the ERP system.
    It includes customer identifiers, birth dates, and gender information
    used for customer enrichment and integration.

=============================================================
*/


        PRINT '-------------------------------------';
        PRINT 'LOADING ERM TABLE';
        PRINT '-------------------------------------';  

        SET @start_time = GETDATE();
        
        PRINT '>> TRUNCATING TABLE : bronze.erp_cust_az12 ';
        TRUNCATE TABLE bronze.erp_cust_az12;
        PRINT 'inserting data into: bronze.erp_cust_az12';
        BULK INSERT bronze.erp_cust_az12
        FROM '/var/opt/mssql/CUST_AZ12.csv'
        WITH (
            firstrow = 2,
            FIELDTERMINATOR = ',',
            tablock
        );
        SET @end_time = GETDATE() ;
        PRINT'>> Load duration ' + CAST(DATEDIFF(second, @start_time, @end_time) as NVARCHAR) + 'seconds';
        PRINT'-----------------------';

/*
=============================================================
DDL Script: Create ERP Location Table
=============================================================

Script Purpose:
    This table stores customer location data imported from the ERP system.
    It contains country and regional information used for geographic
    analysis and reporting.

=============================================================
*/


        SET @start_time = GETDATE();
        PRINT '>> TRUNCATING TABLE : bronze.erp_loc_a101 ';
        TRUNCATE TABLE bronze.erp_loc_a101;
        PRINT 'inserting data into: bronze.erp_loc_a101';
        BULK INSERT bronze.erp_loc_a101
        FROM '/var/opt/mssql/LOC_A101.csv'
        WITH (
            firstrow = 2,
            FIELDTERMINATOR = ',',
            tablock
        );
        SET @end_time = GETDATE() ;
        PRINT'>> Load duration ' + CAST(DATEDIFF(second, @start_time, @end_time) as NVARCHAR) + 'seconds';
        PRINT'-----------------------';

/*
=============================================================
DDL Script: Create ERP Product Category Table
=============================================================

Script Purpose:
    This table stores product category and product hierarchy information
    imported from the ERP system. It is used to enrich product data
    and support business reporting.

=============================================================
*/
        SET @start_time = GETDATE();
        PRINT '>> TRUNCATING TABLE : bronze.erp_px_cat_g1v2';
        TRUNCATE TABLE bronze.erp_px_cat_g1v2;
        PRINT 'inserting data into: bronze.erp_px_cat_g1v2';
        BULK INSERT bronze.erp_px_cat_g1v2
        FROM '/var/opt/mssql/PX_CAT_G1V2.csv'
        WITH (
            firstrow = 2,
            FIELDTERMINATOR = ',',
            tablock
        );
        SET @end_time = GETDATE() ;
        PRINT'>> Load duration ' + CAST(DATEDIFF(second, @start_time, @end_time) as NVARCHAR) + 'seconds';
        PRINT'-----------------------';

    END TRY
    BEGIN CATCH
        PRINT'===========================';
        PRINT'error occured' + ERROR_MESSAGE();
        PRINT'===========================';
    END CATCH
    SET @batch_end_time = GETDATE();
    PRINT'>> Load duration ' + CAST(DATEDIFF(second, @start_time, @end_time) as NVARCHAR) + 'seconds';
    PRINT'-----------------------';
END



