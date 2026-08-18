const express = require('express');
const router = express.Router();

const {
  registrarIncidencia,
  listarIncidencias,
  asignarTecnico,
  cambiarEstado,
  obtenerDetalleIntegrado
} = require('../controllers/incidenciaController');

const {
  verificarToken
} = require('../middleware/authMiddleware');

// Registrar una incidencia
router.post(
  '/incidencias',
  registrarIncidencia
);

// Listar incidencias activas
router.get(
  '/incidencias',
  listarIncidencias
);

// Consultar detalle integrado MySQL y MongoDB
router.get(
  '/incidencias/:id',
  obtenerDetalleIntegrado
);

// Asignar técnico: operación protegida con JWT
router.put(
  '/incidencias/:id/asignar',
  verificarToken,
  asignarTecnico
);

// Cambiar estado: operación protegida con JWT
router.put(
  '/incidencias/:id/estado',
  verificarToken,
  cambiarEstado
);

module.exports = router;
