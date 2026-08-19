USE GenAgo
GO

/*
PO1R01_BD_FJRL
AUTOR: FRANCISCO JAVIER ROSADO LARA
FECHA: 13/08/2026
*/

--==================================================================
--Creación de Vistas
--==================================================================

--Commit y rollback

BEGIN TRANSACTION;
	BEGIN TRY
		--VALIDACIONES
		IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME = 'VWVistaResumenVentas'
					AND TABLE_SCHEMA = 'dbo')
			BEGIN
				--ELIMINAR: Vista VWVistaResumenVentas

				DROP VIEW dbo.VWVistaResumenVentas;

				PRINT 'Vista VWVistaResumenVentas eliminada correctamente.';
			END
		ELSE
			BEGIN
				PRINT 'La vista [dbo].[VWVistaResumenVentas] no existe.'
			END
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;
		THROW;
	END CATCH
GO