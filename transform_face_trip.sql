IF OBJECT_ID('dbo.face_trip') IS NOT NULL
BEGIN
    DROP EXTERNAL TABLE dbo.face_trip
END
-- Create face_trip table
CREATE EXTERNAL TABLE [dbo].[face_trip] WITH
(
    LOCATION     = 'face_trip',
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
FROM [dbo].[trip_ex] as tr
JOIN [dbo].[rider_ex]  as ri ON ri.rider_id = tr.rider_id;

-- Verify the output
SELECT TOP 10 * FROM dbo.face_trip;
