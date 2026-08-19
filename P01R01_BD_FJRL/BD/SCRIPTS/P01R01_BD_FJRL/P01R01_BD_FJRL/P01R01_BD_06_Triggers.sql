Use GenAgo
Go
/*
PO1R01_BD_FJRL
AUTOR: FRANCISCO JAVIER ROSADO LARA
FECHA: 12/08/2026
*/

--    ==================================================================
--    Creación Trigger
--    ==================================================================
CREATE OR ALTER TRIGGER TR_Auditoria_After_Insert
ON Productos
AFTER INSERT
AS
BEGIN

    INSERT INTO AuditoriaProductos
    (
        ProductoID,
        Accion,
        PrecioAnterior,
        PrecioNuevo,
        Usuario
    )
    SELECT
        i.ProductosID,
        'INSERT',
        NULL,
        i.Precio,
        SYSTEM_USER
    FROM inserted i;

END;
GO


-- BEFORE INSERT (SQL Server = INSTEAD OF INSERT)

CREATE OR ALTER TRIGGER TR_Auditoria_Instead_Insert
ON Productos
INSTEAD OF INSERT
AS
BEGIN

    INSERT INTO AuditoriaProductos
    (
        ProductoID,
        Accion,
        PrecioAnterior,
        PrecioNuevo,
        Usuario
    )
    SELECT
        ProductosID,
        'INSERT',
        NULL,
        Precio,
        SYSTEM_USER
    FROM inserted;

    INSERT INTO Productos(ProductosID, Nombre, Precio)
    SELECT ProductosID, Nombre, Precio
    FROM inserted;

END;
GO


CREATE OR ALTER TRIGGER TR_Auditoria_After_Update
ON Productos
AFTER UPDATE
AS
BEGIN

    INSERT INTO AuditoriaProductos
    (
        ProductoID,
        Accion,
        PrecioAnterior,
        PrecioNuevo,
        Usuario
    )
    SELECT
        d.ProductosID,
        'UPDATE',
        d.Precio,
        i.Precio,
        SYSTEM_USER
    FROM deleted d
    INNER JOIN inserted i
        ON d.ProductosID = i.ProductosID;

END;
GO


-- BEFORE UPDATE (SQL Server = INSTEAD OF UPDATE)

CREATE OR ALTER TRIGGER TR_Auditoria_Instead_Update
ON Productos
INSTEAD OF UPDATE
AS
BEGIN

    INSERT INTO AuditoriaProductos
    (
        ProductoID,
        Accion,
        PrecioAnterior,
        PrecioNuevo,
        Usuario
    )
    SELECT
        d.ProductosID,
        'UPDATE',
        d.Precio,
        i.Precio,
        SYSTEM_USER
    FROM deleted d
    INNER JOIN inserted i
        ON d.ProductosID = i.ProductosID;

    UPDATE p
    SET
        p.Nombre = i.Nombre,
        p.Precio = i.Precio
    FROM Productos p
    INNER JOIN inserted i
        ON p.ProductosID = i.ProductosID;

END;
GO


CREATE OR ALTER TRIGGER TR_Auditoria_After_Delete
ON Productos
AFTER DELETE
AS
BEGIN

    INSERT INTO AuditoriaProductos
    (
        ProductoID,
        Accion,
        PrecioAnterior,
        PrecioNuevo,
        Usuario
    )
    SELECT
        d.ProductosID,
        'DELETE',
        d.Precio,
        NULL,
        SYSTEM_USER
    FROM deleted d;

END;
GO


-- BEFORE DELETE (SQL Server = INSTEAD OF DELETE)

CREATE OR ALTER TRIGGER TR_Auditoria_Instead_Delete
ON Productos
INSTEAD OF DELETE
AS
BEGIN

    INSERT INTO AuditoriaProductos
    (
        ProductoID,
        Accion,
        PrecioAnterior,
        PrecioNuevo,
        Usuario
    )
    SELECT
        ProductosID,
        'DELETE',
        Precio,
        NULL,
        SYSTEM_USER
    FROM deleted;

    DELETE p
    FROM Productos p
    INNER JOIN deleted d
        ON p.ProductosID = d.ProductosID;

END;
GO