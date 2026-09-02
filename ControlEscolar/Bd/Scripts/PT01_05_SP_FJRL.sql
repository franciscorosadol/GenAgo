USE Control_Escolar
GO

CREATE OR ALTER PROCEDURE spConsulta (@Matricula INT, @nombre VARCHAR(50))
AS
SELECT nombre FROM Alumno;
GO