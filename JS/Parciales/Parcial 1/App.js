//primero importamos el modulo routes, controllers, utils.
const express = require('express'); //implementamos el express
const incidenciasRoutes = require('./routes/incidencias');

//planteamos el puerto en el que se iniciara el servidor
const app = express();
const PORT = 3000;

app.use(express.json());

// Montar las rutas en el prefijo /incidencias
app.use('/incidencias', incidenciasRoutes);

// Ruta base de prueba
app.get('/', (req, res) => {
    res.status(200).send('API REST TechSupport S.A. funcionando correctamente 🚀');
});

//puerto y mensaje cuando el servidor este corriendo correctamente
app.listen(PORT, () => {
    console.log(`Servidor corriendo en http://localhost:${PORT}`);
});