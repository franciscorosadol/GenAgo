use GenAgo
go

/*
PO1R01_BD_FJRL
AUTOR: FRANCISCO JAVIER ROSADO LARA
FECHA: 12/08/2026
*/

--    ==================================================================
--    CONSULTAS GENERALES
--    ==================================================================

--    =======================
--    Consulta Productos alias P
--    =======================
Select TOP 10 * from  Productos AS P
where Nombre LIKE '%CAF%' ORDER BY 4

--    =======================
--    Consulta Clientes alias C
--    =======================
Select TOP 10 * from  Clientes AS C
where Nombre LIKE '%Jua%'

--    =======================
--    Consulta Pedidos alias PD
--    =======================
Select TOP 10 * from  Pedidos AS P
where Estado LIKE '%Completado%'

--    =======================
--    JOINS
--    Obtener todos los pedidos del cliente
--    =======================
Select
 c.Nombre As Cliente,
 p.pedidoID,
 p.Fecha,
 p.Total,
 p.Estado
 From Clientes As c
 Inner Join Pedidos As p
 on c.ClienteID = p.ClienteID
 order by p.Fecha desc;


--    =======================
--    Left JOIN
--    Obtener todos los pedidos del cliente
--    =======================
 select
 c.Nombre as Cliente,
 p.PedidoID,
 p.Fecha,
 p.Total,
 p.Estado
 From Clientes As c
 Left Join Pedidos As p
 on c.ClienteID = p.ClienteID
 order by p.Fecha desc;


--    =======================
--    Left JOIN
--    Obtener todos los pedidos del cliente
--    =======================
 select
 c.Nombre As Cliente,
 count(p.pedidoID) AS TotalPedidos,
 ISNULL(SUM(p.Total),0) AS TotalGastado
 From Clientes c
 LEFT JOIN Pedidos As p
 On c.ClienteID = p.ClienteID
 group by c.ClienteID, c.Nombre;

 ----aqui falta la de la foto que tomamos


 ---vistas
 select * from VWVistaResumenVentas
 where TotalPedidos > 0
 order by MontoTotal desc;

 --sp
 --Ejecutar el procedimiento:
 EXEC spObtenerClientePorID @ClienteID = 1;

 --Ejecutar:
 Declare @IDNuevo INT;
 EXEC spInsertarPedido
	@ClienteID = 1,
	@Total = 1500.00,
	@NuevoPedidoID = @IDNuevo OUTPUT;
Print 'Pedido creado con ID: '+ CAST(@IDNuevo AS NVARCHAR)


--Auditoria del Trigger
Select * from AuditoriaProductos

update Productos SET Precio = 240 WHERE ProductosID=3


 --sp
 --Ejecutar el SP contenido de tablas:
 EXEC dbo.spConsultarContenidoTablas;

 --Consultar las tablas
 SELECT TOP 10 * FROM AuditoriaProductos AS P
 SELECT TOP 10 * FROM DetallesPedido AS P
 SELECT TOP 10 * FROM Pedidos AS P
 SELECT TOP 10 * FROM Productos AS P
 SELECT TOP 10 * FROM Clientes AS P

 --Para sacar el diccionario de datos
 --HELP_TABLE Productos
USE GenAgo;
GO
--EXEC sp_help 'dbo.Productos';
--EXEC sp_help 'dbo.Clientes';
--EXEC sp_help 'dbo.Pedidos';
--EXEC sp_help 'dbo.DetallesPedido';
EXEC sp_help 'dbo.AuditoriaProductos';