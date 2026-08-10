USE campusfix;
DELIMITER //

CREATE PROCEDURE sp_registrar_incidencia (
    IN p_titulo VARCHAR(100), IN p_descripcion TEXT, IN p_prioridad VARCHAR(10),
    IN p_id_activo INT, IN p_id_usuario_reporta INT, OUT p_id_incidencia INT, OUT p_mensaje VARCHAR(150)
)
BEGIN
    DECLARE v_existe_activo INT DEFAULT 0;
    DECLARE v_existe_usuario INT DEFAULT 0;
    SELECT COUNT(*) INTO v_existe_activo FROM activos WHERE id_activo = p_id_activo;
    SELECT COUNT(*) INTO v_existe_usuario FROM usuarios WHERE id_usuario = p_id_usuario_reporta AND activo = 1;
    
    IF p_titulo IS NULL OR TRIM(p_titulo) = '' THEN SET p_mensaje = 'Error: titulo obligatorio'; SET p_id_incidencia = NULL;
    ELSEIF v_existe_activo = 0 THEN SET p_mensaje = 'Error: activo no existe'; SET p_id_incidencia = NULL;
    ELSEIF v_existe_usuario = 0 THEN SET p_mensaje = 'Error: usuario no existe o inactivo'; SET p_id_incidencia = NULL;
    ELSE
        INSERT INTO incidencias (titulo, descripcion, prioridad, id_activo, id_usuario_reporta, id_estado)
        VALUES (p_titulo, p_descripcion, IFNULL(p_prioridad,'Media'), p_id_activo, p_id_usuario_reporta, 1);
        SET p_id_incidencia = LAST_INSERT_ID();
        SET p_mensaje = CONCAT('Incidencia registrada con codigo ', (SELECT codigo_incidencia FROM incidencias WHERE id_incidencia = p_id_incidencia));
    END IF;
END //

CREATE PROCEDURE sp_asignar_tecnico (
    IN p_id_incidencia INT, IN p_id_tecnico INT, IN p_asignado_por INT, OUT p_mensaje VARCHAR(150)
)
BEGIN
    DECLARE v_rol_tecnico VARCHAR(30);
    DECLARE v_estado_actual VARCHAR(20);
    DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN ROLLBACK; SET p_mensaje = 'Error: asignacion revertida'; END;

    SELECT r.nombre_rol INTO v_rol_tecnico FROM usuarios u INNER JOIN roles r ON u.id_rol = r.id_rol WHERE u.id_usuario = p_id_tecnico AND u.activo = 1;
    SELECT e.nombre_estado INTO v_estado_actual FROM incidencias i INNER JOIN estados_incidencia e ON i.id_estado = e.id_estado WHERE i.id_incidencia = p_id_incidencia;

    IF v_rol_tecnico IS NULL OR v_rol_tecnico <> 'Tecnico' THEN SET p_mensaje = 'Error: no es tecnico activo';
    ELSEIF v_estado_actual IS NULL THEN SET p_mensaje = 'Error: incidencia no existe';
    ELSEIF v_estado_actual = 'Resuelta' THEN SET p_mensaje = 'Error: incidencia ya resuelta';
    ELSE
        START TRANSACTION;
            INSERT INTO asignaciones (id_incidencia, id_tecnico, asignado_por) VALUES (p_id_incidencia, p_id_tecnico, p_asignado_por);
            UPDATE incidencias SET id_tecnico_asignado = p_id_tecnico, id_estado = (SELECT id_estado FROM estados_incidencia WHERE nombre_estado = 'Asignada') WHERE id_incidencia = p_id_incidencia;
        COMMIT;
        SET p_mensaje = 'Tecnico asignado correctamente';
    END IF;
END //

CREATE PROCEDURE sp_cambiar_estado (
    IN p_id_incidencia INT, IN p_nuevo_estado VARCHAR(20), IN p_diagnostico_confirmado TINYINT, OUT p_mensaje VARCHAR(150)
)
BEGIN
    DECLARE v_id_nuevo_estado INT;
    DECLARE v_tecnico_asignado INT;
    DECLARE v_estado_actual VARCHAR(20);
    DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN ROLLBACK; SET p_mensaje = 'Error: cambio revertido'; END;

    SELECT id_estado INTO v_id_nuevo_estado FROM estados_incidencia WHERE nombre_estado = p_nuevo_estado;
    SELECT id_tecnico_asignado, (SELECT nombre_estado FROM estados_incidencia WHERE id_estado = i.id_estado) INTO v_tecnico_asignado, v_estado_actual FROM incidencias i WHERE i.id_incidencia = p_id_incidencia;

    IF v_id_nuevo_estado IS NULL THEN SET p_mensaje = 'Error: estado no existe';
    ELSEIF v_estado_actual IS NULL THEN SET p_mensaje = 'Error: incidencia no existe';
    ELSEIF v_estado_actual = 'Resuelta' THEN SET p_mensaje = 'Error: ya esta resuelta';
    ELSEIF p_nuevo_estado = 'Registrada' THEN SET p_mensaje = 'Error: no se puede volver a Registrada';
    ELSEIF p_nuevo_estado = 'Asignada' THEN SET p_mensaje = 'Error: use sp_asignar_tecnico';
    ELSEIF p_nuevo_estado = 'En proceso' AND v_tecnico_asignado IS NULL THEN SET p_mensaje = 'Error: requiere tecnico asignado';
    ELSEIF p_nuevo_estado = 'Resuelta' AND IFNULL(p_diagnostico_confirmado,0) = 0 THEN SET p_mensaje = 'Error: requiere diagnostico en MongoDB';
    ELSE
        START TRANSACTION;
            UPDATE incidencias SET id_estado = v_id_nuevo_estado, fecha_resolucion = IF(p_nuevo_estado = 'Resuelta', NOW(), fecha_resolucion) WHERE id_incidencia = p_id_incidencia;
        COMMIT;
        SET p_mensaje = CONCAT('Estado actualizado a ', p_nuevo_estado);
    END IF;
END //
DELIMITER ;

-- Ejecutar asignaciones de prueba
CALL sp_asignar_tecnico(1, 2, 1, @m1); CALL sp_asignar_tecnico(2, 3, 1, @m2); CALL sp_asignar_tecnico(3, 4, 1, @m3);
CALL sp_asignar_tecnico(4, 2, 1, @m4); CALL sp_asignar_tecnico(5, 3, 1, @m5); CALL sp_asignar_tecnico(6, 4, 1, @m6);
CALL sp_asignar_tecnico(7, 2, 1, @m7); CALL sp_asignar_tecnico(8, 3, 1, @m8); CALL sp_asignar_tecnico(9, 4, 1, @m9);
CALL sp_asignar_tecnico(10, 2, 1, @m10); CALL sp_asignar_tecnico(11, 3, 1, @m11); CALL sp_asignar_tecnico(12, 4, 1, @m12);
CALL sp_asignar_tecnico(13, 2, 1, @m13); CALL sp_asignar_tecnico(14, 3, 1, @m14); CALL sp_asignar_tecnico(15, 4, 1, @m15);
CALL sp_asignar_tecnico(16, 2, 1, @m16); CALL sp_asignar_tecnico(17, 3, 1, @m17); CALL sp_asignar_tecnico(18, 4, 1, @m18);
CALL sp_asignar_tecnico(19, 2, 1, @m19); CALL sp_asignar_tecnico(20, 3, 1, @m20);

CALL sp_cambiar_estado(1, 'En proceso', 0, @e1); CALL sp_cambiar_estado(2, 'En proceso', 0, @e2);
CALL sp_cambiar_estado(3, 'En proceso', 0, @e3); CALL sp_cambiar_estado(4, 'En proceso', 0, @e4);
CALL sp_cambiar_estado(5, 'En proceso', 0, @e5); CALL sp_cambiar_estado(6, 'En proceso', 0, @e6);
CALL sp_cambiar_estado(7, 'En proceso', 0, @e7); CALL sp_cambiar_estado(8, 'En proceso', 0, @e8);

CALL sp_cambiar_estado(1, 'Resuelta', 1, @r1); CALL sp_cambiar_estado(2, 'Resuelta', 1, @r2);
CALL sp_cambiar_estado(3, 'Resuelta', 1, @r3); CALL sp_cambiar_estado(4, 'Resuelta', 1, @r4);
CALL sp_cambiar_estado(5, 'Resuelta', 1, @r5);