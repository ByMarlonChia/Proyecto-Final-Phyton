-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 05-11-2025 a las 07:20:31
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `agronorte`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `control_invernadero`
--

CREATE TABLE `control_invernadero` (
  `idControl` int(11) NOT NULL,
  `invernadero_id` int(11) NOT NULL,
  `fecha` datetime NOT NULL,
  `temperatura` decimal(5,2) DEFAULT NULL,
  `humedad` decimal(5,2) DEFAULT NULL,
  `ph_suelo` decimal(5,2) DEFAULT NULL,
  `observaciones` text DEFAULT NULL,
  `creado_en` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `enfermedad`
--

CREATE TABLE `enfermedad` (
  `idEnfermedad` int(11) NOT NULL,
  `nombreEnfermedad` varchar(200) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `tipoCultivo` varchar(120) DEFAULT NULL,
  `fechaDeteccion` date DEFAULT NULL,
  `nivelGravedad` enum('bajo','medio','alto','critico') DEFAULT 'medio',
  `invernadero_id` int(11) DEFAULT NULL,
  `creado_en` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `enfermedad`
--

INSERT INTO `enfermedad` (`idEnfermedad`, `nombreEnfermedad`, `descripcion`, `tipoCultivo`, `fechaDeteccion`, `nivelGravedad`, `invernadero_id`, `creado_en`) VALUES
(1, 'Mildiu', 'Hongo que afecta hojas y fruto', 'Tomate', '2024-08-12', 'alto', 1, '2025-11-05 05:33:41'),
(2, 'Pudrición de raíz', 'Causada por exceso de humedad en sustrato', 'Lechuga', '2024-03-02', 'medio', 2, '2025-11-05 05:33:41');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `invernadero`
--

CREATE TABLE `invernadero` (
  `idInvernadero` int(11) NOT NULL,
  `nombreInvernadero` varchar(180) NOT NULL,
  `capacidadProduccion` int(11) DEFAULT NULL,
  `superficie` decimal(10,2) DEFAULT NULL,
  `tipoCultivo` varchar(100) DEFAULT NULL,
  `sistemaRiego` varchar(100) DEFAULT NULL,
  `fechaCreacion` date DEFAULT NULL,
  `responsable` varchar(150) DEFAULT NULL,
  `estado` varchar(50) DEFAULT 'activo',
  `imagen` varchar(255) DEFAULT NULL,
  `creado_en` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `invernadero`
--

INSERT INTO `invernadero` (`idInvernadero`, `nombreInvernadero`, `capacidadProduccion`, `superficie`, `tipoCultivo`, `sistemaRiego`, `fechaCreacion`, `responsable`, `estado`, `imagen`, `creado_en`) VALUES
(1, 'Invernadero Central', 1200, 250.50, 'Tomate', 'Goteo', '2023-06-01', 'Juan Pérez', 'activo', NULL, '2025-11-05 05:33:41'),
(2, 'Invernadero Norte', 800, 150.00, 'Lechuga', 'Aspersión', '2024-01-15', 'María Gómez', 'activo', NULL, '2025-11-05 05:33:41');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `notificacion`
--

CREATE TABLE `notificacion` (
  `idNotificacion` int(11) NOT NULL,
  `usuario_id` int(11) DEFAULT NULL,
  `mensaje` text NOT NULL,
  `tipo` varchar(60) DEFAULT 'sistema',
  `leido` tinyint(1) DEFAULT 0,
  `enlace` varchar(255) DEFAULT NULL,
  `creado_en` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `idUsuario` int(11) NOT NULL,
  `usuario` varchar(100) NOT NULL,
  `contrasena` varchar(255) NOT NULL,
  `nombre` varchar(150) DEFAULT NULL,
  `correo` varchar(150) DEFAULT NULL,
  `rol` enum('admin','tecnico','usuario') DEFAULT 'usuario',
  `activo` tinyint(1) DEFAULT 1,
  `creado_en` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`idUsuario`, `usuario`, `contrasena`, `nombre`, `correo`, `rol`, `activo`, `creado_en`) VALUES
(1, 'admin', '$2y$12$XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX', 'Administrador', 'admin@local.test', 'admin', 1, '2025-11-05 05:33:41'),
(2, 'tecnico', '$2y$12$YYYYYYYYYYYYYYYYYYYYYYYYYYYYYY', 'Técnico', 'tecnico@local.test', 'tecnico', 1, '2025-11-05 05:33:41'),
(3, 'usuario1', '$2y$12$ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ', 'Usuario Demo', 'user@local.test', 'usuario', 1, '2025-11-05 05:33:41');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `control_invernadero`
--
ALTER TABLE `control_invernadero`
  ADD PRIMARY KEY (`idControl`),
  ADD KEY `idx_control_fecha` (`invernadero_id`,`fecha`),
  ADD KEY `idx_control_invernadero_fecha` (`invernadero_id`,`fecha`);

--
-- Indices de la tabla `enfermedad`
--
ALTER TABLE `enfermedad`
  ADD PRIMARY KEY (`idEnfermedad`),
  ADD KEY `invernadero_id` (`invernadero_id`),
  ADD KEY `idx_enfermedad_tipo` (`tipoCultivo`);

--
-- Indices de la tabla `invernadero`
--
ALTER TABLE `invernadero`
  ADD PRIMARY KEY (`idInvernadero`),
  ADD KEY `idx_tipoCultivo` (`tipoCultivo`),
  ADD KEY `idx_responsable` (`responsable`),
  ADD KEY `idx_invernadero_tipo` (`tipoCultivo`);

--
-- Indices de la tabla `notificacion`
--
ALTER TABLE `notificacion`
  ADD PRIMARY KEY (`idNotificacion`),
  ADD KEY `usuario_id` (`usuario_id`,`leido`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`idUsuario`),
  ADD UNIQUE KEY `usuario` (`usuario`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `control_invernadero`
--
ALTER TABLE `control_invernadero`
  MODIFY `idControl` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `enfermedad`
--
ALTER TABLE `enfermedad`
  MODIFY `idEnfermedad` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `invernadero`
--
ALTER TABLE `invernadero`
  MODIFY `idInvernadero` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `notificacion`
--
ALTER TABLE `notificacion`
  MODIFY `idNotificacion` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `idUsuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `control_invernadero`
--
ALTER TABLE `control_invernadero`
  ADD CONSTRAINT `control_invernadero_ibfk_1` FOREIGN KEY (`invernadero_id`) REFERENCES `invernadero` (`idInvernadero`) ON DELETE CASCADE;

--
-- Filtros para la tabla `enfermedad`
--
ALTER TABLE `enfermedad`
  ADD CONSTRAINT `enfermedad_ibfk_1` FOREIGN KEY (`invernadero_id`) REFERENCES `invernadero` (`idInvernadero`) ON DELETE SET NULL;

--
-- Filtros para la tabla `notificacion`
--
ALTER TABLE `notificacion`
  ADD CONSTRAINT `notificacion_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`idUsuario`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
