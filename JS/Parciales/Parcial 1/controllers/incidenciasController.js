const { limpiarTexto, validarPrioridad } = require('../utils/helpers');

const incidencias = [];
let idCounter = 1;

const registrarIncidencia = (req, res) => {
    const { empleado, area, descripcion, prioridad } = req.body;

    if (!empleado || !area || !descripcion || !prioridad) {
        return res.status(400).json({ mensaje: 'Todos los campos son obligatorios' });
    }

    if (empleado.trim() === '' || area.trim() === '' || descripcion.trim() === '' || prioridad.trim() === '') {
        return res.status(400).json({ mensaje: 'No se permiten cadenas vacías' });
    }

    if (!validarPrioridad(prioridad)) {
        return res.status(400).json({ mensaje: 'Prioridad inválida. Debe ser: Alta, Media o Baja' });
    }

    const nuevaIncidencia = {
        id: idCounter++,
        empleado: empleado.trim(),
        area: area.trim(),
        descripcion: descripcion.trim(),
        prioridad: prioridad.charAt(0).toUpperCase() + prioridad.slice(1).toLowerCase(),
        estado: 'Pendiente'
    };

    incidencias.push(nuevaIncidencia);
    return res.status(201).json({ mensaje: 'Incidencia registrada correctamente' });
};

const listarIncidencias = (req, res) => {
    return res.status(200).json(incidencias);
};

const buscarIncidenciaPorId = (req, res) => {
    const id = Number(req.params.id);
    const incidencia = incidencias.find((item) => item.id === id);

    if (!incidencia) {
        return res.status(404).json({ mensaje: 'Incidencia no encontrada' });
    }

    return res.status(200).json(incidencia);
};

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

const eliminarIncidencia = (req, res) => {
    const id = Number(req.params.id);
    const index = incidencias.findIndex((item) => item.id === id);

    if (index === -1) {
        return res.status(404).json({ mensaje: 'Incidencia no encontrada' });
    }

    incidencias.splice(index, 1);
    return res.status(200).json({ mensaje: 'Incidencia eliminada correctamente' });
};

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

const clasificarIncidencia = (req, res) => {
    const id = Number(req.params.id);
    const incidencia = incidencias.find((item) => item.id === id);

    if (!incidencia) {
        return res.status(404).json({ mensaje: 'Incidencia no encontrada' });
    }

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

module.exports = {
    registrarIncidencia,
    listarIncidencias,
    buscarIncidenciaPorId,
    cambiarEstadoIncidencia,
    eliminarIncidencia,
    obtenerEstadisticas,
    clasificarIncidencia
};