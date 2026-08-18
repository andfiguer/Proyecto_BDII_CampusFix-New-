# CampusFix

Sistema web para la gestión de incidencias tecnológicas en una institución educativa, desarrollado como proyecto integrador de Base de Datos II.

CampusFix permite registrar incidencias relacionadas con equipos tecnológicos, asignar técnicos, registrar diagnósticos, cambiar estados, consultar información integrada y generar reportes.

## Tecnologías

- Node.js
- Express
- MySQL/MariaDB
- MongoDB
- JSON Web Token
- HTML
- CSS
- JavaScript
- Bootstrap

## Arquitectura

El proyecto utiliza dos motores de bases de datos:

- **MySQL:** usuarios, roles, activos, ubicaciones, incidencias, asignaciones, estados e historial.
- **MongoDB:** diagnósticos y evidencias.

La relación entre ambas bases se realiza mediante:

```text
MySQL: incidencias.id_incidencia
MongoDB: diagnosticos.incidenciaId
MongoDB: evidencias.incidenciaId
```

La API consulta ambos motores y combina los resultados en una sola respuesta JSON.

## Estructura del proyecto

```text
Proyecto_BDII_CampusFix-New-/
├── backend/
│   ├── scripts/
│   │   └── exportar_mongodb.js
│   ├── src/
│   │   ├── config/
│   │   ├── controllers/
│   │   ├── middleware/
│   │   ├── routes/
│   │   └── app.js
│   ├── .env.example
│   ├── package.json
│   └── package-lock.json
├── frontend/
│   ├── css/
│   │   └── styles.css
│   ├── js/
│   │   ├── app.js
│   │   └── reportes.js
│   └── index.html
├── database/
│   ├── mysql/
│   │   ├── 01_schema.sql
│   │   ├── 02_funciones_triggers.sql
│   │   ├── 03_datos_prueba.sql
│   │   ├── 04_procedimientos.sql
│   │   └── 05_vistas_transacciones.sql
│   ├── mongodb/
│   │   └── mongodb_setup.js
│   └── backups/
│       ├── mysql/
│       └── mongodb/
├── docs/
│   └── avance4/
├── .gitignore
└── README.md
```

## Requisitos

- Node.js
- npm
- MySQL o MariaDB
- MongoDB
- Git

## Preparación del entorno

Ingresar al backend:

```bash
cd backend
```

Instalar dependencias:

```bash
npm install
```

Crear el archivo de configuración:

```bash
cp .env.example .env
```

Editar `.env` y colocar las credenciales reales de MySQL, MongoDB y JWT.

Ejemplo de variables:

```env
PORT=3000
DB_HOST=localhost
DB_PORT=3306
DB_USER=usuario_mysql
DB_PASSWORD=contrasena_mysql
DB_NAME=campusfix
MONGO_URI=mongodb://usuario:contrasena@localhost:27017/campusfix
JWT_SECRET=clave_segura
```

El archivo `.env` no se almacena en Git.

## Preparación de MySQL

Los scripts deben ejecutarse en este orden:

1. `01_schema.sql`
2. `02_funciones_triggers.sql`
3. `03_datos_prueba.sql`
4. `04_procedimientos.sql`
5. `05_vistas_transacciones.sql`

Estos scripts crean:

- 8 tablas.
- 2 funciones.
- 4 triggers.
- 3 procedimientos almacenados.
- 2 vistas.
- Índices.
- Datos de prueba.
- Ejemplos de transacciones.

No se recomienda volver a ejecutar los scripts de datos sobre una base ya preparada, porque se podrían duplicar registros.

## Preparación de MongoDB

El archivo:

```text
database/mongodb/mongodb_setup.js
```

crea las colecciones:

- `diagnosticos`
- `evidencias`

También crea índices sobre `incidenciaId` e inserta datos de prueba.

## Ejecución

Desde la carpeta `backend`:

```bash
npm start
```

Resultado esperado:

```text
MySQL conectado correctamente
MongoDB conectado correctamente
Servidor en http://localhost:3000
```

Abrir en el navegador:

```text
http://localhost:3000
```

## Usuario de demostración

```text
Correo: carlos.andrade@ecotec.edu.ec
Contraseña: Admin123
```

Estas credenciales pertenecen exclusivamente al conjunto de datos de prueba.

## Funcionalidades

- Autenticación con JWT.
- Registro de incidencias.
- Generación automática del código de incidencia.
- Listado de incidencias activas.
- Asignación de técnicos.
- Registro de diagnósticos.
- Registro de evidencias.
- Cambio de estado.
- Historial automático.
- Consulta integrada MySQL y MongoDB.
- Reportes por estado.
- Reportes por técnico.
- Reportes de activos con más incidencias.
- Respaldos de MySQL y MongoDB.

## Endpoints principales

### Autenticación

```http
POST /api/auth/login
```

### Incidencias

```http
POST /api/incidencias
GET  /api/incidencias
GET  /api/incidencias/:id
PUT  /api/incidencias/:id/asignar
PUT  /api/incidencias/:id/estado
```

### Diagnósticos y evidencias

```http
POST /api/incidencias/:id/diagnosticos
POST /api/incidencias/:id/evidencias
```

### Reportes

```http
GET /api/reportes/estados
GET /api/reportes/tecnicos
GET /api/reportes/activos
```

Las operaciones de asignación, cambio de estado y reportes requieren un token JWT.

Formato del encabezado:

```http
Authorization: Bearer TOKEN
```

## Prueba rápida

Comprobar la API:

```bash
curl http://localhost:3000/api/incidencias
```

Comprobar la integración:

```bash
curl http://localhost:3000/api/incidencias/1
```

La consulta integrada devuelve:

- Información de la incidencia desde MySQL.
- Diagnósticos desde MongoDB.
- Evidencias desde MongoDB.

## Respaldos

Los respaldos se encuentran en:

```text
database/backups/mysql/
database/backups/mongodb/
```

MySQL se respalda en formato SQL.

MongoDB se respalda en archivos JSON correspondientes a las colecciones `diagnosticos` y `evidencias`.

## Seguridad

- Las operaciones administrativas utilizan JWT.
- Las consultas SQL utilizan parámetros.
- Las credenciales se almacenan en `.env`.
- `.env` y `node_modules` están excluidos mediante `.gitignore`.
- Las reglas principales también se validan mediante procedimientos y restricciones de la base de datos.

## Flujo principal

```text
Registrar incidencia
        ↓
Generar código e historial
        ↓
Asignar técnico
        ↓
Registrar diagnóstico
        ↓
Cambiar a En proceso
        ↓
Cambiar a Resuelta
        ↓
Consultar detalle integrado
```

## Proyecto académico

Proyecto integrador desarrollado para la asignatura Base de Datos II.
