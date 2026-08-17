const { pool } = require('../config/db_mysql');
const { getDB } = require('../config/db_mongo');

// POST /api/incidencias - Registrar nueva incidencia 
const registrarIncidencia = async (req, res) => {
    try {
        const { titulo, descripcion, prioridad, id_activo, id_usuario_reporta } = req.body;

        // Validación de campos obligatorios (
        if (!titulo || !id_activo || !id_usuario_reporta) {
            return res.status(400).json({
                error: 'Faltan campos obligatorios (titulo, id_activo, id_usuario_reporta)'
            });
        }

        // Llamar al procedimiento almacenado sp_registrar_incidencia
       
        const [resultados] = await pool.query(
            'CALL sp_registrar_incidencia(?, ?, ?, ?, ?, @p_id_incidencia, @p_mensaje)',
            [titulo, descripcion || null, prioridad || 'Media', id_activo, id_usuario_reporta]
        );

        
        const [outParams] = await pool.query('SELECT @p_id_incidencia AS id_incidencia, @p_mensaje AS mensaje');
        
        const idIncidencia = outParams[0].id_incidencia;
        const mensaje = outParams[0].mensaje;

        // Si el SP devolvió error
        if (!idIncidencia) {
            return res.status(400).json({ error: mensaje });
        }

        res.status(201).json({
            mensaje: mensaje,
            id_incidencia: idIncidencia
        });

    } catch (error) {
        console.error('Error al registrar incidencia:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }
};

// GET /api/incidencias - Listar incidencias activas


const listarIncidencias = async (req, res) => {
    try {
        const [filas] = await pool.query('SELECT * FROM vw_incidencias_activas ORDER BY fecha_registro DESC');

        res.json({
            total: filas.length,
            incidencias: filas
        });
    } catch (error) {
        console.error('Error al listar incidencias:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }
};


// PUT /api/incidencias/:id/asignar - Asignar técnico 
const asignarTecnico = async (req, res) => {
    try {
        const incidenciaId = parseInt(req.params.id);
        const { id_tecnico, asignado_por } = req.body;

        // Validación de campos obligatorios
        if (!id_tecnico || !asignado_por) {
            return res.status(400).json({
                error: 'Faltan campos obligatorios (id_tecnico, asignado_por)'
            });
        }

        // Llamar al procedimiento almacenado sp_asignar_tecnico
        // El SP tiene 1 parámetro OUT: p_mensaje
        const [resultados] = await pool.query(
            'CALL sp_asignar_tecnico(?, ?, ?, @p_mensaje)',
            [incidenciaId, id_tecnico, asignado_por]
        );

        // Obtener el valor del parámetro OUT
        const [outParams] = await pool.query('SELECT @p_mensaje AS mensaje');
        const mensaje = outParams[0].mensaje;

        // Si el SP devolvió error (el mensaje empieza con "Error:")
        if (mensaje && mensaje.startsWith('Error:')) {
            return res.status(400).json({ error: mensaje });
        }

        res.json({
            mensaje: mensaje || 'Técnico asignado correctamente',
            incidencia_id: incidenciaId,
            tecnico_id: id_tecnico
        });

    } catch (error) {
        console.error('Error al asignar técnico:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }
};

// PUT /api/incidencias/:id/estado - Cambiar estado 
const cambiarEstado = async (req, res) => {
    try {
        const incidenciaId = parseInt(req.params.id);
        const { nuevo_estado, diagnostico_confirmado } = req.body;

        // Validación de campos obligatorios
        if (!nuevo_estado) {
            return res.status(400).json({
                error: 'Falta campo obligatorio (nuevo_estado)'
            });
        }

        // Llamar al procedimiento almacenado sp_cambiar_estado
        const [resultados] = await pool.query(
            'CALL sp_cambiar_estado(?, ?, ?, @p_mensaje)',
            [incidenciaId, nuevo_estado, diagnostico_confirmado || 0]
        );

        // Obtener el valor del parámetro OUT
        const [outParams] = await pool.query('SELECT @p_mensaje AS mensaje');
        const mensaje = outParams[0].mensaje;

        // Si el SP devolvió error 
        if (mensaje && mensaje.startsWith('Error:')) {
            return res.status(400).json({ error: mensaje });
        }

        res.json({
            mensaje: mensaje || 'Estado actualizado correctamente',
            incidencia_id: incidenciaId,
            nuevo_estado: nuevo_estado
        });

    } catch (error) {
        console.error('Error al cambiar estado:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }
};


// GET /api/incidencias/:id - Detalle integrado MySQL y MongoDB
const obtenerDetalleIntegrado = async (req, res) => {
    try {
        const id = parseInt(req.params.id);

        // 1Consultar MySQL incidencia ,  técnico , estado , ubicación
        const [filas] = await pool.query(
            `SELECT i.id_incidencia, i.codigo_incidencia, i.titulo, i.descripcion,
                    i.prioridad, i.fecha_registro, i.fecha_resolucion,
                    e.nombre_estado,
                    ur.nombre_completo AS reportado_por,
                    ut.nombre_completo AS tecnico_asignado,
                    a.nombre_activo, u.nombre_ubicacion
             FROM incidencias i
             INNER JOIN estados_incidencia e ON i.id_estado = e.id_estado
             INNER JOIN usuarios ur ON i.id_usuario_reporta = ur.id_usuario
             LEFT JOIN usuarios ut ON i.id_tecnico_asignado = ut.id_usuario
             INNER JOIN activos a ON i.id_activo = a.id_activo
             INNER JOIN ubicaciones u ON a.id_ubicacion = u.id_ubicacion
             WHERE i.id_incidencia = ?`,
            [id]
        );

        if (filas.length === 0) {
            return res.status(404).json({ error: 'Incidencia no encontrada' });
        }

        // 2 Consultar MongoDB diagnósticos y evidencias
        const db = getDB();
        const diagnosticos = await db.collection('diagnosticos')
            .find({ incidenciaId: id }).toArray();
        const evidencias = await db.collection('evidencias')
            .find({ incidenciaId: id }).toArray();

        //  Combinar ambas bases en un solo JSON 
        res.json({
            incidencia: filas[0],
            diagnosticos: diagnosticos,
            evidencias: evidencias
        });

    } catch (error) {
        console.error('Error en detalle integrado:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }
};







module.exports = { registrarIncidencia, listarIncidencias, asignarTecnico, cambiarEstado, obtenerDetalleIntegrado};


