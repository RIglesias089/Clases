//Hacemos una funcon que nos ayudara a limpiar el texto que se ingrese en los campos de 
//descripcion y prioridad, eliminando espacios en blanco y convirtiendo a minusculas.
const limpiarTexto = (texto) => {
    if (typeof texto !== 'string') return '';
    return texto.trim().toLowerCase();
};

//Hacemos una funcion que nos ayudara a validar la prioridad que se ingrese en el campo de prioridad,
//verificando que sea una de las prioridades validas: alta, media o baja.
const validarPrioridad = (prioridad) => {
    const prioridadesValidas = ['alta', 'media', 'baja'];
    return prioridadesValidas.includes(limpiarTexto(prioridad));
};

//Exportamos las funciones para que puedan ser utilizadas en el archivo de controller.
module.exports = {
    limpiarTexto,
    validarPrioridad
};