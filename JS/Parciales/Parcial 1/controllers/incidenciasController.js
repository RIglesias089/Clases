//mandamos a llamar las funciones de el helper 
const { limpiarTexto, validarPrioridad } = require('../utils/helpers');

//creamos un arreglo el cual almacenara las incidencias y un contador para el id 
const incidencias = [];
let idCounter = 1;

//Implementamos las funciones que seran utilizadas en cada ruta de la API REST
const registrarIncidencia = (req, res) => {
    const { empleado, area, descripcion, prioridad } = req.body; 

    //Usamos un if en cada caso para validar que los campos no esten vacios 
    // y que la prioridad sea valida, en caso de que no se cumpla alguna de estas condiciones, 
    // se enviara un mensaje de error.
    if (!empleado || !area || !descripcion || !prioridad) {
        return res.status(400).json({ mensaje: 'Todos los campos son obligatorios' });
    }

    if (empleado.trim() === '' || area.trim() === '' || descripcion.trim() === '' || prioridad.trim() === '') {
        return res.status(400).json({ mensaje: 'No se permiten cadenas vacías' });
    }

    if (!validarPrioridad(prioridad)) {
        return res.status(400).json({ mensaje: 'Prioridad inválida. Debe ser: Alta, Media o Baja' });
    }

    // Creamos un objeto con la nueva incidencia y lo agregamos al arreglo de incidencias
    const nuevaIncidencia = {
        id: idCounter++,
        empleado: empleado.trim(),
        area: area.trim(),
        descripcion: descripcion.trim(),
        prioridad: prioridad.charAt(0).toUpperCase() + prioridad.slice(1).toLowerCase(),
        estado: 'Pendiente'
    };

    //aca hacemos un push al arreglo de incidencias para agregar la nueva incidencia y 
    // enviamos un mensaje de exito.
    incidencias.push(nuevaIncidencia);
    return res.status(201).json({ mensaje: 'Incidencia registrada correctamente' });
};

//Bloque que nos permite listar todas las incidencias registradas, enviando un mensaje de exito 
//y el arreglo de incidencias.
const listarIncidencias = (req, res) => {
    return res.status(200).json(incidencias);
};

//En buscar incidencia por id, primero obtenemos el id de la incidencia que se quiere buscar,
// luego buscamos la incidencia en el arreglo de incidencias, si no se encuentra,
//  enviamos un mensaje de error, si se encuentra, enviamos la incidencia encontrada.
const buscarIncidenciaPorId = (req, res) => {
    const id = Number(req.params.id);
    const incidencia = incidencias.find((item) => item.id === id);

    if (!incidencia) {
        return res.status(404).json({ mensaje: 'Incidencia no encontrada' });
    }

    return res.status(200).json(incidencia);
};

//para el cambio de estado de la incidencia, primero buscamos la incidencia por id,
// si no se encuentra, enviamos un mensaje de error, si se encuentra, 
// validamos que el estado ingresado sea valido,
const cambiarEstadoIncidencia = (req, res) => {
    const id = Number(req.params.id);
    const { estado } = req.body;
    const incidencia = incidencias.find((item) => item.id === id);

    if (!incidencia) {
        return res.status(404).json({ mensaje: 'Incidencia no encontrada' });
    }

    if (!estado) {
        return res.status(400).json({ mensaje: 'El campo estado es obligatorio' });
    }

    //Usamos un swich para evaluar el estado que se ingrese, si es valido, se actualiza el estado 
    // de la incidencia, si no es valido, se envia un mensaje de error.
    switch (limpiarTexto(estado)) {
        case 'pendiente':
            incidencia.estado = 'Pendiente';
            break;
        case 'en proceso':
            incidencia.estado = 'En Proceso';
            break;
        case 'resuelta':
            incidencia.estado = 'Resuelta';
            break;
        case 'cancelada':
            incidencia.estado = 'Cancelada';
            break;
        default:
            return res.status(400).json({ mensaje: 'Estado inválido' });
    }

    return res.status(200).json({ mensaje: 'Estado actualizado correctamente', incidencia });
};

//en el caso de eliminar la incidencia, primero buscamos la incidencia por id, si no se encuentra, 
// enviamos un mensaje de error, si se encuentra, eliminamos la incidencia del arreglo y 
// enviamos un mensaje de exito.
const eliminarIncidencia = (req, res) => {
    const id = Number(req.params.id);
    const index = incidencias.findIndex((item) => item.id === id);

    if (index === -1) {
        return res.status(404).json({ mensaje: 'Incidencia no encontrada' });
    }

    incidencias.splice(index, 1);
    return res.status(200).json({ mensaje: 'Incidencia eliminada correctamente' });
};

//en el caso de obtener estadisticas, primero obtenemos el total de incidencias,
//  luego obtenemos el total de incidencias por estado y enviamos un objeto con las estadisticas obtenidas.
const obtenerEstadisticas = (req, res) => {
    const estadisticas = {
        totalIncidencias: incidencias.length,
        pendientes: incidencias.filter(i => i.estado === 'Pendiente').length,
        enProceso: incidencias.filter(i => i.estado === 'En Proceso').length,
        resueltas: incidencias.filter(i => i.estado === 'Resuelta').length,
        canceladas: incidencias.filter(i => i.estado === 'Cancelada').length
    };

    return res.status(200).json(estadisticas);
};

//en el caso de clasificar la incidencia, primero buscamos la incidencia por id, si no se encuentra,
// enviamos un mensaje de error, si se encuentra, clasificamos la incidencia segun su prioridad y 
// enviamos un objeto con la clasificacion obtenida.
const clasificarIncidencia = (req, res) => {
    const id = Number(req.params.id);
    const incidencia = incidencias.find((item) => item.id === id);

    if (!incidencia) {
        return res.status(404).json({ mensaje: 'Incidencia no encontrada' });
    }

    //usamos un swich para clasificar la incidencia
    let clasificacion = '';
    switch (incidencia.prioridad) {
        case 'Alta':
            clasificacion = 'Crítica';
            break;
        case 'Media':
            clasificacion = 'Importante';
            break;
        case 'Baja':
            clasificacion = 'Normal';
            break;
        default:
            clasificacion = 'Sin clasificar';
            break;
    }

    return res.status(200).json({ id: incidencia.id, clasificacion });
};

//exportamos el bloque de funciones para que puedan ser utilizadas en el archivo de rutas.
module.exports = {
    registrarIncidencia,
    listarIncidencias,
    buscarIncidenciaPorId,
    cambiarEstadoIncidencia,
    eliminarIncidencia,
    obtenerEstadisticas,
    clasificarIncidencia
};