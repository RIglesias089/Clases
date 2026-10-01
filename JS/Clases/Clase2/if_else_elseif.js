//El if es uno de los condicionales mas usados, este tiene una estructura que se ve asi:

var hour = 10;

if (hour < 12) {
    console.log("Buenos dias, aun es hora de desayunar");
} // tambien en caso de que queramos evaluar algo mas que no sea solo una condicion podemos expandir de la siguiente forma 


var edad = 18;

if (edad < 18) {
    console.log("Eres menor de 18");
} else if (edad == 18){
    console.log("tienes 18 años");
} else {
    console.log("eres mayor de 18 años");
}

//hay una manera de plantear una condicion, de manera mas "corta" que se ve de la siguiente manera 
 let text = (edad < 18 ) ? "eres menor de 18 años" : "Eres mayor de 18 anios";

//Este se llama operador ternario, bsuca hacer de una manera mas corta la escritura de un if, if else, else.

