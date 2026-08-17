const express = require('express');
const router = express.Router();
const { reportePorEstado, reportePorTecnico } = require('../controllers/reporteController');
const { verificarToken } = require('../middleware/authMiddleware');

// GET /api/reportes/estados (PROTEGIDO)
router.get('/reportes/estados', verificarToken, reportePorEstado);

// GET /api/reportes/tecnicos (PROTEGIDO)
router.get('/reportes/tecnicos', verificarToken, reportePorTecnico);

module.exports = router;