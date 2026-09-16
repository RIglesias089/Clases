// utils/helpers.js

const limpiarTexto = (texto) => {
    if (typeof texto !== 'string') return '';
    return texto.trim().toLowerCase();
};

const validarPrioridad = (prioridad) => {
    const prioridadesValidas = ['alta', 'media', 'baja'];
    return prioridadesValidas.includes(limpiarTexto(prioridad));
};

module.exports = {
    limpiarTexto,
    validarPrioridad
};