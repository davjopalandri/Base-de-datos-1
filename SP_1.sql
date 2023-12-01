-- 5) Crear el Stored Procedure llamado " ObtenerPatenteCamionAsignado"

CREATE PROCEDURE ObtenerPatenteCamionAsignado
    @DNI_Chofer INT,
    @FechaConsulta DATE,
    @MensajeResultado NVARCHAR(100) OUTPUT,
    @PatenteCamion NVARCHAR(20) OUTPUT
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM Chofer c
        INNER JOIN Viaje_Envio v ON ch.ID_Chofer = v.ID_Chofer
        WHERE ch.DNI = @DNI_Chofer
            AND v.Fecha_Asignacion <= @FechaConsulta
            AND (v.Fecha_Desasignacion IS NULL OR ac.Fecha_Desasignacion > @FechaConsulta)
    )
    BEGIN
        SET @Encontrado = 1;
        SET @PatenteCamion = (
            SELECT TOP 1 cv.Patente_Camion
            FROM Chofer c
            INNER JOIN Asignacion_Camion ac ON c.ID_Chofer = ac.ID_Chofer
            WHERE c.DNI = @DNI_Chofer
                AND ac.Fecha_Asignacion <= @FechaConsulta
                AND (ac.Fecha_Desasignacion IS NULL OR ac.Fecha_Desasignacion > @FechaConsulta)
            ORDER BY ac.Fecha_Asignacion DESC
        );

        SET @MensajeResultado = 'El chofer tiene un camión asignado en la fecha dada.';
    END
    ELSE
    BEGIN
        SET @MensajeResultado = 'No se encontró al chofer o no tiene un camión asignado en la fecha dada.';
    END

    -- Devolver resultados
    SELECT @Encontrado AS 'Encontrado';
END;

--Puedes ejecutar este procedimiento almacenado de la siguiente manera:
DECLARE @Mensaje NVARCHAR(100);
DECLARE @Patente NVARCHAR(20);

EXEC ObtenerPatenteCamionAsignado
    @DNI_Chofer = 12345678, -- Reemplaza con el DNI del chofer que deseas consultar
    @FechaConsulta = '2023-11-01', -- Reemplaza con la fecha de consulta
    @MensajeResultado = @Mensaje OUTPUT,
    @PatenteCamion = @Patente OUTPUT;

PRINT @Mensaje;
PRINT 'Patente del camión: ' + ISNULL(@Patente, 'No asignado');


