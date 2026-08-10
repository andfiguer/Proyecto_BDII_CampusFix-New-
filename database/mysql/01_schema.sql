CREATE DATABASE IF NOT EXISTS campusfix CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE campusfix;

CREATE TABLE roles (
  id_rol INT AUTO_INCREMENT PRIMARY KEY,
  nombre_rol VARCHAR(30) NOT NULL UNIQUE,
  descripcion VARCHAR(150)
);

CREATE TABLE usuarios (
  id_usuario INT AUTO_INCREMENT PRIMARY KEY,
  nombre_completo VARCHAR(100) NOT NULL,
  correo VARCHAR(100) NOT NULL UNIQUE,
  contrasena VARCHAR(255) NOT NULL,
  id_rol INT NOT NULL,
  activo TINYINT(1) NOT NULL DEFAULT 1,
  fecha_registro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_usuarios_rol FOREIGN KEY (id_rol) REFERENCES roles(id_rol)
);

CREATE TABLE ubicaciones (
  id_ubicacion INT AUTO_INCREMENT PRIMARY KEY,
  nombre_ubicacion VARCHAR(50) NOT NULL,
  tipo VARCHAR(30) NOT NULL,
  descripcion VARCHAR(150)
);

CREATE TABLE activos (
  id_activo INT AUTO_INCREMENT PRIMARY KEY,
  nombre_activo VARCHAR(100) NOT NULL,
  tipo_activo VARCHAR(50) NOT NULL,
  id_ubicacion INT NOT NULL,
  estado_activo VARCHAR(20) NOT NULL DEFAULT 'Operativo',
  CONSTRAINT fk_activos_ubicacion FOREIGN KEY (id_ubicacion) REFERENCES ubicaciones(id_ubicacion),
  CONSTRAINT chk_estado_activo CHECK (estado_activo IN ('Operativo','Danado','Mantenimiento','Fuera de servicio'))
);

CREATE TABLE estados_incidencia (
  id_estado INT AUTO_INCREMENT PRIMARY KEY,
  nombre_estado VARCHAR(20) NOT NULL UNIQUE,
  orden INT NOT NULL
);

CREATE TABLE incidencias (
  id_incidencia INT AUTO_INCREMENT PRIMARY KEY,
  codigo_incidencia VARCHAR(20) UNIQUE,
  titulo VARCHAR(100) NOT NULL,
  descripcion TEXT,
  prioridad VARCHAR(10) NOT NULL DEFAULT 'Media',
  id_activo INT NOT NULL,
  id_usuario_reporta INT NOT NULL,
  id_tecnico_asignado INT NULL,
  id_estado INT NOT NULL,
  fecha_registro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  fecha_resolucion DATETIME NULL,
  CONSTRAINT fk_incidencias_activo FOREIGN KEY (id_activo) REFERENCES activos(id_activo),
  CONSTRAINT fk_incidencias_usuario FOREIGN KEY (id_usuario_reporta) REFERENCES usuarios(id_usuario),
  CONSTRAINT fk_incidencias_tecnico FOREIGN KEY (id_tecnico_asignado) REFERENCES usuarios(id_usuario),
  CONSTRAINT fk_incidencias_estado FOREIGN KEY (id_estado) REFERENCES estados_incidencia(id_estado),
  CONSTRAINT chk_prioridad CHECK (prioridad IN ('Baja','Media','Alta','Urgente'))
);

CREATE TABLE asignaciones (
  id_asignacion INT AUTO_INCREMENT PRIMARY KEY,
  id_incidencia INT NOT NULL,
  id_tecnico INT NOT NULL,
  asignado_por INT NOT NULL,
  fecha_asignacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_asignaciones_incidencia FOREIGN KEY (id_incidencia) REFERENCES incidencias(id_incidencia),
  CONSTRAINT fk_asignaciones_tecnico FOREIGN KEY (id_tecnico) REFERENCES usuarios(id_usuario),
  CONSTRAINT fk_asignaciones_admin FOREIGN KEY (asignado_por) REFERENCES usuarios(id_usuario)
);

CREATE TABLE historial_estados (
  id_historial INT AUTO_INCREMENT PRIMARY KEY,
  id_incidencia INT NOT NULL,
  id_estado INT NOT NULL,
  fecha_cambio DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  comentario VARCHAR(255),
  CONSTRAINT fk_historial_incidencia FOREIGN KEY (id_incidencia) REFERENCES incidencias(id_incidencia),
  CONSTRAINT fk_historial_estado FOREIGN KEY (id_estado) REFERENCES estados_incidencia(id_estado)
);

CREATE INDEX idx_incidencias_estado ON incidencias(id_estado);
CREATE INDEX idx_incidencias_tecnico ON incidencias(id_tecnico_asignado);