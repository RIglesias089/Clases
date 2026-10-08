/*
  =============================================================================
  APUNTES DE CLASE: PERMISOS, SEGURIDAD Y AUDITORÍAS EN SQL SERVER
  =============================================================================
*/

-- -----------------------------------------------------------------------------
-- 1. ANÁLISIS DE PERMISOS, ROLES Y EL COMANDO REVOKE
-- -----------------------------------------------------------------------------
/*
  Ejemplo analizado en clase:
  
  GRANT SELECT ON Clientes TO consultas;
  ALTER ROLE consultas ADD MEMBER u1;
  GRANT UPDATE, DELETE ON Clientes TO u1;
  REVOKE SELECT ON Clientes FROM u1;

  - Permisos vigentes para u1: El usuario puede ejecutar operaciones de 
    UPDATE, DELETE y SELECT.
  - Comportamiento del REVOKE: Aunque se ejecutó el comando para revocar el 
    SELECT directamente al usuario, este permiso no se pierde por completo.
  - Motivo: El REVOKE directo no afecta los permisos HEREDADOS. Como u1 pertenece 
    al rol "consultas" (y este rol sí tiene concedido el SELECT), el usuario 
    mantiene el acceso a las consultas a través de dicha membresía.
*/


-- -----------------------------------------------------------------------------
-- 2. PERFILES Y POLÍTICAS DE SEGURIDAD
-- -----------------------------------------------------------------------------
/*
  Iniciamos el tema de "Perfiles y políticas de seguridad" para realizar 
  auditorías con herramientas como SQL Audit.

  - Diferencia con otros SGBD: A diferencia de Oracle u otros motores, SQL Server 
    no maneja un objeto formal de "perfil", pero permite configurar propiedades 
    de seguridad esenciales:
    * CHECK_POLICY = ON: Aplica las reglas y directivas de seguridad de 
      contraseñas de Windows (complejidad, longitud, caracteres).
    * CHECK_EXPIRATION = ON: Habilita la caducidad automática de la contraseña 
      para obligar a su cambio periódico y plantear contraseñas seguras.
*/


-- -----------------------------------------------------------------------------
-- 3. SQL AUDIT (AUDITORÍA EN SQL SERVER)
-- -----------------------------------------------------------------------------
/*
  Herramienta de SQL Server para registrar actividades y accesos con fines de 
  seguridad, cumplimiento normativo y control.

  - Server Audit: Es el componente o servidor donde se consolidan los resultados 
    de la auditoría realizada.
  - Archivo de registro: Los resultados se almacenan en un archivo con la 
    extensión ".sqlaudit", que funciona de manera equivalente a un archivo de 
    logs tradicional.
  - Datos registrados por el archivo: 
    * Hora exacta de la actividad.
    * Dirección IP del cliente.
    * Usuario que se conectó o realizó alguna acción en la base de datos.
*/


-- -----------------------------------------------------------------------------
-- 4. ¿POR QUÉ Y EN QUÉ CASOS SE UTILIZAN LAS AUDITORÍAS?
-- -----------------------------------------------------------------------------
/*
  - Cumplimiento normativo: Permiten cumplir con normativas que exigen definir 
    qué se va a auditar y por cuánto tiempo.
  - Control y seguridad: Ayudan a llevar un control estricto de los datos y a 
    detectar actividades sospechosas de usuarios que realizan cambios no 
    autorizados en la información, los privilegios o la seguridad.
*/


-- -----------------------------------------------------------------------------
-- 5. NIVELES DE AUDITORÍA
-- -----------------------------------------------------------------------------
/*
  - Nivel de Servidor: Permite auditar niveles de logueo, quiénes ingresan al 
    servidor mediante roles, backups y cambios de configuración.
  - Nivel de Base de Datos: Audita sentencias (SELECT, INSERT, UPDATE, DELETE) 
    sobre las tablas, así como intentos de ver o crear nuevos objetos.
  - Nivel de Columna: Aplicado específicamente a operaciones de UPDATE, audita 
    modificaciones realizadas sobre campos o columnas específicas.
*/


-- -----------------------------------------------------------------------------
-- 6. DESTINOS POSIBLES DE ALMACENAMIENTO
-- -----------------------------------------------------------------------------
/*
  - Archivos: Guardados con la extensión ".sqlaudit", consultables mediante 
    T-SQL o SSMS.
  - Application Log de Windows: Configurable para registrar eventos en el 
    Event Viewer de Windows.
  - Security Log de Windows: Integrado nativamente con el Event Viewer del 
    sistema operativo.
*/


-- -----------------------------------------------------------------------------
-- 7. CONSULTA DE REGISTROS Y CONSIDERACIONES FINALES
-- -----------------------------------------------------------------------------
/*
  - Maneras de consultar el registro:
    1. T-SQL: Utilizando la función sys.fn_get_audit_file() con un SELECT.
    2. Forma gráfica: Clic derecho en la carpeta de seguridad -> Audits -> 
       View Audit Logs en SSMS.
    3. Visor de eventos: Usando el Event Viewer de Windows para ver los logs.

  - Restricción importante: Solo se puede tener una especificación de 
    auditoría activa a la vez por nivel.
*/


-- =============================================================================
-- PRÁCTICA: CONFIGURACIÓN DE AUDITORÍA Y CONSULTAS
-- =============================================================================

-- Paso 1: Conectar a la base de datos master
USE master;
GO

-- Paso 2: Crear el Server Audit (asegúrate de tener permisos en la ruta física, ej: C:\audit\)
CREATE SERVER AUDIT NorthwindAudit
TO FILE (
    FILEPATH = 'C:\audit\', 
    MAXSIZE = 10MB, 
    MAX_FILES = 5
)
WITH (
    ON_FAILURE = CONTINUE
);
GO

-- El audit aparece deshabilitado de entrada.
-- Paso 3: Habilitar el Server Audit
ALTER SERVER AUDIT NorthwindAudit 
WITH (STATE = ON);
GO


-- Paso 4: Configurar la especificación de auditoría a nivel de base de datos
USE Northwind;
GO

CREATE DATABASE AUDIT SPECIFICATION DML_Audit
FOR SERVER AUDIT NorthwindAudit
ADD (INSERT, UPDATE, DELETE ON dbo.Products BY public),
ADD (SELECT ON dbo.Employees BY public),
ADD (SELECT, INSERT, UPDATE, DELETE ON dbo.Orders BY public);
GO

-- Al ejecutarlo saldrá deshabilitado; hay que habilitarlo:
ALTER DATABASE AUDIT SPECIFICATION DML_Audit
WITH (STATE = ON);
GO


-- -----------------------------------------------------------------------------
-- PRUEBAS Y ACTIVIDADES DE AUDITORÍA
-- -----------------------------------------------------------------------------

-- Probar consultas y operaciones para generar registros:
SELECT * FROM Employees;
GO

-- Agregar un usuario al rol db_owner (ejemplo visto en clase)
ALTER ROLE db_owner ADD MEMBER profesor;
GO

-- Consultar productos
SELECT TOP 5 * FROM Products;
GO

-- Actualizar un producto
UPDATE Products 
SET UnitPrice = 18 * 1.1 
WHERE ProductID = 1;
GO

SELECT MAX(ProductID) FROM Products;
GO

-- Insertar un nuevo producto basado en el ID 1
INSERT INTO Products (ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued)
SELECT 'pupusas', SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued
FROM Products 
WHERE ProductID = 1;
GO

SELECT * FROM Products WHERE ProductID = 1;
GO

-- Actualizar stock del producto recién insertado (asumiendo ID 78)
UPDATE Products 
SET UnitsInStock = 100 
WHERE ProductID = 78;
GO

-- Eliminar el registro de prueba
DELETE FROM Products 
WHERE ProductID = 78;
GO

SELECT TOP 10 * FROM Orders;
GO


-- -----------------------------------------------------------------------------
-- CÓMO VER LOS REGISTROS DE AUDITORÍA
-- -----------------------------------------------------------------------------
/*
  Formas de visualización:
  1. Gráfica: Conectado con un usuario con privilegios (sa o administrador), ir a 
     Seguridad -> Audits, hacer clic derecho sobre el archivo .sqlaudit y 
     seleccionar "View Audit Logs".
  2. T-SQL: Consultando directamente con la función del sistema.
*/

-- Ejemplo de consulta T-SQL para ver los eventos de auditoría:
SELECT 
    event_time,
    server_principal_name,
    database_name,
    action_id,
    statement
FROM sys.fn_get_audit_file('C:\audit\*.sqlaudit', DEFAULT, DEFAULT)
WHERE statement LIKE '%delete%'
ORDER BY event_time DESC;
GO

--creamos una vista para no estar llamando a cada una (solucionar y hacerlo0