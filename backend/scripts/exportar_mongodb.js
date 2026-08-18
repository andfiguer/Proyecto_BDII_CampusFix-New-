const fs = require('fs');
const path = require('path');
const { MongoClient } = require('mongodb');

require('dotenv').config({
  path: path.join(__dirname, '..', '.env')
});

const colecciones = ['diagnosticos', 'evidencias'];

async function exportarMongoDB() {
  if (!process.env.MONGO_URI) {
    throw new Error('No se encontró MONGO_URI en el archivo .env');
  }

  const carpetaSalida = path.join(
    __dirname,
    '..',
    '..',
    'database',
    'backups',
    'mongodb'
  );

  await fs.promises.mkdir(carpetaSalida, { recursive: true });

  const cliente = new MongoClient(process.env.MONGO_URI);

  try {
    await cliente.connect();

    const db = cliente.db('campusfix');

    for (const nombreColeccion of colecciones) {
      const documentos = await db.collection(nombreColeccion).find({}).toArray();

      const archivoSalida = path.join(
        carpetaSalida,
        `${nombreColeccion}_respaldo.json`
      );

      await fs.promises.writeFile(
        archivoSalida,
        JSON.stringify(documentos, null, 2),
        'utf8'
      );

      console.log(
        `Colección ${nombreColeccion}: ${documentos.length} documentos exportados`
      );
    }
  } finally {
    await cliente.close();
  }
}

exportarMongoDB().catch((error) => {
  console.error('Error al exportar MongoDB:', error.message);
  process.exit(1);
});
