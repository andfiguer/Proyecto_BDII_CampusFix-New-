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

// POST /api/incidencias (Registrar - Público o protegido según decidas, lo dejo público por ahora para pruebas fáciles)
router.post('/incidencias', registrarIncidencia);

// GET /api/incidencias (Listar - Público)
router.get('/incidencias', listarIncidencias);

// GET /api/incidencias/:id (Detalle Integrado - Público para que el frontend lo vea fácil)
router.get('/incidencias/:id', obtenerDetalleIntegrado);

// PUT /api/incidencias/:id/asignar (Asignar - PROTEGIDO con Token)
router.put('/incidencias/:id/asignar', verificarToken, asignarTecnico);

// PUT /api/incidencias/:id/estado (Cambiar Estado - PROTEGIDO con Token)
router.put('/incidencias/:id/estado', verificarToken, cambiarEstado);

module.exports = router;