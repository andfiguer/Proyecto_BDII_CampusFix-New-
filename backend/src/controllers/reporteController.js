const { pool } = require('../config/db_mysql');

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

const reportePorActivos = async (req, res) => {
  try {
    const [filas] = await pool.query(`
      SELECT
        a.id_activo,
        a.nombre_activo,
        u.nombre_ubicacion,
        COUNT(i.id_incidencia) AS total_incidencias
      FROM activos a
      INNER JOIN ubicaciones u ON a.id_ubicacion = u.id_ubicacion
      LEFT JOIN incidencias i ON a.id_activo = i.id_activo
      GROUP BY a.id_activo, a.nombre_activo, u.nombre_ubicacion
      ORDER BY total_incidencias DESC, a.nombre_activo ASC
      LIMIT 10
    `);

    res.json({
      reporte: 'Activos con mayor número de incidencias',
      datos: filas
    });
  } catch (error) {
    console.error('Error en reporte por activos:', error);
    res.status(500).json({ error: 'Error interno del servidor' });
  }
};

module.exports = {
  reportePorEstado,
  reportePorTecnico,
  reportePorActivos
};
