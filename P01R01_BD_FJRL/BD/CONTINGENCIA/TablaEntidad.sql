USE GenAgo
GO

CREATE TABLE Entidad(
	idEntidad INT PRIMARY KEY IDENTITY (1,1),
	ProductosID INT FOREIGN KEY REFERENCES Productos(ProductosID),
	DetallePedido INT FOREIGN KEY REFERENCES DetallesPedido(DetallePedido),
	PedidoID INT FOREIGN KEY REFERENCES Pedidos(PedidoID),
	ClienteID INT FOREIGN KEY REFERENCES Clientes(ClienteID),
)