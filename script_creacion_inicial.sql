--------------------------------------
---------------- INIT ----------------
--------------------------------------

USE GD1C2022
GO

IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'GROUPBY4')
BEGIN
	EXEC ('CREATE SCHEMA GROUPBY4')
END
GO


IF OBJECT_ID('GROUPBY4.Involucrados_Incidente', 'U') IS NOT NULL DROP TABLE GROUPBY4.Involucrados_Incidente;
IF OBJECT_ID('GROUPBY4.Incidente', 'U') IS NOT NULL DROP TABLE GROUPBY4.Incidente;
IF OBJECT_ID('GROUPBY4.Cambio_Neumatico', 'U') IS NOT NULL DROP TABLE GROUPBY4.Cambio_Neumatico;
IF OBJECT_ID('GROUPBY4.Parada', 'U') IS NOT NULL DROP TABLE GROUPBY4.Parada;
IF OBJECT_ID('GROUPBY4.Motor_Tele', 'U') IS NOT NULL DROP TABLE GROUPBY4.Motor_Tele;
IF OBJECT_ID('GROUPBY4.Freno_Tele', 'U') IS NOT NULL DROP TABLE GROUPBY4.Freno_Tele;
IF OBJECT_ID('GROUPBY4.Neumatico_Tele', 'U') IS NOT NULL DROP TABLE GROUPBY4.Neumatico_Tele;
IF OBJECT_ID('GROUPBY4.Caja_Tele', 'U') IS NOT NULL DROP TABLE GROUPBY4.Caja_Tele;
IF OBJECT_ID('GROUPBY4.Telemetria', 'U') IS NOT NULL DROP TABLE GROUPBY4.Telemetria;
IF OBJECT_ID('GROUPBY4.Sector', 'U') IS NOT NULL DROP TABLE GROUPBY4.Sector;
IF OBJECT_ID('GROUPBY4.Carrera', 'U') IS NOT NULL DROP TABLE GROUPBY4.Carrera;
IF OBJECT_ID('GROUPBY4.Sector_Tipo', 'U') IS NOT NULL DROP TABLE GROUPBY4.Sector_Tipo;
IF OBJECT_ID('GROUPBY4.Caja', 'U') IS NOT NULL DROP TABLE GROUPBY4.Caja;
IF OBJECT_ID('GROUPBY4.Motor', 'U') IS NOT NULL DROP TABLE GROUPBY4.Motor;
IF OBJECT_ID('GROUPBY4.Neumatico', 'U') IS NOT NULL DROP TABLE GROUPBY4.Neumatico;
IF OBJECT_ID('GROUPBY4.Neumatico_Tipo', 'U') IS NOT NULL DROP TABLE GROUPBY4.Neumatico_Tipo;
IF OBJECT_ID('GROUPBY4.Freno', 'U') IS NOT NULL DROP TABLE GROUPBY4.Freno;
IF OBJECT_ID('GROUPBY4.Auto', 'U') IS NOT NULL DROP TABLE GROUPBY4.Auto;
IF OBJECT_ID('GROUPBY4.Incidente_Tipo', 'U') IS NOT NULL DROP TABLE GROUPBY4.Incidente_Tipo;
IF OBJECT_ID('GROUPBY4.Bandera', 'U') IS NOT NULL DROP TABLE GROUPBY4.Bandera;
IF OBJECT_ID('GROUPBY4.Bandera_Tipo', 'U') IS NOT NULL DROP TABLE GROUPBY4.Bandera_Tipo;
IF OBJECT_ID('GROUPBY4.Piloto', 'U') IS NOT NULL DROP TABLE GROUPBY4.Piloto;
IF OBJECT_ID('GROUPBY4.Escuderia', 'U') IS NOT NULL DROP TABLE GROUPBY4.Escuderia;
IF OBJECT_ID('GROUPBY4.Nacionalidad', 'U') IS NOT NULL DROP TABLE GROUPBY4.Nacionalidad;
IF OBJECT_ID('GROUPBY4.Circuito', 'U') IS NOT NULL DROP TABLE GROUPBY4.Circuito;
IF OBJECT_ID('GROUPBY4.Pais', 'U') IS NOT NULL DROP TABLE GROUPBY4.Pais;


--------------------------------------
--------------- TABLES ---------------
--------------------------------------

CREATE TABLE GROUPBY4.Carrera 
(
	carr_codigo INT IDENTITY PRIMARY KEY,
	carr_fecha DATE NOT NULL ,
	carr_clima NVARCHAR(100) NOT NULL,
	carr_total_carrera DECIMAL(18, 2) NOT NULL,
	carr_cant_vueltas INT NOT NULL,
	carr_circuito INT NOT NULL -- (fk)
)
GO

CREATE TABLE GROUPBY4.Circuito 
(
	circ_codigo INT IDENTITY PRIMARY KEY,
	circ_nombre NVARCHAR(255) NOT NULL,
	circ_pais INT NOT NULL --(fk)
)
GO

CREATE TABLE GROUPBY4.Pais
(
	pais_codigo INT IDENTITY PRIMARY KEY,
	pais_nombre NVARCHAR(255) NOT NULL
)
GO

CREATE TABLE GROUPBY4.Sector
(
	sect_codigo INT IDENTITY PRIMARY KEY,
	sect_distancia DECIMAL(18, 2) NOT NULL,
	sect_tipo INT NOT NULL, -- (fk)
	sect_circuito INT NOT NULL -- (fk) 
)
GO

CREATE TABLE GROUPBY4.Sector_Tipo
(
	sect_tipo_codigo INT IDENTITY PRIMARY KEY,
	sect_tipo_nombre NVARCHAR(255) NOT NULL
)
GO

CREATE TABLE GROUPBY4.Telemetria 
(
	tele_codigo INT IDENTITY PRIMARY KEY,
	tele_auto INT NOT NULL, --(fk)
	tele_carrera INT NOT NULL,--(fk)
	tele_sector INT NOT NULL,--(fk)
	 
	tele_numero_vuelta DECIMAL(18, 0) NOT NULL,
	tele_distancia_vuelta DECIMAL(18, 2) NOT NULL,
	tele_distancia_carrera DECIMAL(18, 6) NOT NULL,
	tele_posicion  DECIMAL(18, 0) NOT NULL,
	tele_tiempo_vuelta  DECIMAL(18, 10) NOT NULL ,
	tele_velocidad DECIMAL(18, 2) NOT NULL,
	tele_combustible DECIMAL(18, 2) NOT NULL
)
GO

CREATE TABLE GROUPBY4.Caja_Tele
(
	caja_tele_codigo INT NOT NULL, -- fk
	caja_tele_caja INT NOT NULL, -- fk
	caja_tele_temp_aceite DECIMAL(18, 2) NOT NULL,
	caja_tele_rpm DECIMAL(18, 2) NOT NULL,
	caja_tele_desgaste DECIMAL(18, 2) NOT NULL,
	PRIMARY KEY(caja_tele_codigo, caja_tele_caja)
)
GO

CREATE TABLE GROUPBY4.Neumatico_Tele 
(
	neum_tele_codigo INT NOT NULL, -- fk
	neum_tele_neum INT NOT NULL, -- fk
	neum_tele_posicion NVARCHAR(255)  NOT NULL,
	neum_tele_presion DECIMAL(18, 6)  NOT NULL,
	neum_tele_profundidad DECIMAL(18, 6)  NOT NULL,
	neum_tele_temperatura DECIMAL(18, 6) NOT NULL,
	PRIMARY KEY(neum_tele_codigo, neum_tele_neum)
)
GO

CREATE TABLE GROUPBY4.Freno_Tele 
(
	freno_tele_codigo INT NOT NULL, -- fk
	freno_tele_freno INT NOT NULL, -- fk
	freno_tele_posicion NVARCHAR(255) NOT NULL,
	freno_tele_temperatura DECIMAL(18, 2)  NOT NULL,
	freno_tele_pastilla DECIMAL(18,2) NOT NULL,
	PRIMARY KEY(freno_tele_codigo, freno_tele_freno)
)
GO

CREATE TABLE GROUPBY4.Motor_Tele 
(
	motor_tele_codigo INT NOT NULL, -- fk
	motor_tele_motor INT NOT NULL, -- fk
	motor_tele_potencia DECIMAL(18, 6) NOT NULL,
	motor_tele_rpm DECIMAL(18, 6)  NOT NULL,
	motor_tele_temp_aceite DECIMAL(18, 6)  NOT NULL,
	motor_tele_temp_agua DECIMAL(18, 6)  NOT NULL
	PRIMARY KEY(motor_tele_codigo, motor_tele_motor)
)
GO

CREATE TABLE GROUPBY4.Caja ( 
	caja_codigo INT IDENTITY PRIMARY KEY,
	caja_nro_serie NVARCHAR(50) NOT NULL,
	caja_modelo NVARCHAR(50) NOT NULL
	
)
GO

CREATE TABLE GROUPBY4.Neumatico 
(
	neum_codigo INT IDENTITY PRIMARY KEY,
	neum_nro_serie NVARCHAR(50) NOT NULL,
	neum_tipo INT NOT NULL --fk
)
GO

CREATE TABLE GROUPBY4.Neumatico_Tipo
(
	neum_tipo_codigo INT IDENTITY PRIMARY KEY,
	neum_tipo_detalle NVARCHAR(50) NOT NULL
)
GO

CREATE TABLE GROUPBY4.Freno
(
	freno_codigo INT IDENTITY PRIMARY KEY,
	freno_nro_serie NVARCHAR(50) NOT NULL,
	frano_tamanio_disco DECIMAL(18,2) NOT NULL
)
GO

CREATE TABLE GROUPBY4.Motor
(
	motor_codigo INT IDENTITY PRIMARY KEY,
	motor_nro_serie NVARCHAR(50) NOT NULL,
	motor_modelo NVARCHAR(50) NOT NULL
)
GO


CREATE TABLE GROUPBY4.Parada
(
	para_codigo INT IDENTITY PRIMARY KEY,
	para_tiempo DECIMAL(18, 2) NOT NULL,
	para_vuelta DECIMAL(18, 0) NOT NULL,
	para_carrera INT NOT NULL, --fk 
	para_auto INT NOT NULL --fk 
)
GO

CREATE TABLE GROUPBY4.Cambio_Neumatico
(
	camb_codigo INT IDENTITY PRIMARY KEY,
	camb_posicion NVARCHAR(255) NOT NULL,
	camb_nuevo INT NOT NULL,
	camb_viejo INT NOT NULL,
	camb_parada INT NOT NULL
)
GO

CREATE TABLE GROUPBY4.Incidente
(
	inci_codigo INT IDENTITY PRIMARY KEY,
	inci_bandera INT NOT NULL,-- fk
	inci_carrera INT NOT NULL, --fk
	inci_tipo INT NOT NULL, --fk
	inci_sector INT  NOT NULL, --fk
	inci_tiempo  DECIMAL(18, 2) NOT NULL
)
GO


CREATE TABLE GROUPBY4.Involucrados_Incidente
(
	invo_incidente INT NOT NULL,
	invo_auto INT NOT NULL,
	invo_nro_vuelta DECIMAL(18, 0) NOT NULL,
	PRIMARY KEY(invo_incidente, invo_auto)
)
GO

CREATE TABLE GROUPBY4.Auto
(
	auto_codigo INT IDENTITY PRIMARY KEY,
	auto_modelo NVARCHAR(255) NOT NULL,
	auto_numero INT NOT NULL,
	auto_piloto INT NOT NULL, --fk
	auto_escuderia INT NOT NULL --fk
)
GO

CREATE TABLE GROUPBY4.Escuderia
(
	escu_codigo INT IDENTITY PRIMARY KEY,
	escu_nombre NVARCHAR(255) NOT NULL,
	escu_nacionalidad INT NOT NULL --fk
)
GO

CREATE TABLE GROUPBY4.Nacionalidad
(
	naci_codigo INT IDENTITY PRIMARY KEY,
	naci_nombre NVARCHAR(255) NOT NULL
)
GO

CREATE TABLE GROUPBY4.Piloto
(
	pilo_codigo INT IDENTITY PRIMARY KEY,
	pilo_nombre NVARCHAR(255) NOT NULL,
	pilo_apellido NVARCHAR(255) NOT NULL,
	pilo_nacionalidad INT NOT NULL, -- fk
	pilo_fecha_nacimiento DATE NOT NULL
)
GO

CREATE TABLE GROUPBY4.Incidente_Tipo
(
	inci_tipo_codigo INT IDENTITY PRIMARY KEY,
	inci_tipo_detalle NVARCHAR(255) NOT NULL
)
GO

CREATE TABLE GROUPBY4.Bandera
(
	band_codigo INT IDENTITY PRIMARY KEY,
	band_detalle NVARCHAR(255) NOT NULL
)
GO


--------------------------------------
------------ FOREING KEYS ------------
--------------------------------------

/*

ALTER TABLE GROUPBY4.Carrera
ADD FOREIGN KEY (carr_circuito) REFERENCES GROUPBY4.Circuito(circ_codigo);


ALTER TABLE GROUPBY4.Circuito
ADD FOREIGN KEY (circ_pais) REFERENCES GROUPBY4.Pais(pais_codigo);


ALTER TABLE GROUPBY4.Sector
ADD FOREIGN KEY (sect_tipo) REFERENCES GROUPBY4.Sector_Tipo(sect_tipo_codigo)

ALTER TABLE GROUPBY4.Sector
ADD FOREIGN KEY (sect_circuito) REFERENCES GROUPBY4.Circuito(circ_codigo);


ALTER TABLE GROUPBY4.Telemetria
ADD FOREIGN KEY (tele_auto) REFERENCES GROUPBY4.Auto(auto_codigo);

ALTER TABLE GROUPBY4.Telemetria
ADD FOREIGN KEY (tele_carrera) REFERENCES GROUPBY4.Carrera(carr_codigo);

ALTER TABLE GROUPBY4.Telemetria
ADD FOREIGN KEY (tele_sector) REFERENCES GROUPBY4.Sector(sect_codigo);


ALTER TABLE GROUPBY4.Caja_Tele
ADD FOREIGN KEY (caja_tele_codigo) REFERENCES GROUPBY4.Telemetria(tele_codigo);

ALTER TABLE GROUPBY4.Caja_Tele
ADD FOREIGN KEY (caja_tele_caja) REFERENCES GROUPBY4.Caja(caja_codigo);


ALTER TABLE GROUPBY4.Neumatico_Tele
ADD FOREIGN KEY (neum_tele_codigo) REFERENCES GROUPBY4.Telemetria(tele_codigo);

ALTER TABLE GROUPBY4.Neumatico_Tele
ADD FOREIGN KEY (neum_tele_neum) REFERENCES GROUPBY4.Neumatico(neum_codigo);


ALTER TABLE GROUPBY4.Freno_Tele
ADD FOREIGN KEY (freno_tele_codigo) REFERENCES GROUPBY4.Telemetria(tele_codigo);

ALTER TABLE GROUPBY4.Freno_Tele
ADD FOREIGN KEY (freno_tele_freno) REFERENCES GROUPBY4.Freno(freno_codigo);


ALTER TABLE GROUPBY4.Motor_Tele
ADD FOREIGN KEY (motor_tele_codigo) REFERENCES GROUPBY4.Telemetria(tele_codigo);

ALTER TABLE GROUPBY4.Motor_Tele
ADD FOREIGN KEY (motor_tele_motor) REFERENCES GROUPBY4.Motor(motor_codigo);


ALTER TABLE GROUPBY4.Neumatico
ADD FOREIGN KEY (neum_tipo) REFERENCES GROUPBY4.Neumatico_Tipo(neum_tipo_codigo);


ALTER TABLE GROUPBY4.Parada
ADD FOREIGN KEY (para_carrera) REFERENCES GROUPBY4.Carrera(carr_codigo);

ALTER TABLE GROUPBY4.Parada
ADD FOREIGN KEY (para_auto) REFERENCES GROUPBY4.Auto(auto_codigo);


ALTER TABLE GROUPBY4.Incidente
ADD FOREIGN KEY (inci_bandera) REFERENCES GROUPBY4.Bandera(band_codigo);

ALTER TABLE GROUPBY4.Incidente
ADD FOREIGN KEY (inci_carrera) REFERENCES GROUPBY4.Carrera(carr_codigo);

ALTER TABLE GROUPBY4.Incidente
ADD FOREIGN KEY (inci_tipo) REFERENCES GROUPBY4.Incidente_Tipo(inci_tipo_codigo);

ALTER TABLE GROUPBY4.Incidente
ADD FOREIGN KEY (inci_sector) REFERENCES GROUPBY4.Sector(sect_codigo);


ALTER TABLE GROUPBY4.Auto
ADD FOREIGN KEY (auto_piloto) REFERENCES GROUPBY4.Piloto(pilo_codigo);

ALTER TABLE GROUPBY4.Auto
ADD FOREIGN KEY (auto_escuderia) REFERENCES GROUPBY4.Escuderia(escu_codigo);


ALTER TABLE GROUPBY4.Escuderia
ADD FOREIGN KEY (escu_nacionalidad) REFERENCES GROUPBY4.Nacionalidad(naci_codigo);

ALTER TABLE GROUPBY4.Piloto
ADD FOREIGN KEY (pilo_nacionalidad) REFERENCES GROUPBY4.Nacionalidad(naci_codigo);

*/


--------------------------------------
------------ INSERT DATA -------------
--------------------------------------


INSERT INTO GROUPBY4.Caja
SELECT DISTINCT 
	 m.TELE_CAJA_NRO_SERIE, 
	 m.TELE_CAJA_MODELO
FROM gd_esquema.Maestra m
WHERE m.TELE_AUTO_CODIGO IS NOT NULL
GO

INSERT INTO GROUPBY4.Motor
SELECT DISTINCT 
	 m.TELE_MOTOR_NRO_SERIE, 
	 m.TELE_MOTOR_MODELO
FROM gd_esquema.Maestra m
WHERE m.TELE_AUTO_CODIGO IS NOT NULL
GO

CREATE VIEW GROUPBY4.VistaNeumaticos AS
SELECT DISTINCT	m.NEUMATICO1_NRO_SERIE_NUEVO NEUMATICO, m.NEUMATICO1_TIPO_NUEVO TIPO FROM gd_esquema.Maestra m WHERE m.NEUMATICO1_NRO_SERIE_NUEVO IS NOT NULL UNION
SELECT DISTINCT	m.NEUMATICO2_NRO_SERIE_NUEVO, m.NEUMATICO2_TIPO_NUEVO FROM gd_esquema.Maestra m WHERE m.NEUMATICO2_NRO_SERIE_NUEVO IS NOT NULL UNION
SELECT DISTINCT	m.NEUMATICO3_NRO_SERIE_NUEVO, m.NEUMATICO3_TIPO_NUEVO FROM gd_esquema.Maestra m WHERE m.NEUMATICO3_NRO_SERIE_NUEVO IS NOT NULL UNION
SELECT DISTINCT	m.NEUMATICO4_NRO_SERIE_NUEVO, m.NEUMATICO4_TIPO_NUEVO FROM gd_esquema.Maestra m WHERE m.NEUMATICO4_NRO_SERIE_NUEVO IS NOT NULL UNION
SELECT DISTINCT	m.NEUMATICO1_NRO_SERIE_VIEJO, m.NEUMATICO1_TIPO_VIEJO FROM gd_esquema.Maestra m WHERE m.NEUMATICO1_NRO_SERIE_VIEJO IS NOT NULL UNION
SELECT DISTINCT	m.NEUMATICO2_NRO_SERIE_VIEJO, m.NEUMATICO2_TIPO_VIEJO FROM gd_esquema.Maestra m WHERE m.NEUMATICO2_NRO_SERIE_VIEJO IS NOT NULL UNION
SELECT DISTINCT	m.NEUMATICO3_NRO_SERIE_VIEJO, m.NEUMATICO3_TIPO_VIEJO FROM gd_esquema.Maestra m WHERE m.NEUMATICO3_NRO_SERIE_VIEJO IS NOT NULL UNION
SELECT DISTINCT	m.NEUMATICO4_NRO_SERIE_VIEJO, m.NEUMATICO4_TIPO_VIEJO FROM gd_esquema.Maestra m	WHERE m.NEUMATICO4_NRO_SERIE_VIEJO IS NOT NULL 
GO

INSERT INTO GROUPBY4.Neumatico_Tipo
SELECT 
	n.TIPO
FROM GROUPBY4.VistaNeumaticos N
GROUP BY n.TIPO
GO

INSERT INTO GROUPBY4.Neumatico
SELECT
	n.NEUMATICO,
	t.neum_tipo_codigo
FROM GROUPBY4.VistaNeumaticos n
JOIN GROUPBY4.Neumatico_Tipo t ON n.TIPO = t.neum_tipo_detalle
GO

DROP VIEW GROUPBY4.VistaNeumaticos
GO

INSERT INTO GROUPBY4.Freno
SELECT DISTINCT m.TELE_FRENO1_NRO_SERIE, m.TELE_FRENO1_TAMANIO_DISCO FROM gd_esquema.Maestra m WHERE m.TELE_AUTO_CODIGO IS NOT NULL UNION
SELECT DISTINCT m.TELE_FRENO2_NRO_SERIE, m.TELE_FRENO2_TAMANIO_DISCO FROM gd_esquema.Maestra m WHERE m.TELE_AUTO_CODIGO IS NOT NULL UNION
SELECT DISTINCT m.TELE_FRENO3_NRO_SERIE, m.TELE_FRENO3_TAMANIO_DISCO FROM gd_esquema.Maestra m WHERE m.TELE_AUTO_CODIGO IS NOT NULL UNION
SELECT DISTINCT m.TELE_FRENO4_NRO_SERIE, m.TELE_FRENO4_TAMANIO_DISCO FROM gd_esquema.Maestra m WHERE m.TELE_AUTO_CODIGO IS NOT NULL
GO

INSERT INTO GROUPBY4.Telemetria 
SELECT 
	m.TELE_AUTO_CODIGO,
	m.CODIGO_CARRERA,
	m.CODIGO_SECTOR,
	m.TELE_AUTO_NUMERO_VUELTA,
	m.TELE_AUTO_DISTANCIA_VUELTA,
	m.TELE_AUTO_DISTANCIA_CARRERA,
	m.TELE_AUTO_POSICION,
	m.TELE_AUTO_TIEMPO_VUELTA,
	m.TELE_AUTO_VELOCIDAD,
	m.TELE_AUTO_COMBUSTIBLE
FROM 
	gd_esquema.Maestra m
WHERE m.TELE_AUTO_CODIGO IS NOT NULL
GO

INSERT INTO GROUPBY4.Motor_Tele
SELECT DISTINCT
	t.tele_codigo,
	mo.motor_codigo,
	m.TELE_MOTOR_POTENCIA,
	m.TELE_MOTOR_RPM,
	m.TELE_MOTOR_TEMP_ACEITE,
	m.TELE_MOTOR_TEMP_AGUA
FROM gd_esquema.Maestra M
JOIN GROUPBY4.motor mo ON m.TELE_MOTOR_NRO_SERIE = mo.motor_nro_serie
JOIN GROUPBY4.Telemetria t ON m.TELE_AUTO_CODIGO = t.tele_auto
GO

INSERT INTO GROUPBY4.Caja_Tele
SELECT DISTINCT
	t.tele_codigo,
	c.caja_codigo,
	m.TELE_CAJA_TEMP_ACEITE,
	m.TELE_CAJA_RPM,
	m.TELE_CAJA_DESGASTE
FROM gd_esquema.Maestra M
JOIN GROUPBY4.Caja c ON m.TELE_CAJA_NRO_SERIE = c.caja_nro_serie
JOIN GROUPBY4.Telemetria t ON m.TELE_AUTO_CODIGO = t.tele_auto
GO

INSERT INTO GROUPBY4.Neumatico_Tele
SELECT DISTINCT
	t.tele_codigo,
	n.neum_codigo,
	m.TELE_NEUMATICO1_POSICION,
	m.TELE_NEUMATICO1_PRESION,
	m.TELE_NEUMATICO1_PROFUNDIDAD,
	m.TELE_NEUMATICO1_TEMPERATURA
FROM gd_esquema.Maestra m
JOIN GROUPBY4.Neumatico n ON m.TELE_NEUMATICO1_NRO_SERIE = n.neum_nro_serie 
JOIN GROUPBY4.Telemetria T on m.TELE_AUTO_CODIGO = t.tele_auto
GO

INSERT INTO GROUPBY4.Neumatico_Tele
SELECT DISTINCT
	t.tele_codigo,
	n.neum_codigo,
	m.TELE_NEUMATICO2_POSICION,
	m.TELE_NEUMATICO2_PRESION,
	m.TELE_NEUMATICO2_PROFUNDIDAD,
	m.TELE_NEUMATICO2_TEMPERATURA
FROM gd_esquema.Maestra m
JOIN GROUPBY4.Neumatico n ON m.TELE_NEUMATICO2_NRO_SERIE = n.neum_nro_serie 
JOIN GROUPBY4.Telemetria T on m.TELE_AUTO_CODIGO = t.tele_auto
GO

INSERT INTO GROUPBY4.Neumatico_Tele
SELECT DISTINCT
	t.tele_codigo,
	n.neum_codigo,
	m.TELE_NEUMATICO3_POSICION,
	m.TELE_NEUMATICO3_PRESION,
	m.TELE_NEUMATICO3_PROFUNDIDAD,
	m.TELE_NEUMATICO3_TEMPERATURA
FROM gd_esquema.Maestra m
JOIN GROUPBY4.Neumatico n ON m.TELE_NEUMATICO3_NRO_SERIE = n.neum_nro_serie 
JOIN GROUPBY4.Telemetria T on m.TELE_AUTO_CODIGO = t.tele_auto
GO

INSERT INTO GROUPBY4.Neumatico_Tele
SELECT DISTINCT
	t.tele_codigo,
	n.neum_codigo,
	m.TELE_NEUMATICO4_POSICION,
	m.TELE_NEUMATICO4_PRESION,
	m.TELE_NEUMATICO4_PROFUNDIDAD,
	m.TELE_NEUMATICO4_TEMPERATURA
FROM gd_esquema.Maestra m
JOIN GROUPBY4.Neumatico n ON m.TELE_NEUMATICO4_NRO_SERIE = n.neum_nro_serie 
JOIN GROUPBY4.Telemetria T on m.TELE_AUTO_CODIGO = t.tele_auto
GO

INSERT INTO GROUPBY4.Freno_Tele
SELECT DISTINCT
	t.tele_codigo,
	f.freno_codigo,
	m.TELE_FRENO1_POSICION,
	m.TELE_FRENO1_TEMPERATURA,
	m.TELE_FRENO1_GROSOR_PASTILLA
FROM gd_esquema.Maestra m
JOIN GROUPBY4.Freno f ON m.TELE_FRENO1_NRO_SERIE = f.freno_nro_serie 
JOIN GROUPBY4.Telemetria T on m.TELE_AUTO_CODIGO = t.tele_auto
GO

INSERT INTO GROUPBY4.Freno_Tele
SELECT DISTINCT
	t.tele_codigo,
	f.freno_codigo,
	m.TELE_FRENO2_POSICION,
	m.TELE_FRENO2_TEMPERATURA,
	m.TELE_FRENO2_GROSOR_PASTILLA
FROM gd_esquema.Maestra m
JOIN GROUPBY4.Freno f ON m.TELE_FRENO2_NRO_SERIE = f.freno_nro_serie 
JOIN GROUPBY4.Telemetria T on m.TELE_AUTO_CODIGO = t.tele_auto
GO

INSERT INTO GROUPBY4.Freno_Tele
SELECT DISTINCT
	t.tele_codigo,
	f.freno_codigo,
	m.TELE_FRENO3_POSICION,
	m.TELE_FRENO3_TEMPERATURA,
	m.TELE_FRENO3_GROSOR_PASTILLA
FROM gd_esquema.Maestra m
JOIN GROUPBY4.Freno f ON m.TELE_FRENO3_NRO_SERIE = f.freno_nro_serie 
JOIN GROUPBY4.Telemetria T on m.TELE_AUTO_CODIGO = t.tele_auto
GO

INSERT INTO GROUPBY4.Freno_Tele
SELECT DISTINCT
	t.tele_codigo,
	f.freno_codigo,
	m.TELE_FRENO4_POSICION,
	m.TELE_FRENO4_TEMPERATURA,
	m.TELE_FRENO4_GROSOR_PASTILLA
FROM gd_esquema.Maestra m
JOIN GROUPBY4.Freno f ON m.TELE_FRENO4_NRO_SERIE = f.freno_nro_serie 
JOIN GROUPBY4.Telemetria T on m.TELE_AUTO_CODIGO = t.tele_auto
GO
