CREATE OR ALTER PROCEDURE ObtenerPatenteCamionAsignado 
	@DNI_Chofer INT, 
	@MensajeResultado VARCHAR(100) OUTPUT,
	@FechaConsulta DATE,
    @PatenteCamion VARCHAR(20) OUTPUT
AS
BEGIN
IF EXISTS (SELECT 1 FROM Chofer WHERE DNI = @DNI_Chofer)
BEGIN
	SET @MensajeResultado = 'El chofer Existe'
	PRINT @MensajeResultado
	
	IF EXISTS (	SELECT 1 FROM Chofer c
				JOIN Asignacion_Camion_Chofer asig ON c.ID_Chofer = asig.ID_Chofer
				JOIN Camion cam ON asig.ID_Camion = cam.ID_Camion
				WHERE @FechaConsulta BETWEEN asig.Fecha_Inicio AND ISNULL(asig.Fecha_Fin, GETDATE()))
	BEGIN
		SET @MensajeResultado = 'El chofer tiene un camión asignado en la fecha dada.'
		PRINT @MensajeResultado
		
		SET @PatenteCamion = (SELECT TOP 1 cam.Patente
								FROM Chofer c
								JOIN Asignacion_Camion_Chofer asig ON c.ID_Chofer = asig.ID_Chofer
								JOIN Camion cam ON asig.ID_Camion = cam.ID_Camion
								WHERE @FechaConsulta BETWEEN asig.Fecha_Inicio AND ISNULL(asig.Fecha_Fin, GETDATE()))
		PRINT 'Patente del camión asignado: ' + @PatenteCamion;

		END
		
		ELSE
		BEGIN
			SET @MensajeResultado = 'El chofer no tiene un camión asignado en la fecha dada.'
			PRINT @MensajeResultado;
		END
	END
	ELSE
	BEGIN
		SET @MensajeResultado = 'El chofer no existe.'
		PRINT @MensajeResultado;
	END
END

EXEC ObtenerPatenteCamionAsignado
  @DNI_Chofer = 340790328,
  @FechaConsulta = '2023-04-11',
  @MensajeResultado = 'Andaaaaa!',
  @PatenteCamion = ''

