USE [SpeedyGonzalesSRL]


CREATE TABLE dbo.Provincia (
    ID_Provincia int NOT NULL IDENTITY(1, 1) PRIMARY KEY,
    Nombre varchar(50)
);


CREATE TABLE dbo.Ciudad(
	ID_Ciudad int NOT NULL IDENTITY(1, 1) PRIMARY KEY,
	ID_Provincia int NOT NULL,
	Nombre varchar(50),
	CONSTRAINT FK_Provincia FOREIGN KEY (ID_Provincia) REFERENCES dbo.Provincia (ID_Provincia)
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
	CONSTRAINT FK_Remolque FOREIGN KEY (ID_Remolque) REFERENCES dbo.Remolques (ID_Remolques)
);


CREATE TABLE dbo.Clientes(
	ID_Cliente int NOT NULL IDENTITY(1, 1) PRIMARY KEY,
	Codigo_de_cliente varchar(50)  NOT NULL,
	Nombre varchar(50),
	Apellido varchar(50),
	DNI int,
	Razon_Social varchar(50),
	CUIT varchar(50) NOT NULL,
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
	Nombre varchar(50) NOT NULL,
	Apellido varchar(50) NOT NULL,
	Razon_Social varchar(50) NOT NULL,
	DNI int NOT NULL,
	CUIT varchar(20) NOT NULL,
	ID_Direccion_Chofer varchar(50),
	Telefono varchar(20),
	Email varchar(50),
);

CREATE TABLE dbo.Viaje_Envio(
	ID_Viaje_Envio int NOT NULL IDENTITY(1, 1) PRIMARY KEY,
	Codigo_de_viaje varchar(50) NOT NULL,
	ID_Cliente int NOT NULL,
	ID_Camion int NOT NULL,
	ID_Chofer int NOT NULL,
	ID_Provincia_Origen int NOT NULL,
	ID_Ciudad_Origen int NOT NULL,
	Dirección_Origen varchar(50),
	ID_Provincia_Destino int NOT NULL,
	ID_Ciudad_Destino int NOT NULL,
	Dirección_Destino varchar(50),
	Cantidad_de_km_recorridos REAL NOT NULL,
	Fecha_Salida_Estimada DATE NOT NULL,
	Fecha_Salida_Real DATE NOT NULL,
	Fecha_Llegada_Estimada DATE NOT NULL,
	Fecha_Llegada_Real DATE NOT NULL,
    FOREIGN KEY (ID_Cliente) REFERENCES dbo.Clientes (ID_Cliente),
    FOREIGN KEY (ID_Camion) REFERENCES dbo.Camiones (ID_Camion),
 FOREIGN KEY (ID_Chofer) REFERENCES dbo.Chofer (ID_Chofer),
 FOREIGN KEY (ID_Provincia_Origen) REFERENCES dbo.Provincia (ID_Provincia),
 FOREIGN KEY (ID_Ciudad_Origen) REFERENCES dbo.Ciudad (ID_Ciudad),
 FOREIGN KEY (ID_Provincia_Destino) REFERENCES dbo.Provincia (ID_Provincia),
 FOREIGN KEY (ID_Ciudad_Destino) REFERENCES dbo.Ciudad (ID_Ciudad),
);

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

