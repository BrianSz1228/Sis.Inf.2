CREATE TABLE `Cliente` (
  `id_cliente` int PRIMARY KEY AUTO_INCREMENT,
  `nombre_apellido` varchar(255),
  `telefono` varchar(255),
  `direccion` varchar(255),
  `correo_electronico` varchar(255),
  `registrarCliente()` void,
  `modificarDatos()` void
);

CREATE TABLE `Productor` (
  `id_productor` int PRIMARY KEY AUTO_INCREMENT,
  `nombre_completo` varchar(255),
  `matricula` varchar(255),
  `gestionarPoliza()` void
);

CREATE TABLE `Poliza` (
  `id_poliza` int PRIMARY KEY AUTO_INCREMENT,
  `id_cliente` int,
  `id_productor` int,
  `tipo_poliza` varchar(255) COMMENT 'Vehicular, Vida o Hogar',
  `fecha_inicio` date,
  `fecha_fin` date,
  `costo` float,
  `emitirPoliza()` void,
  `verificarVigencia()` boolean
);

CREATE TABLE `Poliza_Vehicular` (
  `id_poliza_vehicular` int PRIMARY KEY AUTO_INCREMENT,
  `id_poliza` int UNIQUE,
  `id_vehiculo` int,
  `cobertura` varchar(255),
  `solicitarGrua()` boolean,
  `validarLimiteGrua()` boolean
);

CREATE TABLE `Poliza_Vida` (
  `id_poliza_vida` int PRIMARY KEY AUTO_INCREMENT,
  `id_poliza` int UNIQUE,
  `edad` int,
  `profesion` varchar(255),
  `capital_asegurado` float
);

CREATE TABLE `Poliza_Hogar` (
  `id_poliza_hogar` int PRIMARY KEY AUTO_INCREMENT,
  `id_poliza` int UNIQUE,
  `direccion_propiedad` varchar(255),
  `agregarItem()` void
);

CREATE TABLE `Historial_Medico` (
  `id_historial` int PRIMARY KEY AUTO_INCREMENT,
  `id_poliza_vida` int,
  `fecha` date,
  `estudios_medicos` text,
  `evolucion` text,
  `dictamen_medico` text,
  `registrarEstudios()` void
);

CREATE TABLE `Vehiculo` (
  `id_vehiculo` int PRIMARY KEY AUTO_INCREMENT,
  `patente` varchar(255),
  `marca` varchar(255),
  `modelo` varchar(255),
  `anio` int,
  `color` varchar(255),
  `km_contratacion` int,
  `fecha_vtv` date
);

CREATE TABLE `Beneficiario` (
  `id_beneficiario` int PRIMARY KEY AUTO_INCREMENT,
  `id_poliza_vida` int,
  `nombre_apellido` varchar(255),
  `parentesco` varchar(255)
);

CREATE TABLE `Item_Hogar` (
  `id_item` int PRIMARY KEY AUTO_INCREMENT,
  `id_poliza_hogar` int,
  `descripcion` varchar(255),
  `valor_estimado` float
);

CREATE TABLE `Servicio_Grua` (
  `id_grua` int PRIMARY KEY AUTO_INCREMENT,
  `id_poliza_vehicular` int,
  `fecha` date,
  `ubicacion` varchar(255),
  `km_traslado` int,
  `registrarRemolque()` void
);

CREATE TABLE `Tipo_Siniestro` (
  `id_tipo_siniestro` int PRIMARY KEY AUTO_INCREMENT,
  `descripcion_tipo` varchar(255) COMMENT 'Ej: Choque, Robo, Incendio'
);

CREATE TABLE `Siniestro` (
  `id_siniestro` int PRIMARY KEY AUTO_INCREMENT,
  `id_poliza` int,
  `id_tipo_siniestro` int,
  `fecha` date,
  `ubicacion` varchar(255),
  `descripcion` text,
  `datos_tercero` text,
  `poliza_aseguradora_tercero` varchar(255),
  `denuncia_policial` varchar(255),
  `reportarSiniestro()` void
);

CREATE TABLE `Foto_Siniestro` (
  `id_foto` int PRIMARY KEY AUTO_INCREMENT,
  `id_siniestro` int,
  `archivo_url` varchar(255),
  `fecha_subida` date
);

CREATE TABLE `Item_Afectado` (
  `id_item_afectado` int PRIMARY KEY AUTO_INCREMENT,
  `id_siniestro` int,
  `descripcion` varchar(255),
  `gravedad_danio` varchar(255)
);

CREATE TABLE `Perito` (
  `id_perito` int PRIMARY KEY AUTO_INCREMENT,
  `nombre_apellido` varchar(255),
  `matricula` varchar(255)
);

CREATE TABLE `Informe_Tecnico` (
  `id_informe` int PRIMARY KEY AUTO_INCREMENT,
  `id_siniestro` int,
  `id_perito` int,
  `fecha_informe` date,
  `detalle_tecnico` text,
  `adjuntarInformePerito()` void
);

CREATE TABLE `Taller` (
  `id_taller` int PRIMARY KEY AUTO_INCREMENT,
  `nombre_taller` varchar(255),
  `direccion` varchar(255),
  `datos_pago` varchar(255)
);

CREATE TABLE `Reparacion` (
  `id_reparacion` int PRIMARY KEY AUTO_INCREMENT,
  `id_siniestro` int,
  `id_taller` int,
  `fecha_ingreso` date,
  `costo_reparacion` float,
  `observaciones` text,
  `registrarIngreso()` void
);

ALTER TABLE `Poliza` ADD FOREIGN KEY (`id_cliente`) REFERENCES `Cliente` (`id_cliente`);

ALTER TABLE `Poliza` ADD FOREIGN KEY (`id_productor`) REFERENCES `Productor` (`id_productor`);

ALTER TABLE `Poliza` ADD FOREIGN KEY (`id_poliza`) REFERENCES `Poliza_Vehicular` (`id_poliza`);

ALTER TABLE `Poliza` ADD FOREIGN KEY (`id_poliza`) REFERENCES `Poliza_Vida` (`id_poliza`);

ALTER TABLE `Poliza` ADD FOREIGN KEY (`id_poliza`) REFERENCES `Poliza_Hogar` (`id_poliza`);

ALTER TABLE `Poliza_Vehicular` ADD FOREIGN KEY (`id_vehiculo`) REFERENCES `Vehiculo` (`id_vehiculo`);

ALTER TABLE `Beneficiario` ADD FOREIGN KEY (`id_poliza_vida`) REFERENCES `Poliza_Vida` (`id_poliza_vida`);

ALTER TABLE `Historial_Medico` ADD FOREIGN KEY (`id_poliza_vida`) REFERENCES `Poliza_Vida` (`id_poliza_vida`);

ALTER TABLE `Item_Hogar` ADD FOREIGN KEY (`id_poliza_hogar`) REFERENCES `Poliza_Hogar` (`id_poliza_hogar`);

ALTER TABLE `Servicio_Grua` ADD FOREIGN KEY (`id_poliza_vehicular`) REFERENCES `Poliza_Vehicular` (`id_poliza_vehicular`);

ALTER TABLE `Siniestro` ADD FOREIGN KEY (`id_poliza`) REFERENCES `Poliza` (`id_poliza`);

ALTER TABLE `Siniestro` ADD FOREIGN KEY (`id_tipo_siniestro`) REFERENCES `Tipo_Siniestro` (`id_tipo_siniestro`);

ALTER TABLE `Foto_Siniestro` ADD FOREIGN KEY (`id_siniestro`) REFERENCES `Siniestro` (`id_siniestro`);

ALTER TABLE `Item_Afectado` ADD FOREIGN KEY (`id_siniestro`) REFERENCES `Siniestro` (`id_siniestro`);

ALTER TABLE `Informe_Tecnico` ADD FOREIGN KEY (`id_siniestro`) REFERENCES `Siniestro` (`id_siniestro`);

ALTER TABLE `Informe_Tecnico` ADD FOREIGN KEY (`id_perito`) REFERENCES `Perito` (`id_perito`);

ALTER TABLE `Reparacion` ADD FOREIGN KEY (`id_siniestro`) REFERENCES `Siniestro` (`id_siniestro`);

ALTER TABLE `Reparacion` ADD FOREIGN KEY (`id_taller`) REFERENCES `Taller` (`id_taller`);
