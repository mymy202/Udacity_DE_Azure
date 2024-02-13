IF OBJECT_ID('dbo.dim_station') IS NOT NULL
BEGIN
    DROP TABLE dbo.dim_station
END
-- Create dim_rider table
CREATE EXTERNAL TABLE [dbo].[dim_station] WITH
(
    LOCATION     = 'dim_station',
    DATA_SOURCE = [file_haoptm_dfs_core_windows_net],
    FILE_FORMAT = [SynapseDelimitedTextFormat]
)
AS
SELECT 
    [station_id],
	[name],
	[latitude] ,
	[longitude] 
FROM [dbo].[station_ex];

-- Verify the output
SELECT TOP 10 * FROM dbo.dim_station;