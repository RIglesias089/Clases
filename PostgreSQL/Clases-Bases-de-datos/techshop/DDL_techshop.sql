-- create database laboratorios_PS;

create table clientes(
	id_clientes serial primary key,
	nombre varchar(50) not null,
	apellido varchar(50) not null,
	email varchar(50) unique not null, --el unique lo usamos para evitar valores duplicados a la hora de registrar clientes
	numero_de_telefono int unique not null
);

create table categorias(
id_categorias serial primary key  not null,
nombre_categoria varchar(100) not null unique 
);

create table productos(
id_producto serial primary key,
nombre_producto varchar(100)not null,
precio numeric(10,2) check(precio > 0), --aca creamos ponemos la seguridad de que no sean precios negativos.
cantidad int check(cantidad >= 0) not null,
id_categorias int,
constraint fk_categorias foreign key (id_categorias) references categorias(id_categorias) --hacemos la conexion a la tabla de categorias
);

create table ventas(
id_ventas serial primary key,
fecha_de_venta timestamp default current_timestamp, --el timestamp almacena la hora y la fecha, el default lo que hace es decirle a la bd que si no se da la fecha o algo, pondra la default de el servidor
total numeric(10,2) default 0.00,
id_clientes int,
constraint fk_cliente foreign key (id_clientes) references clientes(id_clientes)
);

create table detalles_de_ventas(
id_detalles serial primary key,
id_ventas int,
id_producto int,
cantidades int check (cantidades > 0),
subtotal numeric (10, 2),
constraint fk_ventas foreign key (id_ventas) references ventas(id_ventas),
constraint fk_productos foreign key (id_producto) references productos(id_producto)
);



