USE Control_Escolar
GO


CREATE TABLE dbo.Alumno(
	Matricula INT IDENTITY(1,1) PRIMARY KEY,
	nombre VARCHAR(50) NOT NULL,
	direccion VARCHAR(50) NOT NULL,
	apellidoPaterno VARCHAR(50) NOT NULL,
	apellidoMaterno VARCHAR(50) NOT NULL,
	correo VARCHAR(50) NOT NULL,
	telefono VARCHAR(50) NOT NULL
);


GO