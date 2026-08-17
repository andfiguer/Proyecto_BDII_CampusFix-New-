const { MongoClient } = require('mongodb');
require('dotenv').config();

const uri = process.env.MONGO_URI;
const client = new MongoClient(uri);

let db;

const connectDB = async () => {
  try {
    await client.connect();
    db = client.db('campusfix'); 
    console.log('✅ MongoDB conectado correctamente');
  } catch (error) {
    console.error(' Error conectando a MongoDB:', error.message);
  }
};

const getDB = () => {
  if (!db) {
    throw new Error('Base de datos no inicializada. Llama a connectDB primero.');
  }
  return db;
};

module.exports = { connectDB, getDB };