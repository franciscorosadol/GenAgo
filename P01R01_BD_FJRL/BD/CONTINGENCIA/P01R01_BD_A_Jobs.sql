USE msdb;
GO

IF EXISTS (SELECT 1 FROM dbo.sysjobs WHERE name = 'jExecSPConenidoTablas')
BEGIN

EXEC dbo.sp_delete_job
	@job_name = N'jExecSPConenidoTablas',
	@delete_unused_schedule = 1

PRINT 'Job y recursos asociados eliminados';

--Borrar duplicados

DECLARE @SCHEDULE_ID INT;
DECLARE cur CURSOR FOR
	SELECT SCHEDULE_ID FROM msdb.dbo.sysschedules WHERE name = N'Schedule_Cada5Min';
OPEN cur;
FETCH NEXT FROM cur INTO @SCHEDULE_ID;
WHILE @@FETCH_STATUS = 0
BEGIN
	EXEC dbo.sp_delete_schedule @SCHEDULE_ID = @SCHEDULE_ID,
	@FORCE_DELETE = 1
	FETCH NEXT FROM cur INTO @SCHEDULE_ID;

END
CLOSE cur
	DEALLOCATE cur;
	print 'Se borraron duplicates'

	END
GO