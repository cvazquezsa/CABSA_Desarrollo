/*************************     Contabilidad Electrónica     ****************************************/
SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
GO 
/**************** xpCxAfectar ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpCxAfectar') and sysstat & 0xf = 4) drop procedure dbo.xpCxAfectar
GO
CREATE PROCEDURE xpCxAfectar
    		    @ID               		int,
    		    @Accion			char(20),
    		    @Empresa          		char(5),    	
    		    @Usuario			char(10),
    		    @Modulo	      		char(5),
    		    @Mov              		char(20),
	            @MovID			varchar(20),
    		    @MovTipo	      		char(20),    		    
    		    @MovMoneda			char(10),
    		    @MovTipoCambio		float,
    		    @FechaEmision		datetime,
    		    @Condicion			varchar(50),
    		    @Vencimiento		datetime,
    		    @FormaPago			varchar(50),
    		    @ClienteProv		char(10),
    		    @CPMoneda			char(10),
    		    @CPFactor			float,
    		    @CPTipoCambio		float,
    		    @Importe			money,
    		    @Impuestos			money,
    		    @Saldo			money,
    		    @CtaDinero			char(10),
    		    @AplicaManual      		bit,
    		    @ConDesglose		bit,                   
    		    @Conexion			bit,
	            @SincroFinal		bit,
    		    @Sucursal			int,
 	    	    @EstatusNuevo	    	char(15),
    		    @MovAplica			char(20),
    		    @MovAplicaID		varchar(20),
    		    @Ok               		int          OUTPUT,
    		    @OkRef            		varchar(255) OUTPUT,
    		    @Estatus			varchar(15) = NULL
AS BEGIN

/*INICIO ContaSAT*/
/*Este bloque sirve para grabar el registro correspondientes al MovAplica en la tabla de MovImpuestos */
DECLARE		@CE_IDAplica		 	int,
		@CE_MovAplicaFactor		float,
		@CE_MovAplicaImporteTotal  	money,
		@CE_MovAplicaRetencion		money,
		@CE_MovAplicaRetencion2		money,
		@CE_MovAplicaRetencion3		money,
		@CE_MovAplicaTipoCambio 	float,
		@CE_MovAplicaMoneda 		varchar(20),
		@CE_MovAplicaImporteNeto 	money,
		@CE_Retencion			money,
		@CE_Impuestos			float,
		@CE_Importe			money,
		@CE_ImporteTotal		money
			
  IF @MovTipo IN ('CXC.ANC', 'CXC.ACA', 'CXP.ANC', 'CXP.ACA') AND @Accion <> 'CANCELAR' 
  BEGIN
  IF @Modulo = 'CXC' 
     SELECT @CE_IDAplica = ID,@CE_MovAplicaRetencion = ISNULL(Retencion, 0), @CE_MovAplicaRetencion2 = NULL, @CE_MovAplicaRetencion3 = NULL, @CE_MovAplicaImporteTotal  = ISNULL(Importe, 0.0) + ISNULL(Impuestos, 0.0), @CE_MovAplicaTipoCambio = TipoCambio, @CE_MovAplicaMoneda = Moneda,@CE_Impuestos =ISNULL(Impuestos, 0.0),@CE_Retencion=ISNULL(Retencion, 0),@CE_Importe=ISNULL(Importe, 0.0)
     FROM Cxc 
    WHERE Empresa = @Empresa AND Mov = @MovAplica AND MovID = @MovAplicaID AND Estatus NOT IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR', 'CANCELADO') 
  ELSE
  IF @Modulo = 'CXP' 
     SELECT @CE_IDAplica = ID,  @CE_MovAplicaRetencion = ISNULL(Retencion, 0), @CE_MovAplicaRetencion2 = ISNULL(Retencion2, 0), @CE_MovAplicaRetencion3 = ISNULL(Retencion3, 0), @CE_MovAplicaImporteTotal  = ISNULL(Importe, 0.0) + ISNULL(Impuestos, 0.0), @CE_MovAplicaTipoCambio = TipoCambio, @CE_MovAplicaMoneda = Moneda,@Impuestos =ISNULL(Impuestos, 0.0),@CE_Retencion=ISNULL(Retencion, 0),@CE_Importe=ISNULL(Importe, 0.0)
     FROM Cxp 
     WHERE Empresa = @Empresa AND Mov = @MovAplica AND MovID = @MovAplicaID AND Estatus NOT IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR', 'CANCELADO')
    
    SELECT @CE_ImporteTotal = @CE_Importe + @CE_Impuestos - ISNULL(@CE_Retencion,0) - ISNULL(@CE_MovAplicaRetencion2,0) - ISNULL(@CE_MovAplicaRetencion3,0)
    
    SELECT @CE_MovAplicaImporteNeto = ISNULL(@CE_MovAplicaImporteTotal,0.0) - ISNULL(@CE_MovAplicaRetencion,0.0) - ISNULL(@CE_MovAplicaRetencion2,0.0) - ISNULL(@CE_MovAplicaRetencion3,0.0) 
        SELECT @CE_MovAplicaFactor = (@CE_ImporteTotal * @MovTipoCambio) / NULLIF(CONVERT(float, @CE_MovAplicaImporteNeto * @CE_MovAplicaTipoCambio), 0)*-1


    IF NOT EXISTS (SELECT ID FROM MovImpuesto WHERE  Modulo = @Modulo AND ModuloID = @ID AND OrigenModuloID=@CE_IDAplica )
    INSERT MovImpuesto (
           Modulo,  ModuloID, OrigenModulo, OrigenModuloID, OrigenConcepto, OrigenDeducible,		OrigenFecha, LoteFijo, Retencion1, Retencion2, Retencion3, Excento1, Excento2, Excento3, Impuesto1, Impuesto2, Impuesto3, TipoImpuesto1, TipoImpuesto2, TipoImpuesto3, TipoRetencion1, TipoRetencion2, TipoRetencion3, Importe1,                  Importe2,                  Importe3,                  SubTotal,                  ContUso, ContUso2, ContUso3, ClavePresupuestal, ClavePresupuestalImpuesto1, DescuentoGlobal)
    SELECT @Modulo, @ID,      OrigenModulo, OrigenModuloID, OrigenConcepto, ISNULL(OrigenDeducible, 100), OrigenFecha, LoteFijo, Retencion1, Retencion2, Retencion3, Excento1, Excento2, Excento3, Impuesto1, Impuesto2, Impuesto3, TipoImpuesto1, TipoImpuesto2, TipoImpuesto3, TipoRetencion1, TipoRetencion2, TipoRetencion3, Importe1*@CE_MovAplicaFactor, Importe2*@CE_MovAplicaFactor, Importe3*@CE_MovAplicaFactor, SubTotal*@CE_MovAplicaFactor, ContUso, ContUso2, ContUso3, ClavePresupuestal, ClavePresupuestalImpuesto1, DescuentoGlobal
      FROM MovImpuesto
     WHERE Modulo = @Modulo AND ModuloID = @CE_IDAplica
  END
/*FIN ContaSAT*/ 
  RETURN
END
GO

