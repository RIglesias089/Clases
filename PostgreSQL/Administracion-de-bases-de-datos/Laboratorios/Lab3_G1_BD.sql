-- Base de datos para el grupo 1
USE master;
GO

CREATE DATABASE DB_Gimnasio_G1;
GO

USE DB_Gimnasio_G1;
GO

CREATE TABLE dbo.Socio (
    id INT PRIMARY KEY,
    nombre NVARCHAR(100) NOT NULL,
    fecha_registro DATE NOT NULL
);
GO

-- INSERT INTO dbo.Socio (id, nombre, fecha_registro) VALUES (100, N'Socio de ejemplo', '2024-01-01');

--Ejercicio 1:

--Creamos el audit
USE master;
GO

CREATE SERVER AUDIT Audit_Socios_G1
TO FILE (
    FILEPATH  = '/audit/Socios_G1/',
    MAXSIZE   = 20 MB,
    MAX_FILES = 20
)
WITH (
    QUEUE_DELAY = 1000,
    ON_FAILURE  = CONTINUE
);
GO

ALTER SERVER AUDIT Audit_Socios_G1
WITH (STATE = ON);
GO

-- Verificar estado (esperado: STARTED)
SELECT name, status_desc, audit_file_path
FROM sys.dm_server_audit_status
WHERE name = 'Audit_Socios_G1';
GO


--vemos solo los insert realizados en l aauditoria
USE DB_Gimnasio_G1;
GO

CREATE DATABASE AUDIT SPECIFICATION Audit_DB_Socio_G1
FOR SERVER AUDIT Audit_Socios_G1
ADD (INSERT ON OBJECT::dbo.Socio BY public)
WITH (STATE = ON);
GO

--Registramos los cuatro primeros socios de dos insert
--socios 1 y 2
INSERT INTO dbo.Socio (id, nombre, fecha_registro)
VALUES (1, N'Juan Manuel G. Rivera',  '2024-01-15'),
       (2, N'Camila M. Morataya V.', '2024-02-20');
GO

--socios 3 y 4
INSERT INTO dbo.Socio (id, nombre, fecha_registro)
VALUES (3, N'Kenia M. Ayala S.',  '2021-09-05'),
       (4, N'Karla M. Gomez V.', '2024-01-26');
GO

-- Consultamos la tabla ordenada por id
SELECT id, nombre, fecha_registro
FROM dbo.Socio
ORDER BY id;
GO

--Leemos la evidencia con el sys.fn_get_audit_file desde el mas reciente al mas antiguo
USE master;
GO

SELECT event_time, action_id, succeeded, server_principal_name, statement
FROM sys.fn_get_audit_file('/audit/Socios_G1/*.sqlaudit', DEFAULT, DEFAULT)
WHERE database_name = 'DB_Gimnasio_G1'
  AND schema_name   = 'dbo'
  AND object_name   = 'Socio'
ORDER BY event_time DESC;
GO

--Ejercicio 2:
--Ejecutamos un delete y leemos la evidencia de la tabla filtrando 
USE DB_Gimnasio_G1;
GO

DELETE FROM dbo.Socio WHERE id = -1;
GO

USE master;
GO

SELECT event_time, action_id, succeeded, server_principal_name, statement
FROM sys.fn_get_audit_file('/audit/Socios_G1/*.sqlaudit', DEFAULT, DEFAULT)
WHERE database_name = 'DB_Gimnasio_G1'
  AND schema_name   = 'dbo'
  AND object_name   = 'Socio'
  AND action_id     = 'DL'
ORDER BY event_time DESC;
GO

--insertamos a Delete sin desactivar la especificacion 
USE DB_Gimnasio_G1;
GO

ALTER DATABASE AUDIT SPECIFICATION Audit_DB_Socio_G1
ADD (DELETE ON OBJECT::dbo.Socio BY public);
GO

--Realizamos con el orden correcto de la guia
-- a) Desactivar la especificación
ALTER DATABASE AUDIT SPECIFICATION Audit_DB_Socio_G1
WITH (STATE = OFF);
GO

-- b) Agregar la acción DELETE sobre dbo.Socio para public
ALTER DATABASE AUDIT SPECIFICATION Audit_DB_Socio_G1
ADD (DELETE ON OBJECT::dbo.Socio BY public);
GO

-- c) Activarla de nuevo
ALTER DATABASE AUDIT SPECIFICATION Audit_DB_Socio_G1
WITH (STATE = ON);
GO

-- d) Limpiar la caché de permisos para que el cambio aplique de inmediato
DBCC FREESYSTEMCACHE ('TokenAndPermUserStore');
GO

--Registramos a un socio temporal
INSERT INTO dbo.Socio (id, nombre, fecha_registro)
VALUES (91, N'Socio temporal G1', '2024-12-31');
GO

DELETE FROM dbo.Socio WHERE id = 91;
GO

DELETE FROM dbo.Socio WHERE id = -1;
GO

-- Leer de nuevo la evidencia de DELETE
USE master;
GO

SELECT event_time, action_id, succeeded, server_principal_name, statement
FROM sys.fn_get_audit_file('/audit/Socios_G1/*.sqlaudit', DEFAULT, DEFAULT)
WHERE database_name = 'DB_Gimnasio_G1'
  AND schema_name   = 'dbo'
  AND object_name   = 'Socio'
  AND action_id     = 'DL'
ORDER BY event_time DESC;
GO

--Ejercicio 3
--Inscribimos al quinto socio y consultamos la tabla ordenada por el id
USE DB_Gimnasio_G1;
GO

INSERT INTO dbo.Socio (id, nombre, fecha_registro)
VALUES (5, N'Andres F. Soto L.', '2024-06-15');
GO

SELECT id, nombre, fecha_registro
FROM dbo.Socio
ORDER BY id;
GO

--leemos con action_id del mas antiguo al mas reciente
USE master;
GO

SELECT event_time, action_id, succeeded, server_principal_name, statement
FROM sys.fn_get_audit_file('/audit/Socios_G1/*.sqlaudit', DEFAULT, DEFAULT)
WHERE database_name = 'DB_Gimnasio_G1'
  AND schema_name   = 'dbo'
  AND object_name   = 'Socio'
  AND action_id     = 'IN'
ORDER BY event_time ASC;
GO

--Hacemos que el evento de el quinto socio tenga hora de El savlador
SELECT event_time                           AS hora_utc,
       DATEADD(HOUR, -6, event_time)        AS hora_el_salvador,
       action_id,
       succeeded,
       server_principal_name,
       statement
FROM sys.fn_get_audit_file('/audit/Socios_G1/*.sqlaudit', DEFAULT, DEFAULT)
WHERE database_name = 'DB_Gimnasio_G1'
  AND schema_name   = 'dbo'
  AND object_name   = 'Socio'
  AND action_id     = 'IN'
  AND statement LIKE '%(5, N''Andres%'
ORDER BY event_time ASC;
GO
