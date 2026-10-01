//En JS tenemos el uso de operadores como matematicos basicos
const precio1 = 100;
const precio2 = 200;

let total = precio1 + precio2; // para operadores tipo + - * / 
let resutlado = 10 % 3; //Para poder obtener un resiuduo

//Tambien contamos con otrod operadores como:

//Operadores de igualdad estricta
// Planteamiento: Validar si el rol del usuario ingresado coincide con el rol autorizado del sistema
const rolAutorizado = "admin";
const rolIngresado = "admin";

const esAccesoValido = (rolIngresado === rolAutorizado);

//Operadores logicos
// Planteamiento: Verificar si un usuario puede entrar a una zona VIP (requiere ser mayor de edad Y tener membresía)
const esMayorEdad = true;
const tieneMembresia = false;

const puedeEntrarVip = esMayorEdad && tieneMembresia; 
const puedeEntrarGeneral = esMayorEdad || tieneMembresia;

//operadores de asignacion o incremento
// Planteamiento: Llevar el conteo de productos añadidos a un carrito de compras
let cantidadProductos = 2;

// El usuario añade 3 productos más al carrito
cantidadProductos += 3; // Equivalente a: cantidadProductos = cantidadProductos + 3

