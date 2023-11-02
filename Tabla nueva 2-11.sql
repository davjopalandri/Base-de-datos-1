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