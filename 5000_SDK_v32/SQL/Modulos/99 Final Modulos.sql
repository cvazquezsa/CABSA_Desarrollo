
/****** MovBitacora ******/
if exists (select * from sysobjects where id = object_id('dbo.tgMovBitacoraA') and sysstat & 0xf = 8) drop trigger dbo.tgMovBitacoraA
GO
CREATE TRIGGER tgMovBitacoraA ON MovBitacora
--//WITH ENCRYPTION
FOR INSERT
AS BEGIN
  DECLARE
   @Modulo		char(5),
   @ID			int,
   @RID			int,
   @Estatus		varchar(15),
   @Situacion		varchar(50),
   @SituacionFecha	datetime,
   @SituacionUsuario	varchar(10),
   @SituacionNota	varchar(100)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @Modulo = Modulo, @ID = ID, @RID = RID FROM Inserted
  EXEC spMovInfo @ID, @Modulo, @Estatus = @Estatus OUTPUT, @Situacion = @Situacion OUTPUT, @SituacionFecha = @SituacionFecha OUTPUT, @SituacionUsuario = @SituacionUsuario OUTPUT, @SituacionNota = @SituacionNota OUTPUT
  UPDATE MovBitacora 
     SET MovEstatus = @Estatus,
         MovSituacion = @Situacion,
         MovSituacionFecha = @SituacionFecha,
         MovSituacionUsuario = @SituacionUsuario,
         MovSituacionNota = @SituacionNota
   WHERE Modulo = @Modulo AND ID = @ID AND RID = @RID
END
GO

