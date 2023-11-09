select COUNT(*) AS Viajes_a_Provincia_StFe
from Viaje_Envio v
left join Ciudad c ON v.ID_Ciudad_Destino = c.ID_Ciudad
left join Provincia p ON c.ID_Provincia = p.ID_Provincia
WHERE P.Nombre = 'Santa Fe'; 

select * 
from Provincia

select *
from Camion

select *
from Marcas

select *
from Modelos

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
    v.Codigo_de_viaje AS Codigo_de_viaje,
    c.Nombre AS Cliente,
    ch.Nombre AS Chofer,
	ciud.Nombre AS Ciudad_de_Origen,
    v.Cantidad_de_km_recorridos AS Km_Recorridos,
    v.Fecha_Salida_Real AS Fecha_Salida,
	v.Fecha_Llegada_Real AS Fecha_Llegada
FROM Viaje_Envio v
LEFT JOIN Clientes c ON v.ID_Cliente = c.ID_Cliente
LEFT JOIN Chofer ch ON v.ID_Chofer = ch.ID_Chofer
LEFT JOIN Ciudad ciud ON v.ID_Ciudad_Origen = ciud.ID_Ciudad
LEFT JOIN Provincia p ON ciud.ID_Provincia = p.ID_Provincia
WHERE v.Fecha_Salida_Real >= '2023-01-01' AND v.Fecha_Salida_Real <= '2023-06-30'
    AND p.Nombre = 'Córdoba';


--- Tercera Query---
SELECT TOP 3
    ch.Nombre AS Nombre_Chofer,
    SUM(v.Cantidad_de_km_recorridos) AS Total_Kilometros_Recorridos
FROM dbo.Chofer ch
LEFT JOIN Viaje_Envio v ON ch.ID_Chofer = v.ID_Chofer
WHERE YEAR(v.Fecha_Salida_Real) = 2023
GROUP BY ch.Nombre
ORDER BY Total_Kilometros_Recorridos DESC;


---Cuarta Query---
SELECT ISNULL(c.Nombre, c.Razon_Social) AS Cliente, 
		ch.Nombre AS Nombre_Chofer,
		ve.Cantidad_de_km_recorridos AS Km_Recorridos
FROM Clientes c
LEFT JOIN Viaje_Envio ve ON c.ID_Cliente = ve.ID_Cliente
LEFT JOIN Chofer ch ON ch.ID_chofer = ve.ID_Chofer
WHERE YEAR(ve.Fecha_Salida_Real) = 2023
GROUP BY ISNULL(c.Nombre, c.Razon_Social), ch.Nombre, ve.Cantidad_de_km_recorridos
ORDER BY Km_Recorridos DESC;



