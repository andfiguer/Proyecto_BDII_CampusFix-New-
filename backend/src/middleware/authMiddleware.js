const jwt = require('jsonwebtoken');


const verificarToken = (req, res, next) => {
    const header = req.headers.authorization;

    //  Si no hay header de autorización, rechazar
    if (!header) {
        return res.status(401).json({ error: 'Token no proporcionado' });
    }

    //  El formato debe ser: "Bearer <token>"
    const token = header.startsWith('Bearer ') ? header.split(' ')[1] : header;

    try {
        //  Verificar que el token sea válido y no haya expirado
        const datos = jwt.verify(token, process.env.JWT_SECRET);
        req.usuario = datos; // Guardamos  id, rol, nombre 
        next(); // 
    } catch (error) {
        //  Token inválido o expirado
        return res.status(401).json({ error: 'Token inválido o expirado' });
    }
};

module.exports = { verificarToken };