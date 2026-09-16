//primero importamos el modulo de expresmkdir routes, controllers, utilsmkdir routes, controllers, utils
const express = require('express');
const incidenciasRoutes = require('./routes/incidencias');

const app = express();
const PORT = 3000;

// Middleware fundamental para leer JSON en las peticiones POST y PUT
app.use(express.json());

// Montar las rutas en el prefijo /incidencias
app.use('/incidencias', incidenciasRoutes);

// Ruta base de prueba
app.get('/', (req, res) => {
    res.status(200).send('API REST TechSupport S.A. funcionando correctamente 🚀');
});

// Levantar servidor
app.listen(PORT, () => {
    console.log(`Servidor corriendo en http://localhost:${PORT}`);
});