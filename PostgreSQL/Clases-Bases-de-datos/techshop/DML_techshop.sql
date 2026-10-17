-- 1. SALIR DE CUALQUIER TRANSACCIÓN ABORTADA PREVIAMENTE
ROLLBACK;

-- Opcional: Descomenta la línea de abajo si quieres limpiar la base antes de insertar de nuevo
-- TRUNCATE detalles_de_ventas, ventas, productos, categorias, clientes RESTART IDENTITY CASCADE;

-- 2. Aseguramos el esquema correcto, hace que postgress busque en public antes de cualquier cosa para encotnrar la ruta
SET search_path TO public;

-- 3. Iniciamos la transacción limpia
BEGIN;

--4. empezamos la poblacion de la bd, es de aclarar que esta poblacion de datos la solicita a gemini, para agilizar ir a las pruebas
INSERT INTO clientes (nombre, apellido, email, numero_de_telefono) VALUES 
('Carlos', 'Gomez', 'carlos.gomez@email.com', 78901234),
('Ana', 'Martinez', 'ana.martinez@email.com', 71234567),
('Luis', 'Perez', 'luis.perez@email.com', 75432109),
('Maria', 'Lopez', 'maria.lopez@email.com', 73216548),
('Jorge', 'Ramirez', 'jorge.ramirez@email.com', 79876543);

INSERT INTO categorias (nombre_categoria) VALUES 
('Laptops'), 
('Accesorios'), 
('Almacenamiento'), 
('Monitores'), 
('Audio');

INSERT INTO productos (nombre_producto, precio, cantidad, id_categorias) VALUES 
('Laptop Gamer XYZ', 1200.00, 10, 1),
('Laptop Oficina ABC', 750.50, 15, 1),
('Mouse Inalambrico RGB', 25.50, 50, 2),
('Teclado Mecanico', 45.00, 30, 2),
('Disco SSl 1TB', 85.00, 25, 3),
('Memoria USB 64GB', 15.00, 100, 3),
('Monitor 24 pulgadas IPS', 180.00, 12, 4),
('Audifonos Gamer 7.1', 60.00, 20, 5);

INSERT INTO ventas (total, id_clientes) VALUES 
(1225.50, 1),  
(240.00, 2),   
(750.50, 3),   
(105.00, 4);   

INSERT INTO detalles_de_ventas (id_ventas, id_producto, cantidades, subtotal) VALUES 
-- Venta 1
(1, 1, 1, 1200.00),
(1, 3, 1, 25.50),
-- Venta 2
(2, 7, 1, 180.00),
(2, 6, 4, 60.00),
-- Venta 3
(3, 2, 1, 750.50),
-- Venta 4
(4, 4, 1, 45.00),
(4, 8, 1, 60.00);

COMMIT;


