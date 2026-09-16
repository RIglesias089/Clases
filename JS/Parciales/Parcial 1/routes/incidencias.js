//Implementamos el router de express para definir las rutas de la API REST
const express = require('express');
const router = express.Router();

//Implementamos las constantes que seran las funciones que podemos utilizar en cada ruta de la API REST
const {
    registrarIncidencia,
    listarIncidencias,
    buscarIncidenciaPorId,
    cambiarEstadoIncidencia,
    eliminarIncidencia,
    obtenerEstadisticas,
    clasificarIncidencia
} = require('../controllers/incidenciasController');

//Definimos las rutas que se deben utilizar para llamar a cada funcion en especifico.
router.post('/', registrarIncidencia);
router.get('/estadisticas', obtenerEstadisticas);
router.get('/', listarIncidencias);
router.get('/:id', buscarIncidenciaPorId);
router.get('/:id/clasificacion', clasificarIncidencia);
router.put('/:id/estado', cambiarEstadoIncidencia);
router.delete('/:id', eliminarIncidencia);

//Esportamos el router para que pueda ser utilizado en el archivo principal de App.js
module.exports = router;