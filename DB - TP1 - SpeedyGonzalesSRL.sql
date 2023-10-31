CREATE DATABASE SpeedyGonzalesSRL;

USE SpeedyGonzalesSRL;

CREATE TABLE [dbo].[Chofer](
	[ID_Chofer] [int] NOT NULL IDENTITY,
	[Nombre] [varchar](50) NOT NULL,
	[Apellido] [varchar](50) NOT NULL,
	[Razon_Social] [varchar](50) NOT NULL,
	[DNI] [int] NOT NULL,
	[CUIT] [varchar](20) NOT NULL,
	[ID_Direccion_Chofer] [varchar](50) NULL,
	[Telefono] [varchar](20) NULL,
	[Email] [varchar](50) NULL,
 CONSTRAINT [PK_Chofer] PRIMARY KEY CLUSTERED 
(
	[ID_Chofer] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO;

-- DECLARACION Y CARGA DE TABLA PROVINCIA
CREATE TABLE [dbo].[Provincia](
	[ID_Provincia] [int] NOT NULL IDENTITY,
	[Nombre] [varchar](50)
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

-- TABLA CIUDAD
