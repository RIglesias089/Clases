//Aca veremos un operador el cual es el swich, mas que todo usado para poder evaluar multiples condiciones
//en un mismo bloque de codigo, o que de igual maner pueda llamar funciones a un menu principal.

//solicitamos el dato a la persona
let dia = Number(prompt("Ingrese porfavor un numero de el 0-6 para saber el dia: "));

switch (dia) { //Nace desde la posicion 0 en adelante
    case 0:
        console.log("Hoy es lunes");
        break;
    case 1:
        console.log ("Hoy es martes");
        break;
    case 2:
        console.log("Hoy es miercoels");
        break;
    case 3:
        console.log("Hoy es jueves");
        break;
    case 4:
        console.log("Hoy es viernes");
        break;
    case 5:
        console.log("Hoy es sabado");
        break;
    case 6:
        console.log("Hoy es domingo");
        break;
    default:
        console.log("Dia ingresado invalido");
        break;
}