const { pool } = require('../config/db_mysql');

// GET /api/reportes/estados 
const reportePorEstado = async (req, res) => {
    try {
        const [filas] = await pool.query(`
            SELECT e.nombre_estado, COUNT(i.id_incidencia) AS total
            FROM estados_incidencia e
            LEFT JOIN incidencias i ON e.id_estado = i.id_estado
            GROUP BY e.id_estado, e.nombre_estado
            ORDER BY e.orden
        `);

        res.json({
            reporte: 'Incidencias por estado',
            datos: filas
        });
    } catch (error) {
        console.error('Error en reporte por estado:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }
};

// GET /api/reportes/tecnicos 
const reportePorTecnico = async (req, res) => {
    try {
        const [filas] = await pool.query('SELECT * FROM vw_resumen_por_tecnico');

        res.json({
            reporte: 'Resumen por técnico',
            datos: filas
        });
    } catch (error) {
        console.error('Error en reporte por técnico:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }
};

module.exports = { reportePorEstado, reportePorTecnico };