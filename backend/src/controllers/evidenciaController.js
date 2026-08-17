const { getDB } = require('../config/db_mongo');

const registrarEvidencia = async (req, res) => {
    try {
        const db = getDB();
        const incidenciaId = parseInt(req.params.id);
        const { tipo, nombre, url, descripcion } = req.body;

        // Validación de campos obligatorios 
        if (!tipo || !nombre || !url) {
            return res.status(400).json({
                error: 'Faltan campos obligatorios (tipo, nombre, url)'
            });
        }

        const nuevaEvidencia = {
            incidenciaId,
            tipo,           
            nombre,
            url,
            descripcion: descripcion || '',
            fecha: new Date()
        };

        const resultado = await db.collection('evidencias').insertOne(nuevaEvidencia);

        res.status(201).json({
            mensaje: 'Evidencia registrada correctamente',
            id: resultado.insertedId,
            evidencia: nuevaEvidencia
        });
    } catch (error) {
        console.error('Error al registrar evidencia:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }
};

module.exports = { registrarEvidencia };