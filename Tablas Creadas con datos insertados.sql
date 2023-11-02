USE SpeedyGonzalesSRL


CREATE TABLE dbo.Provincia (
    ID_Provincia int NOT NULL IDENTITY(1, 1) PRIMARY KEY,
    Nombre varchar(50)
);


CREATE TABLE dbo.Ciudad(
	ID_Ciudad int NOT NULL IDENTITY(1, 1) PRIMARY KEY,
	ID_Provincia int NOT NULL,
	Nombre varchar(50),
	FOREIGN KEY (ID_Provincia) REFERENCES dbo.Provincia (ID_Provincia)
);


CREATE TABLE dbo.Remolques(
	ID_Remolques int NOT NULL IDENTITY(1, 1) PRIMARY KEY,
	Tipo_de_remolque varchar(50) NOT NULL,
);


CREATE TABLE dbo.Camiones(
	ID_Camion int NOT NULL IDENTITY(1, 1) PRIMARY KEY,
	Patente varchar(50),
	Marca varchar(50),
	Modelo int,
	A�o DATE,
	ID_Remolque int NOT NULL,
	FOREIGN KEY (ID_Remolque) REFERENCES dbo.Remolques (ID_Remolques)
);


CREATE TABLE dbo.Clientes(
	ID_Cliente int NOT NULL IDENTITY(1, 1) PRIMARY KEY,
	Codigo_de_cliente varchar(50)  NOT NULL,
	Nombre varchar(50),
	Apellido varchar(50),
	DNI int,
	Razon_Social varchar(50),
	CUIT varchar(50),
	Telefono varchar(50),
	Email varchar(50),
	ID_Ciudad int,
	ID_Provincia int,
	Domicilio varchar(50),
	FOREIGN KEY (ID_Ciudad) REFERENCES dbo.Ciudad (ID_Ciudad),
	FOREIGN KEY (ID_Provincia) REFERENCES dbo.Provincia (ID_Provincia)
);


CREATE TABLE dbo.Chofer(
	ID_Chofer int NOT NULL IDENTITY(1, 1) PRIMARY KEY,
	ID_Camion int NOT NULL,
	Nombre varchar(50) NOT NULL,
	Apellido varchar(50) NOT NULL,
	Razon_Social varchar(50) NOT NULL,
	DNI int NOT NULL,
	CUIT varchar(20) NOT NULL,
	Domicilio varchar(50),
	Telefono varchar(20),
	Email varchar(50),
  FOREIGN KEY (ID_Camion) REFERENCES dbo.Camiones (ID_Camion),
);

CREATE TABLE dbo.Viaje_Envio(
	ID_Viaje_Envio int NOT NULL IDENTITY(1, 1) PRIMARY KEY,
	Codigo_de_viaje varchar(50) NOT NULL,
	ID_Cliente int NOT NULL,
	ID_Chofer int NOT NULL,
	ID_Provincia_Origen int NOT NULL,
	ID_Ciudad_Origen int NOT NULL,
	Direcci�n_Origen varchar(50),
	ID_Provincia_Destino int NOT NULL,
	ID_Ciudad_Destino int NOT NULL,
	Direcci�n_Destino varchar(50),
	Cantidad_de_km_recorridos REAL NOT NULL,
	Fecha_Salida_Estimada DATE NOT NULL,
	Fecha_Salida_Real DATE NOT NULL,
	Fecha_Llegada_Estimada DATE NOT NULL,
	Fecha_Llegada_Real DATE NOT NULL,
 FOREIGN KEY (ID_Cliente) REFERENCES dbo.Clientes (ID_Cliente),
 FOREIGN KEY (ID_Chofer) REFERENCES dbo.Chofer (ID_Chofer),
 FOREIGN KEY (ID_Provincia_Origen) REFERENCES dbo.Provincia (ID_Provincia),
 FOREIGN KEY (ID_Ciudad_Origen) REFERENCES dbo.Ciudad (ID_Ciudad),
 FOREIGN KEY (ID_Provincia_Destino) REFERENCES dbo.Provincia (ID_Provincia),
 FOREIGN KEY (ID_Ciudad_Destino) REFERENCES dbo.Ciudad (ID_Ciudad),
);


/* Inserto tres remolques */
INSERT INTO dbo.Remolques (Tipo_de_remolque)
VALUES
    ('Remolque de enganche'),
    ('Remolque Eje central'),
    ('Remolque Semiremolque');

/* Inserto datos para 6 Camiones*/
INSERT INTO dbo.Camiones (Patente, Marca, Modelo, A�o, ID_Remolque)
VALUES
    ('ABC123', 'Marca1', 2020, '2020-01-01', 1),
    ('DEF456', 'Marca2', 2019, '2019-02-15', 2),
    ('GHI789', 'Marca3', 2018, '2018-05-10', 3),
    ('JKL012', 'Marca4', 2021, '2021-11-30', 1),
    ('MNO345', 'Marca5', 2017, '2017-09-20', 2),
    ('PQR678', 'Marca6', 2022, '2022-03-05', 3);

/* Inserto datos para 10 choferes */
INSERT INTO dbo.Chofer (ID_Camion, Nombre, Apellido, Razon_Social, DNI, CUIT, Domicilio, Telefono, Email)
VALUES
    (1, 'Juan', 'P�rez', 'Transportes P�rez SRL', 12345678, '20-12345678-4', 'Direcci�n1', '555-123-456', 'juan@email.com'),
    (2, 'Ana', 'L�pez', 'Transportes L�pez SA', 87654321, '27-87654321-8', 'Direcci�n2', '555-987-654', 'ana@email.com'),
    (3, 'Carlos', 'G�mez', 'G�mez Transport', 98765432, '30-98765432-6', 'Direcci�n3', '555-345-678', 'carlos@email.com'),
    (4, 'Mar�a', 'Mart�nez', 'Mart�nez Log�stica', 23456789, '25-23456789-1', 'Direcci�n4', '555-234-567', 'maria@email.com'),
    (5, 'Luis', 'Torres', 'Transportes Torres', 34567890, '27-34567890-3', 'Direcci�n5', '555-789-012', 'luis@email.com'),
    (6, 'Ana', 'Rodr�guez', 'Rodr�guez Logistics', 76543210, '30-76543210-7', 'Direcci�n6', '555-345-678', 'ana2@email.com'),
    (1, 'Miguel', 'S�nchez', 'S�nchez Transport', 65432109, '25-65432109-9', 'Direcci�n7', '555-654-321', 'miguel@email.com'),
    (2, 'Laura', 'Garc�a', 'Garc�a Transporte', 89012345, '27-89012345-2', 'Direcci�n8', '555-890-123', 'laura@email.com'),
    (3, 'Javier', 'Fern�ndez', 'Fern�ndez Trucking', 12345987, '30-12345987-5', 'Direcci�n9', '555-987-123', 'javier@email.com'),
    (4, 'Eva', 'D�az', 'D�az Logistics', 98765412, '25-98765412-0', 'Direcci�n10', '555-987-654', 'eva@email.com');




INSERT INTO Provincia (Nombre)
VALUES ('Buenos Aires'),
('Catamarca'),
('Chaco'),
('Chubut'),
('C�rdoba'),
('Corrientes'),
('Entre R�os'),
('Formosa'),
('Jujuy'),
('La Pampa'),
('La Rioja'),
('Mendoza'),
('Misiones'),
('Neuqu�n'),
('R�o Negro'),
('Salta'),
('San Juan'),
('San Luis'),
('Santa Cruz'),
('Santa Fe'),
('Santiago del Estero'),
('Tierra del Fuego'),
('Tucum�n');

/* Inserto 50 ciudades de Argentina con su ID_provincia*/
INSERT INTO dbo.Ciudad (ID_Provincia, Nombre)
VALUES
    (1, 'Buenos Aires'),
    (1, 'La Plata'),
    (5, 'C�rdoba'),
    (5, 'Villa Mar�a'),
    (20, 'Rosario'),
    (20, 'Santa Fe'),
    (12, 'Mendoza'),
    (12, 'San Rafael'),
    (2, 'Tucum�n'),
    (2, 'San Miguel de Tucum�n'),
    (16, 'Salta'),
    (16, 'San Salvador de Jujuy'),
    (15, 'Bariloche'),
    (15, 'San Carlos de Bariloche'),
    (8, 'Mar del Plata'),
    (8, 'Miramar'),
    (10, 'Santa Rosa'),
    (10, 'General Pico'),
    (3, 'Corrientes'),
    (3, 'Goya'),
    (13, 'Posadas'),
    (13, 'Ober�'),
    (17, 'San Juan'),
    (17, 'Rawson'),
    (14, 'Neuqu�n'),
    (14, 'Cutral-C�'),
    (11, 'La Rioja'),
    (11, 'Chamical'),
    (18, 'San Luis'),
    (18, 'Villa Mercedes'),
    (6, 'Catamarca'),
    (6, 'San Fernando del Valle de Catamarca'),
    (8, 'Formosa'),
    (8, 'Formosa'),
    (9, 'La Quiaca'),
    (9, 'Abra Pampa'),
    (19, 'Ushuaia'),
    (19, 'R�o Grande'),
    (20, 'Rawson'),
    (20, 'Trelew'),
    (21, 'Viedma'),
    (21, 'San Antonio Oeste'),
    (12, 'San Carlos de Bol�var'),
    (12, 'Pehuaj�');


/* Inserto 20 Clientes entre personas y empresas*/
INSERT INTO dbo.Clientes (Codigo_de_cliente, Nombre, Apellido, DNI, Razon_Social, CUIT, Telefono, Email, ID_Ciudad, ID_Provincia, Domicilio)
VALUES
    ('CLI001', 'Juan', 'P�rez', 12345678, NULL, NULL, '555-123-456', 'juan@email.com', 1, 1, 'Direcci�n1'),
    ('CLI002', 'Ana', 'L�pez', 87654321, NULL, NULL, '555-987-654', 'ana@email.com', 2, 2, 'Direcci�n2'),
    ('CLI003', 'Carlos', 'G�mez', 98765432, NULL, NULL, '555-345-678', 'carlos@email.com', 3, 3, 'Direcci�n3'),
    ('CLI004', 'Mar�a', 'Mart�nez', 23456789, NULL, NULL, '555-234-567', 'maria@email.com', 4, 4, 'Direcci�n4'),
    ('CLI005', 'Luis', 'Torres', 34567890, NULL, NULL, '555-789-012', 'luis@email.com', 5, 5, 'Direcci�n5'),
    ('CLI006', NULL, NULL, NULL, 'Empresa A', 'NULL', '555-123-456', 'empresaA@email.com', 1, 1, 'Direcci�n1'),
    ('CLI007', NULL, NULL, NULL, 'Empresa B', '30-87654321-8', '555-987-654', 'empresaB@email.com', 2, 2, 'Direcci�n2'),
    ('CLI008', NULL, NULL, NULL, 'Empresa C', '30-98765432-6', '555-345-678', 'empresaC@email.com', 3, 3, 'Direcci�n3'),
    ('CLI009', NULL, NULL, NULL, 'Empresa D', '30-23456789-1', '555-234-567', 'empresaD@email.com', 4, 4, 'Direcci�n4'),
    ('CLI010', NULL, NULL, NULL, 'Empresa E', '30-34567890-3', '555-789-012', 'empresaE@email.com', 5, 5, 'Direcci�n5'),
    ('CLI011', NULL, NULL, NULL, 'Cliente X', '30-12345678-4', '555-123-456', 'clienteX@email.com', 1, 1, 'Direcci�n1'),
    ('CLI012', NULL, NULL, NULL, 'Cliente Y', '30-87654321-8', '555-987-654', 'clienteY@email.com', 2, 2, 'Direcci�n2'),
    ('CLI013', NULL, NULL, NULL, 'Cliente Z', '30-98765432-6', '555-345-678', 'clienteZ@email.com', 3, 3, 'Direcci�n3'),
    ('CLI014', NULL, NULL, NULL, 'Cliente W', '30-23456789-1', '555-234-567', 'clienteW@email.com', 4, 4, 'Direcci�n4'),
    ('CLI015', NULL, NULL, NULL, 'Cliente V', '30-34567890-3', '555-789-012', 'clienteV@email.com', 5, 5, 'Direcci�n5'),
    ('CLI016', 'Pedro', 'Garc�a', 34567812, NULL, NULL, '555-123-987', 'pedro@email.com', 1, 1, 'Direcci�n1'),
    ('CLI017', 'Marta', 'Fern�ndez', 65432109, NULL, NULL, '555-987-123', 'marta@email.com', 2, 2, 'Direcci�n2'),
    ('CLI018', 'Roberto', 'S�nchez', 23456780, NULL, NULL, '555-789-345', 'roberto@email.com', 3, 3, 'Direcci�n3'),
    ('CLI019', 'Laura', 'G�mez', 98765421, NULL, NULL, '555-345-678', 'laura2@email.com', 4, 4, 'Direcci�n4'),
	('CLI020', 'Stefan', 'Gomez', 87654321, NULL, NULL, '555-876-543', 'nuevo_cliente@email.com', 2, 2, 'Otra Direcci�n');


/* INSERTO 18 VIAJES */
INSERT INTO dbo.Viaje_Envio (Codigo_de_viaje, ID_Cliente, ID_Chofer, ID_Provincia_Origen, ID_Ciudad_Origen, Direcci�n_Origen, ID_Provincia_Destino, ID_Ciudad_Destino, Direcci�n_Destino, Cantidad_de_km_recorridos, Fecha_Salida_Estimada, Fecha_Salida_Real, Fecha_Llegada_Estimada, Fecha_Llegada_Real)
VALUES
    ('VIAJE001', 1, 1, 1, 1, 'Direcci�n Origen 1', 1, 2, 'Direcci�n Destino 1', 500.5, '2023-10-31', '2023-10-31', '2023-11-05', '2023-11-05'),
    ('VIAJE002', 2, 2, 2, 3, 'Direcci�n Origen 2', 2, 4, 'Direcci�n Destino 2', 600.0, '2023-11-01', '2023-04-01', '2023-11-06', '2023-11-06'),
    ('VIAJE003', 3, 3, 3, 5, 'Direcci�n Origen 3', 3, 6, 'Direcci�n Destino 3', 700.2, '2023-11-02', '2023-11-02', '2023-11-07', '2023-11-07'),
    ('VIAJE004', 4, 4, 4, 7, 'Direcci�n Origen 4', 4, 8, 'Direcci�n Destino 4', 800.7, '2023-11-03', '2023-11-03', '2023-11-08', '2023-11-08'),
    ('VIAJE005', 5, 5, 5, 9, 'Direcci�n Origen 5', 5, 10, 'Direcci�n Destino 5', 900.0, '2023-11-04', '2023-03-04', '2023-11-09', '2023-11-09'),
    ('VIAJE006', 6, 6, 1, 11, 'Direcci�n Origen 6', 2, 12, 'Direcci�n Destino 6', 600.0, '2023-11-05', '2023-11-05', '2023-11-10', '2023-11-10'),
    ('VIAJE007', 7, 7, 2, 13, 'Direcci�n Origen 7', 3, 14, 'Direcci�n Destino 7', 700.5, '2023-11-06', '2023-11-06', '2023-11-11', '2023-11-11'),
    ('VIAJE008', 8, 8, 3, 15, 'Direcci�n Origen 8', 4, 16, 'Direcci�n Destino 8', 800.2, '2023-11-07', '2023-11-07', '2023-11-12', '2023-11-12'),
    ('VIAJE009', 9, 9, 4, 17, 'Direcci�n Origen 9', 5, 18, 'Direcci�n Destino 9', 900.8, '2023-11-08', '2023-11-08', '2023-11-13', '2023-11-13'),
	('VIAJE010', 10, 2, 2, 1, 'Direcci�n Origen 10', 2, 3, 'Direcci�n Destino 10', 550.0, '2023-11-09', '2023-11-09', '2023-11-14', '2023-11-14'),
    ('VIAJE011', 11, 3, 3, 2, 'Direcci�n Origen 11', 3, 4, 'Direcci�n Destino 11', 620.0, '2023-11-10', '2023-11-10', '2023-11-15', '2023-11-15'),
    ('VIAJE012', 12, 4, 4, 3, 'Direcci�n Origen 12', 20, 5, 'Direcci�n Destino 12', 720.2, '2023-11-11', '2023-11-11', '2023-11-16', '2023-11-16'),
    ('VIAJE013', 13, 5, 5, 4, 'Direcci�n Origen 13', 5, 6, 'Direcci�n Destino 13', 820.7, '2023-11-12', '2023-11-12', '2023-11-17', '2023-11-17'),
    ('VIAJE014', 14, 6, 1, 5, 'Direcci�n Origen 14', 2, 7, 'Direcci�n Destino 14', 920.0, '2023-11-13', '2023-11-13', '2023-11-18', '2023-11-18'),
    ('VIAJE015', 15, 7, 2, 6, 'Direcci�n Origen 15', 20, 8, 'Direcci�n Destino 15', 560.5, '2023-11-14', '2023-11-14', '2023-11-19', '2023-11-19'),
    ('VIAJE016', 16, 8, 3, 7, 'Direcci�n Origen 16', 4, 9, 'Direcci�n Destino 16', 840.2, '2023-11-15', '2023-11-15', '2023-11-20', '2023-11-20'),
    ('VIAJE017', 17, 9, 4, 8, 'Direcci�n Origen 17', 20, 10, 'Direcci�n Destino 17', 920.8, '2023-11-16', '2023-11-16', '2023-11-21', '2023-11-21'),
    ('VIAJE018', 19, 3, 5, 2, 'Direcci�n Origen 19', 1, 1, 'Direcci�n Destino 19', 550.0, '2023-11-17', '2023-11-17', '2023-11-22', '2023-11-22'),
	('VIAJE019', 20, 4, 2, 3, 'Direcci�n Origen 20', 2, 4, 'Direcci�n Destino 20', 670.0, '2023-11-18', '2023-11-18', '2023-11-23', '2023-11-23'),
    ('VIAJE020', 10, 1, 1, 2, 'Direcci�n Origen 10', 20, 3, 'Direcci�n Destino 10', 610.0, '2023-11-19', '2023-11-19', '2023-11-24', '2023-11-24');