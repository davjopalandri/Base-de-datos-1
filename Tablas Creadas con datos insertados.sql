-- 2. Escriba las instrucciones SQL para la creaci�n de las tablas correspondientes al
-- diagrama anterior.

CREATE DATABASE SpeedyGonzalesSRL;

USE SpeedyGonzalesSRL;

CREATE TABLE Provincia (
	ID_Provincia tinyint NOT NULL IDENTITY PRIMARY KEY,
	Nombre varchar(50)
);

CREATE TABLE Ciudad (
	ID_Ciudad int NOT NULL IDENTITY PRIMARY KEY,
	ID_Provincia tinyint NOT NULL,
	Nombre varchar(50),
	FOREIGN KEY (ID_Provincia) REFERENCES Provincia (ID_Provincia)
);

CREATE TABLE Remolque (
	ID_Remolque tinyint NOT NULL IDENTITY PRIMARY KEY,
	Tipo_de_remolque varchar(50) NOT NULL,
);

CREATE TABLE dbo.Marcas(
	ID_Marca int NOT NULL IDENTITY PRIMARY KEY,
	Nombre_Marca varchar(50),
);

CREATE TABLE dbo.Modelos(
	ID_Modelos int NOT NULL IDENTITY PRIMARY KEY,
	Nombre_Modelos varchar(50),
	ID_Marca int NOT NULL,
	FOREIGN KEY (ID_Marca) REFERENCES Marcas (ID_Marca)
);

CREATE TABLE Camion (
	ID_Camion int NOT NULL IDENTITY PRIMARY KEY,
	Patente varchar(30),
	Marca varchar(40),
	ID_Modelo int NOT NULL,
	Anio YEAR,
	ID_Remolque tinyint NOT NULL,
	FOREIGN KEY (ID_Remolque) REFERENCES Remolque (ID_Remolque),
	FOREIGN KEY (ID_Modelo) REFERENCES dbo.Modelos (ID_Modelos)
);

CREATE TABLE Cliente (
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

CREATE TABLE Chofer (
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
  FOREIGN KEY (ID_Camion) REFERENCES Camiones (ID_Camion),
);

CREATE TABLE Viaje_Envio(
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
INSERT INTO dbo.Remolques (Tipo_de_remolque)
VALUES
	('Remolque de enganche'),
	('Remolque Eje central'),
	('Remolque Semiremolque');

/* Inserto datos para 6 Camiones*/
INSERT INTO dbo.Camiones (Patente, Marca, Modelo, Anio, ID_Remolque)
VALUES
    ('ABC123', 'Marca1', 2020, '2020-01-01', 1),
    ('DEF456', 'Marca2', 2019, '2019-02-15', 2),
    ('GHI789', 'Marca3', 2018, '2018-05-10', 3);


/* Inserto datos para 10 choferes */
INSERT INTO dbo.Chofer (ID_Camion, Nombre, Apellido, Razon_Social, DNI, CUIT, Domicilio, Telefono, Email)
VALUES
    (1, 'Juan', 'P�rez', 'Transportes P�rez SRL', 12345678, '20-12345678-4', 'Direcci�n1', '555-123-456', 'juan@email.com'),
    (2, 'Ana', 'L�pez', 'Transportes L�pez SA', 87654321, '27-87654321-8', 'Direcci�n2', '555-987-654', 'ana@email.com');



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
    (20, 'Santa Fe');


/* Inserto 20 Clientes entre personas y empresas*/
INSERT INTO dbo.Clientes (Nombre, Apellido, DNI, Razon_Social, CUIT, Telefono, Email, ID_Ciudad, Domicilio)
VALUES
    ('Juan', 'P�rez', 12345678, NULL, NULL, '555-123-456', 'juan@email.com', 1, 'Direcci�n1'),
    ('Ana', 'L�pez', 87654321, NULL, NULL, '555-987-654', 'ana@email.com', 2, 'Direcci�n2'),
    ('Carlos', 'G�mez', 98765432, NULL, NULL, '555-345-678', 'carlos@email.com', 3, 'Direcci�n3');


/* INSERTO 18 VIAJES */
INSERT INTO dbo.Viaje_Envio (ID_Cliente, ID_Chofer, ID_Ciudad_Origen, Direcci�n_Origen, ID_Ciudad_Destino, Direcci�n_Destino, Cantidad_de_km_recorridos, Fecha_Salida_Estimada, Fecha_Salida_Real, Fecha_Llegada_Estimada, Fecha_Llegada_Real)
VALUES
    (1, 1, 1, 'Direcci�n Origen 1', 2, 'Direcci�n Destino 1', 500.5, '2023-10-31', '2023-10-31', '2023-11-05', '2023-11-05'),
    (2, 2, 3, 'Direcci�n Origen 2', 4, 'Direcci�n Destino 2', 600.0, '2023-11-01', '2023-04-01', '2023-11-06', '2023-11-06'),
    (3, 2, 5, 'Direcci�n Origen 3', 6, 'Direcci�n Destino 3', 700.2, '2023-11-02', '2023-11-02', '2023-11-07', '2023-11-07');