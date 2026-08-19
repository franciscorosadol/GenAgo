USE GenAgo
GO
/*
PO1R01_BD_FJRL
AUTOR: FRANCISCO JAVIER ROSADO LARA
FECHA: 13/08/2026
*/

--    ==================================================================
--    Creación SP'S
--    ==================================================================


--    =======================
--    Obtener cliente
--    =======================

CREATE OR ALTER PROCEDURE spObtenerClientePorID @ClienteID INT
AS
BEGIN
	SELECT ClienteID
		,Nombre
		,Email
		,Telefono
	FROM Clientes
	WHERE ClienteID = @ClienteID;
END;
GO

--    =======================
--    SP Insertar Pedido
--    =======================
CREATE
	OR

ALTER PROCEDURE spInsertarPedido @ClienteID INT
	,@Total DECIMAL(10, 2)
	,@Estado NVARCHAR(20) = 'Pendiente'
	,@NuevoPedidoID INT OUTPUT
AS
BEGIN
	INSERT INTO Pedidos (
		ClienteID
		,Total
		,Estado
		,Fecha
		)
	VALUES (
		@ClienteID
		,@Total
		,@Estado
		,GETDATE()
		);

	--Obtener el ID del pedido recien creado
	SET @NuevoPedidoID = SCOPE_IDENTITY();

	SELECT @NuevoPedidoID AS PedidoCreado;
END;
GO

--    =================================
--    SP Consultar las tablas de la BD
--    =================================
CREATE
	OR

ALTER PROCEDURE dbo.spConsultarContenidoTablas
AS
BEGIN
	SET NOCOUNT ON;

	-- Cada SELECT trae el contenido completo de una tabla; se muestran como resultsets separados
	SELECT *
	FROM dbo.Productos;

	SELECT *
	FROM dbo.Clientes;

	SELECT *
	FROM dbo.Pedidos;

	SELECT *
	FROM dbo.DetallesPedido;

	SELECT *
	FROM dbo.AuditoriaProductos;
END
GO

