SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
SET ARITHABORT OFF 
GO

/**************** xpMovCopiarEncabezado ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpMovCopiarEncabezado') and type = 'P') drop procedure dbo.xpMovCopiarEncabezado
GO             
CREATE PROCEDURE xpMovCopiarEncabezado
      @Sucursal       int,
      @Modulo         char(5), 
      @ID             int,
      @Empresa        char(5), 
      @Mov            char(20),
      @MovID          varchar(20),
      @Usuario        char(10), 
      @FechaEmision   datetime, 
      @Estatus        char(15),
      @Moneda         char(10),
      @TipoCambio     float,
      @Almacen        char(10),
      @AlmacenDestino char(10),
      @GenerarDirecto bit,
      @GenerarMov     char(20),
      @GenerarMovID   varchar(20), 
      @GenerarID      int,
      @Ok             int  OUTPUT,
      @CopiarBitacora bit
AS BEGIN

 IF @Modulo = 'VTAS'
  INSERT INTO VentaCFDIRelacionado(ID,CFDIAplica,CFDIAplicaID,CFDIAplicaUUID,TipoOperacion,ClavePedimento,CertificadoOrigen,NumCertificadoOrigen,NumeroExportadorConfiable,Incoterm,Subdivision,Destinatario)
   SELECT @GenerarID, CFDIAplica,CFDIAplicaID,CFDIAplicaUUID,TipoOperacion,ClavePedimento,CertificadoOrigen,NumCertificadoOrigen,NumeroExportadorConfiable,Incoterm,Subdivision,Destinatario
     FROM VentaCFDIRelacionado WHERE ID = @ID

 IF @Modulo = 'DIN' AND dbo.fnMovTipo('DIN',@Mov) = 'DIN.SD'
    IF EXISTS (SELECT * FROM ContSAtInfoAdiIngreso WHERE ID = @ID)
	INSERT ContSAtInfoAdiIngreso (ID, MetodoPago, NumeroCheque, BanOrigen, CtaOrigen, BanDestino, CtaDestino, RFCCliente)
	SELECT @GenerarID, MetodoPago, NumeroCheque, BanOrigen, CtaOrigen, BanDestino, CtaDestino, RFCCliente
	FROM ContSAtInfoAdiIngreso
	WHERE ID = @ID

RETURN
END
GO