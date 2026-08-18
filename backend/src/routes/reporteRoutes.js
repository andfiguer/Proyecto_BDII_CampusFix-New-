const express = require('express');
const router = express.Router();

const {
  reportePorEstado,
  reportePorTecnico,
  reportePorActivos
} = require('../controllers/reporteController');

const { verificarToken } = require('../middleware/authMiddleware');

router.get('/reportes/estados', verificarToken, reportePorEstado);
router.get('/reportes/tecnicos', verificarToken, reportePorTecnico);
router.get('/reportes/activos', verificarToken, reportePorActivos);

module.exports = router;
