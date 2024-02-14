--Create dim_time table
IF OBJECT_ID('dbo.dim_time') IS NOT NULL
BEGIN
    DROP EXTERNAL TABLE dbo.dim_time;
END

-- Create dim_time table
CREATE EXTERNAL TABLE dim_time (
	[date] [varchar](50)  NULL,
    	[day_of_the_week] int,
    	[day_of_the_month] int,
	[quarter] int,
	[month] int,
	[year] int);

-- Add constraint
ALTER TABLE dbo.dim_time add CONSTRAINT PK_dim_time_time_id PRIMARY KEY NONCLUSTERED (time_id) NOT ENFORCED;

DECLARE @StartDate DATETIME
DECLARE @EndDate DATETIME
SET @StartDate = (SELECT MIN(TRY_CONVERT(datetime, left(start_at, 19))) FROM staging_trip)
SET @EndDate = DATEADD(year, 5, (SELECT MAX(TRY_CONVERT(datetime, left(start_at, 19))) FROM staging_trip))

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
