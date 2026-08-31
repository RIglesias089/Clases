//              =====EJERCICIO 4=====
function calculadora(numero1, numero2, operacion) {
    let resultado;

    switch (operacion.toLowerCase()) {
        case "suma":
            resultado = numero1 + numero2;
            break;
        case "resta":
            resultado = numero1 - numero2;
            break;
        case "multiplicacion":
            resultado = numero1 * numero2;
            break;
        case "division":
            if (numero2 === 0) {
                return "Error: No se puede dividir entre cero.";
            }
            resultado = numero1 / numero2;
            break;
        default:
            return "Operación no permitida.";
    }

    console.log('Resultado de la ' + operacion + ':' +resultado);
    return resultado;
}


calculadora(10, 5, "suma");
calculadora(10, 5, "resta");
calculadora(20, 4, "division");
calculadora(15, 3, "multiplicacion");
