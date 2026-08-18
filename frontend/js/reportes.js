const btnReporteEstados = document.getElementById('btnReporteEstados');
const btnReporteTecnicos = document.getElementById('btnReporteTecnicos');
const btnReporteActivos = document.getElementById('btnReporteActivos');
const resultadoReporte = document.getElementById('resultadoReporte');

btnReporteEstados.addEventListener('click', () => {
  cargarReporte('/api/reportes/estados');
});

btnReporteTecnicos.addEventListener('click', () => {
  cargarReporte('/api/reportes/tecnicos');
});

btnReporteActivos.addEventListener('click', () => {
  cargarReporte('/api/reportes/activos');
});

async function cargarReporte(ruta) {
  const token = localStorage.getItem('campusfixToken');

  if (!token) {
    resultadoReporte.innerHTML = `
      <div class="alert alert-warning mb-0">
        Inicia sesión antes de consultar reportes.
      </div>
    `;
    return;
  }

  resultadoReporte.innerHTML = '<div class="text-muted">Cargando reporte...</div>';

  try {
    const respuesta = await fetch(ruta, {
      headers: {
        'Authorization': `Bearer ${token}`
      }
    });

    const datos = await respuesta.json();

    if (!respuesta.ok) {
      resultadoReporte.innerHTML = `
        <div class="alert alert-danger mb-0">
          ${datos.error || 'No se pudo cargar el reporte.'}
        </div>
      `;
      return;
    }

    if (!datos.datos || datos.datos.length === 0) {
      resultadoReporte.innerHTML = `
        <div class="alert alert-warning mb-0">
          El reporte no contiene datos.
        </div>
      `;
      return;
    }

    const columnas = Object.keys(datos.datos[0]);

    const encabezados = columnas.map((columna) => `
      <th>${columna.replaceAll('_', ' ')}</th>
    `).join('');

    const filas = datos.datos.map((fila) => `
      <tr>
        ${columnas.map((columna) => `<td>${fila[columna] !== null && fila[columna] !== undefined ? fila[columna] : '-'}</td>`).join('')}
      </tr>
    `).join('');

    resultadoReporte.innerHTML = `
      <h4 class="h6 text-primary">${datos.reporte}</h4>
      <div class="table-responsive">
        <table class="table table-sm table-striped align-middle">
          <thead class="table-primary">
            <tr>${encabezados}</tr>
          </thead>
          <tbody>${filas}</tbody>
        </table>
      </div>
    `;
  } catch (error) {
    resultadoReporte.innerHTML = `
      <div class="alert alert-danger mb-0">
        Error de conexión al cargar el reporte.
      </div>
    `;
  }
}
