USE msdb
GO

IF NOT EXISTS (SELECT 1 FROM dbo.sysjobs WHERE name = 'jExecSPContenidoTablas')
BEGIN

/*
PO1R01_BD_FJRL
AUTOR: FRANCISCO JAVIER ROSADO LARA
FECHA: 13/08/2026
*/

EXEC dbo.sp_add_job
	@job_name = N'jExecSPContenidoTablas', --Hacer el Job
	@enabled = 1,
	@description = N'ejecuta el sp cada 5 minutos'

--2. Crear el step
EXEC dbo.sp_add_jobstep
	@job_name = N'jExecSPContenidoTablas',
	@step_name = N'Ejecutar_Mi_SP',
	@subsystem = N'TSQL',
	@COMMAND = N'EXEC dbo.spConsultarContenidoTablas;',
	@database_name = N'GenAgo'

--.3 Crear el Schedule
EXEC dbo.sp_add_schedule
	--@job_name = N'jExecSP', --Nombre del Job
	--@name = N'RespaldoCadaHora', --Nombre de la programación
	@schedule_name = N'Schedule_Cada5Min',
	--@enabled = 1, --Habilitar la programación
	@freq_type = 4, --Frecuencia diaria
	@freq_interval = 1, --Ejecutar todos los días
	@freq_subday_type = 4, --Frecuencia de horas
	@freq_subday_interval = 5, --Frecuencia de cada 5 minutos
	@active_start_time = 000000, --Hora de inicio (Formato HHMMSS), empieza a medianoche
	@active_end_time = 235959

--4. Agregar el job al servidor
EXEC dbo.sp_attach_schedule
	@job_name = N'jExecSPContenidoTablas',
	@schedule_name = N'Schedule_Cada5Min'

--5. Agregar el job al server para que el sql server agent lo ejecute
EXEC dbo.sp_add_jobserver
	@job_name = N'jExecSPContenidoTablas',
	@server_name = N'(LOCAL)' --Cambia ''

END
GO