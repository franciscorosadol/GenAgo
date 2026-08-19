USE GenAgo
GO

/*
PO1R01_BD_FJRL
AUTOR: FRANCISCO JAVIER ROSADO LARA
FECHA: 11/08/2026
*/
--==================================================================
--Creación de Vistas
--==================================================================
--    =======================
--    Vista Resumen de ventas
--    =======================
CREATE
	OR

ALTER VIEW VWVistaResumenVentas
AS
SELECT c.ClienteID
	,c.Nombre AS Cliente
	,c.Email
	,Count(p.pedidoID) AS TotalPedidos
	,ISNULL(SUM(p.Total), 0) AS MontoTotal
	,MAX(p.fecha) AS UltimaCompra
FROM Clientes c
LEFT JOIN Pedidos p ON c.ClienteID = p.ClienteID
GROUP BY c.ClienteID
	,c.Nombre
	,c.Email;
GO

