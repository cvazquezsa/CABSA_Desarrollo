

/**************** spCalcInvSeguridad ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCalcInvSeguridad') and type = 'P') drop procedure dbo.spCalcInvSeguridad
GO
CREATE PROCEDURE spCalcInvSeguridad
		   @Empresa	 char(5),
                   @Dias	 int,
                   @Factor	 float
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Desde	  datetime,
    @Hasta	  datetime,
    @Almacen	  char(10),
    @Articulo	  char(20),
    @SubCuenta	  varchar(50),
    @VentaNeta	  float,
    @Minimo	  float,
    @Ok		  int,
    @OkRef	  varchar(255)

  SELECT @Ok = NULL, @OkRef = NULL, @Hasta = GETDATE()
  EXEC spExtraerFecha @Hasta OUTPUT
  SELECT @Desde = DATEADD(day, -@Dias, @Hasta)

  BEGIN TRANSACTION
    UPDATE ArtAlm SET Minimo = NULL WHERE Empresa = @Empresa
    DECLARE crVentas CURSOR FOR     
     SELECT NULLIF(RTRIM(d.Almacen), ''), NULLIF(RTRIM(d.Articulo), ''), ISNULL(RTRIM(d.SubCuenta), ''), SUM(d.Cantidad*d.Factor*mt.Factor)
       FROM Venta e, VentaD d, MovTipo mt
      WHERE e.Empresa = @Empresa AND e.Estatus = 'CONCLUIDO' AND e.ID = d.ID AND mt.Modulo = 'VTAS' AND mt.Mov = e.Mov AND mt.Clave IN ('VTAS.F','VTAS.FAR', 'VTAS.FC', 'VTAS.FG', 'VTAS.FX', 'VTAS.D', 'VTAS.DFC') AND e.FechaEmision BETWEEN @Desde AND @Hasta
      GROUP BY d.Almacen, d.Articulo, d.SubCuenta
    OPEN crVentas
    FETCH NEXT FROM crVentas INTO @Almacen, @Articulo, @SubCuenta, @VentaNeta
    WHILE @@fetch_status <> -1 AND @Ok IS NULL AND @Almacen IS NOT NULL AND @Articulo IS NOT NULL
    BEGIN
      IF @@fetch_status <> -2 AND @Ok IS NULL
      BEGIN
        SELECT @Minimo = ROUND(((@VentaNeta/@Dias)*(365/12))*@Factor, 0)

        UPDATE ArtAlm
           SET Minimo = @Minimo
         WHERE Empresa = @Empresa
           AND Almacen = @Almacen
           AND Articulo = @Articulo
           AND SubCuenta = @SubCuenta
        IF @@ROWCOUNT = 0
          INSERT ArtAlm (Empresa, Almacen, Articulo, SubCuenta, Minimo) VALUES (@Empresa, @Almacen, @Articulo, @SubCuenta, @Minimo)  
      END
      FETCH NEXT FROM crVentas INTO @Almacen, @Articulo, @SubCuenta, @VentaNeta
    END
    CLOSE crVentas
    DEALLOCATE crVentas

  IF @Ok IS NULL
    COMMIT TRANSACTION
  ELSE
    ROLLBACK TRANSACTION

  IF @Ok IS NULL  
  BEGIN
    SELECT @OkRef = "Proceso Concluido."
    SELECT @OkRef
  END ELSE
  BEGIN
    SELECT Descripcion+' '+RTRIM(@OkRef) 
      FROM MensajeLista
     WHERE Mensaje = @Ok  
  END
  RETURN
END
GO

-- spEvaluacionReferencia 'Look', 'CJ', '3/4/5'
/**************** spEvaluacionReferencia ****************/
if exists (select * from sysobjects where id = object_id('dbo.spEvaluacionReferencia') and type = 'P') drop procedure dbo.spEvaluacionReferencia
GO
CREATE PROCEDURE spEvaluacionReferencia
			@Referencia	varchar(50),
			@Contacto	varchar(20),
			@Fecha		datetime
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Calificacion	float,
    @Evaluacion		varchar(50),
    @Punto		varchar(100),
    @Respuesta		varchar(50)

  SELECT @Calificacion = Calificacion
    FROM EvaluacionCalificacion
   WHERE Evaluacion = @Referencia AND Contacto = @Contacto AND Fecha = @Fecha

  DECLARE crEvaluacionFormato CURSOR LOCAL FOR
   SELECT Evaluacion, Punto 
     FROM EvaluacionFormato
    WHERE Referencia = @Referencia
  OPEN crEvaluacionFormato
  FETCH NEXT FROM crEvaluacionFormato INTO @Evaluacion, @Punto
  WHILE @@fetch_status <> -1 
  BEGIN
    IF @@fetch_status <> -2 
    BEGIN
      EXEC spEvaluacionCto @Evaluacion, @Fecha, @Contacto
      SELECT @Respuesta = CONVERT(varchar, @Calificacion)
      UPDATE EvaluacionCto 
         SET Calificacion = @Calificacion, Respuesta = @Respuesta
       WHERE Evaluacion = @Evaluacion AND Fecha = @Fecha AND Punto = @Punto AND Contacto = @Contacto
      IF @@ROWCOUNT = 0
        INSERT EvaluacionCto (Evaluacion,  Fecha,  Punto,  Contacto,  Calificacion,  Respuesta) 
                      VALUES (@Evaluacion, @Fecha, @Punto, @Contacto, @Calificacion, @Respuesta)
      EXEC spEvaluacionReferencia @Evaluacion, @Contacto, @Fecha
    END
    FETCH NEXT FROM crEvaluacionFormato INTO @Evaluacion, @Punto
  END
  CLOSE crEvaluacionFormato
  DEALLOCATE crEvaluacionFormato

  RETURN
END
GO
