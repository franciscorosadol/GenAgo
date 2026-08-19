USE GenAgo
GO
/*
PO1R01_BD_FJRL
AUTOR: FRANCISCO JAVIER ROSADO LARA
FECHA: 11/08/2026
*/

--    ==================================================================
--    CREACIÓN DE TABLAS
--    ==================================================================

--- ======================
--- Tabla Productos
--- ======================
--Commit y Rollback
Begin Transaction;
	begin try
--Validaciones
		If NOT EXISTS (select 1 from INFORMATION_SCHEMA.TABLES where TABLE_NAME = 'Productos'
		and TABLE_SCHEMA = 'dbo')
		BEGIN
		CREATE TABLE Productos(
		ProductosID INT PRIMARY KEY IDENTITY(1,1),
		Nombre NVARCHAR (100) NOT NULL,
		Categoria NVARCHAR (50) NOT NULL,
		Precio DECIMAL (10,2) NOT NULL,
		Stock INT DEFAULT 0,
		FechaCreacion DATETIME DEFAULT GETDATE()
		)
		Print 'Tabla: Productos creada correctamente';
	End
	Else
	Begin
	Print 'La tabla [dbo].[Productos] ya existe.'
	End
	Commit Transaction ; --Confirmar cambios
	END TRY
	BEGIN CATCH
	If @@TRANCOUNT > 0
	Rollback Transaction;
	Throw;
	End Catch
	Go


	--- ======================
--- Tabla Clientes
--- ======================
--Commit y Rollback
Begin Transaction;
	begin try
--Validaciones
		If NOT EXISTS (select 1 from INFORMATION_SCHEMA.TABLES where TABLE_NAME = 'Clientes'
		and TABLE_SCHEMA = 'dbo')
		BEGIN
		CREATE TABLE Clientes(
		ClienteID INT PRIMARY KEY IDENTITY(1,1),
		Nombre NVARCHAR (100) NOT NULL,
		Email NVARCHAR (100),
		Telefono NVARCHAR (15),
		)
		Print 'Tabla: Clientes creada correctamente';
	End
	Else
	Begin
	Print 'La tabla [dbo].[Clientes] ya existe.'
	End
	Commit Transaction ; --Confirmar cambios
	END TRY
	BEGIN CATCH
	If @@TRANCOUNT > 0
	Rollback Transaction;
	Throw;
	End Catch
	Go



--- ======================
--- Tabla Pedidos
--- ======================
--Commit y Rollback
Begin Transaction;
	begin try
--Validaciones
		If NOT EXISTS (select 1 from INFORMATION_SCHEMA.TABLES where TABLE_NAME = 'Pedidos'
		and TABLE_SCHEMA = 'dbo')
		BEGIN
		CREATE TABLE Pedidos(
		PedidoID INT PRIMARY KEY IDENTITY(1,1),
		ClienteID INT FOREIGN KEY REFERENCES Clientes(ClienteID),
		Fecha DATETIME DEFAULT GETDATE(),
		Total DECIMAL (10,2) NOT NULL,
		Estado NVARCHAR(20) DEFAULT 'Pendiente'
		);
		Print 'Tabla: Pedidos creada correctamente';
	End
	Else
	Begin
	Print 'La tabla [dbo].[Pedidos] ya existe.'
	End
	Commit Transaction ; --Confirmar cambios
	END TRY
	BEGIN CATCH
	If @@TRANCOUNT > 0
	Rollback Transaction;
	Throw;
	End Catch
	Go



--- ======================
--- Tabla DetallesPedido
--- ======================
--Commit y Rollback
Begin Transaction;
	begin try
--Validaciones
		If NOT EXISTS (select 1 from INFORMATION_SCHEMA.TABLES where TABLE_NAME = 'DetallesPedido'
		and TABLE_SCHEMA = 'dbo')
		BEGIN
		CREATE TABLE DetallesPedido(
		DetallePedido INT PRIMARY KEY IDENTITY(1,1),
		PedidoID INT FOREIGN KEY REFERENCES Pedidos(PedidoID),
		ProductoID INT FOREIGN KEY REFERENCES Productos(ProductosID),
		Cantidad INT NOT NULL,
		PrecioUnitario DECIMAL(10,2) NOT NULL);
		Print 'Tabla: DetallesPedido creada correctamente';
	End
	Else
	Begin
	Print 'La tabla [dbo].[DetallesPedido] ya existe.'
	End
	Commit Transaction ; --Confirmar cambios
	END TRY
	BEGIN CATCH
	If @@TRANCOUNT > 0
	Rollback Transaction;
	Throw;
	End Catch
	Go



--- ======================
--- Creacion de Triggers
--- ======================
--Commit y Rollback
Begin Transaction;
	begin try
--Validaciones
		If NOT EXISTS (select 1 from INFORMATION_SCHEMA.TABLES where TABLE_NAME = 'AuditoriaProductos'
		and TABLE_SCHEMA = 'dbo')
		BEGIN
			CREATE TABLE AuditoriaProductos(
				AuditoriaID INT PRIMARY KEY IDENTITY(1,1),
				ProductoID INT,
				Accion NVARCHAR(20),
				PrecioAnterior DECIMAL(10,2),
				PrecioNuevo DECIMAL(10,2),
				Usuario NVARCHAR(100),
				Fecha DATETIME DEFAULT GETDATE()
				);
			Print 'Tabla: AuditoriaProductos creada correctamente';
		End
	Else
		Begin
			Print 'La tabla [dbo].[AuditoriaProductos] ya existe.'
		End
	Commit Transaction ; --Confirmar cambios
	END TRY
	BEGIN CATCH
	If @@TRANCOUNT > 0
	Rollback Transaction;
	Throw;
	End Catch
	Go