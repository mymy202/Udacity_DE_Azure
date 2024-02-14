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

CREATE EXTERNAL TABLE dbo.rider_ex (
	[rider_id] bigint,
	[firstName] nvarchar(4000),
	[lastName] nvarchar(4000),
	[_address] nvarchar(4000),
	[birthday] datetime2(0),
	[account_start_date] datetime2(0),
	[account_end_date] datetime2(0),
	[is_member] bit
	)
	WITH (
	LOCATION = 'rider.csv',
	DATA_SOURCE = [file_haoptm_dfs_core_windows_net],
	FILE_FORMAT = [SynapseDelimitedTextFormat]
	)
GO


SELECT TOP 100 * FROM dbo.rider_ex
GO
