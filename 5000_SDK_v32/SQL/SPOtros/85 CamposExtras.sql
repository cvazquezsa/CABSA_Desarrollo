-- spCamposExtrasContacto 'Cliente', 'Cliente', 'MEX'
/****** spCamposExtrasContacto *****/
if exists (select * from sysobjects where id = object_id('dbo.spCamposExtrasContacto') and type = 'P') drop procedure dbo.spCamposExtrasContacto
GO
CREATE PROCEDURE spCamposExtrasContacto
			@Tipo		varchar(20),
			@SubTipo	varchar(20),
			@Clave		char(10)
--//WITH ENCRYPTION
AS BEGIN
  SELECT ct.CampoExtra, ce.Nombre, ce.AyudaTipo, ce.AyudaReferencia, ce.AyudaExpresion, ce.ValidacionTipo, ce.ValidacionReferencia, ce.ValidacionTabla, ce.ValidacionCampo, ce.ValidacionExpresion, ce.Mascara, ct.Grupo, ct.Requerido, c.Valor
    FROM CtoTipoCampoExtra ct
    JOIN CampoExtra ce ON ce.CampoExtra = ct.CampoExtra
    LEFT OUTER JOIN CtoCampoExtra c ON c.Tipo = ct.Tipo AND c.SubTipo = ct.SubTipo AND c.CampoExtra = ct.CampoExtra AND c.Clave = @Clave
   WHERE ct.Tipo = @Tipo AND ct.SubTipo = @SubTipo
   ORDER BY ct.Orden

  RETURN
END
GO

/****** spCamposExtrasMovCto *****/
if exists (select * from sysobjects where id = object_id('dbo.spCamposExtrasMovCto') and type = 'P') drop procedure dbo.spCamposExtrasMovCto
GO
CREATE PROCEDURE spCamposExtrasMovCto
			@Modulo		char(5),
			@Mov		char(20),
			@ID		int,
			@Tipo		varchar(20)	OUTPUT,
			@SubTipo	varchar(20)	OUTPUT,
			@Clave		char(10)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  /*SELECT @Tipo = CtoTipo, @Clave = Contacto
    FROM dbo.fnMovReg(@Modulo, @ID)*/
  EXEC spMovInfo @ID, @Modulo, @CtoTipo = @Tipo OUTPUT, @Contacto = @Clave OUTPUT

  IF @Tipo = 'Cliente' SELECT @SubTipo = Tipo FROM Cte WHERE Cliente = @Clave ELSE
  IF @Tipo = 'Proveedor' SELECT @SubTipo = Tipo FROM Prov WHERE Proveedor = @Clave ELSE
  IF @Tipo = 'Agente' SELECT @SubTipo = Tipo FROM Agente WHERE Agente = @Clave
  RETURN
END
GO


-- spCamposExtrasMovimiento 'VTAS', 'Cotizacion', 1
/****** spCamposExtrasMovimiento *****/
if exists (select * from sysobjects where id = object_id('dbo.spCamposExtrasMovimiento') and type = 'P') drop procedure dbo.spCamposExtrasMovimiento
GO
CREATE PROCEDURE spCamposExtrasMovimiento
			@Modulo	char(5),
			@Mov	char(20),
			@ID	int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Tipo	varchar(20),
    @SubTipo	varchar(20),
    @Clave	char(10)

  IF NOT EXISTS(SELECT * FROM MovCampoExtra WHERE Modulo = @Modulo AND Mov = @Mov AND ID = @ID)
  BEGIN
    EXEC spCamposExtrasMovCto @Modulo, @Mov, @ID, @Tipo OUTPUT, @SubTipo OUTPUT, @Clave OUTPUT
    INSERT MovCampoExtra (Modulo, Mov, ID, CampoExtra, Valor, Puntos)
    SELECT @Modulo, @Mov, @ID, c.CampoExtra, c.Valor, c.Puntos
      FROM CtoCampoExtra c
      JOIN MovTipoCampoExtra mt ON mt.Modulo = @Modulo AND mt.Mov = @Mov AND mt.CampoExtra = c.CampoExtra
     WHERE c.Tipo = @Tipo AND c.SubTipo = @SubTipo AND c.Clave = @Clave AND NULLIF(RTRIM(c.Valor), '') IS NOT NULL
  END
  SELECT mt.CampoExtra, ce.Nombre, ce.AyudaTipo, ce.AyudaReferencia, ce.AyudaExpresion, ce.ValidacionTipo, ce.ValidacionReferencia, ce.ValidacionTabla, ce.ValidacionCampo, ce.ValidacionExpresion, ce.Mascara, mt.Grupo, mt.Requerido, m.Valor
    FROM MovTipoCampoExtra mt
    JOIN CampoExtra ce ON ce.CampoExtra = mt.CampoExtra
    LEFT OUTER JOIN MovCampoExtra m ON m.Modulo = mt.Modulo AND m.Mov = mt.Mov AND m.CampoExtra = mt.CampoExtra AND m.ID = @ID
   WHERE mt.Modulo = @Modulo AND mt.Mov = @Mov
   ORDER BY mt.Orden
  RETURN
END
GO

/****** spCtoCampoExtra *****/
if exists (select * from sysobjects where id = object_id('dbo.spCtoCampoExtra') and type = 'P') drop procedure dbo.spCtoCampoExtra
GO
CREATE PROCEDURE spCtoCampoExtra
			@Tipo		varchar(20),
			@SubTipo	varchar(20),
			@Clave		varchar(20),
			@CampoExtra	varchar(50),
			@Valor		varchar(255),
			@ConPuntos	bit	= 0,
			@Puntos		float	= NULL
--//WITH ENCRYPTION
AS BEGIN

  IF @ConPuntos = 0
    SELECT @Puntos = Puntos FROM CampoExtraAyudaLista WHERE CampoExtra = @CampoExtra AND Opcion = @Valor

  UPDATE CtoCampoExtra
     SET Valor = @Valor, Puntos = @Puntos
   WHERE Tipo = @Tipo AND SubTipo = @SubTipo AND Clave = @Clave AND CampoExtra = @CampoExtra 
  IF @@ROWCOUNT = 0
    INSERT CtoCampoExtra (Tipo,  SubTipo,  Clave,  CampoExtra,  Valor, Puntos) 
                  VALUES (@Tipo, @SubTipo, @Clave, @CampoExtra, @Valor, @Puntos) 
  RETURN
END
GO

-- EXEC spMovCampoExtra 'VTAS', 'Cotizacion', 2, 'CteDireccion', 'Direccion 2'
/****** spMovCampoExtra *****/
if exists (select * from sysobjects where id = object_id('dbo.spMovCampoExtra') and type = 'P') drop procedure dbo.spMovCampoExtra
GO
CREATE PROCEDURE spMovCampoExtra
			@Modulo		char(5),
			@Mov		char(20),
			@ID		int,
			@CampoExtra	varchar(50),
			@Valor		varchar(255)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Puntos	float

  SELECT @Puntos = Puntos FROM CampoExtraAyudaLista WHERE CampoExtra = @CampoExtra AND Opcion = @Valor

  UPDATE MovCampoExtra
     SET Valor = @Valor, Puntos = @Puntos
   WHERE Modulo = @Modulo AND Mov = @Mov AND ID = @ID AND CampoExtra = @CampoExtra 
  IF @@ROWCOUNT = 0
    INSERT MovCampoExtra (Modulo,  Mov,  ID,  CampoExtra,  Valor,  Puntos) 
                  VALUES (@Modulo, @Mov, @ID, @CampoExtra, @Valor, @Puntos) 
  RETURN
END
GO


/****** spMovCampoExtraAfectarContacto *****/
if exists (select * from sysobjects where id = object_id('dbo.spMovCampoExtraAfectarContacto') and type = 'P') drop procedure dbo.spMovCampoExtraAfectarContacto
GO
CREATE PROCEDURE spMovCampoExtraAfectarContacto
			@Modulo		char(5),
			@Mov		char(20),
			@ID		int,
			@Estatus	varchar(15),
			@EstatusNuevo	varchar(15)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Tipo		varchar(20),
    @SubTipo		varchar(20),
    @Clave		char(10),
    @CampoExtra		varchar(50),
    @Valor		varchar(255),
    @ValorAnterior	varchar(255),
    @Puntos		float,
    @PuntosAnteriores	float

  IF EXISTS(SELECT * FROM MovTipo WHERE Modulo = @Modulo AND Mov = @Mov AND CE = 1 AND CEAfectarContacto = 1) 
  BEGIN
    EXEC spCamposExtrasMovCto @Modulo, @Mov, @ID, @Tipo OUTPUT, @SubTipo OUTPUT, @Clave OUTPUT

    DECLARE crMovCampoExtra CURSOR FOR 
     SELECT m.CampoExtra, m.Valor, m.ValorAnterior, m.Puntos, m.PuntosAnteriores
       FROM MovCampoExtra m
       JOIN CtoTipoCampoExtra ct ON ct.Tipo = @Tipo AND ct.SubTipo = @SubTipo AND ct.CampoExtra = m.CampoExtra
      WHERE m.Modulo = @Modulo AND m.Mov = @Mov AND m.ID = @ID
    OPEN crMovCampoExtra
    FETCH NEXT FROM crMovCampoExtra INTO @CampoExtra, @Valor, @ValorAnterior, @Puntos, @PuntosAnteriores
    WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        IF @EstatusNuevo <> 'CANCELADO'
        BEGIN
          SELECT @ValorAnterior = NULL, @PuntosAnteriores = NULL
          SELECT @ValorAnterior = Valor, @PuntosAnteriores = Puntos
            FROM CtoCampoExtra
           WHERE Tipo = @Tipo AND SubTipo = @SubTipo AND Clave = @Clave AND CampoExtra = @CampoExtra 

          UPDATE MovCampoExtra 
             SET ValorAnterior = @ValorAnterior, PuntosAnteriores = @PuntosAnteriores 
           WHERE CURRENT OF crMovCampoExtra
          EXEC spCtoCampoExtra @Tipo, @SubTipo, @Clave, @CampoExtra, @Valor, 1, @Puntos
        END ELSE
          EXEC spCtoCampoExtra @Tipo, @SubTipo, @Clave, @CampoExtra, @ValorAnterior, 1, @PuntosAnteriores
      END
      FETCH NEXT FROM crMovCampoExtra INTO @CampoExtra, @Valor, @ValorAnterior, @Puntos, @PuntosAnteriores
    END
    CLOSE crMovCampoExtra
    DEALLOCATE crMovCampoExtra
  END
  RETURN
END
GO

/****** spCamposExtrasMovFlujo *****/
if exists (select * from sysobjects where id = object_id('dbo.spCamposExtrasMovFlujo') and type = 'P') drop procedure dbo.spCamposExtrasMovFlujo
GO
CREATE PROCEDURE spCamposExtrasMovFlujo
			@OModulo	char(5),
			@OMov		char(20),
			@OID		int,
			@DModulo	char(5),
			@DMov		char(20),
			@DID		int
--//WITH ENCRYPTION
AS BEGIN
  IF (SELECT CE FROM MovTipo WHERE Modulo = @OModulo AND Mov = @OMov) = 1 AND
     (SELECT CE FROM MovTipo WHERE Modulo = @DModulo AND Mov = @DMov) = 1
  BEGIN
    IF NOT EXISTS(SELECT * FROM MovCampoExtra WHERE Modulo = @DModulo AND Mov = @DMov AND ID = @DID)
    BEGIN
      INSERT MovCampoExtra (Modulo, Mov, ID, CampoExtra, Valor)
      SELECT @DModulo, @DMov, @DID, m.CampoExtra, m.Valor
        FROM MovCampoExtra m
        JOIN MovTipoCampoExtra mt ON mt.Modulo = @DModulo AND mt.Mov = @DMov AND mt.CampoExtra = m.CampoExtra
       WHERE m.Modulo = @OModulo AND m.Mov = @OMov AND m.ID = @OID AND NULLIF(RTRIM(m.Valor), '') IS NOT NULL
    END
  END
  RETURN
END
GO

/*
create view VentaCampoExtra
as
select
  Venta.*, 
  "CteDireccion" = (SELECT Valor FROM MovCampoExtra WHERE Modulo='VTAS' AND Mov=m.Mov AND ID=m.ID AND CampoExtra='CteDireccion'),
  "CtePais"      = (SELECT Valor FROM MovCampoExtra WHERE Modulo='VTAS' AND Mov=m.Mov AND ID=m.ID AND CampoExtra='CtePais'),
  "CtePoblacion" = (SELECT Valor FROM MovCampoExtra WHERE Modulo='VTAS' AND Mov=m.Mov AND ID=m.ID AND CampoExtra='CtePoblacion')
from Venta m
*/

-- spMovCampoExtraCrearVista 'VTAS'
/****** spMovCampoExtraCrearVista *****/
if exists (select * from sysobjects where id = object_id('dbo.spMovCampoExtraCrearVista') and type = 'P') drop procedure dbo.spMovCampoExtraCrearVista
GO
CREATE PROCEDURE spMovCampoExtraCrearVista
			@Modulo	varchar(5)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @a		int,
    @c		varchar(5),
    @Tabla	varchar(50),
    @Vista	varchar(50),
    @CampoExtra	varchar(50),    
    @SELECT	varchar(8000)

  SELECT @Tabla = dbo.fnMovTabla(@Modulo)

  SELECT @a = 0, @Vista = 'dbo.'+@Tabla+'CampoExtra', @SELECT = ''
  DECLARE crMovTipoCampoExtra CURSOR FOR 
   SELECT DISTINCT CampoExtra
     FROM MovTipoCampoExtra
    WHERE Modulo = @Modulo
  OPEN crMovTipoCampoExtra
  FETCH NEXT FROM crMovTipoCampoExtra INTO @CampoExtra
  WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      SELECT @a = @a + 1
      SELECT @c = CONVERT(varchar, @a)
      SELECT @SELECT = @SELECT+', "'+@CampoExtra+'"=(SELECT Valor FROM MovCampoExtra ce WHERE ce.Modulo="'+@Modulo+'" AND ce.Mov=m.Mov AND ce.ID=m.ID AND ce.CampoExtra="'+@CampoExtra+'")'
    END
    FETCH NEXT FROM crMovTipoCampoExtra INTO @CampoExtra
  END
  CLOSE crMovTipoCampoExtra
  DEALLOCATE crMovTipoCampoExtra
  EXEC('if exists (select * from sysobjects where id = object_id("'+@Vista+'") and type = "V") drop view '+@Vista)
  EXEC('CREATE VIEW '+@Vista+' WITH ENCRYPTION AS SELECT m.*'+@SELECT+' FROM '+@Tabla+' m')
  RETURN
END
GO

/*
EXEC spCtoCampoExtraCrearVista 'Cliente'
EXEC spCtoCampoExtraCrearVista 'Proveedor'
EXEC spCtoCampoExtraCrearVista 'Agente'
EXEC spCtoCampoExtraCrearVista 'Personal'
EXEC spCtoCampoExtraCrearVista 'Almacen'
EXEC spCtoCampoExtraCrearVista 'Empresa'
*/
/****** spCtoCampoExtraCrearVista *****/
if exists (select * from sysobjects where id = object_id('dbo.spCtoCampoExtraCrearVista') and type = 'P') drop procedure dbo.spCtoCampoExtraCrearVista
GO
CREATE PROCEDURE spCtoCampoExtraCrearVista
			@Tipo	varchar(20)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @a		int,
    @c		varchar(5),
    @Tabla	varchar(50),
    @Vista	varchar(50),
    @CampoExtra	varchar(50),    
    @SELECT	varchar(8000)

  SELECT @Tabla = dbo.fnCtoTabla(@Tipo)

  SELECT @a = 0, @Vista = 'dbo.'+@Tabla+'CampoExtra', @SELECT = ''
  DECLARE crCtoTipoCampoExtra CURSOR FOR 
   SELECT DISTINCT CampoExtra
     FROM CtoTipoCampoExtra
    WHERE Tipo = @Tipo
  OPEN crCtoTipoCampoExtra
  FETCH NEXT FROM crCtoTipoCampoExtra INTO @CampoExtra
  WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      SELECT @a = @a + 1
      SELECT @c = CONVERT(varchar, @a)
      SELECT @SELECT = @SELECT+', "'+@CampoExtra+'"=(SELECT Valor FROM CtoCampoExtra ce WHERE ce.Tipo="'+@Tipo+'" AND ce.SubTipo=c.Tipo AND ce.Clave=c.'+@Tipo+' AND ce.CampoExtra="'+@CampoExtra+'")'
    END
    FETCH NEXT FROM crCtoTipoCampoExtra INTO @CampoExtra
  END
  CLOSE crCtoTipoCampoExtra
  DEALLOCATE crCtoTipoCampoExtra
  EXEC('if exists (select * from sysobjects where id = object_id("'+@Vista+'") and type = "V") drop view '+@Vista)
  EXEC('CREATE VIEW '+@Vista+' WITH ENCRYPTION AS SELECT c.*'+@SELECT+' FROM '+@Tabla+' c')
  RETURN
END
GO
