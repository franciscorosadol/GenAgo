USE GenAgo
GO

/*
PO1R01_BD_FJRL
AUTOR: FRANCISCO JAVIER ROSADO LARA
FECHA: 13/08/2026
*/
--==============================
--Contingencia de SP
--==============================

BEGIN TRANSACTION;
	BEGIN TRY
	--VALIDACIONES
	IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME = 'spOtenerClientePorID'
				AND ROUTINE_SCHEMA = 'dbo')
		BEGIN
		--ELIMINAR: Procedimiento spOtenerClientePorID
		DROP PROCEDURE dbo.spOtenerClientePorID;

		PRINT 'Proecedimiento spOtenerClientePorID eliminado correctamente.';
	END
ELSE
	BEGIN
		PRINT 'El procedimiento [dbo].[spOtenerClientePorID] no existe.'
	END
COMMIT TRANSACTION;--CONFRIMAR CAMBIOS
END TRY
BEGIN CATCH
	IF @@TRANCOUNT > 0
		ROLLBACK TRANSACTION;
	THROW;
END CATCH
GO


BEGIN TRANSACTION;
	BEGIN TRY
	--VALIDACIONES
	IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME = 'spConsultarContenidoTablas'
				AND ROUTINE_SCHEMA = 'dbo')
		BEGIN
		--ELIMINAR: Procedimiento spConsultarContenidoTablas
		DROP PROCEDURE dbo.spConsultarContenidoTablas;

		PRINT 'Proecedimiento spConsultarContenidoTablas eliminado correctamente.';
	END
ELSE
	BEGIN
		PRINT 'El procedimiento [dbo].[spConsultarContenidoTablas] no existe.'
	END
COMMIT TRANSACTION;--CONFRIMAR CAMBIOS
END TRY
BEGIN CATCH
	IF @@TRANCOUNT > 0
		ROLLBACK TRANSACTION;
	THROW;
END CATCH
GO