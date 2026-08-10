const { getDB } = require('../config/db_mongo');

const registrarDiagnostico = async (req, res) => {
  try {
    const db = getDB();
    const incidenciaId = parseInt(req.params.id);
    const { tecnicoId, descripcion, pruebasRealizadas, causaProbable, solucionAplicada } = req.body;
    
    if (!tecnicoId || !descripcion || !causaProbable || !solucionAplicada) {
      return res.status(400).json({ 
        error: 'Faltan campos obligatorios (tecnicoId, descripcion, causaProbable, solucionAplicada)' 
      });
    }

    const nuevoDiagnostico = {
      incidenciaId,
      tecnicoId,
      descripcion,
      pruebasRealizadas: pruebasRealizadas || [],
      causaProbable,
      solucionAplicada,
      fecha: new Date()
    };

    const resultado = await db.collection('diagnosticos').insertOne(nuevoDiagnostico);

    res.status(201).json({
      mensaje: 'Diagnóstico registrado correctamente',
      id: resultado.insertedId,
      diagnostico: nuevoDiagnostico
    });

  } catch (error) {
    console.error('Error al registrar diagnóstico:', error);
    res.status(500).json({ error: 'Error interno del servidor' });
  }
};

module.exports = { registrarDiagnostico };