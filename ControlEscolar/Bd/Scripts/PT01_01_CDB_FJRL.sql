/*
Prueba tecnica
Autor: FJRL
Fecha: 1/09/2026
*/

IF NOT EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'Control_Escolar')
	BEGIN
		CREATE DATABASE Control_Escolar;
		Print 'Base de datos Control_Escolar creada correctamente.';
	END
		ELSE
	BEGIN
		PRINT 'LA BASE DE DATOS Control_Escolar YA EXISTE.';
	END
GO