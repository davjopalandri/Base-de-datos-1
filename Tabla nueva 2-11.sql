select COUNT(*) 
from Viaje_Envio v
left join Provincia p ON v.ID_Provincia_Destino = p.ID_Provincia
WHERE P.Nombre = 'Santa Fe'; 

select * 
from Provincia

select *
from Camiones

select *
from Chofer

select *
from Ciudad

select *
from Clientes

select *
from Viaje_Envio

--- Segunda Query---
SELECT
    VE.Codigo_de_viaje AS Codigo_de_viaje,
    C.Nombre AS Cliente,
    CH.Nombre AS Chofer,
	CIUD.Nombre AS Ciudad_de_Origen,
    VE.Cantidad_de_km_recorridos AS Km_Recorridos,
    VE.Fecha_Salida_Real AS Fecha_Salida
FROM dbo.Viaje_Envio VE
LEFT JOIN dbo.Clientes C ON VE.ID_Cliente = C.ID_Cliente
LEFT JOIN dbo.Chofer CH ON VE.ID_Chofer = CH.ID_Chofer
LEFT JOIN dbo.Ciudad CIUD ON VE.ID_Ciudad_Origen = CIUD.ID_Ciudad
LEFT JOIN dbo.Provincia PROV ON VE.ID_Provincia_Origen = PROV.ID_Provincia
WHERE VE.Fecha_Salida_Real >= '2023-01-01' AND VE.Fecha_Salida_Real <= '2023-06-30'
    AND PROV.Nombre = 'Córdoba';


--- Tercera Query---
SELECT TOP 3
    CH.Nombre AS Nombre_Chofer,
    SUM(VE.Cantidad_de_km_recorridos) AS Total_Kilometros_Recorridos
FROM dbo.Chofer CH
LEFT JOIN dbo.Viaje_Envio VE ON CH.ID_Chofer = VE.ID_Chofer
WHERE YEAR(VE.Fecha_Salida_Real) = 2023
GROUP BY CH.Nombre
ORDER BY Total_Kilometros_Recorridos DESC;

---Cuarta Query---
SELECT DISTINCT
    C.Nombre AS Nombre_Cliente,
	C.Razon_Social AS Compania,
    CH.Nombre AS Nombre_Chofer,
    VE.Codigo_de_viaje AS Codigo_de_Viaje,
    VE.Cantidad_de_km_recorridos AS Km_Recorridos
FROM dbo.Clientes C
LEFT JOIN dbo.Viaje_Envio VE ON C.ID_Cliente = VE.ID_Cliente
LEFT JOIN dbo.Chofer CH ON VE.ID_Chofer = CH.ID_Chofer
WHERE YEAR(VE.Fecha_Salida_Real) = 2023
ORDER BY Km_Recorridos DESC;
