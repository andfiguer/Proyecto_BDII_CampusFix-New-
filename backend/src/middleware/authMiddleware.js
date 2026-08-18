const jwt = require('jsonwebtoken');

const verificarToken = (req, res, next) => {
  const authorizationHeader = req.headers.authorization;

  if (!authorizationHeader) {
    return res.status(403).json({
      error: 'Acceso denegado: Token no proporcionado'
    });
  }

  const [tipo, token] = authorizationHeader.split(' ');

  if (tipo !== 'Bearer' || !token) {
    return res.status(403).json({
      error: 'Formato de token inválido'
    });
  }

  try {
    const decoded = jwt.verify(
      token,
      process.env.JWT_SECRET
    );

    req.usuario = decoded;
    next();
  } catch (error) {
    return res.status(401).json({
      error: 'Token inválido o expirado'
    });
  }
};

module.exports = { verificarToken };
