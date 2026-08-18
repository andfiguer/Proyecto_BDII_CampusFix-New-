const express = require('express');
const router = express.Router();

const {
  reportePorEstado,
  reportePorTecnico,
  reportePorActivos
} = require('../controllers/reporteController');

const {
  verificarToken
} = require('../middleware/authMiddleware');

// Reporte de incidencias agrupadas por estado
router.get(
  '/reportes/estados',
  verificarToken,
  reportePorEstado
);

// Reporte de incidencias agrupadas por técnico
router.get(
  '/reportes/tecnicos',
  verificarToken,
  reportePorTecnico
);

// Reporte de activos con mayor número de incidencias
router.get(
  '/reportes/activos',
  verificarToken,
  reportePorActivos
);

module.exports = router;
