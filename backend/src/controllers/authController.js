const { pool } = require('../config/db_mysql');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');

const login = async (req, res) => {
    try {
        const { correo, contrasena } = req.body;

        //  Validar campos obligatorios
        if (!correo || !contrasena) {
            return res.status(400).json({ error: 'Correo y contraseña son obligatorios' });
        }

        //  Buscar usuario en MySQL
        const [filas] = await pool.query(
            'SELECT id_usuario, nombre_completo, correo, contrasena, id_rol, activo FROM usuarios WHERE correo = ?',
            [correo]
        );

        if (filas.length === 0) {
            return res.status(401).json({ error: 'Credenciales inválidas' });
        }

        const usuario = filas[0];

        //  Verificar que esté activo
        if (!usuario.activo) {
            return res.status(403).json({ error: 'Usuario inactivo' });
        }

        //  Comparar contraseña
        const crypto = require('crypto');
        const hashIngresado = crypto.createHash('sha256').update(contrasena).digest('hex');

        if (hashIngresado !== usuario.contrasena) {
            return res.status(401).json({ error: 'Credenciales inválidas' });
        }

        //. Generar Token
        const token = jwt.sign(
            {
                id: usuario.id_usuario,
                rol: usuario.id_rol,
                nombre: usuario.nombre_completo
            },
            process.env.JWT_SECRET,
            { expiresIn: '2h' }
        );

        //  Respuesta
        res.json({
            mensaje: 'Login exitoso',
            token,
            usuario: {
                id: usuario.id_usuario,
                nombre: usuario.nombre_completo,
                correo: usuario.correo,
                rol: usuario.id_rol
            }
        });

    } catch (error) {
        console.error('Error en login:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }
};

module.exports = { login };