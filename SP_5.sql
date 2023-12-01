CREATE OR ALTER PROCEDURE ObtenerPatenteCamionAsignado 
	@DNI_Chofer INT, 
	@MensajeResultado NVARCHAR(100) OUTPUT,
	@FechaConsulta DATE,
    @PatenteCamion NVARCHAR(20) OUTPUT
AS
BEGIN
	IF EXISTS ( SELECT ID_Chofer FROM Chofer
				WHERE DNI = @DNI_Chofer)
		SET @MensajeResultado = 'Lo encontro'
		PRINT @MensajeResultado
	
	SELECT TOP 1 ca.Patente
    FROM Chofer c
	JOIN Viaje_Envio v ON c.ID_Chofer = v.ID_Chofer
    JOIN Camion ca ON v.ID_Camion = ca.ID_Camion
    WHERE   c.DNI = @DNI_Chofer
			AND ac.Fecha_Asignacion <= @FechaConsulta
            AND (ac.Fecha_Desasignacion IS NULL OR ac.Fecha_Desasignacion > @FechaConsulta)
            ORDER BY ac.Fecha_Asignacion DESC
	END
	ELSE
	 
        );

SET @MensajeResultado = 'No lo encontro'


EXEC ObtenerPatenteCamionAsignado
@DNI_Chofer = '340790328',
@MensajeResultado = 'hola'