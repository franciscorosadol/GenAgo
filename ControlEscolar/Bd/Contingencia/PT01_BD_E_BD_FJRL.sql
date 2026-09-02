/*
Prueba tecnica
Autor: FJRL
Fecha: 1/09/2026
Database - Contingencia
*/

BEGIN TRY
	IF EXISTS (SELECT 1 FROM SYS.DATABASES WHERE name = 'Control_Escolar')
	BEGIN
		USE master;
		ALTER DATABASE Control_Escolar SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
		DROP DATABASE Control_Escolar;
		PRINT 'BD Control_Escolar eliminada';
	END
	ELSE
	BEGIN
		PRINT 'La BD [Control_Escolar] no existe.'
	END
END TRY
BEGIN CATCH
	IF EXISTS (SELECT 1 FROM SYS.DATABASES WHERE name = 'Control_Escolar')
		ALTER DATABASE Control_Escolar SET MULTI_USER;
	THROW;
END CATCH
GO
