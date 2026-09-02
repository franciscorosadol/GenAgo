USE Control_Escolar;
GO

SET IDENTITY_INSERT Alumno ON;

INSERT INTO Alumno (Matricula, nombre, direccion, apellidoPaterno, apellidoMaterno, correo, telefono)
VALUES 
('1', 'Fer', 'Xalapa', 'Fernandez', 'Hernandez', 'mail@mail', '2231870312'),
('2', 'Andrei', 'Acapulco', 'Gonzalez', 'Roa', 'correo@mail', '2231092374'),
('3', 'Adrian', 'Chiapas', 'Zamudio', 'Morat', 'email@mail', '2231653198');

SET IDENTITY_INSERT Alumno OFF;