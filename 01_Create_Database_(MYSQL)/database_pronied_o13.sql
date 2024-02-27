-- CREATE THE DATABASE
CREATE DATABASE IF NOT EXISTS pronied_o13;

USE pronied_o13;

-- CREATING TABLES

-- DIMENSION TABLES

-- CREATE RESIDENTES TABLE
DROP TABLE IF EXISTS residentes;
CREATE TABLE residentes (
    residente_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    celular VARCHAR(50) NOT NULL
);

-- CREATE RESIDENTES JUNIOR TABLE
DROP TABLE IF EXISTS residentes_junior;
CREATE TABLE residentes_junior (
    residente_junior_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    celular VARCHAR(50) NOT NULL
);

-- CREATE COLEGIOS TABLE
DROP TABLE IF EXISTS colegios;
CREATE TABLE colegios (
    colegio_id INT NOT NULL PRIMARY KEY,
    colegio_nombre VARCHAR(100) NOT NULL,
    distrito VARCHAR(50) NOT NULL,
    estado_pronied ENUM('Apro. Acta', 'Aprob. Sin Acta', 'Observado') NOT NULL,
    estado_ejecucion ENUM('Pendiente', 'Ejecutado', 'En Ejecución') NOT NULL,
    latitud DECIMAL(10, 8) NOT NULL,
    longitud DECIMAL(11, 8) NOT NULL
);

-- CREATE CONTRATISTAS TABLE
DROP TABLE IF EXISTS contratistas;
CREATE TABLE contratistas (
    contratista_id INT NOT NULL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL,
    numero_celular VARCHAR(20) NOT NULL,
    razon_social VARCHAR(80) NOT NULL UNIQUE,
    numero_de_contrato VARCHAR(20) NOT NULL UNIQUE,
    cantidad_meac INT NOT NULL,
    costo_por_meac DECIMAL(12, 2) NOT NULL,
    adelanto_contrato DECIMAL(12, 2) NOT NULL
);

-- CREATE MEACS TABLE
DROP TABLE IF EXISTS meacs;
CREATE TABLE meacs (
    colegio_id INT NOT NULL,
    meac_id INT NOT NULL,
    meac_name VARCHAR(10) NOT NULL,
    nivel ENUM('Primaria', 'Secundaria') NOT NULL,
    tipo_terreno VARCHAR(250),
    estado_ejecucion ENUM('Pendiente', 'Ejecutado', 'En Ejecución'),

    PRIMARY KEY (colegio_id, meac_id),
    FOREIGN KEY (colegio_id) REFERENCES colegios(colegio_id)
);

-- CREATE PLAZO_EJECUCION TABLE
DROP TABLE IF EXISTS plazo_ejecucion;
CREATE TABLE plazo_ejecucion (
	fecha DATE NOT NULL PRIMARY KEY,
    fecha_contratual VARCHAR(10) NOT NULL UNIQUE,
    año INT NOT NULL,
    numero_mes INT NOT NULL,
    mes_nombre VARCHAR(10),
    semana INT NOT NULL,
    numero_dia INT NOT NULL,
    dia VARCHAR(10) NOT NULL,
    avance_programado DECIMAL(10,4) NOT NULL,
    avance_programado_acumulado DECIMAL(10,4) NOT NULL
);


-- CREATE RENDIMIENTOS TABLE
ALTER TABLE meacs ADD INDEX idx_meac_id (meac_id);

DROP TABLE IF EXISTS rendimientos;
CREATE TABLE rendimientos (
	colegio_id INT NOT NULL,
    meac_id INT NOT NULL,
    avance_acumulado DECIMAL(10,4) NOT NULL,
    rendimiento DECIMAL(10,4) NOT NULL,
    dias_en_ejecucion INT NOT NULL,
    estado_ejecucion ENUM('Pendiente','Ejecutado','En Ejecución'),
    
    PRIMARY KEY (colegio_id, meac_id),
    FOREIGN KEY (colegio_id) REFERENCES colegios(colegio_id), 
    FOREIGN KEY (meac_id) REFERENCES meacs(meac_id)
); 



-- FACTLESS TABLES

-- CREATE ASIGNACION_CONTRATISTAS TABLE
DROP TABLE IF EXISTS asignacion_contratistas;
CREATE TABLE asignacion_contratistas (
	colegio_id INT NOT NULL,
    meac_id INT NOT NULL,
    contratista_id INT NOT NULL,
    
    PRIMARY KEY (colegio_id, meac_id), 
    FOREIGN KEY (colegio_id) REFERENCES colegios(colegio_id),
    FOREIGN KEY (meac_id) REFERENCES meacs(meac_id),
    FOREIGN KEY (contratista_id) REFERENCES contratistas(contratista_id)
);

-- CREATE ASIGNACION_RESIDENTES TABLE
DROP TABLE IF EXISTS asignacion_residentes;
CREATE TABLE asignacion_residente (
	colegio_id INT NOT NULL,
    residente_id INT NOT NULL,
    
    PRIMARY KEY (colegio_id, residente_id),
    FOREIGN KEY (colegio_id) REFERENCES colegios(colegio_id),
    FOREIGN KEY (residente_id) REFERENCES residentes(residente_id)
);

-- CREATE ASIGNACION_RESIDENTES_JUNIOR TABLE
DROP TABLE IF EXISTS asignacion_residentes_junior;
CREATE TABLE asignacion_residentes_junior (
	colegio_id INT NOT NULL,
    meac_id INT NOT NULL,
    residente_junior_id INT NOT NULL,
    
    PRIMARY KEY (colegio_id, meac_id), 
    FOREIGN KEY (colegio_id) REFERENCES colegios(colegio_id),
    FOREIGN KEY (meac_id) REFERENCES meacs(meac_id),
    FOREIGN KEY (residente_junior_id) REFERENCES residentes_junior(residente_junior_id)
);


-- FACT TABLES

-- CREATE PROGRESO_DIARIO TABLE
DROP TABLE IF EXISTS progreso_diario;
CREATE TABLE progreso_diario (
	colegio_id INT NOT NULL,
    meac_id INT NOT NULL,
    fecha DATE NOT NULL,
    avance_acumulado DECIMAL(10,4),
    avance_diario DECIMAL(10,4),
    
    PRIMARY KEY (colegio_id, meac_id),
    FOREIGN KEY (colegio_id) REFERENCES colegios(colegio_id),
    FOREIGN KEY (meac_id) REFERENCES meacs(meac_id)
);
    
    
    
    
    
    
    
    
    
    
    
