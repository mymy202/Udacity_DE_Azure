IF NOT EXISTS (SELECT * FROM sys.external_file_formats WHERE name = 'SynapseDelimitedTextFormat') 
	CREATE EXTERNAL FILE FORMAT [SynapseDelimitedTextFormat] 
	WITH ( FORMAT_TYPE = DELIMITEDTEXT ,
	       FORMAT_OPTIONS (
			 FIELD_TERMINATOR = ',',
			 USE_TYPE_DEFAULT = FALSE
			))
GO

IF NOT EXISTS (SELECT * FROM sys.external_data_sources WHERE name = 'file_haoptm_dfs_core_windows_net') 
	CREATE EXTERNAL DATA SOURCE [file_haoptm_dfs_core_windows_net] 
	WITH (
		LOCATION = 'abfss://file@haoptm.dfs.core.windows.net' 
	)
GO

CREATE EXTERNAL TABLE dbo.trip_ex (
	[trip_id] nvarchar(4000),
	[rideable_type] nvarchar(4000),
	[start_at] varchar(50),
	[ended_at] varchar(50),
	[start_station_id] nvarchar(4000),
	[end_station_id] nvarchar(4000),
	[rider_id] bigint
	)
	WITH (
	LOCATION = 'trip.csv',
	DATA_SOURCE = [file_haoptm_dfs_core_windows_net],
	FILE_FORMAT = [SynapseDelimitedTextFormat]
	)
GO


SELECT TOP 100 * FROM dbo.trip_ex
GO