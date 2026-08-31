//              =====EJERCICIO 5=====
function generarUsuario(nombreCompleto) {
    // Convierte a minúsculas y elimina todos los espacios en blanco
    let usuarioLimpio = nombreCompleto.toLowerCase().replace(/\s+/g, "");
    let nombreUsuario = usuarioLimpio + "_dev";
    
    console.log('Nombre original: ' + nombreCompleto);
    console.log('Usuario generado: ' + nombreUsuario);
    
    return nombreUsuario;
}


generarUsuario("Sergio Checo Perez");
