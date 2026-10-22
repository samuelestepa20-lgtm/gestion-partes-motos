-- =============================================
-- BASE DE DATOS: SISTEMA DE GESTIÓN DE PARTES DE MOTOS
-- =============================================

-- Crear la base de datos
CREATE DATABASE IF NOT EXISTS gestion_partes_motos;
USE gestion_partes_motos;

-- =============================================
-- TABLA 1: MARCA
-- =============================================
CREATE TABLE MARCA (
    id_marca INT PRIMARY KEY AUTO_INCREMENT,
    nombre_marca VARCHAR(50) NOT NULL,
    pais_origen VARCHAR(40) NOT NULL,
    estado_marca ENUM('Activo', 'Inactivo') DEFAULT 'Activo'
);

-- =============================================
-- TABLA 2: MODELO_MOTO
-- =============================================
CREATE TABLE MODELO_MOTO (
    id_modelo INT PRIMARY KEY AUTO_INCREMENT,
    id_marca INT NOT NULL,
    nombre_modelo VARCHAR(50) NOT NULL,
    referencia VARCHAR(30) NOT NULL,
    anio INT NOT NULL,
    FOREIGN KEY (id_marca) REFERENCES MARCA(id_marca) ON DELETE CASCADE
);

-- =============================================
-- TABLA 3: CATEGORIA_COMPONENTE
-- =============================================
CREATE TABLE CATEGORIA_COMPONENTE (
    id_categoria INT PRIMARY KEY AUTO_INCREMENT,
    nombre_categoria VARCHAR(50) NOT NULL,
    descripcion TEXT
);

-- =============================================
-- TABLA 4: COMPONENTE
-- =============================================
CREATE TABLE COMPONENTE (
    id_componente INT PRIMARY KEY AUTO_INCREMENT,
    codigo_unico VARCHAR(30) NOT NULL UNIQUE,
    nombre_componente VARCHAR(100) NOT NULL,
    descripcion TEXT,
    id_categoria INT NOT NULL,
    ubicacion_almacen VARCHAR(50) NOT NULL,
    estado ENUM('Disponible', 'Agotado', 'En mantenimiento') DEFAULT 'Disponible',
    FOREIGN KEY (id_categoria) REFERENCES CATEGORIA_COMPONENTE(id_categoria)
);

-- =============================================
-- TABLA 5: COMPATIBILIDAD (Parte ↔ Modelo de moto)
-- =============================================
CREATE TABLE COMPATIBILIDAD (
    id_compatibilidad INT PRIMARY KEY AUTO_INCREMENT,
    id_componente INT NOT NULL,
    id_modelo INT NOT NULL,
    FOREIGN KEY (id_componente) REFERENCES COMPONENTE(id_componente) ON DELETE CASCADE,
    FOREIGN KEY (id_modelo) REFERENCES MODELO_MOTO(id_modelo) ON DELETE CASCADE,
    UNIQUE KEY compatibilidad_unica (id_componente, id_modelo)
);

-- =============================================
-- TABLA 6: ROL
-- =============================================
CREATE TABLE ROL (
    id_rol INT PRIMARY KEY AUTO_INCREMENT,
    nombre_rol VARCHAR(30) NOT NULL,
    descripcion_rol TEXT
);

-- =============================================
-- TABLA 7: USUARIO
-- =============================================
CREATE TABLE USUARIO (
    id_usuario INT PRIMARY KEY AUTO_INCREMENT,
    nombre_completo VARCHAR(100) NOT NULL,
    correo VARCHAR(100) NOT NULL UNIQUE,
    contrasena VARCHAR(255) NOT NULL,
    id_rol INT NOT NULL,
    estado_usuario ENUM('Activo', 'Inactivo') DEFAULT 'Activo',
    FOREIGN KEY (id_rol) REFERENCES ROL(id_rol)
);

-- =============================================
-- DATOS DE PRUEBA (para que ya aparezcan registros)
-- =============================================

-- Roles
INSERT INTO ROL (nombre_rol, descripcion_rol) VALUES
('Administrador', 'Control total del sistema'),
('Encargado Inventario', 'Registro y consulta de partes'),
('Consulta', 'Solo puede buscar y ver información');

-- Marcas
INSERT INTO MARCA (nombre_marca, pais_origen) VALUES
('Yamaha', 'Japón'),
('Honda', 'Japón'),
('Suzuki', 'Japón'),
('Kawasaki', 'Japón');

-- Modelos
INSERT INTO MODELO_MOTO (id_marca, nombre_modelo, referencia, anio) VALUES
(1, 'YZF-R3', 'R3-2025', 2025),
(2, 'CB190R', 'CB190-2024', 2024),
(3, 'GSX-R150', 'GSXR-150', 2025),
(4, 'Ninja 400', 'NINJA-400', 2024);

-- Categorías
INSERT INTO CATEGORIA_COMPONENTE (nombre_categoria, descripcion) VALUES
('Motor', 'Piezas del sistema de motor'),
('Frenos', 'Sistema de frenado y repuestos'),
('Eléctrica', 'Luces, cableado y componentes eléctricos'),
('Suspensión', 'Amortiguadores y sistemas de suspensión');

-- Componentes
INSERT INTO COMPONENTE (codigo_unico, nombre_componente, id_categoria, ubicacion_almacen, estado) VALUES
('MOT-001', 'Pistón completo', 1, 'Estante A-1', 'Disponible'),
('FRE-001', 'Pastillas de freno delantero', 2, 'Estante B-3', 'Disponible'),
('ELE-001', 'Foco principal LED', 3, 'Estante C-2', 'Disponible'),
('SUS-001', 'Amortiguador trasero', 4, 'Estante D-1', 'Disponible');

-- Compatibilidad
INSERT INTO COMPATIBILIDAD (id_componente, id_modelo) VALUES
(1, 1), (1, 4),
(2, 2), (2, 3),
(3, 1), (3, 2),
(4, 3), (4, 4);

-- =============================================
-- VERIFICAR QUE TODO SE CREÓ BIEN
-- =============================================
SHOW TABLES;

SHOW TABLES;