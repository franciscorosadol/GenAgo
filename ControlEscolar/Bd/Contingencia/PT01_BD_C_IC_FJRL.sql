USE Control_Escolar
GO

/*
Prueba tecnica
Autor: FJRL
Fecha: 1/09/2026
Initial charge - Contingencia
*/

BEGIN TRANSACTION
BEGIN TRY
	--CONSULTAR Y VALIDAR
	IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Alumno' AND TABLE_SCHEMA = 'dbo')
	BEGIN
		--ELIMINAR
		DELETE FROM dbo.Alumno
		PRINT 'Datos de la tabla Alumno eliminados correctamente.'
	END
	ELSE
	BEGIN
		PRINT 'La tabla [dbo].[Alumno] no existe.'
	END

	COMMIT TRANSACTION;
END TRY
BEGIN CATCH
	IF @@TRANCOUNT > 0
		ROLLBACK TRANSACTION;
	THROW;
END CATCH
GO
