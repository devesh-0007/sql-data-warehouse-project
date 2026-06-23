/*
=============================================================
DDL Script: Create Bronze Tables
=============================================================

Script Purpose:
    This script creates tables in the 'bronze' schema, dropping existing tables
    if they already exist.

    Run this script to re-define the DDL structure of 'bronze' Tables

=============================================================
*/


IF OBJECT_ID('bronze.crm_cust_info', 'U') is NOT NULL
DROP TABLE bronze.crm_cust_info ; 
CREATE TABLE bronze.crm_cust_info(
    cst_id INT,
    cst_key NVARCHAR(50),
    cst_firstname NVARCHAR(50),
    cst_lastname NVARCHAR(50),
    cst_material_status NVARCHAR(50),
    cst_gndr NVARCHAR(50),
    cst_create_date DATE
);

IF OBJECT_ID('bronze.crm_prd_info', 'U') is NOT NULL
DROP TABLE bronze.crm_prd_info ; 
CREATE TABLE bronze.crm_prd_info(
    pro_id INT,
    pro_key NVARCHAR(50),
    pro_nm NVARCHAR(50),
    pro_cost INT,
    pro_line NVARCHAR(50),
    cst_gndr NVARCHAR(50),
    cst_create_date DATE
);
IF OBJECT_ID('bronze.crm_sales_dateils', 'U') is NOT NULL
DROP TABLE bronze.crm_sales_dateils ; 
CREATE TABLE bronze.crm_sales_dateils(
    sls_odr_nm NVARCHAR(50),
    sls_prd_key NVARCHAR(50),
    sls_cust_id INT,
    sls_order_dt int,
    sls_ship_dt int,
    sls_due_dt int,
    sls_sales INT,
    sls_quality INT,
    sls_price INT

);

IF OBJECT_ID('bronze.erp_loc_a101', 'U') is NOT NULL
DROP TABLE bronze.erp_loc_a101 ; 
CREATE TABLE bronze.erp_loc_a101(
    cid NVARCHAR(50) ,
    cntry NVARCHAR(50)
);
IF OBJECT_ID('bronze.erp_cust_az12', 'U') is NOT NULL
DROP TABLE bronze.erp_cust_az12 ; 
CREATE TABLE bronze.erp_cust_az12(
    cid NVARCHAR(50),
    bdate DATE,
    gen NVARCHAR(50)
);
IF OBJECT_ID('bronze.erp_px_cat_g1v2', 'U') is NOT NULL
DROP TABLE bronze.erp_px_cat_g1v2 ; 
CREATE TABLE bronze.erp_px_cat_g1v2(
    id NVARCHAR(50),
    cat NVARCHAR(50),
    subcat NVARCHAR(50),
    maintenance NVARCHAR(50)
);
