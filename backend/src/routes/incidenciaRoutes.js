const express = require('express');
const router = express.Router();
const { verificarToken } = require('../middleware/authMiddleware');
const { registrarIncidencia, listarIncidencias, asignarTecnico, cambiarEstado, obtenerDetalleIntegrado } = require('../controllers/incidenciaController');

// POST /api/incidencias
router.post('/incidencias', registrarIncidencia);

// GET /api/incidencias 
router.get('/incidencias', listarIncidencias);

// PUT /api/incidencias/:id/asignar 
router.put('/incidencias/:id/asignar', asignarTecnico);


// PUT /api/incidencias/:id/estado 
router.put('/incidencias/:id/estado', cambiarEstado);


// PUT /api/incidencias/:id/asignar 
router.put('/incidencias/:id/asignar', verificarToken, asignarTecnico);

// PUT /api/incidencias/:id/estado 
router.put('/incidencias/:id/estado', verificarToken, cambiarEstado);


// GET /api/incidencias/:id Integración híbrida
router.get('/incidencias/:id', obtenerDetalleIntegrado);

   
module.exports = router;