USE GenAgo
GO

/*
PO1R01_BD_FJRL
AUTOR: FRANCISCO JAVIER ROSADO LARA
FECHA: 13/08/2026
*/

--COMMIT Y ROLLBACK
BEGIN TRANSACTION;
	BEGIN TRY
		--VALIDACIONES
		IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'DetallesPedido'
					AND TABLE_SCHEMA = 'dbo')
				BEGIN
					--ELIMINAR:Datos de DetallePedido

					DELETE FROM dbo.DetallesPedido;

					PRINT 'Datos de la tabla DetallesPedido eliminados correctamente.';
				END
			ELSE
				BEGIN
					PRINT 'La tabla [dbo].[DetallesPedido] no existe.'
				END
			COMMIT TRANSACTION;
		END TRY
		BEGIN CATCH
			IF @@TRANCOUNT > 0
				ROLLBACK TRANSACTION;
			THROW;
		END CATCH
	GO

	--Tabla Productos
BEGIN TRANSACTION;
	BEGIN TRY
		--VALIDACIONES
		IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Productos'
					AND TABLE_SCHEMA = 'dbo')
				BEGIN
					--ELIMINAR:Datos de DetallePedido

					DELETE FROM dbo.Productos;

					PRINT 'Datos de la tabla Productos eliminados correctamente.';
				END
			ELSE
				BEGIN
					PRINT 'La tabla [dbo].[Productos] no existe.'
				END
			COMMIT TRANSACTION;
		END TRY
		BEGIN CATCH
			IF @@TRANCOUNT > 0
				ROLLBACK TRANSACTION;
			THROW;
		END CATCH
	GO
	
	--Tabla Clientes
BEGIN TRANSACTION;
	BEGIN TRY
		--VALIDACIONES
		IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Clientes'
					AND TABLE_SCHEMA = 'dbo')
				BEGIN
					--ELIMINAR:Datos de DetallePedido

					DELETE FROM dbo.Clientes;

					PRINT 'Datos de la tabla Clientes eliminados correctamente.';
				END
			ELSE
				BEGIN
					PRINT 'La tabla [dbo].[Clientes] no existe.'
				END
			COMMIT TRANSACTION;
		END TRY
		BEGIN CATCH
			IF @@TRANCOUNT > 0
				ROLLBACK TRANSACTION;
			THROW;
		END CATCH
	GO

	--Tabla Pedidos
BEGIN TRANSACTION;
	BEGIN TRY
		--VALIDACIONES
		IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Pedidos'
					AND TABLE_SCHEMA = 'dbo')
				BEGIN
					--ELIMINAR:Datos de DetallePedido

					DELETE FROM dbo.Pedidos;

					PRINT 'Datos de la tabla Pedidos eliminados correctamente.';
				END
			ELSE
				BEGIN
					PRINT 'La tabla [dbo].[Pedidos] no existe.'
				END
			COMMIT TRANSACTION;
		END TRY
		BEGIN CATCH
			IF @@TRANCOUNT > 0
				ROLLBACK TRANSACTION;
			THROW;
		END CATCH
	GO