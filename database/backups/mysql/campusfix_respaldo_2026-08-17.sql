-- MySQL dump 10.13  Distrib 8.4.7, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: campusfix
-- ------------------------------------------------------
-- Server version	11.8.3-MariaDB-ubu2404

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `campusfix`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `campusfix` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */;

USE `campusfix`;

--
-- Table structure for table `activos`
--

DROP TABLE IF EXISTS `activos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `activos` (
  `id_activo` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_activo` varchar(100) NOT NULL,
  `tipo_activo` varchar(50) NOT NULL,
  `id_ubicacion` int(11) NOT NULL,
  `estado_activo` varchar(20) NOT NULL DEFAULT 'Operativo',
  PRIMARY KEY (`id_activo`),
  KEY `fk_activos_ubicacion` (`id_ubicacion`),
  CONSTRAINT `fk_activos_ubicacion` FOREIGN KEY (`id_ubicacion`) REFERENCES `ubicaciones` (`id_ubicacion`),
  CONSTRAINT `chk_estado_activo` CHECK (`estado_activo` in ('Operativo','Danado','Mantenimiento','Fuera de servicio'))
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activos`
--

LOCK TABLES `activos` WRITE;
/*!40000 ALTER TABLE `activos` DISABLE KEYS */;
INSERT INTO `activos` VALUES (1,'PC-Lab1-01','Computador',1,'Operativo'),(2,'PC-Lab1-02','Computador',1,'Operativo'),(3,'Proyector-Lab1','Proyector',1,'Operativo'),(4,'PC-Lab2-01','Computador',2,'Operativo'),(5,'PC-Lab2-02','Computador',2,'Mantenimiento'),(6,'Impresora-Lab2','Impresora',2,'Operativo'),(7,'Proyector-Aula204','Proyector',3,'Danado'),(8,'PC-Aula204-01','Computador',3,'Operativo'),(9,'Router-Aula204','Router',3,'Operativo'),(10,'Proyector-Aula305','Proyector',4,'Operativo'),(11,'PC-Aula305-01','Computador',4,'Operativo'),(12,'PC-Aula305-02','Computador',4,'Operativo'),(13,'PC-Biblioteca-01','Computador',5,'Operativo'),(14,'PC-Biblioteca-02','Computador',5,'Operativo'),(15,'Impresora-Biblioteca','Impresora',5,'Fuera de servicio');
/*!40000 ALTER TABLE `activos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `asignaciones`
--

DROP TABLE IF EXISTS `asignaciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `asignaciones` (
  `id_asignacion` int(11) NOT NULL AUTO_INCREMENT,
  `id_incidencia` int(11) NOT NULL,
  `id_tecnico` int(11) NOT NULL,
  `asignado_por` int(11) NOT NULL,
  `fecha_asignacion` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id_asignacion`),
  KEY `fk_asignaciones_incidencia` (`id_incidencia`),
  KEY `fk_asignaciones_tecnico` (`id_tecnico`),
  KEY `fk_asignaciones_admin` (`asignado_por`),
  CONSTRAINT `fk_asignaciones_admin` FOREIGN KEY (`asignado_por`) REFERENCES `usuarios` (`id_usuario`),
  CONSTRAINT `fk_asignaciones_incidencia` FOREIGN KEY (`id_incidencia`) REFERENCES `incidencias` (`id_incidencia`),
  CONSTRAINT `fk_asignaciones_tecnico` FOREIGN KEY (`id_tecnico`) REFERENCES `usuarios` (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asignaciones`
--

LOCK TABLES `asignaciones` WRITE;
/*!40000 ALTER TABLE `asignaciones` DISABLE KEYS */;
INSERT INTO `asignaciones` VALUES (1,1,2,1,'2026-08-09 22:18:07'),(2,2,3,1,'2026-08-09 22:18:07'),(3,3,4,1,'2026-08-09 22:18:07'),(4,4,2,1,'2026-08-09 22:18:07'),(5,5,3,1,'2026-08-09 22:18:07'),(6,6,4,1,'2026-08-09 22:18:07'),(7,7,2,1,'2026-08-09 22:18:07'),(8,8,3,1,'2026-08-09 22:18:07'),(9,9,4,1,'2026-08-09 22:18:07'),(10,10,2,1,'2026-08-09 22:18:07'),(11,11,3,1,'2026-08-09 22:18:07'),(12,12,4,1,'2026-08-09 22:18:07'),(13,13,2,1,'2026-08-09 22:18:07'),(14,14,3,1,'2026-08-09 22:18:07'),(15,15,4,1,'2026-08-09 22:18:07'),(16,16,2,1,'2026-08-09 22:18:07'),(17,17,3,1,'2026-08-09 22:18:07'),(18,18,4,1,'2026-08-09 22:18:07'),(19,19,2,1,'2026-08-09 22:18:07'),(20,20,3,1,'2026-08-09 22:18:07'),(21,21,2,1,'2026-08-09 22:18:16'),(23,21,2,1,'2026-08-10 00:35:37'),(24,33,2,1,'2026-08-17 19:21:24');
/*!40000 ALTER TABLE `asignaciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estados_incidencia`
--

DROP TABLE IF EXISTS `estados_incidencia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estados_incidencia` (
  `id_estado` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_estado` varchar(20) NOT NULL,
  `orden` int(11) NOT NULL,
  PRIMARY KEY (`id_estado`),
  UNIQUE KEY `nombre_estado` (`nombre_estado`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estados_incidencia`
--

LOCK TABLES `estados_incidencia` WRITE;
/*!40000 ALTER TABLE `estados_incidencia` DISABLE KEYS */;
INSERT INTO `estados_incidencia` VALUES (1,'Registrada',1),(2,'Asignada',2),(3,'En proceso',3),(4,'Resuelta',4);
/*!40000 ALTER TABLE `estados_incidencia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `historial_estados`
--

DROP TABLE IF EXISTS `historial_estados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `historial_estados` (
  `id_historial` int(11) NOT NULL AUTO_INCREMENT,
  `id_incidencia` int(11) NOT NULL,
  `id_estado` int(11) NOT NULL,
  `fecha_cambio` datetime NOT NULL DEFAULT current_timestamp(),
  `comentario` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_historial`),
  KEY `fk_historial_incidencia` (`id_incidencia`),
  KEY `fk_historial_estado` (`id_estado`),
  CONSTRAINT `fk_historial_estado` FOREIGN KEY (`id_estado`) REFERENCES `estados_incidencia` (`id_estado`),
  CONSTRAINT `fk_historial_incidencia` FOREIGN KEY (`id_incidencia`) REFERENCES `incidencias` (`id_incidencia`)
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `historial_estados`
--

LOCK TABLES `historial_estados` WRITE;
/*!40000 ALTER TABLE `historial_estados` DISABLE KEYS */;
INSERT INTO `historial_estados` VALUES (1,1,1,'2026-08-09 22:17:58','Registro inicial de la incidencia'),(2,2,1,'2026-08-09 22:17:58','Registro inicial de la incidencia'),(3,3,1,'2026-08-09 22:17:58','Registro inicial de la incidencia'),(4,4,1,'2026-08-09 22:17:58','Registro inicial de la incidencia'),(5,5,1,'2026-08-09 22:17:58','Registro inicial de la incidencia'),(6,6,1,'2026-08-09 22:17:58','Registro inicial de la incidencia'),(7,7,1,'2026-08-09 22:17:58','Registro inicial de la incidencia'),(8,8,1,'2026-08-09 22:17:58','Registro inicial de la incidencia'),(9,9,1,'2026-08-09 22:17:58','Registro inicial de la incidencia'),(10,10,1,'2026-08-09 22:17:58','Registro inicial de la incidencia'),(11,11,1,'2026-08-09 22:17:58','Registro inicial de la incidencia'),(12,12,1,'2026-08-09 22:17:58','Registro inicial de la incidencia'),(13,13,1,'2026-08-09 22:17:58','Registro inicial de la incidencia'),(14,14,1,'2026-08-09 22:17:58','Registro inicial de la incidencia'),(15,15,1,'2026-08-09 22:17:58','Registro inicial de la incidencia'),(16,16,1,'2026-08-09 22:17:58','Registro inicial de la incidencia'),(17,17,1,'2026-08-09 22:17:58','Registro inicial de la incidencia'),(18,18,1,'2026-08-09 22:17:58','Registro inicial de la incidencia'),(19,19,1,'2026-08-09 22:17:58','Registro inicial de la incidencia'),(20,20,1,'2026-08-09 22:17:58','Registro inicial de la incidencia'),(21,21,1,'2026-08-09 22:17:58','Registro inicial de la incidencia'),(22,22,1,'2026-08-09 22:17:58','Registro inicial de la incidencia'),(23,23,1,'2026-08-09 22:17:58','Registro inicial de la incidencia'),(24,24,1,'2026-08-09 22:17:58','Registro inicial de la incidencia'),(25,25,1,'2026-08-09 22:17:58','Registro inicial de la incidencia'),(26,26,1,'2026-08-09 22:17:58','Registro inicial de la incidencia'),(27,27,1,'2026-08-09 22:17:58','Registro inicial de la incidencia'),(28,28,1,'2026-08-09 22:17:58','Registro inicial de la incidencia'),(29,29,1,'2026-08-09 22:17:58','Registro inicial de la incidencia'),(30,30,1,'2026-08-09 22:17:58','Registro inicial de la incidencia'),(31,1,2,'2026-08-09 22:18:07','Cambio automatico de estado'),(32,2,2,'2026-08-09 22:18:07','Cambio automatico de estado'),(33,3,2,'2026-08-09 22:18:07','Cambio automatico de estado'),(34,4,2,'2026-08-09 22:18:07','Cambio automatico de estado'),(35,5,2,'2026-08-09 22:18:07','Cambio automatico de estado'),(36,6,2,'2026-08-09 22:18:07','Cambio automatico de estado'),(37,7,2,'2026-08-09 22:18:07','Cambio automatico de estado'),(38,8,2,'2026-08-09 22:18:07','Cambio automatico de estado'),(39,9,2,'2026-08-09 22:18:07','Cambio automatico de estado'),(40,10,2,'2026-08-09 22:18:07','Cambio automatico de estado'),(41,11,2,'2026-08-09 22:18:07','Cambio automatico de estado'),(42,12,2,'2026-08-09 22:18:07','Cambio automatico de estado'),(43,13,2,'2026-08-09 22:18:07','Cambio automatico de estado'),(44,14,2,'2026-08-09 22:18:07','Cambio automatico de estado'),(45,15,2,'2026-08-09 22:18:07','Cambio automatico de estado'),(46,16,2,'2026-08-09 22:18:07','Cambio automatico de estado'),(47,17,2,'2026-08-09 22:18:07','Cambio automatico de estado'),(48,18,2,'2026-08-09 22:18:07','Cambio automatico de estado'),(49,19,2,'2026-08-09 22:18:07','Cambio automatico de estado'),(50,20,2,'2026-08-09 22:18:07','Cambio automatico de estado'),(51,1,3,'2026-08-09 22:18:07','Cambio automatico de estado'),(52,2,3,'2026-08-09 22:18:07','Cambio automatico de estado'),(53,3,3,'2026-08-09 22:18:07','Cambio automatico de estado'),(54,4,3,'2026-08-09 22:18:07','Cambio automatico de estado'),(55,5,3,'2026-08-09 22:18:07','Cambio automatico de estado'),(56,6,3,'2026-08-09 22:18:07','Cambio automatico de estado'),(57,7,3,'2026-08-09 22:18:07','Cambio automatico de estado'),(58,8,3,'2026-08-09 22:18:07','Cambio automatico de estado'),(59,1,4,'2026-08-09 22:18:07','Cambio automatico de estado'),(60,2,4,'2026-08-09 22:18:07','Cambio automatico de estado'),(61,3,4,'2026-08-09 22:18:07','Cambio automatico de estado'),(62,4,4,'2026-08-09 22:18:07','Cambio automatico de estado'),(63,5,4,'2026-08-09 22:18:07','Cambio automatico de estado'),(64,21,2,'2026-08-09 22:18:16','Cambio automatico de estado'),(65,31,1,'2026-08-09 23:57:52','Registro inicial de la incidencia'),(66,21,3,'2026-08-10 00:44:22','Cambio automatico de estado'),(67,32,1,'2026-08-16 22:36:44','Registro inicial de la incidencia'),(68,33,1,'2026-08-17 19:09:26','Registro inicial de la incidencia'),(69,33,2,'2026-08-17 19:21:24','Cambio automatico de estado'),(70,33,3,'2026-08-17 19:25:37','Cambio automatico de estado'),(71,33,4,'2026-08-17 19:25:56','Cambio automatico de estado'),(72,34,1,'2026-08-17 19:31:06','Registro inicial de la incidencia');
/*!40000 ALTER TABLE `historial_estados` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `incidencias`
--

DROP TABLE IF EXISTS `incidencias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `incidencias` (
  `id_incidencia` int(11) NOT NULL AUTO_INCREMENT,
  `codigo_incidencia` varchar(20) DEFAULT NULL,
  `titulo` varchar(100) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `prioridad` varchar(10) NOT NULL DEFAULT 'Media',
  `id_activo` int(11) NOT NULL,
  `id_usuario_reporta` int(11) NOT NULL,
  `id_tecnico_asignado` int(11) DEFAULT NULL,
  `id_estado` int(11) NOT NULL,
  `fecha_registro` datetime NOT NULL DEFAULT current_timestamp(),
  `fecha_resolucion` datetime DEFAULT NULL,
  PRIMARY KEY (`id_incidencia`),
  UNIQUE KEY `codigo_incidencia` (`codigo_incidencia`),
  KEY `fk_incidencias_activo` (`id_activo`),
  KEY `fk_incidencias_usuario` (`id_usuario_reporta`),
  KEY `idx_incidencias_estado` (`id_estado`),
  KEY `idx_incidencias_tecnico` (`id_tecnico_asignado`),
  CONSTRAINT `fk_incidencias_activo` FOREIGN KEY (`id_activo`) REFERENCES `activos` (`id_activo`),
  CONSTRAINT `fk_incidencias_estado` FOREIGN KEY (`id_estado`) REFERENCES `estados_incidencia` (`id_estado`),
  CONSTRAINT `fk_incidencias_tecnico` FOREIGN KEY (`id_tecnico_asignado`) REFERENCES `usuarios` (`id_usuario`),
  CONSTRAINT `fk_incidencias_usuario` FOREIGN KEY (`id_usuario_reporta`) REFERENCES `usuarios` (`id_usuario`),
  CONSTRAINT `chk_prioridad` CHECK (`prioridad` in ('Baja','Media','Alta','Urgente'))
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `incidencias`
--

LOCK TABLES `incidencias` WRITE;
/*!40000 ALTER TABLE `incidencias` DISABLE KEYS */;
INSERT INTO `incidencias` VALUES (1,'INC-2026-0001','Computador no enciende','El equipo no responde','Alta',1,5,2,4,'2026-08-09 22:17:58','2026-08-09 22:18:07'),(2,'INC-2026-0002','Proyector sin imagen','No muestra senal','Media',3,6,3,4,'2026-08-09 22:17:58','2026-08-09 22:18:07'),(3,'INC-2026-0003','Impresora no imprime','No responde','Media',6,7,4,4,'2026-08-09 22:17:58','2026-08-09 22:18:07'),(4,'INC-2026-0004','Sin conexion a internet','Sin red','Urgente',9,8,2,4,'2026-08-09 22:17:58','2026-08-09 22:18:07'),(5,'INC-2026-0005','Pantalla azul','Pantalla azul al arrancar','Alta',4,9,3,4,'2026-08-09 22:17:58','2026-08-09 22:18:07'),(6,'INC-2026-0006','Mouse no responde','No detecta movimiento','Baja',2,5,4,3,'2026-08-09 22:17:58',NULL),(7,'INC-2026-0007','Teclado danado','Teclas no responden','Baja',8,6,2,3,'2026-08-09 22:17:58',NULL),(8,'INC-2026-0008','Proyector borroso','Imagen desenfocada','Media',10,7,3,3,'2026-08-09 22:17:58',NULL),(9,'INC-2026-0009','Impresora atascada','Papel atascado','Media',15,8,4,2,'2026-08-09 22:17:58',NULL),(10,'INC-2026-0010','Router sin wifi','No hay red inalambrica','Alta',9,9,2,2,'2026-08-09 22:17:58',NULL),(11,'INC-2026-0011','Computador lento','Tarda en iniciar','Media',11,5,3,2,'2026-08-09 22:17:58',NULL),(12,'INC-2026-0012','Pantalla parpadea','Parpadeo constante','Baja',12,6,4,2,'2026-08-09 22:17:58',NULL),(13,'INC-2026-0013','Proyector no enciende','No responde','Alta',7,7,2,2,'2026-08-09 22:17:58',NULL),(14,'INC-2026-0014','Sin sonido','No emiten sonido','Baja',13,8,3,2,'2026-08-09 22:17:58',NULL),(15,'INC-2026-0015','Impresora sin toner','Toner bajo','Baja',6,9,4,2,'2026-08-09 22:17:58',NULL),(16,'INC-2026-0016','Computador se reinicia','Se apaga solo','Urgente',14,5,2,2,'2026-08-09 22:17:58',NULL),(17,'INC-2026-0017','Red muy lenta','Navegacion lenta','Media',9,6,3,2,'2026-08-09 22:17:58',NULL),(18,'INC-2026-0018','Proyector con manchas','Manchas oscuras','Baja',10,7,4,2,'2026-08-09 22:17:58',NULL),(19,'INC-2026-0019','Teclado no reconocido','No detecta USB','Media',8,8,2,2,'2026-08-09 22:17:58',NULL),(20,'INC-2026-0020','Computador con virus','Ventanas emergentes','Alta',1,9,3,2,'2026-08-09 22:17:58',NULL),(21,'INC-2026-0021','Impresora con lineas','Lineas horizontales','Media',15,5,2,3,'2026-08-09 22:17:58',NULL),(22,'INC-2026-0022','Mouse sin bateria','No enciende','Baja',2,6,NULL,1,'2026-08-09 22:17:58',NULL),(23,'INC-2026-0023','Proyector cable danado','Cable HDMI deteriorado','Media',3,7,NULL,1,'2026-08-09 22:17:58',NULL),(24,'INC-2026-0024','Computador no reconoce USB','Puertos fallan','Media',11,8,NULL,1,'2026-08-09 22:17:58',NULL),(25,'INC-2026-0025','Pantalla con lineas','Lineas verticales','Alta',12,9,NULL,1,'2026-08-09 22:17:58',NULL),(26,'INC-2026-0026','Router necesita reinicio','Se desconecta','Media',9,5,NULL,1,'2026-08-09 22:17:58',NULL),(27,'INC-2026-0027','Impresora no escanea','Escaneo no responde','Baja',6,6,NULL,1,'2026-08-09 22:17:58',NULL),(28,'INC-2026-0028','Computador fecha incorrecta','No guarda fecha','Baja',4,7,NULL,1,'2026-08-09 22:17:58',NULL),(29,'INC-2026-0029','Proyector ruidoso','Ventilador hace ruido','Baja',10,8,NULL,1,'2026-08-09 22:17:58',NULL),(30,'INC-2026-0030','Sin acceso carpeta','No acceden a red','Media',9,9,NULL,1,'2026-08-09 22:17:58',NULL),(31,'INC-2026-0031','Monitor no enciende en Lab 1','El monitor del puesto 3 no da senal','Alta',1,5,NULL,1,'2026-08-09 23:57:52',NULL),(32,'INC-2026-0032','Proyector no enciende en Aula 305','Sin senal de video','Alta',10,5,NULL,1,'2026-08-16 22:36:44',NULL),(33,'INC-2026-0033','Prueba#1','Fallo en la base de datos, reporte 1.','Media',1,1,2,4,'2026-08-17 19:09:26','2026-08-17 19:25:56'),(34,'INC-2026-0034','Prueba validación sin técnico','Ninguna','Media',1,1,NULL,1,'2026-08-17 19:31:06',NULL);
/*!40000 ALTER TABLE `incidencias` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_uca1400_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trg_generar_codigo_incidencia
BEFORE INSERT ON incidencias
FOR EACH ROW
BEGIN
    IF NEW.codigo_incidencia IS NULL OR NEW.codigo_incidencia = '' THEN
        SET NEW.codigo_incidencia = CONCAT('INC-', YEAR(CURDATE()), '-', LPAD((SELECT COUNT(*) FROM incidencias) + 1, 4, '0'));
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_uca1400_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trg_historial_insert
AFTER INSERT ON incidencias
FOR EACH ROW
BEGIN
    INSERT INTO historial_estados (id_incidencia, id_estado, comentario)
    VALUES (NEW.id_incidencia, NEW.id_estado, 'Registro inicial de la incidencia');
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_uca1400_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trg_historial_update
AFTER UPDATE ON incidencias
FOR EACH ROW
BEGIN
    IF NEW.id_estado <> OLD.id_estado THEN
        INSERT INTO historial_estados (id_incidencia, id_estado, comentario)
        VALUES (NEW.id_incidencia, NEW.id_estado, 'Cambio automatico de estado');
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_uca1400_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trg_impedir_delete_resuelta
BEFORE DELETE ON incidencias
FOR EACH ROW
BEGIN
    DECLARE v_nombre_estado VARCHAR(20);
    SELECT nombre_estado INTO v_nombre_estado FROM estados_incidencia WHERE id_estado = OLD.id_estado;
    IF v_nombre_estado = 'Resuelta' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No se puede eliminar una incidencia en estado Resuelta';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id_rol` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_rol` varchar(30) NOT NULL,
  `descripcion` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`id_rol`),
  UNIQUE KEY `nombre_rol` (`nombre_rol`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'Administrador','Gestiona incidencias, tecnicos y reportes'),(2,'Tecnico','Atiende y da seguimiento a incidencias asignadas'),(3,'Usuario','Reporta incidencias tecnologicas');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ubicaciones`
--

DROP TABLE IF EXISTS `ubicaciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ubicaciones` (
  `id_ubicacion` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_ubicacion` varchar(50) NOT NULL,
  `tipo` varchar(30) NOT NULL,
  `descripcion` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`id_ubicacion`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ubicaciones`
--

LOCK TABLES `ubicaciones` WRITE;
/*!40000 ALTER TABLE `ubicaciones` DISABLE KEYS */;
INSERT INTO `ubicaciones` VALUES (1,'Laboratorio 1','Laboratorio','Laboratorio de computo - Bloque A'),(2,'Laboratorio 2','Laboratorio','Laboratorio de redes - Bloque A'),(3,'Aula 204','Aula','Aula teorica - Bloque B'),(4,'Aula 305','Aula','Aula teorica - Bloque B'),(5,'Biblioteca','Biblioteca','Sala de computo - Biblioteca central');
/*!40000 ALTER TABLE `ubicaciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `id_usuario` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_completo` varchar(100) NOT NULL,
  `correo` varchar(100) NOT NULL,
  `contrasena` varchar(255) NOT NULL,
  `id_rol` int(11) NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT 1,
  `fecha_registro` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `correo` (`correo`),
  KEY `fk_usuarios_rol` (`id_rol`),
  CONSTRAINT `fk_usuarios_rol` FOREIGN KEY (`id_rol`) REFERENCES `roles` (`id_rol`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,'Carlos Andrade','carlos.andrade@ecotec.edu.ec','3b612c75a7b5048a435fb6ec81e52ff92d6d795a8b5a9c17070f6a63c97a53b2',1,1,'2026-08-09 22:17:58'),(2,'Ana Torres','ana.torres@ecotec.edu.ec','9aa3c98ffbadb9247e2be2182ed6cabd991ad32053fc1d154d8c542a444e03a7',2,1,'2026-08-09 22:17:58'),(3,'Luis Marin','luis.marin@ecotec.edu.ec','9aa3c98ffbadb9247e2be2182ed6cabd991ad32053fc1d154d8c542a444e03a7',2,1,'2026-08-09 22:17:58'),(4,'Priscila Chavez','priscila.chavez@ecotec.edu.ec','9aa3c98ffbadb9247e2be2182ed6cabd991ad32053fc1d154d8c542a444e03a7',2,1,'2026-08-09 22:17:58'),(5,'Maria Salazar','maria.salazar@ecotec.edu.ec','66d4fca6f91a71a033d2369ad7a302bf83b925364cb73bcc9677e378c4685437',3,1,'2026-08-09 22:17:58'),(6,'Jorge Bravo','jorge.bravo@ecotec.edu.ec','66d4fca6f91a71a033d2369ad7a302bf83b925364cb73bcc9677e378c4685437',3,1,'2026-08-09 22:17:58'),(7,'Diana Velez','diana.velez@ecotec.edu.ec','66d4fca6f91a71a033d2369ad7a302bf83b925364cb73bcc9677e378c4685437',3,1,'2026-08-09 22:17:58'),(8,'Kevin Zambrano','kevin.zambrano@ecotec.edu.ec','66d4fca6f91a71a033d2369ad7a302bf83b925364cb73bcc9677e378c4685437',3,1,'2026-08-09 22:17:58'),(9,'Fernanda Rios','fernanda.rios@ecotec.edu.ec','66d4fca6f91a71a033d2369ad7a302bf83b925364cb73bcc9677e378c4685437',3,1,'2026-08-09 22:17:58'),(10,'Pablo Endara','pablo.endara@ecotec.edu.ec','66d4fca6f91a71a033d2369ad7a302bf83b925364cb73bcc9677e378c4685437',3,0,'2026-08-09 22:17:58');
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `vw_incidencias_activas`
--

DROP TABLE IF EXISTS `vw_incidencias_activas`;
/*!50001 DROP VIEW IF EXISTS `vw_incidencias_activas`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_incidencias_activas` AS SELECT 
 1 AS `id_incidencia`,
 1 AS `codigo_incidencia`,
 1 AS `titulo`,
 1 AS `prioridad`,
 1 AS `nombre_activo`,
 1 AS `nombre_ubicacion`,
 1 AS `reportado_por`,
 1 AS `tecnico_asignado`,
 1 AS `nombre_estado`,
 1 AS `fecha_registro`,
 1 AS `dias_abierta`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_resumen_por_tecnico`
--

DROP TABLE IF EXISTS `vw_resumen_por_tecnico`;
/*!50001 DROP VIEW IF EXISTS `vw_resumen_por_tecnico`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_resumen_por_tecnico` AS SELECT 
 1 AS `id_tecnico`,
 1 AS `tecnico`,
 1 AS `total_incidencias`,
 1 AS `asignadas`,
 1 AS `en_proceso`,
 1 AS `resueltas`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping events for database 'campusfix'
--

--
-- Dumping routines for database 'campusfix'
--
/*!50003 DROP FUNCTION IF EXISTS `fn_dias_incidencia` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_uca1400_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_dias_incidencia`(p_id_incidencia INT) RETURNS int(11)
    DETERMINISTIC
BEGIN
    DECLARE v_dias INT;
    SELECT DATEDIFF(NOW(), fecha_registro) INTO v_dias FROM incidencias WHERE id_incidencia = p_id_incidencia;
    RETURN IFNULL(v_dias, -1);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_incidencias_activas_tecnico` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_uca1400_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_incidencias_activas_tecnico`(p_id_tecnico INT) RETURNS int(11)
    DETERMINISTIC
BEGIN
    DECLARE v_total INT;
    SELECT COUNT(*) INTO v_total FROM incidencias i
    INNER JOIN estados_incidencia e ON i.id_estado = e.id_estado
    WHERE i.id_tecnico_asignado = p_id_tecnico AND e.nombre_estado IN ('Asignada','En proceso');
    RETURN v_total;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_asignar_tecnico` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_uca1400_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_asignar_tecnico`(
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_cambiar_estado` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_uca1400_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_cambiar_estado`(
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_registrar_incidencia` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_uca1400_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_registrar_incidencia`(
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Current Database: `campusfix`
--

USE `campusfix`;

--
-- Final view structure for view `vw_incidencias_activas`
--

/*!50001 DROP VIEW IF EXISTS `vw_incidencias_activas`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_uca1400_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_incidencias_activas` AS select `i`.`id_incidencia` AS `id_incidencia`,`i`.`codigo_incidencia` AS `codigo_incidencia`,`i`.`titulo` AS `titulo`,`i`.`prioridad` AS `prioridad`,`a`.`nombre_activo` AS `nombre_activo`,`u`.`nombre_ubicacion` AS `nombre_ubicacion`,`ur`.`nombre_completo` AS `reportado_por`,`ut`.`nombre_completo` AS `tecnico_asignado`,`e`.`nombre_estado` AS `nombre_estado`,`i`.`fecha_registro` AS `fecha_registro`,`fn_dias_incidencia`(`i`.`id_incidencia`) AS `dias_abierta` from (((((`incidencias` `i` join `activos` `a` on(`i`.`id_activo` = `a`.`id_activo`)) join `ubicaciones` `u` on(`a`.`id_ubicacion` = `u`.`id_ubicacion`)) join `usuarios` `ur` on(`i`.`id_usuario_reporta` = `ur`.`id_usuario`)) left join `usuarios` `ut` on(`i`.`id_tecnico_asignado` = `ut`.`id_usuario`)) join `estados_incidencia` `e` on(`i`.`id_estado` = `e`.`id_estado`)) where `e`.`nombre_estado` <> 'Resuelta' */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_resumen_por_tecnico`
--

/*!50001 DROP VIEW IF EXISTS `vw_resumen_por_tecnico`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_uca1400_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_resumen_por_tecnico` AS select `ut`.`id_usuario` AS `id_tecnico`,`ut`.`nombre_completo` AS `tecnico`,count(`i`.`id_incidencia`) AS `total_incidencias`,sum(case when `e`.`nombre_estado` = 'Asignada' then 1 else 0 end) AS `asignadas`,sum(case when `e`.`nombre_estado` = 'En proceso' then 1 else 0 end) AS `en_proceso`,sum(case when `e`.`nombre_estado` = 'Resuelta' then 1 else 0 end) AS `resueltas` from (((`usuarios` `ut` join `roles` `r` on(`ut`.`id_rol` = `r`.`id_rol`)) left join `incidencias` `i` on(`i`.`id_tecnico_asignado` = `ut`.`id_usuario`)) left join `estados_incidencia` `e` on(`i`.`id_estado` = `e`.`id_estado`)) where `r`.`nombre_rol` = 'Tecnico' group by `ut`.`id_usuario`,`ut`.`nombre_completo` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-08-17 19:37:36
