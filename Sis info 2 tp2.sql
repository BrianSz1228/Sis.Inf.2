CREATE TABLE `Pais` (
  `id_pais` int PRIMARY KEY AUTO_INCREMENT,
  `pais` varchar(255)
);

CREATE TABLE `Ciudad` (
  `id_ciudad` int PRIMARY KEY AUTO_INCREMENT,
  `ciudad` varchar(255),
  `id_pais` int
);

CREATE TABLE `Personaje` (
  `id_personaje` int PRIMARY KEY AUTO_INCREMENT,
  `nombre` varchar(255),
  `apellido` varchar(255),
  `seudonimo` varchar(255),
  `fecha_nacimiento` date,
  `id_ciudad_nacimiento` int,
  `fecha_defuncion` date,
  `id_ciudad_defuncion` int,
  `calcularEdad()` int,
  `obtenerBiografia()` varchar(255),
  `obtenerPadres()` list
);

CREATE TABLE `Ocupacion` (
  `id_ocupacion` int PRIMARY KEY AUTO_INCREMENT,
  `nombre_ocupacion` varchar(255)
);

CREATE TABLE `Evento` (
  `id_evento` int PRIMARY KEY AUTO_INCREMENT,
  `nombre_evento` varchar(255),
  `fecha_inicio` date,
  `fecha_fin` date,
  `id_ciudad` int,
  `calcularDuracion()` int,
  `listarParticipantes()` list
);

CREATE TABLE `Cancion` (
  `id_cancion` int PRIMARY KEY AUTO_INCREMENT,
  `titulo` varchar(255),
  `id_autor` varchar(255),
  `fecha` date,
  `id_genero` int,
  `reproducir()` void,
  `obtenerPersonajesMencionados()` list
);

CREATE TABLE `Genero` (
  `id_genero` int,
  `genero` varchar(255)
);

CREATE TABLE `Bibliografia` (
  `id_bibliografia` int PRIMARY KEY AUTO_INCREMENT,
  `id_personaje` int,
  `tipo_fuente` varchar(255),
  `titulo` varchar(255),
  `paginas` int,
  `fecha_publicacion` date,
  `generarCitaFormatoAPA()` varchar(255),
  `validarAutenticidad()` boolean
);

CREATE TABLE `Personaje_Ocupacion` (
  `id_personaje` int,
  `id_ocupacion` int,
  `fecha_inicio` date,
  `fecha_fin` date,
  PRIMARY KEY (`id_personaje`, `id_ocupacion`, `fecha_inicio`)
);

CREATE TABLE `Personaje_Evento` (
  `id_personaje` int,
  `id_evento` int,
  `fecha_inicio` date,
  `fecha_fin` date,
  `id_ciudad` int,
  `id_rol` varchar(255),
  PRIMARY KEY (`id_personaje`, `id_evento`)
);

CREATE TABLE `Rol` (
  `id_rol` int,
  `rol` varchar(255)
);

CREATE TABLE `Personaje_Cancion` (
  `id_Personaje` int,
  `id_cancion` int,
  PRIMARY KEY (`id_Personaje`, `id_cancion`)
);

CREATE TABLE `Relacion` (
  `id_relacion` int,
  `relacion` varchar(255)
);

CREATE TABLE `Personaje_Relacion` (
  `Id_personaje1` int,
  `id_personaje2` int,
  `Id_relacion` int
);

ALTER TABLE `Ciudad` ADD FOREIGN KEY (`id_pais`) REFERENCES `Pais` (`id_pais`);

ALTER TABLE `Personaje` ADD FOREIGN KEY (`id_ciudad_nacimiento`) REFERENCES `Ciudad` (`id_ciudad`);

ALTER TABLE `Personaje` ADD FOREIGN KEY (`id_ciudad_defuncion`) REFERENCES `Ciudad` (`id_ciudad`);

ALTER TABLE `Evento` ADD FOREIGN KEY (`id_ciudad`) REFERENCES `Ciudad` (`id_ciudad`);

ALTER TABLE `Bibliografia` ADD FOREIGN KEY (`id_personaje`) REFERENCES `Personaje` (`id_personaje`);

ALTER TABLE `Personaje_Ocupacion` ADD FOREIGN KEY (`id_personaje`) REFERENCES `Personaje` (`id_personaje`);

ALTER TABLE `Personaje_Ocupacion` ADD FOREIGN KEY (`id_ocupacion`) REFERENCES `Ocupacion` (`id_ocupacion`);

ALTER TABLE `Personaje` ADD FOREIGN KEY (`id_personaje`) REFERENCES `Personaje_Relacion` (`Id_personaje1`);

ALTER TABLE `Personaje` ADD FOREIGN KEY (`id_personaje`) REFERENCES `Personaje_Relacion` (`id_personaje2`);

ALTER TABLE `Personaje_Relacion` ADD FOREIGN KEY (`Id_relacion`) REFERENCES `Relacion` (`id_relacion`);

ALTER TABLE `Cancion` ADD FOREIGN KEY (`id_genero`) REFERENCES `Genero` (`id_genero`);

ALTER TABLE `Personaje_Evento` ADD FOREIGN KEY (`id_ciudad`) REFERENCES `Ciudad` (`id_ciudad`);

ALTER TABLE `Personaje` ADD FOREIGN KEY (`id_personaje`) REFERENCES `Cancion` (`id_autor`);

ALTER TABLE `Personaje_Evento` ADD FOREIGN KEY (`id_personaje`) REFERENCES `Personaje` (`id_personaje`);

ALTER TABLE `Personaje_Evento` ADD FOREIGN KEY (`id_evento`) REFERENCES `Evento` (`id_evento`);

ALTER TABLE `Personaje_Evento` ADD FOREIGN KEY (`id_rol`) REFERENCES `Rol` (`id_rol`);

ALTER TABLE `Personaje_Cancion` ADD FOREIGN KEY (`id_Personaje`) REFERENCES `Personaje` (`id_personaje`);

ALTER TABLE `Personaje_Cancion` ADD FOREIGN KEY (`id_cancion`) REFERENCES `Cancion` (`id_cancion`);
