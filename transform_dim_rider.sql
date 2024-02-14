IF OBJECT_ID('dbo.dim_rider') IS NOT NULL
BEGIN
    DROP EXTERNAL TABLE dbo.dim_rider
END
-- Create dim_rider table
CREATE EXTERNAL TABLE [dbo].[dim_rider] WITH
(
    LOCATION     = 'dim_rider',
    DATA_SOURCE = [file_haoptm_dfs_core_windows_net],
    FILE_FORMAT = [SynapseDelimitedTextFormat]
)
AS
SELECT 
    [rider_id] 
    ,[firstName]
    ,[lastName] 
    ,[_address] 
    ,[birthday] 
    ,[account_start_date] 
    ,[account_end_date] 
    ,[is_member] 
FROM [dbo].[rider_ex];

-- Verify the output
SELECT TOP 10 * FROM dbo.dim_rider;
