IF OBJECT_ID('dbo.face_payment') IS NOT NULL
BEGIN
    DROP EXTERNAL TABLE dbo.face_payment
END
-- Create face_payment table
CREATE EXTERNAL TABLE [dbo].[dim_payment] WITH
(
    LOCATION     = 'face_payment',
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
SELECT TOP 10 * FROM dbo.face_payment;
