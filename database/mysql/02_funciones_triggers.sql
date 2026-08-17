USE campusfix;

DELIMITER //

CREATE FUNCTION fn_dias_incidencia(p_id_incidencia INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE v_dias INT;
    SELECT DATEDIFF(NOW(), fecha_registro) INTO v_dias FROM incidencias WHERE id_incidencia = p_id_incidencia;
    RETURN IFNULL(v_dias, -1);
END //

CREATE FUNCTION fn_incidencias_activas_tecnico(p_id_tecnico INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE v_total INT;
    SELECT COUNT(*) INTO v_total FROM incidencias i
    INNER JOIN estados_incidencia e ON i.id_estado = e.id_estado
    WHERE i.id_tecnico_asignado = p_id_tecnico AND e.nombre_estado IN ('Asignada','En proceso');
    RETURN v_total;
END //

DELIMITER ;

DELIMITER //

CREATE TRIGGER trg_generar_codigo_incidencia
BEFORE INSERT ON incidencias
FOR EACH ROW
BEGIN
    IF NEW.codigo_incidencia IS NULL OR NEW.codigo_incidencia = '' THEN
        SET NEW.codigo_incidencia = CONCAT('INC-', YEAR(CURDATE()), '-', LPAD((SELECT COUNT(*) FROM incidencias) + 1, 4, '0'));
    END IF;
END //

CREATE TRIGGER trg_historial_insert
AFTER INSERT ON incidencias
FOR EACH ROW
BEGIN
    INSERT INTO historial_estados (id_incidencia, id_estado, comentario)
    VALUES (NEW.id_incidencia, NEW.id_estado, 'Registro inicial de la incidencia');
END //

CREATE TRIGGER trg_historial_update
AFTER UPDATE ON incidencias
FOR EACH ROW
BEGIN
    IF NEW.id_estado <> OLD.id_estado THEN
        INSERT INTO historial_estados (id_incidencia, id_estado, comentario)
        VALUES (NEW.id_incidencia, NEW.id_estado, 'Cambio automatico de estado');
    END IF;
END //

CREATE TRIGGER trg_impedir_delete_resuelta
BEFORE DELETE ON incidencias
FOR EACH ROW
BEGIN
    DECLARE v_nombre_estado VARCHAR(20);
    SELECT nombre_estado INTO v_nombre_estado FROM estados_incidencia WHERE id_estado = OLD.id_estado;
    IF v_nombre_estado = 'Resuelta' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No se puede eliminar una incidencia en estado Resuelta';
    END IF;
END //

DELIMITER ;