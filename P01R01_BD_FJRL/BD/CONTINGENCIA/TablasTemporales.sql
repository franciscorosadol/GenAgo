USE GenAgo
GO

--TABLAS FISICAS
--tblPersonal


--TABLAS TEMPORALES
--Temporary tables
--Esta vive durante el tiempo de sesión hasta que cerramos el servidor

CREATE TABLE #users(
	nombre varchar(10),
	clave varchar(10),
	PRIMARY KEY(nombre)
)

SELECT * FROM #users;

INSERT INTO #users VALUES ('NEK', '123');

--TABLA TIPO VARIABLE
--ESTA VIVE EN EL TIEMPO DE EJECUCIÓN DEL SCRIPT

DECLARE
	@TABLA1 TABLE(
		ID INT,
		NOMBRE VARCHAR,
		TELEFONO NUMERIC(10)
	);

INSERT INTO @TABLA1 VALUES (1, 'J', 123);

SELECT * FROM @TABLA1;