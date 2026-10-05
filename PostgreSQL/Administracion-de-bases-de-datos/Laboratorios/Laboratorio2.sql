-- Crear y usar la base de datos
USE master;
GO

IF NOT EXISTS (
    SELECT name
    FROM sys.databases
    WHERE name = N'DB_Ventas'
)
BEGIN
    CREATE DATABASE DB_Ventas;
END
GO

-- Crear tablas
IF OBJECT_ID('dbo.Orders', 'U') IS NOT NULL
    DROP TABLE dbo.Orders;

IF OBJECT_ID('dbo.Products', 'U') IS NOT NULL
    DROP TABLE dbo.Products;

IF OBJECT_ID('dbo.Suppliers', 'U') IS NOT NULL
    DROP TABLE dbo.Suppliers;

IF OBJECT_ID('dbo.Categories', 'U') IS NOT NULL
    DROP TABLE dbo.Categories;
GO

-- Crear tabla Categories
CREATE TABLE dbo.Categories (
    CategoryID INT PRIMARY KEY,
    CategoryName NVARCHAR(100) NOT NULL
);
GO

-- Crear tabla Suppliers
CREATE TABLE dbo.Suppliers (
    SupplierID INT PRIMARY KEY,
    CompanyName NVARCHAR(100) NOT NULL
);
GO

-- Crear tabla Products
CREATE TABLE dbo.Products (
    ProductID INT PRIMARY KEY,
    ProductName NVARCHAR(100) NOT NULL,
    SupplierID INT NOT NULL,
    CategoryID INT NOT NULL,
    QuantityPerUnit NVARCHAR(50),
    UnitPrice DECIMAL(10,2),
    UnitsInStock INT,
    Discontinued BIT NOT NULL DEFAULT 0,

    CONSTRAINT FK_Products_Suppliers
        FOREIGN KEY (SupplierID)
        REFERENCES dbo.Suppliers(SupplierID),

    CONSTRAINT FK_Products_Categories
        FOREIGN KEY (CategoryID)
        REFERENCES dbo.Categories(CategoryID)
);
GO

-- Crear tabla Orders
CREATE TABLE dbo.Orders (
    OrderID INT PRIMARY KEY,
    CustomerID NVARCHAR(20),
    OrderDate DATE
);
GO

-- Insertar categorías
INSERT INTO dbo.Categories (CategoryID, CategoryName)
VALUES
    (1, N'Bebidas'),
    (2, N'Condimentos'),
    (3, N'Repostería');
GO

-- Insertar proveedores
INSERT INTO dbo.Suppliers (SupplierID, CompanyName)
VALUES
    (1, N'Proveedor A'),
    (2, N'Proveedor B'),
    (3, N'Proveedor C');
GO

-- Insertar productos
INSERT INTO dbo.Products
    (ProductID, ProductName, SupplierID, CategoryID,
     QuantityPerUnit, UnitPrice, UnitsInStock, Discontinued)
VALUES
    (1, N'Producto 1', 1, 1, N'10 cajas', 18.00, 50, 0),
    (2, N'Producto 2', 1, 1, N'20 cajas', 25.00, 30, 0),
    (3, N'Producto 3', 2, 2, N'12 frascos', 45.00, 20, 0),
    (4, N'Producto 4', 2, 3, N'24 unidades', 60.00, 15, 0),
    (5, N'Producto 5', 3, 1, N'6 botellas', 75.00, 10, 0),
    (6, N'Producto 6', 3, 2, N'12 unidades', 90.00, 8, 0);
GO

-- Insertar órdenes
INSERT INTO dbo.Orders (OrderID, CustomerID, OrderDate)
VALUES
    (1, N'CUST001', '2026-01-10'),
    (2, N'CUST002', '2026-02-15');
GO

-- Ejrcicio 1, login y usuario de sofia

-- Crear login de Sofía
USE master;
GO

IF EXISTS (SELECT 1 FROM sys.server_principals WHERE name = N'g1_sofia')
    DROP LOGIN g1_sofia;
GO

CREATE LOGIN g1_sofia
WITH PASSWORD = 'UCA@2026',
     CHECK_POLICY = ON,
     CHECK_EXPIRATION = ON;
GO

-- Crear usuario en DB_Ventas
USE DB_Ventas;
GO

CREATE USER g1_sofia
FOR LOGIN g1_sofia;
GO

-- Crear rol del catálogo
CREATE ROLE g1_rol_catalogo;
GO

-- Dar permisos de consulta
GRANT SELECT ON dbo.Products
TO g1_rol_catalogo;

GRANT SELECT ON dbo.Categories
TO g1_rol_catalogo;

GRANT SELECT ON dbo.Suppliers
TO g1_rol_catalogo;
GO

-- Agregar a Sofía al rol
ALTER ROLE g1_rol_catalogo
ADD MEMBER g1_sofia;
GO

--probamos con el user de sofia
EXECUTE AS USER = 'g1_sofia';
GO

--hacemos la consulta de los primeros 5 mas caros
SELECT TOP 5
    p.ProductName,
    p.UnitPrice,
    c.CategoryName
FROM dbo.Products AS p
INNER JOIN dbo.Categories AS c
    ON p.CategoryID = c.CategoryID
ORDER BY p.UnitPrice DESC;
GO

-- Comprobamos que no tenga acceso a los Orders
BEGIN TRY
    SELECT *
    FROM dbo.Orders;
END TRY
BEGIN CATCH --Ahora si no se obtiene el acceso (como debe ser) 
    SELECT 'Sofia no tiene acceso a dbo.Orders' AS Resultado;
END CATCH;
GO

-- Regresamos al usuario original
REVERT;
GO

-- Ejercicio 2, precios con UPDATE por columna

-- Crear login de precios
USE master;
GO

IF EXISTS (SELECT 1 FROM sys.server_principals WHERE name = N'g1_precios')
    DROP LOGIN g1_precios;
GO

--creamos otro login para precios
CREATE LOGIN g1_precios
WITH PASSWORD = 'UCA@2026',
     CHECK_POLICY = ON,
     CHECK_EXPIRATION = ON;
GO

-- Crear usuario en DB_Ventas
USE DB_Ventas;
GO

--Creamos otro usuario relacionado al login
CREATE USER g1_precios
FOR LOGIN g1_precios;
GO

-- Crear rol de precios
CREATE ROLE g1_rol_precios;
GO

-- Agregar usuario al rol
ALTER ROLE g1_rol_precios
ADD MEMBER g1_precios;
GO

-- Dar SELECT sobre Products
GRANT SELECT ON dbo.Products
TO g1_rol_precios;
GO

-- Damos UPDATE solamente en dos columnas
GRANT UPDATE (UnitPrice, Discontinued)
ON dbo.Products
TO g1_rol_precios;
GO

-- Probamos permisos de precios
EXECUTE AS USER = 'g1_precios';
GO

BEGIN TRANSACTION;
GO

-- Aumentar 10% los precios de categoría 1
UPDATE dbo.Products
SET UnitPrice = UnitPrice * 1.10
WHERE CategoryID = 1;
GO

select * from Products;

-- Intentar modificar UnitsInStock
BEGIN TRY
    UPDATE dbo.Products
    SET UnitsInStock = 0
    WHERE ProductID = 1;
END TRY
BEGIN CATCH
    SELECT 'No tiene permiso para modificar UnitsInStock' AS Resultado;
END CATCH;
GO

-- Intentar eliminar producto
BEGIN TRY
    DELETE FROM dbo.Products
    WHERE ProductID = 1;
END TRY
BEGIN CATCH
    SELECT 'No tiene permiso para eliminar productos' AS Resultado;
END CATCH;
GO

-- Deshacer los cambios
ROLLBACK;
GO

REVERT;
GO

-- Ver permisos UPDATE por columna
EXECUTE AS USER = 'g1_precios';
GO

SELECT *
FROM fn_my_permissions('dbo.Products.UnitPrice', 'COLUMN')
WHERE permission_name = 'UPDATE';

SELECT *
FROM fn_my_permissions('dbo.Products.Discontinued', 'COLUMN')
WHERE permission_name = 'UPDATE';
GO

REVERT;
GO

-- Ejercicio 3 login para bodega

-- Crear login de bodega
USE master;
GO

IF EXISTS (SELECT 1 FROM sys.server_principals WHERE name = N'g1_app_bodega')
    DROP LOGIN g1_app_bodega;
GO

CREATE LOGIN g1_app_bodega
WITH PASSWORD = 'UCA@2026',
     CHECK_POLICY = ON,
     CHECK_EXPIRATION = OFF;
GO

-- Crear usuario en DB_Ventas
USE DB_Ventas;
GO

CREATE USER g1_app_bodega
FOR LOGIN g1_app_bodega;
GO

-- Crear rol de bodega
CREATE ROLE g1_rol_bodega;
GO

-- Agregar usuario al rol
ALTER ROLE g1_rol_bodega
ADD MEMBER g1_app_bodega;
GO

-- Dar permisos de consulta
GRANT SELECT ON dbo.Products
TO g1_rol_bodega;

GRANT SELECT ON dbo.Categories
TO g1_rol_bodega;
GO

-- Dar permisos de inserción y actualización
GRANT INSERT ON dbo.Products
TO g1_rol_bodega;

GRANT UPDATE ON dbo.Products
TO g1_rol_bodega;
GO

-- Bloquear DELETE y ALTER
DENY DELETE ON dbo.Products
TO g1_app_bodega;

DENY ALTER ON dbo.Products
TO g1_app_bodega;
GO

-- Simular error del administrador
ALTER ROLE db_datawriter
ADD MEMBER g1_app_bodega;
GO

-- Comprobar permisos de bodega
EXECUTE AS USER = 'g1_app_bodega';
GO

SELECT
    'dbo.Products' AS Objeto,
    HAS_PERMS_BY_NAME('dbo.Products', 'OBJECT', 'SELECT') AS [SELECT],
    HAS_PERMS_BY_NAME('dbo.Products', 'OBJECT', 'INSERT') AS [INSERT],
    HAS_PERMS_BY_NAME('dbo.Products', 'OBJECT', 'UPDATE') AS [UPDATE],
    HAS_PERMS_BY_NAME('dbo.Products', 'OBJECT', 'DELETE') AS [DELETE],
    HAS_PERMS_BY_NAME('dbo.Products', 'OBJECT', 'ALTER') AS [ALTER]

UNION ALL

SELECT
    'dbo.Categories',
    HAS_PERMS_BY_NAME('dbo.Categories', 'OBJECT', 'SELECT'),
    HAS_PERMS_BY_NAME('dbo.Categories', 'OBJECT', 'INSERT'),
    HAS_PERMS_BY_NAME('dbo.Categories', 'OBJECT', 'UPDATE'),
    HAS_PERMS_BY_NAME('dbo.Categories', 'OBJECT', 'DELETE'),
    HAS_PERMS_BY_NAME('dbo.Categories', 'OBJECT', 'ALTER')

UNION ALL

SELECT
    'dbo.Suppliers',
    HAS_PERMS_BY_NAME('dbo.Suppliers', 'OBJECT', 'SELECT'),
    HAS_PERMS_BY_NAME('dbo.Suppliers', 'OBJECT', 'INSERT'),
    HAS_PERMS_BY_NAME('dbo.Suppliers', 'OBJECT', 'UPDATE'),
    HAS_PERMS_BY_NAME('dbo.Suppliers', 'OBJECT', 'DELETE'),
    HAS_PERMS_BY_NAME('dbo.Suppliers', 'OBJECT', 'ALTER');
GO

REVERT;
GO

-- Quitar el permiso accidental
ALTER ROLE db_datawriter --quitamos el acceso al rol quitanto a datawriter
DROP MEMBER g1_app_bodega; --que eso pasa quitando directamente a bdega
GO