USE campusfix;

CREATE VIEW vw_incidencias_activas AS
SELECT i.id_incidencia, i.codigo_incidencia, i.titulo, i.prioridad, a.nombre_activo, u.nombre_ubicacion, 
       ur.nombre_completo AS reportado_por, ut.nombre_completo AS tecnico_asignado, e.nombre_estado, 
       i.fecha_registro, fn_dias_incidencia(i.id_incidencia) AS dias_abierta
FROM incidencias i
INNER JOIN activos a ON i.id_activo = a.id_activo
INNER JOIN ubicaciones u ON a.id_ubicacion = u.id_ubicacion
INNER JOIN usuarios ur ON i.id_usuario_reporta = ur.id_usuario
LEFT JOIN usuarios ut ON i.id_tecnico_asignado = ut.id_usuario
INNER JOIN estados_incidencia e ON i.id_estado = e.id_estado
WHERE e.nombre_estado <> 'Resuelta';

CREATE VIEW vw_resumen_por_tecnico AS
SELECT ut.id_usuario AS id_tecnico, ut.nombre_completo AS tecnico, COUNT(i.id_incidencia) AS total_incidencias,
       SUM(CASE WHEN e.nombre_estado = 'Asignada' THEN 1 ELSE 0 END) AS asignadas,
       SUM(CASE WHEN e.nombre_estado = 'En proceso' THEN 1 ELSE 0 END) AS en_proceso,
       SUM(CASE WHEN e.nombre_estado = 'Resuelta' THEN 1 ELSE 0 END) AS resueltas
FROM usuarios ut
INNER JOIN roles r ON ut.id_rol = r.id_rol
LEFT JOIN incidencias i ON i.id_tecnico_asignado = ut.id_usuario
LEFT JOIN estados_incidencia e ON i.id_estado = e.id_estado
WHERE r.nombre_rol = 'Tecnico'
GROUP BY ut.id_usuario, ut.nombre_completo;

-- Demo Transacciones
CALL sp_asignar_tecnico(21, 2, 1, @resultado_commit);

START TRANSACTION;
    UPDATE incidencias SET prioridad = 'Urgente' WHERE id_incidencia = 22;
    INSERT INTO asignaciones (id_incidencia, id_tecnico, asignado_por) VALUES (22, 9999, 1); -- Falla a proposito
ROLLBACK;