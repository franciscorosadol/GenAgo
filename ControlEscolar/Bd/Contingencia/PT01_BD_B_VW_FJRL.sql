USE Control_Escolar
GO

/*
Prueba tecnica
Autor: FJRL
Fecha: 1/09/2026
Views - Contingencia
*/

-- ==================================================
-- Contingencia VW
-- ==================================================

BEGIN TRANSACTION;

BEGIN TRY
	IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME = 'vwAlumno' AND TABLE_SCHEMA = 'dbo')
	BEGIN
		DROP VIEW dbo.vwAlumno;

		PRINT 'Vista vwAlumno eliminada.';
	END
	ELSE
	BEGIN
		PRINT '[dbo].[vwAlumno] no existe.'
	END

	COMMIT TRANSACTION;
END TRY

BEGIN CATCH
	IF @@TRANCOUNT > 0
		ROLLBACK TRANSACTION;

	THROW;
END CATCH
GO
