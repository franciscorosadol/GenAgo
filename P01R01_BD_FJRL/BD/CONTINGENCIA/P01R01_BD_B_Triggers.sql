USE GenAgo
GO

/*
PO1R01_BD_FJRL
AUTOR: FRANCISCO JAVIER ROSADO LARA
FECHA: 13/08/2026
*/

--==============================
--Contingencia de Triggers
--==============================


--Trigger TR_AuditarCambioPrecio
BEGIN TRANSACTION;
	
BEGIN TRY

	--VALIDACIONES
	IF EXISTS(
		SELECT 1
		FROM sys.objects
		WHERE name = 'TR_AuditarCambioPrecio'
			AND type = 'TR'
			AND SCHEMA_NAME(schema_id) = 'dbo'
	)
	BEGIN
		--ELIMINAR: Trigger TR_AuditarCambioPrecio
		DROP TRIGGER dbo.TR_AuditarCambioPrecio;

		PRINT 'Trigger TR_AuditarCambioPrecio eliminado correctamente.';
	END
ELSE
	BEGIN
		PRINT 'El trigger [dbo].[TR_AuditarCambioPrecio] no existe.'
	END

	COMMIT TRANSACTION;

END TRY
BEGIN CATCH
	IF @@TRANCOUNT > 0
		ROLLBACK TRANSACTION;
	THROW;
	END CATCH
GO


--Trigger TR_Auditoria_After_Insert
BEGIN TRANSACTION;
	
BEGIN TRY

	--VALIDACIONES
	IF EXISTS(
		SELECT 1
		FROM sys.objects
		WHERE name = 'TR_Auditoria_After_Insert'
			AND type = 'TR'
			AND SCHEMA_NAME(schema_id) = 'dbo'
	)
	BEGIN
		--ELIMINAR: Trigger TR_Auditoria_After_Insert
		DROP TRIGGER dbo.TR_Auditoria_After_Insert;

		PRINT 'Trigger TR_Auditoria_After_Insert eliminado correctamente.';
	END
ELSE
	BEGIN
		PRINT 'El trigger [dbo].[TR_Auditoria_After_Insert] no existe.'
	END

	COMMIT TRANSACTION;

END TRY
BEGIN CATCH
	IF @@TRANCOUNT > 0
		ROLLBACK TRANSACTION;
	THROW;
	END CATCH
GO


--Trigger TR_Auditoria_After_Delete
BEGIN TRANSACTION;
	
BEGIN TRY

	--VALIDACIONES
	IF EXISTS(
		SELECT 1
		FROM sys.objects
		WHERE name = 'TR_Auditoria_After_Delete'
			AND type = 'TR'
			AND SCHEMA_NAME(schema_id) = 'dbo'
	)
	BEGIN
		--ELIMINAR: Trigger TR_Auditoria_After_Delete
		DROP TRIGGER dbo.TR_Auditoria_After_Delete;

		PRINT 'Trigger TR_Auditoria_After_Delete eliminado correctamente.';
	END
ELSE
	BEGIN
		PRINT 'El trigger [dbo].[TR_Auditoria_After_Delete] no existe.'
	END

	COMMIT TRANSACTION;

END TRY
BEGIN CATCH
	IF @@TRANCOUNT > 0
		ROLLBACK TRANSACTION;
	THROW;
	END CATCH
GO