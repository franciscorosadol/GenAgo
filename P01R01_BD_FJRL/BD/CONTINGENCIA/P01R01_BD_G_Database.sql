USE GenAgo
GO


--    =======================
--    Drop Database
--    =======================

BEGIN TRY
	--VALIDACIONES
	IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'GenAgo')
		BEGIN
			--Eliminar: Base de datos GenAgo
			USE master;

			ALTER DATABASE GenAgo SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
			DROP DATABASE GenAgo;

			PRINT 'Base de datos GenAgo eliminada correctamente.';
		END
	ELSE
		BEGIN
			PRINT 'La base de datos [GenAgo] no existe.'
		END
END TRY
BEGIN CATCH
	--INTENTAR RESTAURAR ACCESO MULTI-USUARIO
	IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'GenAgo')
		ALTER DATABASE GenAgo SET MULTI_USER;

	THROW;
END CATCH
GO