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
		--Validacioes - ELiminar en orden inverso de dependencias
		--Tabla: Detalles pedidos (Tiene dos FK a pedidos y productos)
		IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'DetallesPedido' 
			AND TABLE_SCHEMA = 'dbo')
			BEGIN
			DROP TABLE dbo.DetallesPedido;
			PRINT 'Tabla DetallesPedido eliminada correctamente';
			END
			COMMIT TRANSACTION;--Confirmar cambios
		END TRY
		BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;
			THROW;
		END CATCH
	GO



BEGIN TRANSACTION;
	BEGIN TRY
	--Validacioes - ELiminar en orden inverso de dependencias
	--Tabla: Detalles pedidos (Tiene dos FK a pedidos y productos)
		IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'AuditoriaProductos' 
		AND TABLE_SCHEMA = 'dbo')
		BEGIN
			DROP TABLE dbo.AuditoriaProductos;
			PRINT 'Tabla AuditoriaProductos eliminada correctamente';
			END
			COMMIT TRANSACTION;--Confirmar cambios
		END TRY
		BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;
			THROW;
	END CATCH
GO






BEGIN TRANSACTION;
	BEGIN TRY
		--Validacioes - ELiminar en orden inverso de dependencias
		IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Pedidos' 
		AND TABLE_SCHEMA = 'dbo')
		BEGIN
			DROP TABLE dbo.Pedidos;
			PRINT 'Tabla Pedidos eliminada correctamente';
			END
			COMMIT TRANSACTION;--Confirmar cambios
		END TRY
		BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;
			THROW;
		END CATCH
	GO




BEGIN TRANSACTION;
	BEGIN TRY
		--Validacioes - ELiminar en orden inverso de dependencias
		IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Clientes' 
		AND TABLE_SCHEMA = 'dbo')
		BEGIN
			DROP TABLE dbo.Clientes;
			PRINT 'Tabla Clientes eliminada correctamente';
			END
			COMMIT TRANSACTION;--Confirmar cambios
		END TRY
		BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;
			THROW;
		END CATCH
	GO







BEGIN TRANSACTION;
	BEGIN TRY
		--Validacioes - ELiminar en orden inverso de dependencias
		IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Productos' 
		AND TABLE_SCHEMA = 'dbo')
		BEGIN
			DROP TABLE dbo.Productos;
			PRINT 'Tabla Productos eliminada correctamente';
			END
			COMMIT TRANSACTION;--Confirmar cambios
		END TRY
		BEGIN CATCH
			IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;
			THROW;
		END CATCH
	GO