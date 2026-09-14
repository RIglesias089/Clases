const express = require('express');
const app = express();
const port = 3000;
//Interpretador de json
app.use(express.json());

//Funcion para calcular los impuestosw 
function calcularImpuestos(pais, salarioBruto) {
    const paisLimpio = pais.trim().toLowerCase();
    
    let porcentajeIVA, porcentajeRenta;

    switch (paisLimpio) {
        case "el salvador":
            porcentajeIVA = 0.13;
            porcentajeRenta = 0.10;
            break;
        case "guatemala":
            porcentajeIVA = 0.12;
            porcentajeRenta = 0.07;
            break;
        case "costa rica":
            porcentajeIVA = 0.13;
            porcentajeRenta = 0.15;
            break;
        case "honduras":
            porcentajeIVA = 0.15;
            porcentajeRenta = 0.10;
            break;
        case "panama":
            porcentajeIVA = 0.07;
            porcentajeRenta = 0.10;
            break;
        case "nicaragua":
            porcentajeIVA = 0.15;
            porcentajeRenta = 0.10;
            break;
        default:
            throw new Error("País no permitido. Los países válidos son: El Salvador, Guatemala, Costa Rica, Honduras, Panama, Nicaragua.");
    }

    const valorIva = salarioBruto * porcentajeIVA;
    const valorRenta = salarioBruto * porcentajeRenta;
    const salarioNeto = salarioBruto - valorIva - valorRenta;

    return {
        pais: paisLimpio,
        salarioBruto: salarioBruto,
        porcentajeIVA: `${Math.round(porcentajeIVA * 100)}%`,
        porcentajeRenta: `${Math.round(porcentajeRenta * 100)}%`,
        iva: valorIva,
        renta: valorRenta,
        salarioNeto: salarioNeto
    };
}

// Ruta para la peticion json
app.post('/calcular-impuestos', (req, res) => {
    try {
        const { pais, salario } = req.body;

        if (!pais || salario === undefined) {
            throw new Error("Faltan datos obligatorios. Debe enviar 'pais' y 'salario'.");
        }

        if (typeof salario !== 'number' || salario <= 0) {
            throw new Error("El salario debe ser un número válido mayor a 0.");
        }

        // se llama a la funcion correctamente 
        const resultado = calcularImpuestos(pais, salario);

        res.status(200).json(resultado);

    } catch (error) {
        // este guarda el error para presentarlo 
        res.status(400).json({
            error: true,
            mensaje: error.message
        });
    }
});

app.listen(port, () => {
    console.log(`Servidor corriendo en http://localhost:${port}`);
});