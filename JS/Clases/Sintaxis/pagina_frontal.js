//vamos a ver las bases de la sintaxis y demas respecto a JS, como fuciona como trabajar en la consola en una 
//pagina web, asi como la creacion de APIs, para su uso en el desarrollo de dicha wen, cerrando tambien con 
// uso de ciertas framewoks y librerias como lo que son node.js y express

/*Para programar en JS, tenemos ciertas reglas como lo que son las siguietnes apra la declaraciond e variables */

let x = 5; //La variable let, es usada para variables que no pueden cambiar de valor.
let y = 8; 

let z = x+y; //Creamos una variable z, que hara la suma de als variables ya dadas como lo que son x e y.

//tambien existen otro tipo de variables denominadas var.
var a = 10 //la diferencia de var a let, es que var son variables que pueden cambiaer de valor.

//Con esto sabemos qeu la mayor difrencia entre let y var, es que let es una variable que no puede cambiar de valor,
//mientras que var si puede cambiar de valor.

//respecto a la escritura de los datos de las variables puede ser tanto entero como decimal, las cadenas de texto pueden ser
//Tanto con comillas dobles como comillas simples.

const name = "Ricardo"; //const es ua variable a la que no se le puede cambiar el varlor.

//En JS, esta el uso de operadores que se dividen en lo sisguientes.

/*Operadores aritmeticos, son aquellos compuestos por "+,-,/,*", */
const precioProducto = 100;
const costoEnvio = 15;

let totalPagar = precioProducto + costoEnvio; // 100 + 15
let sobranteInventario = 10 % 3;              // Residuo de dividir 10 entre 3

//operador de igualdad estricta
const rolAutorizado = "admin";
const rolIngresado = "admin";

const esAccesoValido = (rolIngresado === rolAutorizado);

// Operador logico de & y ||
const esMayorEdad = true;
const tieneMembresia = false;

const puedeEntrarVip = esMayorEdad && tieneMembresia; 
const puedeEntrarGeneral = esMayorEdad || tieneMembresia;


// operadores incrementales
let cantidadProductos = 2;

// El usuario añade 3 productos más al carrito
cantidadProductos += 3; // Equivalente a: cantidadProductos = cantidadProductos + 3

//Ejemplos

// String
let color = "Yellow";
let lastName = "Johnson";

// Number
let length = 16;
let weight = 7.5;

// BigInt
let x = 1234567890123456789012345n;
let y = BigInt(1234567890123456789012345)

// Boolean
let x = true;
let y = false;

// Object
const person = {firstName:"John", lastName:"Doe"};

// Array object
const cars = ["Saab", "Volvo", "BMW"];

// Date object
const date = new Date("2022-03-25");

// Undefined
let x;
let y;

// Null
let x = null;
let y = null;

// Symbol
const x = Symbol();
const y = Symbol();

//Para cada proceso de la programacion tambien tenemos un listado de palabras clave, que veremos uno por uno en cada clase
/*var, let, const que vimos ya aca, tambien tenemos:
if, else
for
while 
function
return
try.
*/