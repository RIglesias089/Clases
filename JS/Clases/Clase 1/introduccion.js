/**Para empezar debemos saber que JS es un lenguaje el cual nos ayudara con la programacion web
 * principalmente debemos sabes que JSn podemos hacer cosas esteticas desde el cambio y diseño de
 * textos y demas, ah cosas mas importantes, como validaciones de datos, detectar clics, movimientos
 * o incluso mostrar cosas como mapas en 2D o 3D, aca tenemos toda la logica y funcionalidad de la pagina**/

//Cuando tenemos variables que pueden cambiar, usamos el let
let x = 5;
let y = 8;

//Cuando tenemos cariables que no cambiaran, se usa el apartado de const, por ejemplo
const nombre = "luis";

//JS es un lenguaje de tipado dinamico, por lo que los datos mas usados son: 
//Strings, numbers, booleans, objects.
const tipotexto = "hola mundo"; 
const tiponumero = 2026;
const tipoBooleano = true;

//podemos agrupar datos en una sola variable, por ejemplo
const usuario = {
    id: 1,
    nombre : "Juan",
    activo : false
};

//Podemos usar arreglos, de la siguiente manera
const arrglo = []; //dentro van los valores de el arreglo

//Como siempre podemos hacer uso de las funciones para determinar procesos especificos.
const sumarNumeros = (a, b) => { // esta es una funcion de flecha, hace que no usemos el function y devuelve un valor   
    return a+b; //de manera automatica
};

//Cuando queremos mandar a llamar dicha funcion y guardar un resultado
const resultados = sumarNumeros(6,7);
console.log(resultados); //imprime el resultado de la funcion a la que se manda a llamar

//Cuando queremos hacer un if/ else, lo podemos hacer de la siguiente manera
const edad = 18;
if (edad >= 18){
    console.log("Eres mayor de edad");
} else {
    console.log("Eres menor de edad");
}

//uso de . y de los metodos en JS, se usan para poder acceder a propiedades o metodos que pertenecen
//ya sea a un objeto o a un dato, tambien para hacer uso de ciertas cosas como veremos mas adelante.
const textoDesordenado = "  Hola Javascript   ";

//usamos el punto  para aplicar  metodos integrados en JS.
const textoLimpio = textoDesordenado.trim().toLowerCase(); //quitamos espacios inecesaris y hacemos minusculas
