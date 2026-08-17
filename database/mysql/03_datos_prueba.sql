USE campusfix;

INSERT INTO roles (nombre_rol, descripcion) VALUES
('Administrador','Gestiona incidencias, tecnicos y reportes'),
('Tecnico','Atiende y da seguimiento a incidencias asignadas'),
('Usuario','Reporta incidencias tecnologicas');

INSERT INTO estados_incidencia (nombre_estado, orden) VALUES
('Registrada', 1), ('Asignada', 2), ('En proceso', 3), ('Resuelta', 4);

INSERT INTO ubicaciones (nombre_ubicacion, tipo, descripcion) VALUES
('Laboratorio 1','Laboratorio','Laboratorio de computo - Bloque A'),
('Laboratorio 2','Laboratorio','Laboratorio de redes - Bloque A'),
('Aula 204','Aula','Aula teorica - Bloque B'),
('Aula 305','Aula','Aula teorica - Bloque B'),
('Biblioteca','Biblioteca','Sala de computo - Biblioteca central');

INSERT INTO usuarios (nombre_completo, correo, contrasena, id_rol, activo) VALUES
('Carlos Andrade','carlos.andrade@ecotec.edu.ec', SHA2('Admin123',256), 1, 1),
('Ana Torres','ana.torres@ecotec.edu.ec', SHA2('Tecnico123',256), 2, 1),
('Luis Marin','luis.marin@ecotec.edu.ec', SHA2('Tecnico123',256), 2, 1),
('Priscila Chavez','priscila.chavez@ecotec.edu.ec', SHA2('Tecnico123',256), 2, 1),
('Maria Salazar','maria.salazar@ecotec.edu.ec', SHA2('Usuario123',256), 3, 1),
('Jorge Bravo','jorge.bravo@ecotec.edu.ec', SHA2('Usuario123',256), 3, 1),
('Diana Velez','diana.velez@ecotec.edu.ec', SHA2('Usuario123',256), 3, 1),
('Kevin Zambrano','kevin.zambrano@ecotec.edu.ec', SHA2('Usuario123',256), 3, 1),
('Fernanda Rios','fernanda.rios@ecotec.edu.ec', SHA2('Usuario123',256), 3, 1),
('Pablo Endara','pablo.endara@ecotec.edu.ec', SHA2('Usuario123',256), 3, 0);

INSERT INTO activos (nombre_activo, tipo_activo, id_ubicacion, estado_activo) VALUES
('PC-Lab1-01','Computador',1,'Operativo'), ('PC-Lab1-02','Computador',1,'Operativo'), ('Proyector-Lab1','Proyector',1,'Operativo'),
('PC-Lab2-01','Computador',2,'Operativo'), ('PC-Lab2-02','Computador',2,'Mantenimiento'), ('Impresora-Lab2','Impresora',2,'Operativo'),
('Proyector-Aula204','Proyector',3,'Danado'), ('PC-Aula204-01','Computador',3,'Operativo'), ('Router-Aula204','Router',3,'Operativo'),
('Proyector-Aula305','Proyector',4,'Operativo'), ('PC-Aula305-01','Computador',4,'Operativo'), ('PC-Aula305-02','Computador',4,'Operativo'),
('PC-Biblioteca-01','Computador',5,'Operativo'), ('PC-Biblioteca-02','Computador',5,'Operativo'), ('Impresora-Biblioteca','Impresora',5,'Fuera de servicio');

INSERT INTO incidencias (titulo, descripcion, prioridad, id_activo, id_usuario_reporta, id_estado) VALUES
('Computador no enciende','El equipo no responde','Alta',1,5,1), ('Proyector sin imagen','No muestra senal','Media',3,6,1),
('Impresora no imprime','No responde','Media',6,7,1), ('Sin conexion a internet','Sin red','Urgente',9,8,1),
('Pantalla azul','Pantalla azul al arrancar','Alta',4,9,1), ('Mouse no responde','No detecta movimiento','Baja',2,5,1),
('Teclado danado','Teclas no responden','Baja',8,6,1), ('Proyector borroso','Imagen desenfocada','Media',10,7,1),
('Impresora atascada','Papel atascado','Media',15,8,1), ('Router sin wifi','No hay red inalambrica','Alta',9,9,1),
('Computador lento','Tarda en iniciar','Media',11,5,1), ('Pantalla parpadea','Parpadeo constante','Baja',12,6,1),
('Proyector no enciende','No responde','Alta',7,7,1), ('Sin sonido','No emiten sonido','Baja',13,8,1),
('Impresora sin toner','Toner bajo','Baja',6,9,1), ('Computador se reinicia','Se apaga solo','Urgente',14,5,1),
('Red muy lenta','Navegacion lenta','Media',9,6,1), ('Proyector con manchas','Manchas oscuras','Baja',10,7,1),
('Teclado no reconocido','No detecta USB','Media',8,8,1), ('Computador con virus','Ventanas emergentes','Alta',1,9,1),
('Impresora con lineas','Lineas horizontales','Media',15,5,1), ('Mouse sin bateria','No enciende','Baja',2,6,1),
('Proyector cable danado','Cable HDMI deteriorado','Media',3,7,1), ('Computador no reconoce USB','Puertos fallan','Media',11,8,1),
('Pantalla con lineas','Lineas verticales','Alta',12,9,1), ('Router necesita reinicio','Se desconecta','Media',9,5,1),
('Impresora no escanea','Escaneo no responde','Baja',6,6,1), ('Computador fecha incorrecta','No guarda fecha','Baja',4,7,1),
('Proyector ruidoso','Ventilador hace ruido','Baja',10,8,1), ('Sin acceso carpeta','No acceden a red','Media',9,9,1);