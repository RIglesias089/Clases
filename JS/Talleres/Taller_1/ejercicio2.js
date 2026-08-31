//              =====EJERCICIO 2=====
function clasificarNota(nota) {
    if (nota < 0 || nota > 100) {
        return "Nota inválida. Debe estar entre 0 y 100.";
    }
    
    let resultado = "";
    
    if (nota >= 90) {
        resultado = "Excelente";
    } else if (nota >= 80) {
        resultado = "Muy Bueno";
    } else if (nota >= 70) {
        resultado = "Bueno";
    } else if (nota >= 60) {
        resultado = "Regular";
    } else {
        resultado = "Reprobado";
    }
    
    console.log('Nota: '+ nota + '- Resultado:' + resultado);
    return resultado;
}

clasificarNota(95);
clasificarNota(85);
clasificarNota(75);
clasificarNota(65);
clasificarNota(55);