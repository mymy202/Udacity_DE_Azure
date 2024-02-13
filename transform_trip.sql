IF OBJECT_ID('dbo.dim_trip') IS NOT NULL
BEGIN
    DROP TABLE dbo.dim_trip
END
-- Create dim_trip table
CREATE EXTERNAL TABLE [dbo].[dim_trip] WITH
(
    LOCATION     = 'dim_trip',
    DATA_SOURCE = [file_haoptm_dfs_core_windows_net],
    FILE_FORMAT = [SynapseDelimitedTextFormat]
)
AS
SELECT 
    [trip_id] ,
	[rideable_type] ,
	[start_at] ,
	[ended_at] ,
	[start_station_id] ,
	[end_station_id] ,
	[rider_id] 
FROM [dbo].[trip_ex];

-- Verify the output
SELECT TOP 10 * FROM dbo.dim_trip;