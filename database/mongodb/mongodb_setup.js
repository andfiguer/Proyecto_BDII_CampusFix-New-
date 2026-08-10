db = db.getSiblingDB('campusfix');

db.createCollection("diagnosticos");
db.createCollection("evidencias");
db.diagnosticos.createIndex({ incidenciaId: 1 });
db.evidencias.createIndex({ incidenciaId: 1 });

const tecnicos = [2, 3, 4];
const causas = ["Falla de energia", "Componente danado", "Configuracion incorrecta", "Controlador desactualizado", "Cable suelto", "Sobrecalentamiento", "Software corrupto", "Falta de mantenimiento"];
const soluciones = ["Reemplazo de pieza", "Reinstalacion de software", "Ajuste de configuracion", "Limpieza del equipo", "Actualizacion de controladores", "Reinicio y prueba"];

const diagnosticos = [];
for (let i = 1; i <= 20; i++) {
  diagnosticos.push({
    incidenciaId: i, tecnicoId: tecnicos[i % tecnicos.length],
    descripcion: `Diagnostico de la incidencia ${i}`,
    pruebasRealizadas: ["Prueba inicial", "Prueba de verificacion"],
    causaProbable: causas[i % causas.length],
    solucionAplicada: soluciones[i % soluciones.length],
    fecha: new Date()
  });
}
db.diagnosticos.insertMany(diagnosticos);

const evidencias = [];
for (let i = 1; i <= 20; i++) {
  const esImagen = i % 2 === 0;
  evidencias.push({
    incidenciaId: i, tipo: esImagen ? "imagen" : "documento",
    nombre: `evidencia_${i}.${esImagen ? "jpg" : "pdf"}`,
    url: `https://ejemplo.local/evidencias/evidencia_${i}.${esImagen ? "jpg" : "pdf"}`,
    descripcion: `Evidencia registrada para la incidencia ${i}`,
    fecha: new Date()
  });
}
db.evidencias.insertMany(evidencias);

print("Colecciones e indices creados.");
print("Diagnosticos insertados: " + db.diagnosticos.countDocuments());
print("Evidencias insertadas: " + db.evidencias.countDocuments());