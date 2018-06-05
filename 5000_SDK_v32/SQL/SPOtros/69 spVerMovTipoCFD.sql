SET ANSI_DEFAULTS OFF
GO
/************** spVerMovTipoCFD *************/
if exists (select * from sysobjects where id = object_id('dbo.spVerMovTipoCFD') and type = 'P') drop procedure dbo.spVerMovTipoCFD
GO
CREATE PROCEDURE spVerMovTipoCFD
               @Empresa     varchar(5),
               @Modulo  varchar(5),
               @Mov           varchar(20),
               @ID          int = NULL
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @CFD                     bit,
    @Timbrado                bit, 
    @VersionCFD              varchar(10),
    @UUID                    varchar(50),
    @SelloSAT                varchar(max),
    @TFDCadenaOriginal       varchar(max),
    @Sello                   varchar(max),
    @CFDI                    bit,
	@Estatus                 varchar(20)


  EXEC spMovInfo @ID = @ID OUTPUT, @Modulo = @Modulo, @Estatus = @Estatus OUTPUT

  SELECT @CFD = 0
  EXEC spMovTipoCFD @Empresa, @Modulo, @Mov, @CFD OUTPUT

  SELECT @CFDI = CFDI FROM EmpresaGral WHERE Empresa = @Empresa

  IF @CFD = 1 AND @Estatus <> 'CANCELADO'
  BEGIN

    IF EXISTS (SELECT * FROM CFD WHERE Modulo = @Modulo AND ModuloID = @ID)
    BEGIN
      SELECT @VersionCFD               = Substring(CadenaOriginal, 3, 3),
             @Timbrado                   = Timbrado,
             @UUID                             = UUID,
             @SelloSAT                   = SelloSAT,
             @TFDCadenaOriginal    = TFDCadenaOriginal,
             @Sello = Sello
        FROM CFD WHERE Modulo = @Modulo AND ModuloID = @ID

      IF NULLIF(@VersionCFD,'') IS NULL OR ISNUMERIC(@VersionCFD)= 0 
      SELECT @VersionCFD = Version FROM EmpresaCFD WHERE Empresa = @Empresa     
        
      IF @VersionCFD  >= '3.2' OR @CFDI = 1
      BEGIN
        IF @UUID IS NOT NULL OR @SelloSAT IS NOT NULL --OR @TFDCadenaOriginal IS NOT NULL
          SELECT @CFD = 0
      END
      ELSE IF NULLIF(@Sello,'') IS NOT NULL SELECT @CFD = 0
    END

    IF @VersionCFD  >= '3.2' OR @CFDI = 1
    BEGIN
      IF EXISTS (SELECT * FROM MovTipo mt 
                          JOIN MovFlujo mf ON mf.OModulo = mt.Modulo AND mf.OMov = mt.Mov
                          JOIN CFD cfd ON cfd.Modulo = mt.Modulo AND ModuloID = mf.OID AND (NULLIF(cfd.SelloSAT,'') IS NOT NULL OR cfd.Timbrado = 1 OR cfd.UUID IS NOT NULL)
                         WHERE mt.ConsecutivoModulo = @Modulo AND mt.ConsecutivoMov = @Mov AND mt.Modulo != @Modulo AND mt.Mov != @Mov
                           AND mf.DID = @ID AND mf.DModulo = @Modulo)
        SELECT @CFD = 0
    END ELSE 
    BEGIN 
      IF EXISTS (SELECT * FROM MovTipo mt 
                          JOIN MovFlujo mf ON mf.OModulo = mt.Modulo AND mf.OMov = mt.Mov
                          JOIN CFD cfd ON cfd.Modulo = mt.Modulo AND ModuloID = mf.OID AND NULLIF(cfd.Sello,'') IS NOT NULL  
                         WHERE mt.ConsecutivoModulo = @Modulo AND mt.ConsecutivoMov = @Mov AND mt.Modulo != @Modulo AND mt.Mov != @Mov
                           AND mf.DID = @ID AND mf.DModulo = @Modulo)
        SELECT @CFD = 0
    END     
  END

  SELECT 'CFD' = @CFD

  RETURN 
END
GO
