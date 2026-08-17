const express = require('express');
const router = express.Router();
const { registrarEvidencia } = require('../controllers/evidenciaController');

// POST 
router.post('/incidencias/:id/evidencias', registrarEvidencia);

module.exports = router;