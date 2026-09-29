CREATE TABLE `Pinacoteca` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `nombre` varchar(255) UNIQUE COMMENT 'Nombre único de la pinacoteca',
  `ciudad` varchar(255),
  `provincia` varchar(255),
  `direccion` varchar(255),
  `metros_cuadrados` float
);

CREATE TABLE `Cuadro` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `codigo` varchar(255) UNIQUE,
  `nombre_obra` varchar(255),
  `alto` float,
  `ancho` float,
  `fecha_pintado` date,
  `tecnica` varchar(255),
  `tema` varchar(255),
  `miniatura_url` varchar(255) COMMENT 'Ruta de la imagen de la obra',
  `id_pinacoteca` int COMMENT 'FK a Pinacoteca',
  `id_pintor` int COMMENT 'FK al Pintor que lo creó'
);

CREATE TABLE `Pintor` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `nombre` varchar(255),
  `apellido` varchar(255),
  `seudonimo` varchar(255),
  `fecha_nacimiento` date,
  `ciudad_nacimiento` varchar(255),
  `pais_nacimiento` varchar(255),
  `fecha_fallecimiento` date,
  `ciudad_fallecimiento` varchar(255),
  `pais_fallecimiento` varchar(255),
  `id_maestro` int COMMENT 'FK reflexiva a otro Pintor (puede ser nula)'
);

CREATE TABLE `Escuela` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `nombre` varchar(255),
  `pais_aparicion` varchar(255),
  `fecha_aparicion` date
);

CREATE TABLE `Mecenas` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `nombre` varchar(255),
  `apellido` varchar(255),
  `ciudad` varchar(255),
  `pais` varchar(255)
);

CREATE TABLE `PeriodoEscuela` (
  `id_pintor` int,
  `id_escuela` int,
  `fecha_inicio` date,
  `fecha_fin` date COMMENT 'Puede ser nula si sigue perteneciendo',
  PRIMARY KEY (`id_pintor`, `id_escuela`)
);

CREATE TABLE `Mecenazgo` (
  `id_pintor` int,
  `id_mecenas` int,
  `fecha_inicio` date,
  `fecha_fin` date,
  PRIMARY KEY (`id_pintor`, `id_mecenas`)
);

ALTER TABLE `Cuadro` ADD FOREIGN KEY (`id_pinacoteca`) REFERENCES `Pinacoteca` (`id`);

ALTER TABLE `Cuadro` ADD FOREIGN KEY (`id_pintor`) REFERENCES `Pintor` (`id`);

ALTER TABLE `Pintor` ADD FOREIGN KEY (`id_maestro`) REFERENCES `Pintor` (`id`);

ALTER TABLE `PeriodoEscuela` ADD FOREIGN KEY (`id_pintor`) REFERENCES `Pintor` (`id`);

ALTER TABLE `PeriodoEscuela` ADD FOREIGN KEY (`id_escuela`) REFERENCES `Escuela` (`id`);

ALTER TABLE `Mecenazgo` ADD FOREIGN KEY (`id_pintor`) REFERENCES `Pintor` (`id`);

ALTER TABLE `Mecenazgo` ADD FOREIGN KEY (`id_mecenas`) REFERENCES `Mecenas` (`id`);
