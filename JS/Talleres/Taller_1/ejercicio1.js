
//              =====EJERCICIO 1=====
/**Se nos solicita crear un calculador de descuento que calcule desde el precio original y nos retorne
 * el nombre de el producto, el precio original y el porcentaje y el precio final **/
function calcularDescuento(nombreProducto, precioOriginal, porcentajeDescuento) {
    let descuento = (precioOriginal * porcentajeDescuento) / 100;
    let precioFinal = precioOriginal - descuento;
    
    console.log('Producto: ' + nombreProducto);
    console.log('Precio original: $' + precioOriginal.toFixed(2));
    console.log('Descuento aplicado: ' + porcentajeDescuento + '%');
    console.log('Precio final: $' + precioFinal.toFixed(2));
    
    return precioFinal;
}

//Datos quemados de prueba 
calcularDescuento("Libro", 30, 10);

