const express = require('express');
const router = express.Router();
const { verificarToken } = require('../middleware/authMiddleware');
const { 
    registrarIncidencia, 
    listarIncidencias, 
    asignarTecnico, 
    cambiarEstado, 
    obtenerDetalleIntegrado 
} = require('../controllers/incidenciaController');

// POST /api/incidencias (Registrar)
router.post('/incidencias', registrarIncidencia);

// GET /api/incidencias Listar
router.get('/incidencias', listarIncidencias);

// GET /api/incidencias/:id (Detalle Integrado
router.get('/incidencias/:id', obtenerDetalleIntegrado);

// PUT /api/incidencias/:id/asignar (Asignar esta protegido con Token)
router.put('/incidencias/:id/asignar', verificarToken, asignarTecnico);

// PUT /api/incidencias/:id/estado (Cambiar Estado - protegido con Token)
router.put('/incidencias/:id/estado', verificarToken, cambiarEstado);

module.exports = router;