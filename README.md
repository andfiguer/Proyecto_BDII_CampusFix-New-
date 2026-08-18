# Proyecto_BDII_CampusFix-New-
# CampusFix

Sistema híbrido para la gestión de incidencias tecnológicas universitarias.
Proyecto integrador — **Base de Datos II**, Universidad Tecnológica ECOTEC.

CampusFix centraliza el registro, asignación, diagnóstico y seguimiento de
incidencias tecnológicas (computadores, proyectores, impresoras, conectividad)
en aulas y laboratorios, combinando una base de datos relacional (MySQL) con
una base de datos documental (MongoDB) a través de un backend en Node.js/Express.

## Equipo

| Integrante | Responsabilidad principal |
|---|---|
| Jeremy Gómez Santistevan | Diseño y programación de MySQL (tablas, procedimientos, funciones, triggers, vistas) |
| Gonzalo Sigüenza Medina | Diseño de MongoDB e integración híbrida (colecciones, índices, consulta integrada) |
| Andy Figueroa | Desarrollo del backend (API REST con Node.js y Express, conexión MySQL y MongoDB) |
| Adrian Barahona | Frontend, pruebas y documentación (interfaz HTML/Bootstrap, pruebas, respaldo) |

Docente: Ing. Francisco Xavier Álvarez Solís, M.Sc.

## Arquitectura

```
Frontend (HTML + Bootstrap + JS)
        │
        ▼
Backend / API REST (Node.js + Express)
        │
   ┌────┴────┐
   ▼         ▼
 MySQL    MongoDB
(datos     (diagnósticos
estructurales) y evidencias)
```

El frontend nunca se conecta directamente a las bases de datos; toda consulta
pasa por el backend, que es responsable de combinar la información relacional
y documental cuando corresponde (por ejemplo, en el detalle de una incidencia).

## Tecnologías

| Componente | Tecnología |
|---|---|
| Backend | Node.js + Express.js |
| Base relacional | MySQL 8 / MariaDB |
| Base NoSQL | MongoDB |
| Frontend | HTML, Bootstrap, JavaScript |
| Autenticación | JWT |
| Pruebas de API | Postman / curl |
| Administración | MySQL Workbench o DBeaver, MongoDB Compass |
| Control de versiones | GitHub |

## Estructura del repositorio

```
campusfix/
├── backend/
│   ├── src/app.js
│   ├── .env
│   └── package.json
├── frontend/
│   ├── index.html
│   └── css/styles.css
├── database/
│   ├── mysql/
│   │   ├── 01_schema.sql
│   │   ├── 02_funciones_triggers.sql
│   │   ├── 03_datos_prueba.sql
│   │   ├── 04_procedimientos.sql
│   │   └── 05_vistas_transacciones.sql
│   └── mongodb/
│       └── mongodb_setup.js
├── respaldos/
│   ├── campusfix_respaldo_YYYY-MM-DD.sql
│   ├── campusfix_diagnosticos_YYYY-MM-DD.json
│   └── campusfix_evidencias_YYYY-MM-DD.json
└── docs/
```

## Instalación rápida

Instrucciones completas (con restauración desde respaldo e instalación desde
cero) en [`docs/MANUAL_INSTALACION.md`](docs/MANUAL_INSTALACION.md) o en el
documento `CampusFix_Manual_Instalacion_Restauracion.docx` dentro de `docs/`.

Resumen:

```bash
# 1. Clonar
git clone <url-del-repositorio>
cd campusfix

# 2. MySQL/MariaDB (opción A: restaurar respaldo)
sudo docker exec -i mariadb mariadb -u root -p'AdminMaria_123!' \
  -e "CREATE DATABASE IF NOT EXISTS campusfix;"
sudo docker exec -i mariadb mariadb -u root -p'AdminMaria_123!' campusfix \
  < respaldos/campusfix_respaldo_2026-08-17.sql

# 3. MongoDB (opción A: restaurar respaldo)
mongoimport --db=campusfix --collection=diagnosticos \
  --file=respaldos/campusfix_diagnosticos_2026-08-17.json --jsonArray
mongoimport --db=campusfix --collection=evidencias \
  --file=respaldos/campusfix_evidencias_2026-08-17.json --jsonArray

# 4. Backend
cd backend
npm install
# crear .env (ver plantilla abajo)
node src/app.js
```

Plantilla de `.env`:

```
PORT=3000
DB_HOST=localhost
DB_PORT=3307
DB_USER=root
DB_PASSWORD=AdminMaria_123!
DB_NAME=campusfix
MONGO_URI=mongodb://localhost:27017/campusfix
JWT_SECRET=<una-clave-secreta-larga-y-unica>
```

## Base de datos

**MySQL** — 8 tablas: `roles`, `usuarios`, `ubicaciones`, `activos`,
`estados_incidencia`, `incidencias`, `asignaciones`, `historial_estados`.
Incluye 3 procedimientos almacenados (`sp_registrar_incidencia`,
`sp_asignar_tecnico`, `sp_cambiar_estado`), 2 funciones, 4 triggers, 2 vistas
(`vw_incidencias_activas`, `vw_resumen_por_tecnico`) y 2 transacciones
demostradas (COMMIT y ROLLBACK).

**MongoDB** — 2 colecciones: `diagnosticos` y `evidencias`, cada una indexada
por `incidenciaId`.

## API REST (endpoints principales)

| Ruta | Método | Propósito |
|---|---|---|
| `/api/auth/login` | POST | Iniciar sesión |
| `/api/incidencias` | POST | Registrar una incidencia |
| `/api/incidencias` | GET | Listar incidencias |
| `/api/incidencias/:id` | GET | Consultar detalle integrado (MySQL + MongoDB) |
| `/api/incidencias/:id/asignar` | PUT | Asignar un técnico |
| `/api/incidencias/:id/estado` | PUT | Cambiar el estado |
| `/api/incidencias/:id/diagnosticos` | POST | Registrar un diagnóstico |
| `/api/incidencias/:id/evidencias` | POST | Registrar metadatos de evidencia |
| `/api/reportes/estados` | GET | Incidencias por estado |
| `/api/reportes/tecnicos` | GET | Incidencias por técnico |

## Reglas de negocio implementadas

- Solo un usuario activo puede iniciar sesión.
- Toda incidencia tiene un código único autogenerado (`INC-AAAA-NNNN`).
- Una incidencia nueva inicia en estado `Registrada`.
- No puede pasar a `En proceso` sin técnico asignado.
- No puede pasar a `Resuelta` sin diagnóstico registrado en MongoDB.
- Todo cambio de estado se registra en `historial_estados`.
- Una incidencia `Resuelta` no puede eliminarse físicamente.
- Los cambios que afectan varias tablas se ejecutan dentro de una transacción.

## Respaldo y restauración

Ver `docs/MANUAL_INSTALACION.md` — sección "Generar un nuevo respaldo" y
"Restaurar desde un respaldo existente" (MySQL vía `mysqldump`/`mysql`,
MongoDB vía `mongoexport`/`mongoimport`).

## Licencia / uso académico

Proyecto desarrollado con fines académicos para la asignatura Base de Datos II,
Universidad Tecnológica ECOTEC, 2026.
