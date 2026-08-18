const jwt = require('jsonwebtoken');

const verificarToken = (req, res, next) => {
    // Buscar el token en el header (Authorization: Bearer TOKEN)
    const bearerHeader = req.headers['authorization'];

    if (!bearerHeader) {
        return res.status(403).json({ error: 'Acceso denegado: Token no proporcionado' });
    }

    // El formato suele ser "Bearer <token>", así que cortamos la palabra Bearer
    const token = bearerHeader.split(' ')[1];

    if (!token) {
        return res.status(403).json({ error: 'Formato de token inválido' });
    }

    try {
        // Verificar si el token es válido usando la clave secreta del .env
        const decoded = jwt.verify(token, process.env.JWT_SECRET);

        // Guardamos la info del usuario en la request para usarla en los controladores
        req.usuario = decoded;

        next(); // Continuar con la ejecución del controlador
    } catch (error) {
        res.status(401).json({ error: 'Token inválido o expirado' });
    }
};

module.exports = { verificarToken };