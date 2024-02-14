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
    	tr.[trip_id],
	tr.[rideable_type],
	tr.[start_at],
	tr.[ended_at],
	tr.[start_station_id],
	tr.[end_station_id],
	tr.[rider_id],
	DATEDIFF(hour, tr.start_at, tr.ended_at) AS duration,
    	DATEDIFF(year, ri.birthday, tr.start_at) AS rider_age	
FROM [dbo].[trip_ex] as tr;
JOIN [dbo].[rider_ex]  as ri ON ri.rider_id = tr.rider_id;

-- Verify the output
SELECT TOP 10 * FROM dbo.dim_trip;
