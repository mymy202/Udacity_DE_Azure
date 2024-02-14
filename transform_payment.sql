IF OBJECT_ID('dbo.dim_rider') IS NOT NULL
BEGIN
    DROP EXTERNAL TABLE dbo.dim_payment
END
-- Create dim_payment table
CREATE EXTERNAL TABLE [dbo].[dim_payment] WITH
(
    LOCATION     = 'dim_payment',
    DATA_SOURCE = [file_haoptm_dfs_core_windows_net],
    FILE_FORMAT = [SynapseDelimitedTextFormat]
)
AS
SELECT 
    	[payment_id] ,
	[date] ,
	[amount] ,
	[rider_id] 
FROM [dbo].[payment_ex];

-- Verify the output
SELECT TOP 10 * FROM dbo.dim_payment;
