CREATE TABLE `Categoria` (
  `id_categoria` int PRIMARY KEY AUTO_INCREMENT,
  `nombre_categoria` varchar(255),
  `calcularCostoInventarioCategoria()` float
);

CREATE TABLE `Proveedor` (
  `id_proveedor` int PRIMARY KEY AUTO_INCREMENT,
  `razon_social` varchar(255),
  `telefono` varchar(255)
);

CREATE TABLE `Articulo` (
  `id_articulo` int PRIMARY KEY AUTO_INCREMENT,
  `nro_parte` varchar(255) UNIQUE COMMENT 'Número de Parte',
  `descripcion_general` varchar(255),
  `descripcion_articulo` varchar(255),
  `stock_total` int,
  `cantidad_minima_reposicion` int,
  `es_original` boolean,
  `status` varchar(255) COMMENT 'Ej: en falta, obsoleto, discontinuado',
  `observaciones` text,
  `id_categoria` int,
  `nuevoArticulo()` void,
  `borrarArticulo()` void,
  `modificarArticulo()` void,
  `modificarMinimoReposicion(nuevoMinimo)` void,
  `calcularCostoInventario()` float,
  `verificarStockMinimo()` boolean
);

CREATE TABLE `Stock_detalle` (
  `id_stock_detalle` int PRIMARY KEY AUTO_INCREMENT,
  `id_articulo` int,
  `stock` int,
  `ubicacion` varchar(255)
);

CREATE TABLE `Precio` (
  `id_precio` int PRIMARY KEY AUTO_INCREMENT,
  `id_articulo` int,
  `costo` float,
  `precio_publico` float,
  `precio_segundo` float COMMENT 'Precio al público con 10% descuento',
  `fecha_actualizacion` date,
  `actualizarPrecio(nuevoCosto)` void
);

CREATE TABLE `Evolucion_precio` (
  `id_evolucion` int PRIMARY KEY AUTO_INCREMENT,
  `id_articulo` int,
  `id_proveedor` int,
  `fecha_actualizacion` date,
  `precio` float
);

CREATE TABLE `Articulo_Proveedor` (
  `id_articulo_proveedor` int PRIMARY KEY AUTO_INCREMENT,
  `id_articulo` int,
  `id_proveedor` int
);

CREATE TABLE `Venta` (
  `id_venta` int PRIMARY KEY AUTO_INCREMENT,
  `fecha_venta` date,
  `generarEstadisticaVentas()` list
);

CREATE TABLE `Detalle_Venta` (
  `id_detalle_venta` int PRIMARY KEY AUTO_INCREMENT,
  `id_venta` int,
  `id_articulo` int,
  `cantidad_vendida` int,
  `precio_al_momento` float
);

CREATE TABLE `Orden_Pedido` (
  `id_orden` int PRIMARY KEY AUTO_INCREMENT,
  `fecha_orden` date,
  `id_proveedor` int,
  `estado` varchar(255),
  `generarOrdenPedido()` void
);

CREATE TABLE `Detalle_Orden` (
  `id_detalle_orden` int PRIMARY KEY AUTO_INCREMENT,
  `id_orden` int,
  `id_articulo` int,
  `cantidad_pedida` int,
  `valor_u` float COMMENT 'Valor Unitario',
  `calcularCostoTotal()` float
);

ALTER TABLE `Articulo` ADD FOREIGN KEY (`id_categoria`) REFERENCES `Categoria` (`id_categoria`);

ALTER TABLE `Stock_detalle` ADD FOREIGN KEY (`id_articulo`) REFERENCES `Articulo` (`id_articulo`);

ALTER TABLE `Precio` ADD FOREIGN KEY (`id_articulo`) REFERENCES `Articulo` (`id_articulo`);

ALTER TABLE `Articulo_Proveedor` ADD FOREIGN KEY (`id_articulo`) REFERENCES `Articulo` (`id_articulo`);

ALTER TABLE `Articulo_Proveedor` ADD FOREIGN KEY (`id_proveedor`) REFERENCES `Proveedor` (`id_proveedor`);

ALTER TABLE `Evolucion_precio` ADD FOREIGN KEY (`id_articulo`) REFERENCES `Articulo` (`id_articulo`);

ALTER TABLE `Evolucion_precio` ADD FOREIGN KEY (`id_proveedor`) REFERENCES `Proveedor` (`id_proveedor`);

ALTER TABLE `Detalle_Venta` ADD FOREIGN KEY (`id_venta`) REFERENCES `Venta` (`id_venta`);

ALTER TABLE `Detalle_Venta` ADD FOREIGN KEY (`id_articulo`) REFERENCES `Articulo` (`id_articulo`);

ALTER TABLE `Orden_Pedido` ADD FOREIGN KEY (`id_proveedor`) REFERENCES `Proveedor` (`id_proveedor`);

ALTER TABLE `Detalle_Orden` ADD FOREIGN KEY (`id_orden`) REFERENCES `Orden_Pedido` (`id_orden`);

ALTER TABLE `Detalle_Orden` ADD FOREIGN KEY (`id_articulo`) REFERENCES `Articulo` (`id_articulo`);
