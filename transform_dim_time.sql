--Create dim_time table
IF OBJECT_ID('dbo.dim_time') IS NOT NULL
BEGIN
    DROP EXTERNAL TABLE dbo.dim_time;
END

DECLARE @StartDate DATETIME
DECLARE @EndDate DATETIME
SET @StartDate = (SELECT MIN(start_station_id) FROM trip_ex)
SET @EndDate = DATEADD(year, 5, (SELECT MAX(start_station_id) FROM trip_ex))

-- Create dim_time table
CREATE EXTERNAL TABLE dim_time 
(
	[date] [varchar](50)  NULL,
    [day_of_the_week] int,
    [day_of_the_month] int,
	[quarter] int,
	[month] int,
	[year] int
)
WITH
(
    LOCATION     = 'dim_time',
    DATA_SOURCE = [file_haoptm_dfs_core_windows_net],
    FILE_FORMAT = [SynapseDelimitedTextFormat]
)

WHILE @StartDate <= @EndDate
    BEGIN
        INSERT INTO dbo.[dim_time]
        SELECT
            @StartDate,
            DATEPART(WEEKDAY, @StartDate),
            DATEPART(DAY, @StartDate),
            DATEPART(QUARTER, @StartDate),
            DATEPART(MONTH, @StartDate),
            DATEPART(YEAR, @StartDate)

        SET @StartDate = DATEADD(day, 1, @StartDate)
    END;
 

-- Verify the output
SELECT TOP 10 * FROM [dbo].[dim_time];
