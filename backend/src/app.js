const express = require('express');
const cors = require('cors');
require('dotenv').config();
const path = require('path');

// DB Configs
const { testConnection: testMySQL } = require('./config/db_mysql');
const { connectDB: connectMongo } = require('./config/db_mongo');


// Importar RUTAS
const authRoutes = require('./routes/authRoutes');
const diagnosticoRoutes = require('./routes/diagnosticoRoutes');
const evidenciaRoutes = require('./routes/evidenciaRoutes');
const incidenciaRoutes = require('./routes/incidenciaRoutes');
const reporteRoutes = require('./routes/reporteRoutes'); // Asegúrate que el nombre coincida



// ------
const app = express();
const PORT = process.env.PORT || 3000;

// Middlewares
app.use(cors());
app.use(express.json())
app.use(express.static(path.join(__dirname, '../../frontend')));

// RUTAS
app.use('/api', authRoutes);
app.use('/api', diagnosticoRoutes);
app.use('/api', evidenciaRoutes);
app.use('/api', incidenciaRoutes);
app.use('/api', reporteRoutes);


app.get('/', (req, res) => res.send('API CampusFix Funcionando'));

// Iniciar Servidor y Conexiones
const startServer = async () => {
    await testMySQL();
    await connectMongo();
    app.listen(PORT, () => console.log(`🚀 Servidor en http://localhost:${PORT}`));
};

startServer();
