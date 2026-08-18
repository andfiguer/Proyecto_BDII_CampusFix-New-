let tokenJWT = localStorage.getItem('campusfixToken') || '';

const loginForm = document.getElementById('loginForm');
const loginMensaje = document.getElementById('loginMensaje');

const btnCargarIncidencias = document.getElementById('btnCargarIncidencias');
const listaIncidencias = document.getElementById('listaIncidencias');

const incidenciaForm = document.getElementById('incidenciaForm');
const incidenciaMensaje = document.getElementById('incidenciaMensaje');

const btnDetalle = document.getElementById('btnDetalle');
const detalleIncidencia = document.getElementById('detalleIncidencia');

const btnAsignarTecnico = document.getElementById('btnAsignarTecnico');
const btnRegistrarDiagnostico = document.getElementById('btnRegistrarDiagnostico');
const btnCambiarEstado = document.getElementById('btnCambiarEstado');
const gestionMensaje = document.getElementById('gestionMensaje');

function mostrarMensaje(elemento, tipo, texto) {
  elemento.innerHTML = `<div class="alert alert-${tipo} mb-0">${texto}</div>`;
}

loginForm.addEventListener('submit', async (event) => {
  event.preventDefault();

  const correo = document.getElementById('correo').value;
  const contrasena = document.getElementById('contrasena').value;

  loginMensaje.innerHTML = '<div class="text-muted">Validando credenciales...</div>';

  try {
    const respuesta = await fetch('/api/auth/login', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ correo, contrasena })
    });

    const datos = await respuesta.json();

    if (!respuesta.ok) {
      mostrarMensaje(loginMensaje, 'danger', datos.error);
      return;
    }

    tokenJWT = datos.token;
    localStorage.setItem('campusfixToken', tokenJWT);
    localStorage.setItem('campusfixUsuarioId', datos.usuario.id);

    mostrarMensaje(
      loginMensaje,
      'success',
      `Sesión iniciada: <strong>${datos.usuario.nombre}</strong>. Token JWT almacenado correctamente.`
    );
  } catch (error) {
    mostrarMensaje(loginMensaje, 'danger', 'No se pudo conectar con la API.');
  }
});

btnCargarIncidencias.addEventListener('click', cargarIncidencias);

async function cargarIncidencias() {
  listaIncidencias.innerHTML = '<div class="text-muted">Cargando incidencias...</div>';

  try {
    const respuesta = await fetch('/api/incidencias');
    const datos = await respuesta.json();

    if (!respuesta.ok) {
      mostrarMensaje(listaIncidencias, 'danger', datos.error || 'No se pudieron cargar las incidencias.');
      return;
    }

    if (!datos.incidencias || datos.incidencias.length === 0) {
      mostrarMensaje(listaIncidencias, 'warning', 'No existen incidencias activas.');
      return;
    }

    const filas = datos.incidencias.map((incidencia) => `
      <tr>
        <td>${incidencia.id_incidencia}</td>
        <td>${incidencia.codigo_incidencia || '-'}</td>
        <td>${incidencia.titulo || '-'}</td>
        <td>${incidencia.prioridad || '-'}</td>
        <td>${incidencia.nombre_estado || incidencia.estado || '-'}</td>
      </tr>
    `).join('');

    listaIncidencias.innerHTML = `
      <p class="small text-muted mb-2">Total de incidencias activas: ${datos.total}</p>
      <div class="table-responsive">
        <table class="table table-sm table-striped align-middle">
          <thead class="table-primary">
            <tr>
              <th>ID</th>
              <th>Código</th>
              <th>Título</th>
              <th>Prioridad</th>
              <th>Estado</th>
            </tr>
          </thead>
          <tbody>${filas}</tbody>
        </table>
      </div>
    `;
  } catch (error) {
    mostrarMensaje(listaIncidencias, 'danger', 'Error de conexión al cargar incidencias.');
  }
}

incidenciaForm.addEventListener('submit', async (event) => {
  event.preventDefault();

  const titulo = document.getElementById('tituloIncidencia').value;
  const descripcion = document.getElementById('descripcionIncidencia').value;
  const prioridad = document.getElementById('prioridadIncidencia').value;
  const id_activo = Number(document.getElementById('activoIncidencia').value);
  const id_usuario_reporta = Number(document.getElementById('usuarioReporta').value);

  incidenciaMensaje.innerHTML = '<div class="text-muted">Registrando incidencia...</div>';

  try {
    const respuesta = await fetch('/api/incidencias', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ titulo, descripcion, prioridad, id_activo, id_usuario_reporta })
    });

    const datos = await respuesta.json();

    if (!respuesta.ok) {
      mostrarMensaje(incidenciaMensaje, 'danger', datos.error || 'No se pudo registrar la incidencia.');
      return;
    }

    mostrarMensaje(
      incidenciaMensaje,
      'success',
      `${datos.mensaje}<br>ID generado: <strong>${datos.id_incidencia}</strong>`
    );

    incidenciaForm.reset();
    cargarIncidencias();
  } catch (error) {
    mostrarMensaje(incidenciaMensaje, 'danger', 'Error de conexión al registrar la incidencia.');
  }
});

btnDetalle.addEventListener('click', consultarDetalle);

async function consultarDetalle() {
  const id = document.getElementById('idDetalle').value;

  if (!id) {
    mostrarMensaje(detalleIncidencia, 'warning', 'Ingresa el ID de una incidencia.');
    return;
  }

  detalleIncidencia.innerHTML = '<div class="text-muted">Consultando información integrada...</div>';

  try {
    const respuesta = await fetch(`/api/incidencias/${id}`);
    const datos = await respuesta.json();

    if (!respuesta.ok) {
      mostrarMensaje(detalleIncidencia, 'danger', datos.error || 'No se pudo consultar la incidencia.');
      return;
    }

    const incidencia = datos.incidencia;
    const diagnosticos = datos.diagnosticos || [];
    const evidencias = datos.evidencias || [];

    const diagnosticosHTML = diagnosticos.length > 0
      ? diagnosticos.map((diagnostico) => `
          <li class="list-group-item">
            <strong>${diagnostico.descripcion}</strong><br>
            Causa: ${diagnostico.causaProbable}<br>
            Solución: ${diagnostico.solucionAplicada}
          </li>
        `).join('')
      : '<li class="list-group-item">No existen diagnósticos registrados.</li>';

    const evidenciasHTML = evidencias.length > 0
      ? evidencias.map((evidencia) => `
          <li class="list-group-item">
            <strong>${evidencia.nombre}</strong><br>
            Tipo: ${evidencia.tipo}<br>
            URL: <a href="${evidencia.url}" target="_blank">${evidencia.url}</a>
          </li>
        `).join('')
      : '<li class="list-group-item">No existen evidencias registradas.</li>';

    detalleIncidencia.innerHTML = `
      <div class="alert alert-success">Consulta híbrida completada: MySQL + MongoDB.</div>

      <h3 class="h6 text-primary">Datos de la incidencia (MySQL)</h3>
      <ul class="list-group mb-3">
        <li class="list-group-item"><strong>Código:</strong> ${incidencia.codigo_incidencia}</li>
        <li class="list-group-item"><strong>Título:</strong> ${incidencia.titulo}</li>
        <li class="list-group-item"><strong>Estado:</strong> ${incidencia.nombre_estado}</li>
        <li class="list-group-item"><strong>Reportado por:</strong> ${incidencia.reportado_por}</li>
        <li class="list-group-item"><strong>Técnico:</strong> ${incidencia.tecnico_asignado || 'Sin asignar'}</li>
        <li class="list-group-item"><strong>Activo:</strong> ${incidencia.nombre_activo}</li>
      </ul>

      <h3 class="h6 text-success">Diagnósticos (MongoDB)</h3>
      <ul class="list-group mb-3">${diagnosticosHTML}</ul>

      <h3 class="h6 text-warning">Evidencias (MongoDB)</h3>
      <ul class="list-group">${evidenciasHTML}</ul>
    `;
  } catch (error) {
    mostrarMensaje(detalleIncidencia, 'danger', 'Error de conexión al consultar el detalle.');
  }
}

btnAsignarTecnico.addEventListener('click', asignarTecnico);

async function asignarTecnico() {
  const idIncidencia = Number(document.getElementById('idIncidenciaGestion').value);
  const idTecnico = Number(document.getElementById('idTecnico').value);
  const asignadoPor = Number(localStorage.getItem('campusfixUsuarioId'));

  if (!tokenJWT || !asignadoPor) {
    mostrarMensaje(gestionMensaje, 'warning', 'Inicia sesión antes de asignar un técnico.');
    return;
  }

  if (!idIncidencia || !idTecnico) {
    mostrarMensaje(gestionMensaje, 'warning', 'Ingresa el ID de incidencia y el ID del técnico.');
    return;
  }

  gestionMensaje.innerHTML = '<div class="text-muted">Asignando técnico...</div>';

  try {
    const respuesta = await fetch(`/api/incidencias/${idIncidencia}/asignar`, {
      method: 'PUT',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${tokenJWT}`
      },
      body: JSON.stringify({
        id_tecnico: idTecnico,
        asignado_por: asignadoPor
      })
    });

    const datos = await respuesta.json();

    if (!respuesta.ok) {
      mostrarMensaje(gestionMensaje, 'danger', datos.error || 'No se pudo asignar el técnico.');
      return;
    }

    mostrarMensaje(
      gestionMensaje,
      'success',
      `${datos.mensaje}<br>Incidencia: <strong>${datos.incidencia_id}</strong> - Técnico asignado: <strong>${datos.tecnico_id}</strong>`
    );

    cargarIncidencias();
  } catch (error) {
    mostrarMensaje(gestionMensaje, 'danger', 'Error de conexión al asignar técnico.');
  }
}

btnRegistrarDiagnostico.addEventListener('click', registrarDiagnostico);

async function registrarDiagnostico() {
  const idIncidencia = Number(document.getElementById('idIncidenciaDiagnostico').value);
  const tecnicoId = Number(document.getElementById('idTecnicoDiagnostico').value);
  const descripcion = document.getElementById('descripcionDiagnostico').value;
  const pruebasTexto = document.getElementById('pruebasDiagnostico').value;
  const causaProbable = document.getElementById('causaProbable').value;
  const solucionAplicada = document.getElementById('solucionAplicada').value;

  if (!idIncidencia || !tecnicoId || !descripcion || !causaProbable || !solucionAplicada) {
    mostrarMensaje(gestionMensaje, 'warning', 'Completa todos los campos obligatorios del diagnóstico.');
    return;
  }

  const pruebasRealizadas = pruebasTexto
    .split(',')
    .map((prueba) => prueba.trim())
    .filter((prueba) => prueba !== '');

  gestionMensaje.innerHTML = '<div class="text-muted">Registrando diagnóstico en MongoDB...</div>';

  try {
    const respuesta = await fetch(`/api/incidencias/${idIncidencia}/diagnosticos`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        tecnicoId,
        descripcion,
        pruebasRealizadas,
        causaProbable,
        solucionAplicada
      })
    });

    const datos = await respuesta.json();

    if (!respuesta.ok) {
      mostrarMensaje(gestionMensaje, 'danger', datos.error || 'No se pudo registrar el diagnóstico.');
      return;
    }

    mostrarMensaje(
      gestionMensaje,
      'success',
      `${datos.mensaje}<br>Diagnóstico registrado en MongoDB para la incidencia <strong>${idIncidencia}</strong>.`
    );
  } catch (error) {
    mostrarMensaje(gestionMensaje, 'danger', 'Error de conexión al registrar el diagnóstico.');
  }
}

btnCambiarEstado.addEventListener('click', cambiarEstado);

async function cambiarEstado() {
  const idIncidencia = Number(document.getElementById('idIncidenciaEstado').value);
  const nuevoEstado = document.getElementById('nuevoEstado').value;
  const diagnosticoConfirmado = document.getElementById('diagnosticoConfirmado').checked ? 1 : 0;

  if (!tokenJWT) {
    mostrarMensaje(gestionMensaje, 'warning', 'Inicia sesión antes de cambiar el estado.');
    return;
  }

  if (!idIncidencia) {
    mostrarMensaje(gestionMensaje, 'warning', 'Ingresa el ID de la incidencia.');
    return;
  }

  gestionMensaje.innerHTML = '<div class="text-muted">Actualizando estado...</div>';

  try {
    const respuesta = await fetch(`/api/incidencias/${idIncidencia}/estado`, {
      method: 'PUT',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${tokenJWT}`
      },
      body: JSON.stringify({
        nuevo_estado: nuevoEstado,
        diagnostico_confirmado: diagnosticoConfirmado
      })
    });

    const datos = await respuesta.json();

    if (!respuesta.ok) {
      mostrarMensaje(gestionMensaje, 'danger', datos.error || 'No se pudo cambiar el estado.');
      return;
    }

    mostrarMensaje(
      gestionMensaje,
      'success',
      `${datos.mensaje}<br>Incidencia: <strong>${datos.incidencia_id}</strong> - Nuevo estado: <strong>${datos.nuevo_estado}</strong>`
    );

    cargarIncidencias();
  } catch (error) {
    mostrarMensaje(gestionMensaje, 'danger', 'Error de conexión al cambiar el estado.');
  }
}
