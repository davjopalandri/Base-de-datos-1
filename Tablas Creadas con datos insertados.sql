-- 2. Escriba las instrucciones SQL para la creaci�n de las tablas correspondientes al
-- diagrama anterior.

CREATE DATABASE SpeedyGonzalesSRL;

USE SpeedyGonzalesSRL;

CREATE TABLE Provincia
(
	ID_Provincia tinyint NOT NULL IDENTITY PRIMARY KEY,
	Nombre varchar(50)
);

CREATE TABLE Ciudad
(
	ID_Ciudad int NOT NULL IDENTITY PRIMARY KEY,
	ID_Provincia tinyint NOT NULL,
	Nombre varchar(50),
	FOREIGN KEY (ID_Provincia) REFERENCES Provincia (ID_Provincia)
);

CREATE TABLE Remolque
(
	ID_Remolque tinyint NOT NULL IDENTITY PRIMARY KEY,
	Tipo_de_remolque varchar(50) NOT NULL,
);

CREATE TABLE Marca
(
	ID_Marca int NOT NULL IDENTITY PRIMARY KEY,
	Nombre_Marca varchar(50),
);

CREATE TABLE Modelo
(
	ID_Modelo int NOT NULL IDENTITY PRIMARY KEY,
	Nombre_Modelo varchar(50),
	ID_Marca int NOT NULL,
	FOREIGN KEY (ID_Marca) REFERENCES Marca (ID_Marca)
);

CREATE TABLE Camion
(
	ID_Camion int NOT NULL IDENTITY PRIMARY KEY,
	Patente varchar(30),
	ID_Modelo int NOT NULL,
	Anio DATE,
	ID_Remolque tinyint NOT NULL,
	FOREIGN KEY (ID_Remolque) REFERENCES Remolque (ID_Remolque),
	FOREIGN KEY (ID_Modelo) REFERENCES Modelo (ID_Modelo)
);

CREATE TABLE Cliente
(
	ID_Cliente int NOT NULL IDENTITY PRIMARY KEY,
	Codigo_de_cliente AS ('CLI' + RIGHT('000' + CAST(ID_Cliente AS VARCHAR(3)), 4)) PERSISTED,
	Nombre varchar(50),
	Apellido varchar(50),
	Razon_Social varchar(50),
	DNI int,
	CUIT varchar(50),
	Domicilio varchar(50),
	Telefono varchar(30),
	Email varchar(50),
	ID_Ciudad int NOT NULL,
	FOREIGN KEY (ID_Ciudad) REFERENCES Ciudad (ID_Ciudad),
);

CREATE TABLE Chofer
(
	ID_Chofer int NOT NULL IDENTITY PRIMARY KEY,
	ID_Camion int NOT NULL,
	Nombre varchar(50) NOT NULL,
	Apellido varchar(50) NOT NULL,
	DNI int NOT NULL,
	Domicilio varchar(50),
	Telefono_fijo varchar(30),
	Telefono_celular varchar(30),
	Edad tinyint,
	Email varchar(50),
	Codigo_de_registro varchar(50),
	FOREIGN KEY (ID_Camion) REFERENCES Camion (ID_Camion),
);

CREATE TABLE Viaje_Envio
(
	ID_Viaje_Envio int NOT NULL IDENTITY PRIMARY KEY,
	Codigo_de_viaje AS ('VIAJE' + RIGHT('000' + CAST(ID_Viaje_Envio AS VARCHAR(3)), 4)) PERSISTED,
	ID_Cliente int NOT NULL,
	ID_Chofer int NOT NULL,
	ID_Ciudad_Origen int NOT NULL,
	Direccion_Origen varchar(50),
	ID_Ciudad_Destino int NOT NULL,
	Direccion_Destino varchar(50),
	Cantidad_de_km_recorridos DECIMAL(10, 2) NOT NULL,
	Fecha_Salida_Estimada DATE NOT NULL,
	Fecha_Salida_Real DATE,
	Fecha_Llegada_Estimada DATE NOT NULL,
	Fecha_Llegada_Real DATE,
	FOREIGN KEY (ID_Cliente) REFERENCES Clientes (ID_Cliente),
	FOREIGN KEY (ID_Chofer) REFERENCES Chofer (ID_Chofer),
	FOREIGN KEY (ID_Ciudad_Origen) REFERENCES Ciudad (ID_Ciudad),
	FOREIGN KEY (ID_Ciudad_Destino) REFERENCES Ciudad (ID_Ciudad),
);

/* Inserto tres remolques */
INSERT INTO Remolque
	(Tipo_de_remolque)
VALUES
	('Remolque de enganche'),
	('Remolque Eje central'),
	('Remolque Semiremolque'),
	('Remolque de Lowboy'),
	('Remolque de tolva');

INSERT INTO Marca
	(Nombre_Marca)
VALUES
	('Scania'),
	('Mercedez Benz'),
	('Volkswagen');

INSERT INTO Modelo
	(Nombre_Modelo, ID_Marca)
VALUES
	('Serie P', 1),
	('Serie G', 1),
	('Serie R', 1),
	('Serie S', 1),
	('V8', 1),
	('Actros', 2),
	('Axor', 2),
	('Atego', 2),
	('Accelo', 2),
	('Constellation', 3),
	('e-Delivery', 3),
	('Delivery', 3),
	('Meteor', 3);

-- /* Inserto datos para 6 Camiones*/
INSERT INTO Camion
	(Patente, ID_Modelo, Anio, ID_Remolque)
VALUES
	('ABC123AF', 1, '2020-01-01', 1),
	('DEF456GH', 2, '2019-02-15', 2),
	('GHI789OY', 3, '2018-05-10', 3),
	('FGS456ER', 4, '2018-05-10', 5),
	('LAJ248KO', 5, '2018-05-10', 3),
	('KWI671PO', 6, '2018-05-10', 4);

SELECT *
FROM Camion;

-- /* Inserto datos para 10 choferes */
INSERT INTO Chofer
	(ID_Camion, Nombre, Apellido, DNI, Domicilio, Telefono_fijo, Telefono_celular, Edad, Email, Codigo_de_registro)
VALUES
	(1, 'Juan', 'Perez', 34-079-0328, '5th Floor', 815-452-3896, 555-123-456, 59, 'juan@email.com', 8543761845),
	(2, 'Rodolph', 'Chaffyn', 34-079-0400, 'PO Box 68159', 815-921-6973, 430-329-1123, 56, 'rchaffyn0@noaa.gov', 6989374160),
	(3, 'Steffi', 'Carlton', 79-558-5230, '10th Floor', 200-452-1786, 788-430-3491, 36, 'scarlton1@shinystat.com', 4927990532),
	(4, 'Milo', 'Pescud', 34-079-0327, '12th Floor', 386-893-3896, 344-799-7694, 28, 'mpescud2@va.gov', 7875274745),
	(5, 'Kimble', 'McGrae', 75-038-5343, '7th Floor', 537-480-0415, 525-861-3238, 45, 'kmcgrae3@redcross.org', 9412738927),
	(6, 'Sherlocke', 'Handley', 51-192-5925, 'Apt 1053', 464-196-0839, 645-529-2299, 35, 'shandley4@aboutads.info', 0707260108),
	(1, 'Erda', 'Cuttings', 73-778-0160, 'Room 1675', 303-736-8632, 712-842-8090, 45, 'ecuttings5@slashdot.org', 1937396282),
	(2, 'Daile', 'Kach', 62-999-1511, 'Room 701', 134-101-0075, 823-843-0920, 26, 'dkach6@histats.com', 1569259682),
	(3, 'Rafael', 'Gaither', 90-617-6109, 'Suite 89', 846-637-8237, 878-904-0751, 21, 'rgaither7@china.com', 8798386018),
	(4, 'Devlen', 'Incogna', 20-957-1596, 'Suite 36', 935-657-4314, 704-160-4014, 65, 'dincogna8@washingtonpost.com', 9923570363);

-- /* Inserto datos para 10 choferes */
INSERT INTO Provincia
	(Nombre)
VALUES
	('Buenos Aires'),
	('Catamarca'),
	('Chaco'),
	('Chubut'),
	('Cordoba'),
	('Corrientes'),
	('Entre Rios'),
	('Formosa'),
	('Jujuy'),
	('La Pampa'),
	('La Rioja'),
	('Mendoza'),
	('Misiones'),
	('Neuquen'),
	('Rio Negro'),
	('Salta'),
	('San Juan'),
	('San Luis'),
	('Santa Cruz'),
	('Santa Fe'),
	('Santiago del Estero'),
	('Tierra del Fuego'),
	('Tucuman');

/* Inserto 29 ciudades de Argentina con su ID_provincia*/
INSERT INTO Ciudad
	(ID_Provincia, Nombre)
VALUES
	(1, 'Buenos Aires'),
	(5, 'Córdoba'),
	(20, 'Rosario'),
	(12, 'Mendoza'),
	(1, 'La Plata'),
	(1, 'Mar del Plata'),
	(16, 'Salta'),
	(20, 'Santa Fe'),
	(17, 'San Juan'),
	(1, 'Bahía Blanca'),
	(14, 'Neuquén'),
	(13, 'Posadas'),
	(23, 'San Miguel de Tucumán'),
	(11, 'La Rioja'),
	(9, 'San Salvador de Jujuy'),
	(22, 'Ushuaia'),
	(8, 'Formosa'),
	(3, 'Resistencia'),
	(6, 'Corrientes'),
	(4, 'Rawson'),
	(15, 'Viedma'),
	(10, 'Santa Rosa'),
	(1, 'Quilmes'),
	(1, 'Tandil'),
	(20, 'Rafaela'),
	(12, 'San Rafael'),
	(1, 'Berisso'),
	(1, 'Necochea'),
	(20, 'Reconquista'),
	(4, 'Comodoro Rivadavia');

-- /* Inserto 20 Clientes entre personas y empresas*/
INSERT INTO Cliente	(Nombre, Apellido, Razon_Social, DNI, CUIT, Domicilio, Telefono, Email, ID_Ciudad)
VALUES
	('Etta'     		, 'Reuble'			, NUll, 190023344, NULL, 'Apt 1233'		, 3985574263	, 'ereuble0@facebook.com', 1),
	('Giulietta'		, 'Gerram'			, NUll, 111699581, NULL, 'PO Box 63165', 7318883387	, 'ggerram1@goo.gl', 2),
	('Lucien'				, 'Quinion'			, NUll, 493872000, NULL, 'Suite 99'	, 5828081878, 'lquinion2@irs.gov', 3),
	('Vite'					, 'De Miranda'	, NUll, 888393088, NULL, 'Room 1880'		, 5772604946	, 'vdemiranda3@webs.com', 4),
	('Tiler'				, 'Finby'				, NUll, 314393299, NULL, 'Apt 752'		, 1708782094, 'tfinby4@163.com', 5),
	('Alexine'				, 'Fairbrass'			, NUll, 020110396, NULL, 'PO Box 74202', 4699685518, 'afairbrass5@sitemeter.com', 6),
	('Marthena'				, 'Gritland'			, NUll, 950608256, NULL, '14th Floor', 8044442078	, 'mgritland6@usgs.gov', 7),
	('Lavinie'				, 'Roseaman'			, NUll, 394166700, NULL, 'Room 975'	, 4871835683, 'lroseaman7@cbsnews.com', 8),
	('Gris'						, 'Hensmans'			, NUll, 823888864, NULL, '8th Floor'	, 3193723050, 'ghensmans8@kickstarter.com', 9),
	('Gizela'					, 'O Sullivan', NUll, 940550029, NULL, 'Apt 721'			, 8194665039, 'gosullivan9@google.de', 10);

-- /* INSERTO 18 VIAJES */
-- INSERT INTO dbo.Viaje_Envio (ID_Cliente, ID_Chofer, ID_Ciudad_Origen, Direcci�n_Origen, ID_Ciudad_Destino, Direcci�n_Destino, Cantidad_de_km_recorridos, Fecha_Salida_Estimada, Fecha_Salida_Real, Fecha_Llegada_Estimada, Fecha_Llegada_Real)
-- VALUES
--     (1, 1, 1, 'Direcci�n Origen 1', 2, 'Direcci�n Destino 1', 500.5, '2023-10-31', '2023-10-31', '2023-11-05', '2023-11-05'),
--     (2, 2, 3, 'Direcci�n Origen 2', 4, 'Direcci�n Destino 2', 600.0, '2023-11-01', '2023-04-01', '2023-11-06', '2023-11-06'),
--     (3, 2, 5, 'Direcci�n Origen 3', 6, 'Direcci�n Destino 3', 700.2, '2023-11-02', '2023-11-02', '2023-11-07', '2023-11-07');