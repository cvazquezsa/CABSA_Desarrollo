
/* Configuracion MS SQL Server */

SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF

GO
-- Consecutivos PREV
IF NOT EXISTS (SELECT * FROM SysTabla WHERE SysTabla = 'PrevencionLDC')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('PrevencionLDC', 'Movimiento')
GO
IF NOT EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.PrevencionLDC') and type = 'U') 
BEGIN
  CREATE TABLE dbo.PrevencionLDC (
    ID		int		NOT NULL IDENTITY (1,1),	
    Empresa	varchar(5)      NULL,
    Mov 	varchar(20) 	NULL,
    Serie	varchar(20)		NULL,
    Periodo	int				NULL,
    Ejercicio	int			NULL,		
    Consecutivo int			NOT NULL DEFAULT 0,
    Sucursal	int			NOT NULL DEFAULT 0,
    CONSTRAINT priPrevencionLDC PRIMARY KEY  CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'PrevencionLDC'
END
GO
EXEC spModificarPK_SucursalSinOrigen 'PrevencionLDC', '(ID)'
GO


-- Principal Prevencion PREV
IF NOT EXISTS (SELECT * FROM SysTabla WHERE SysTabla = 'PrevencionLD')
	INSERT INTO SysTabla (SysTabla,       Tipo,        Modulo) 
                  VALUES ('PrevencionLD','Movimiento','PREV' )
GO
IF NOT EXISTS (select * from sysobjects where id = object_id('dbo.PrevencionLD') and type = 'U') 
BEGIN
 CREATE TABLE PrevencionLD	
    (ID	            int		identity Not Null,
	Empresa	        char	(5)	Not Null,
	Mov	            char	(20)	Not Null,
	MovID	        varchar	(20) NULL,	
	FechaEmision	datetime  NULL,	 	
	UltimoCambio	datetime  NULL,			
	Concepto	    varchar	(50) NULL,		
	Proyecto	    varchar	(50)  NULL,		
	UEN	            int  NULL,			    
	Moneda	        char	(10)	Not Null,
	TipoCambio	    float	 NULL,		
	Usuario	        char	(10)  NULL,		
	Autorizacion	char	(10) NULL,		
    Importe         Float   NULL,	
	Referencia	    varchar	(50)    NULL,	
	DocFuente	    int   NULL,
	Observaciones	varchar	(100)    NULL,
	Estatus	        char	(15)   NULL,
	Situacion	    varchar	(50)   NULL,	
	SituacionFecha	datetime   NULL,		
	SituacionUsuario	varchar	(10)   NULL,
	SituacionNota	varchar	(100)   NULL,
	OrigenTipo	    varchar	(10)   NULL,	
	Origen	        varchar	(20)   NULL,	
	OrigenID	    varchar	(20)   NULL,	
	Ejercicio	    int   NULL,		
	Periodo	        int   NULL,	
	FechaRegistro	datetime   NULL,
	FechaConclusion	datetime   NULL,	
	FechaCancelacion	datetime   NULL,    
	Sucursal	    int	Not Null,
	SucursalOrigen	int	Not Null,
	SucursalDestino	int    NULL,		
	ContID	        int    NULL,
	Poliza	        varchar	(20)    NULL,
	PolizaID	    varchar	(20)    NULL,	
	GenerarPoliza	bit    NULL,	
    FechaPoliza	datetime   NULL,
    GenerarDinero	bit    NULL,
	Vencimiento	    datetime    NULL,
	Acreedor	    varchar	(10)    NULL,	
	Condicion	    varchar	(50)    NULL,	
	Cliente	        varchar	(10)    NULL,	
	Almacen	        varchar	(10)    NULL,	
	ActEconomica	varchar	(50) null
    )
  EXEC spSincroSemilla 'PrevencionLD'
END
GO
EXEC spSincroNivelRegistro @Tabla = 'PrevencionLD'
GO


-- PrevencionLDD (Detalle)
IF NOT EXISTS (SELECT * FROM SysTabla WHERE SysTabla = 'PrevencionLDD') 
INSERT INTO SysTabla (SysTabla,        Tipo,        Modulo) 
              VALUES ('PrevencionLDD','Movimiento','PREV')
GO
IF NOT EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.PrevencionLDD') and TYPE = 'U') 
CREATE TABLE PrevencionLDD
	(ID	            int		Not Null,
	Renglon	        float	Not Null,
	OrigenModulo	varchar	(5)    NULL,	
	OrigenModuloID	int    NULL,	
	Aplica	        varchar (20)    NULL,	
	AplicaId	    varchar	(20)    NULL,	
	Importe 	    float    NULL,	
	ActEconimica	varchar	(50)    NULL,	
	SaldoActual	    Float    NULL,		
	SaldoAnterior	float    NULL,		
	Variacion	    float    NULL,		
	Contacto	    varchar	(10)    NULL,	
	ContactoTipo	varchar	(20)    NULL,	
	Sucursal	    int	Not Null,
	SucursalOrigen	int	Not Null,
	Referencia	    varchar	(50)    NULL	
    )
GO
