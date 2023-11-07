CREATE DATABASE SpeedyGonzalesSRL;

USE SpeedyGonzalesSRL;


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
	Año DATE,
	ID_Remolque int NOT NULL,
	FOREIGN KEY (ID_Remolque) REFERENCES dbo.Remolques (ID_Remolques)
);


CREATE TABLE dbo.Clientes(
	ID_Cliente int NOT NULL IDENTITY(1, 1) PRIMARY KEY,
	Codigo_de_viaje AS ('CLI' + RIGHT('000' + CAST(ID_Cliente AS VARCHAR(3)), 4)) PERSISTED,
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
	Codigo_de_viaje AS ('VIAJE' + RIGHT('000' + CAST(ID_Viaje_Envio AS VARCHAR(3)), 4)) PERSISTED,
	ID_Cliente int NOT NULL,
	ID_Chofer int NOT NULL,
	--ID_Provincia_Origen int NOT NULL,
	ID_Ciudad_Origen int NOT NULL,
	Dirección_Origen varchar(50),
	--ID_Provincia_Destino int NOT NULL,
	ID_Ciudad_Destino int NOT NULL,
	Dirección_Destino varchar(50),
	Cantidad_de_km_recorridos REAL NOT NULL,
	Fecha_Salida_Estimada DATE NOT NULL,
	Fecha_Salida_Real DATE NOT NULL,
	Fecha_Llegada_Estimada DATE NOT NULL,
	Fecha_Llegada_Real DATE NOT NULL,
 FOREIGN KEY (ID_Cliente) REFERENCES dbo.Clientes (ID_Cliente),
 FOREIGN KEY (ID_Chofer) REFERENCES dbo.Chofer (ID_Chofer),
 --FOREIGN KEY (ID_Provincia_Origen) REFERENCES dbo.Provincia (ID_Provincia),
 FOREIGN KEY (ID_Ciudad_Origen) REFERENCES dbo.Ciudad (ID_Ciudad),
 --FOREIGN KEY (ID_Provincia_Destino) REFERENCES dbo.Provincia (ID_Provincia),
 FOREIGN KEY (ID_Ciudad_Destino) REFERENCES dbo.Ciudad (ID_Ciudad),
);


/* Inserto tres remolques */
INSERT INTO dbo.Remolques (Tipo_de_remolque)
VALUES
    ('Remolque de enganche'),
    ('Remolque Eje central'),
    ('Remolque Semiremolque');

/* Inserto datos para 6 Camiones*/
INSERT INTO dbo.Camiones (Patente, Marca, Modelo, Año, ID_Remolque)
VALUES
    ('ABC123', 'Marca1', 2020, '2020-01-01', 1),
    ('DEF456', 'Marca2', 2019, '2019-02-15', 2),
    ('GHI789', 'Marca3', 2018, '2018-05-10', 3);


/* Inserto datos para 10 choferes */
INSERT INTO dbo.Chofer (ID_Camion, Nombre, Apellido, Razon_Social, DNI, CUIT, Domicilio, Telefono, Email)
VALUES
    (1, 'Juan', 'Pérez', 'Transportes Pérez SRL', 12345678, '20-12345678-4', 'Dirección1', '555-123-456', 'juan@email.com'),
    (2, 'Ana', 'López', 'Transportes López SA', 87654321, '27-87654321-8', 'Dirección2', '555-987-654', 'ana@email.com');



INSERT INTO Provincia (Nombre)
VALUES ('Buenos Aires'),
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

/* Inserto 50 ciudades de Argentina con su ID_provincia*/
INSERT INTO dbo.Ciudad (ID_Provincia, Nombre)
VALUES
    (1, 'Buenos Aires'),
    (1, 'La Plata'),
    (5, 'Córdoba'),
    (5, 'Villa María'),
    (20, 'Rosario'),
    (20, 'Santa Fe');


/* Inserto 20 Clientes entre personas y empresas*/
INSERT INTO dbo.Clientes (Nombre, Apellido, DNI, Razon_Social, CUIT, Telefono, Email, ID_Ciudad, Domicilio)
VALUES
    ('Juan', 'Pérez', 12345678, NULL, NULL, '555-123-456', 'juan@email.com', 1, 'Dirección1'),
    ('Ana', 'López', 87654321, NULL, NULL, '555-987-654', 'ana@email.com', 2, 'Dirección2'),
    ('Carlos', 'Gómez', 98765432, NULL, NULL, '555-345-678', 'carlos@email.com', 3, 'Dirección3');


/* INSERTO 18 VIAJES */
INSERT INTO dbo.Viaje_Envio (ID_Cliente, ID_Chofer, ID_Ciudad_Origen, Dirección_Origen, ID_Ciudad_Destino, Dirección_Destino, Cantidad_de_km_recorridos, Fecha_Salida_Estimada, Fecha_Salida_Real, Fecha_Llegada_Estimada, Fecha_Llegada_Real)
VALUES
    (1, 1, 1, 'Dirección Origen 1', 2, 'Dirección Destino 1', 500.5, '2023-10-31', '2023-10-31', '2023-11-05', '2023-11-05'),
    (2, 2, 3, 'Dirección Origen 2', 4, 'Dirección Destino 2', 600.0, '2023-11-01', '2023-04-01', '2023-11-06', '2023-11-06'),
    (3, 2, 5, 'Dirección Origen 3', 6, 'Dirección Destino 3', 700.2, '2023-11-02', '2023-11-02', '2023-11-07', '2023-11-07');