--Recordatorio de como funciona postgreSQL

/*Primero qu enada lo que se realiza es la creacion de el docker con el que se
 * trabajara durante el proyecto, el cual es un comando en la terminal:
 * 
 * docker run --name "nombre de el contenedor" -e POSTGRES_PASSWORD="contrasena de el contenedor" -p 5432:5432 -d postgres:latest
 *
 * Con esto tendremos el contenedor de docker creado y listo para conectar en DBeaver
 * Luego de eso podemos empezar hablando de lo que son 
 * 
 * ============================================================================================
 * Creacion de tablas en las bases de datos
 * 
 * Para empezar necesitamso el contenedor logico, donde viviran las tablas, para crear una 
 * tabla se usa el comando
 *  */

--despues de creada la base de datos, podemos crear tablas
create table estudiantes(
estudiante_id serial primary key, --Genera un numero unico automaticamente
nombre varchar(50) not null,	-- estos llevan not null para que sea obligatorio el campo
apellido varchar(50) not null,
fecha_nacimiento date,
es_activo boolean default true --por defecto el estudiante sera activo
);

--Ahora que tenemos una tabla, es importante saber como esta se puede poblar, 
--no sirve denada tener un atabla si no tiene datos, sin datos no podremos hacer consultas

--insertar un solo estudiante
insert into estudiantes (nombre, apellido, fecha_nacimiento, es_activo)
values ('Juan', 'Perez', '2002-05-15', true );

insert into estudiantes (nombre, apellido, fecha_nacimiento, es_activo)
values ('Pedro', 'trujillo', '2007-05-14', false)

--insertados los datos ahora lo que queremos es ver todo lo que hay en al tabla
select * from estudiantes;

--Claramente no solo queremos meter datos si no que tambien vamos a querer
--poder modificar o incluso borrar datos (es importante decir que al borrar hay que tener cuidado)

--Cambiar estado de un estudainte
update estudiantes
set es_activo = false
where nombre = 'Juan';

-- Borrar un estudainte de la base de datos
delete from estudiantes 
where nombre = 'Pedro'

--Ahora con eso hecho, debemos aprender como relacionar tablas (llaves foraneas)
--crearemos otra tabla 
create table carreras(
carrera_id serial primary key,
nombre_carrera varchar(50) not null 
);

--poblamos la tabla 
insert into carreras (nombre_carrera)
values ('ingenieria inrformatica'), ('Medicina'), ('Disenio');
