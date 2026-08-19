/*
PO1R01_BD_FJRL
AUTOR: FRANCISCO JAVIER ROSADO LARA
FECHA: 11/08/2026
*/

--    ==================================================================
--    INITIAL CHARGE(CARGA INICIAL)
--    ==================================================================


--    =======================
--    Tabla Productos
--    =======================
Use GenAgo
Insert into Productos (Nombre, Categoria, Precio, Stock)
	values
		('café Americano', 'bebidas', 35.00, 100),
		('Cappuccino', 'bebidas', 45.00, 100),
		('Croissant', 'Panaderia', 25.00, 50);

Go

--    =======================
--    Tabla Clientes
--    =======================
Insert into Clientes (Nombre, Email, Telefono)
	values
		('Juan Pérez', 'juan@email.com', '2441504731'),
		('Pamela', 'pamela@email.com', '6669996661');
Go

--    =======================
--    Tabla Pedidos
--    =======================
Insert into Pedidos (ClienteID, Total, Estado)
	values
		(1, 125.50, 'Completado');
Go