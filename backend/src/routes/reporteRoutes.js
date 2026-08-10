const express = require('express');
const router = express.Router();
const { reportePorEstado, reportePorTecnico } = require('../controllers/reporteController');
const { verificarToken } = require('../middleware/authMiddleware');

// GET /api/reportes/estados
router.get('/reportes/estados', reportePorEstado);

// GET /api/reportes/tecnicos
router.get('/reportes/tecnicos', reportePorTecnico);

// GET /api/reportes/estados 
router.get('/reportes/estados', verificarToken, reportePorEstado);

// GET /api/reportes/tecnicos 
router.get('/reportes/tecnicos', verificarToken, reportePorTecnico);
module.exports = router;