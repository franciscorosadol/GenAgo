/*
PO1R01_BD_FJRL
AUTOR: FRANCISCO JAVIER ROSADO LARA
FECHA: 11/08/2026
*/

--    ==================================================================
--    CREACIÓN DE LA BASE DE DATOS
--    ==================================================================

IF NOT EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'GenAgo')
	BEGIN
		CREATE DATABASE GenAgo;
		Print 'Base de datos GenAgo creada correctamente.';
	END
		ELSE
	BEGIN
		PRINT 'LA BASE DE DATOS GENAGO YA EXISTE.';
	END
GO