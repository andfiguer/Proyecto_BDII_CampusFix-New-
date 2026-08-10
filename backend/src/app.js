const express = require('express');
const cors = require('cors');
require('dotenv').config();

// Importar configuraciones de DB
const { testConnection: testMySQL } = require('./config/db_mysql');
const { connectDB: connectMongo } = require('./config/db_mongo');

// Importar RUTAS
const diagnosticoRoutes = require('./routes/diagnosticoRoutes');
const evidenciaRoutes = require('./routes/evidenciaRoutes');
const authRoutes = require('./routes/authRoutes');
const incidenciaRoutes = require('./routes/incidenciaRoutes');
const reporteRoutes = require('./routes/reporteRoutes');


// ------
const app = express();
const PORT = process.env.PORT || 3000;

// Middlewares
app.use(cors());
app.use(express.json()); 

// RUTAS
app.use('/api', diagnosticoRoutes);
app.use('/api', evidenciaRoutes);
app.use('/api', authRoutes);
app.use('/api', incidenciaRoutes);
app.use('/api', reporteRoutes);


// Ruta de prueba básica
app.get('/', (req, res) => {
  res.send('API CampusFix funcionando...');
});

// Iniciar Servidor y Conexiones
const startServer = async () => {
  
  await testMySQL();
  await connectMongo();

  app.listen(PORT, () => {
    console.log(`🚀 Servidor corriendo en http://localhost:${PORT}`);
  });
};

startServer();