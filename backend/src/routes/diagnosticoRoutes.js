const express = require('express');
const router = express.Router();
const { registrarDiagnostico } = require('../controllers/diagnosticoController');

// POST /api/incidencias/:id/diagnosticos
router.post('/incidencias/:id/diagnosticos', registrarDiagnostico);

module.exports = router;