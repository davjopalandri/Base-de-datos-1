-- Instrucciones SQL para la creación de las tablas correspondientes al diagrama.

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
	Dirección_Origen varchar(50),
	ID_Ciudad_Destino int NOT NULL,
	Dirección_Destino varchar(50),
	Cantidad_de_km_recorridos DECIMAL(10, 2) NOT NULL,
	Fecha_Salida_Estimada DATE NOT NULL,
	Fecha_Salida_Real DATE,
	Fecha_Llegada_Estimada DATE NOT NULL,
	Fecha_Llegada_Real DATE,
	FOREIGN KEY (ID_Cliente) REFERENCES Cliente (ID_Cliente),
	FOREIGN KEY (ID_Chofer) REFERENCES Chofer (ID_Chofer),
	FOREIGN KEY (ID_Ciudad_Origen) REFERENCES Ciudad (ID_Ciudad),
	FOREIGN KEY (ID_Ciudad_Destino) REFERENCES Ciudad (ID_Ciudad),
);

-- Inserción de datos
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


INSERT INTO Camion
	(Patente, ID_Modelo, Anio, ID_Remolque)
VALUES
	('ABC123AF', 1, '2020-01-01', 1),
	('DEF456GH', 2, '2019-02-15', 2),
	('GHI789OY', 3, '2018-05-10', 3),
	('FGS456ER', 4, '2018-05-10', 5),
	('LAJ248KO', 5, '2018-05-10', 3),
	('KWI671PO', 6, '2018-05-10', 4);


INSERT INTO Chofer
	(ID_Camion, Nombre, Apellido, DNI, Domicilio, Telefono_fijo, Telefono_celular, Edad, Email, Codigo_de_registro)
VALUES
	(1, 'Juan', 'Perez', 34-079-0328, '84 Village Green Court', 815-452-3896, 555-123-456, 59, 'juan@email.com', 8543761845),
	(2, 'Rodolph', 'Chaffyn', 34-079-0400, '19289 Marquette Place', 815-921-6973, 430-329-1123, 56, 'rchaffyn0@noaa.gov', 6989374160),
	(3, 'Steffi', 'Carlton', 79-558-5230, '9707 Summit Avenue', 200-452-1786, 788-430-3491, 36, 'scarlton1@shinystat.com', 4927990532),
	(4, 'Milo', 'Pescud', 34-079-0327, '08981 Merry Crossing', 386-893-3896, 344-799-7694, 28, 'mpescud2@va.gov', 7875274745),
	(5, 'Kimble', 'McGrae', 75-038-5343, '0001 Gulseth Terrace', 537-480-0415, 525-861-3238, 45, 'kmcgrae3@redcross.org', 9412738927),
	(6, 'Sherlocke', 'Handley', 51-192-5925, '888 Commercial Terrace', 464-196-0839, 645-529-2299, 35, 'shandley4@aboutads.info', 0707260108),
	(1, 'Erda', 'Cuttings', 73-778-0160, '6 Ludington Alley', 303-736-8632, 712-842-8090, 45, 'ecuttings5@slashdot.org', 1937396282),
	(2, 'Daile', 'Kach', 62-999-1511, '51 Orin Alley', 134-101-0075, 823-843-0920, 26, 'dkach6@histats.com', 1569259682),
	(3, 'Rafael', 'Gaither', 90-617-6109, '5 Harper Place', 846-637-8237, 878-904-0751, 21, 'rgaither7@china.com', 8798386018),
	(4, 'Devlen', 'Incogna', 20-957-1596, '348 Russell Pass', 935-657-4314, 704-160-4014, 65, 'dincogna8@washingtonpost.com', 9923570363);


INSERT INTO Provincia
	(Nombre)
VALUES
	('Buenos Aires'),
	('Catamarca'),
	('Chaco'),
	('Chubut'),
	('Córdoba'),
	('Corrientes'),
	('Entre Ríos'),
	('Formosa'),
	('Jujuy'),
	('La Pampa'),
	('La Rioja'),
	('Mendoza'),
	('Misiones'),
	('Neuquén'),
	('Río Negro'),
	('Salta'),
	('San Juan'),
	('San Luis'),
	('Santa Cruz'),
	('Santa Fe'),
	('Santiago del Estero'),
	('Tierra del Fuego'),
	('Tucumán');


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


INSERT INTO Cliente
	(Nombre, Apellido, Razon_Social, DNI, CUIT, Domicilio, Telefono, Email, ID_Ciudad)
VALUES
	('Etta', 'Reuble', NUll, 190023344, NULL, '580 Logan Circle', 3985574263	,'ereuble0@facebook.com', 1),
	('Giulietta', 'Gerram', NUll, 111699581, NULL, '9 Norway Maple Lane', 7318883387	,'ggerram1@goo.gl', 2),
	('Lucien', 'Quinion', NUll, 493872000, NULL, '2 Haas Court', 5828081878, 'lquinion2@irs.gov', 3),
	('Vite', 'De Miranda', NUll, 888393088, NULL, '0886 Arkansas Crossing', 5772604946	, 'vdemiranda3@webs.com', 4),
	('Tiler', 'Finby', NUll, 314393299, NULL, '86 Di Loreto Junction', 1708782094, 'tfinby4@163.com', 5),
	('Alexine', 'Fairbrass', NUll, 020110396, NULL, '15011 Acker Road', 4699685518, 'afairbrass5@sitemeter.com', 6),
	('Marthena', 'Gritland', NUll, 950608256, NULL, '6999 Sutteridge Point', 8044442078	, 'mgritland6@usgs.gov', 7),
	('Lavinie', 'Roseaman', NUll, 394166700, NULL, '46 Fremont Alley', 4871835683, 'lroseaman7@cbsnews.com', 8),
	('Gris', 'Hensmans', NUll, 823888864, NULL, '4 Corry Plaza', 3193723050, 'ghensmans8@kickstarter.com', 9),
	('Gizela', 'O Sullivan', NUll, 940550029, NULL, '9459 Starling Trail', 8194665039, 'gosullivan9@google.de', 10),
	(NUll, NUll, 'Avaveo', NUll, 602427830, '939 Carey Way', 2196699443, 'fmcdyer0@ftc.gov', 11),
	(NUll, NUll, 'Eabox', NUll, 492140263, '10 Pond Pass', 4883203472, 'mslewcock1@ocn.ne.jp', 12),
	(NUll, NUll, 'Topdrive', NUll, 618902888, '038 Gina Way', 7044698909, 'seakins2@admin.ch', 13),
	(NUll, NUll, 'Viva', NUll, 723321142, '2177 Transport Road', 5827098763, 'adonnel3@state.tx.us', 14),
	(NUll, NUll, 'Rhynoodle', NUll, 584258449, '8423 Oneill Way', 5146233277, 'ecabedo4@addthis.com', 15),
	(NUll, NUll, 'InnoZ', NUll, 905597562, '934 Mosinee Hill', 5976305487, 'kmorrel5@discuz.net', 17),
	(NUll, NUll, 'Talane', NUll, 888988563, '9 Welch Court', 3166655467, 'klembke6@amazon.com', 16),
	(NUll, NUll, 'Realblab', NUll, 331915737, '4539 Dakota Hill', 1854479430, 'kmatzen7@squarespace.com', 18),
	(NUll, NUll, 'Bubbletube', NUll, 042995274, '2429 Rutledge Avenue', 6582318558, 'rcasoni8@princeton.edu', 19),
	(NUll, NUll, 'Tagopia', NUll, 821447700, '968 Thompson Place', 8837189366, 'loakly9@google.ru', 20);


INSERT INTO Viaje_Envio
	(ID_Cliente, ID_Chofer, ID_Ciudad_Origen, Dirección_Origen, ID_Ciudad_Destino, Dirección_Destino, Cantidad_de_km_recorridos, Fecha_Salida_Estimada, Fecha_Salida_Real, Fecha_Llegada_Estimada, Fecha_Llegada_Real)
VALUES
	(5, 9, 18, '921 Coleman Center', 3, '98925 Cody Drive', 300, '2023-3-5', '2023-3-5', '2023-11-03', '2023-11-03'),
	(1, 1, 1, '709 Merry Center', 2, '06 Mallard Terrace', 500.5, '2023-10-31', '2023-10-31', '2023-11-05', '2023-11-05'),
	(2, 2, 3, '744 Summerview Court', 4, '3699 Veith Center', 600.0, '2023-11-01', '2023-11-01', '2023-11-06', '2023-11-06'),
	(3, 2, 5, '71517 Tennessee Avenue', 6, '6 Mesta Plaza', 700.2, '2023-11-02', '2023-11-02', '2023-11-07', '2023-11-07'),
	(12, 5, 10, '64979 Northfield Trail', 8, '3105 Express Parkway', 180, '2023-09-10', '2023-09-10', '2023-09-12', '2023-09-12'),
	(8, 7, 15, '2319 Cody Trail', 6, '66 Summit Center', 250, '2023-10-05', '2023-10-05', '2023-10-08', '2023-10-08'),
	(18, 3, 22, '87 Summer Ridge Way', 11, '52292 Stephen Pass', 120, '2023-11-15', '2023-11-15', '2023-11-18', '2023-11-18'),
	(14, 8, 5, '181 Northfield Crossing', 20, '	99 Fieldstone Junction', 200, '2023-12-01', '2023-12-01', '2023-12-03', '2023-12-03'),
	(6, 2, 12, '132 Fordem Drive', 17, '03 Upham Lane', 150, '2023-10-20', '2023-10-20', '2023-10-22', '2023-10-22'),
	(10, 6, 7, '3349 Kinsman Circle', 14, '8418 Brentwood Parkway', 220, '2023-11-05', '2023-11-05', '2023-11-07', '2023-11-07'),
	(19, 4, 3, '77713 Knutson Road', 9, '45292 Cascade Pass', 180, '2023-12-10', '2023-12-10', '2023-12-12', '2023-12-12'),
	(7, 10, 20, '4 6th Lane', 5, '2826 Evergreen Alley', 300, '2023-01-02', '2023-01-02', '2023-01-05', '2023-01-05'),
	(16, 1, 8, '2300 Knutson Crossing', 22, '2826 Evergreen Alley', 250, '2023-02-15', '2023-02-15', '2023-02-18', '2023-02-18'),
	(9, 5, 16, '327 Jackson Drive', 12, '00966 Badeau Street', 120, '2023-03-20', '2023-03-20', '2023-03-22', '2023-03-22'),
	(11, 3, 9, '540 Hoepker Pass', 18, '12190 Harbort Street', 200, '2023-04-10', '2023-04-10', '2023-04-12', '2023-04-12'),
	(17, 7, 13, '45385 Anniversary Terrace', 4, '99 Magdeline Place', 180, '2023-05-05', '2023-05-05', '2023-05-08', '2023-05-08'),
	(13, 9, 19, '4548 Cody Street', 7, '78 Hudson Drive', 250, '2023-06-15', '2023-06-15', '2023-06-18', '2023-06-18'),
	(20, 2, 14, '6 Bunker Hill Way', 21, '6562 Browning Crossing', 150, '2023-07-01', '2023-07-01', '2023-07-03', '2023-07-03'),
	(8, 6, 11, '4 Meadow Valley Place', 1, '9996 Gale Avenue', 300, '2023-08-10', '2023-08-10', '2023-08-12', '2023-08-12'),
	(5, 9, 2, '30973 Cambridge Road', 3, '8 Kipling Plaza', 300, '2023-3-5', '2023-3-5', '2023-11-03', '2023-11-03'),
	(1, 1, 2, '331 Crest Line Circle', 2, '68 Corscot Pass', 500.5, '2023-10-31', '2023-10-31', '2023-11-05', '2023-11-05'),
	(2, 2, 2, '831 Hoard Hill', 4, '1 American Ash Avenue', 600.0, '2023-11-01', '2023-11-01', '2023-11-06', '2023-11-06'),
	(3, 2, 2, '511 Jenna Place', 6, '6232 Melvin Lane', 700.2, '2023-11-02', '2023-11-02', '2023-11-07', '2023-11-07'),
	(12, 5, 2, '332 Hooker Park', 8, '1237 1st Avenue', 180, '2023-09-10', '2023-09-10', '2023-09-12', '2023-09-12'),
	(8, 7, 2, '79438 Forest Park', 6, '189 Vahlen Circle', 250, '2023-10-05', '2023-10-05', '2023-10-08', '2023-10-08'),
	(18, 3, 2, '18 Acker Hill', 11, '597 Barnett Avenue', 120, '2023-11-15', '2023-11-15', '2023-11-18', '2023-11-18'),
	(14, 8, 2, '001 Bay Court', 20, '73 Northwestern Plaza', 200, '2023-12-01', '2023-12-01', '2023-12-03', '2023-12-03'),
	(6, 2, 2, '00303 Corscot Plaza', 17, '14 Hermina Lane', 150, '2023-10-20', '2023-10-20', '2023-10-22', '2023-10-22'),
	(10, 6, 2, '153 Haas Center', 14, '23 La Follette Plaza', 220, '2023-11-05', '2023-11-05', '2023-11-07', '2023-11-07'),
	(19, 4, 2, '158 Norway Maple Avenue', 9, '366 Spaight Point', 180, '2023-12-10', '2023-12-10', '2023-12-12', '2023-12-12'),
	(7, 10, 2, '46147 Harbort Lane', 5, '12 Quincy Crossing', 300, '2023-01-02', '2023-01-02', '2023-01-05', '2023-01-05'),
	(16, 1, 2, '55672 Clyde Gallagher Parkway', 22, '2 Maryland Place', 250, '2023-02-15', '2023-02-15', '2023-02-18', '2023-02-18'),
	(9, 5, 2, '658 Hagan Drive', 12, '16 Lakewood Gardens Road', 120, '2023-03-20', '2023-03-20', '2023-03-22', '2023-03-22'),
	(11, 3, 2, '82 Gulseth Trail', 18, '4 Blaine Road', 200, '2023-04-10', '2023-04-10', '2023-04-12', '2023-04-12'),
	(17, 7, 2, '7486 Mayfield Terrace', 4, '95 Fuller Hill', 180, '2023-05-05', '2023-05-05', '2023-05-08', '2023-05-08'),
	(13, 9, 2, '6872 Sheridan Parkway', 7, '05 Nancy Trail', 250, '2023-06-15', '2023-06-15', '2023-06-18', '2023-06-18'),
	(20, 2, 2, '8473 Hollow Ridge Circle', 21, '70468 Forest Run Road', 150, '2023-07-01', '2023-07-01', '2023-07-03', '2023-07-03'),
	(8, 6, 2, '906 Nova Parkway', 1, '7123 Morrow Hill', 300, '2023-08-10', '2023-08-10', '2023-08-12', '2023-08-12');

-- ////////////////////////////////////////////////////////////////////////
---  ¿Cuántos viajes se realizaron hacia la provincia de Santa Fe? ---
SELECT COUNT(*) AS Viajes_a_Provincia_StFe
FROM Viaje_Envio v
	left join Ciudad c ON v.ID_Ciudad_Destino = c.ID_Ciudad
	left join Provincia p ON c.ID_Provincia = p.ID_Provincia
WHERE P.Nombre = 'Santa Fe';

--- Mostrar los datos que considere relevantes sobre los viajes realizados ---
--- desde la provincia de Córdoba durante el primer semestre de 2023       ---
SELECT
	v.Codigo_de_viaje AS Codigo_de_viaje,
	c.Nombre AS Cliente,
	ch.Nombre AS Chofer,
	ciud.Nombre AS Ciudad_de_Origen,
	v.Cantidad_de_km_recorridos AS Km_Recorridos,
	v.Fecha_Salida_Real AS Fecha_Salida,
	v.Fecha_Llegada_Real AS Fecha_Llegada
FROM Viaje_Envio v
	LEFT JOIN Cliente c ON v.ID_Cliente = c.ID_Cliente
	LEFT JOIN Chofer ch ON v.ID_Chofer = ch.ID_Chofer
	LEFT JOIN Ciudad ciud ON v.ID_Ciudad_Origen = ciud.ID_Ciudad
	LEFT JOIN Provincia p ON ciud.ID_Provincia = p.ID_Provincia
WHERE v.Fecha_Salida_Real >= '2023-01-01' AND v.Fecha_Salida_Real <= '2023-06-30'
	AND p.Nombre = 'Córdoba';


--- Listar los tres choferes que registraron la mayor cantidad de kilómetros ---
--- recorridos en el año 2023, mostrando sus nombres y la cantidad de  			 ---
--- kilómetros recorridos en orden descendente.														   ---
SELECT TOP 3
	ch.Nombre AS Nombre_Chofer,
	SUM(v.Cantidad_de_km_recorridos) AS Total_Kilometros_Recorridos
FROM dbo.Chofer ch
	LEFT JOIN Viaje_Envio v ON ch.ID_Chofer = v.ID_Chofer
WHERE YEAR(v.Fecha_Salida_Real) = 2023
GROUP BY ch.Nombre
ORDER BY Total_Kilometros_Recorridos DESC;


--- Obtener una lista de los clientes que solicitaron viajes/envíos en 2023, junto ---
--- con los nombres de los choferes y la cantidad de kilómetros recorridos en      ---
--- cada viaje. Muestra esta información en orden descendente de kilómetros 			 ---
--- recorridos																																		 ---
SELECT ISNULL(c.Nombre, c.Razon_Social) AS Cliente,
	ch.Nombre AS Nombre_Chofer,
	ve.Cantidad_de_km_recorridos AS Km_Recorridos
FROM Cliente c
	LEFT JOIN Viaje_Envio ve ON c.ID_Cliente = ve.ID_Cliente
	LEFT JOIN Chofer ch ON ch.ID_chofer = ve.ID_Chofer
WHERE YEAR(ve.Fecha_Salida_Real) = 2023
GROUP BY ISNULL(c.Nombre, c.Razon_Social), ch.Nombre, ve.Cantidad_de_km_recorridos
ORDER BY Km_Recorridos DESC;