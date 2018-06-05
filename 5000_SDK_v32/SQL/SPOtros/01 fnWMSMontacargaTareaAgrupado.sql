SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
SET ARITHABORT OFF
SET ANSI_WARNINGS OFF
GO

IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnWMSMontacargaTareaAgrupado') DROP FUNCTION dbo.fnWMSMontacargaTareaAgrupado
GO
CREATE FUNCTION dbo.fnWMSMontacargaTareaAgrupado(@Estacion int)
RETURNS @fnWMSMontacargaTareaAgrupado TABLE
   (Guia                            int NULL,
    Estacion						int NULL,
    IDLista                         int NULL,
	ID								int NULL,
	Renglon							float NULL,
	Mov								varchar(20) NULL,
	MovID                           varchar(20) NULL,
	FechaEmision                    datetime NULL,
	Tarima                          varchar(20) NULL,
	Sucursal                        int NULL, 
	NomSucursal                     varchar(20) NULL,
	Pasillo                         varchar(20) NULL,
	PosicionOrigen                  varchar(10) NULL,
	PosicionDestino                 varchar(10) NULL,
	Articulo                        varchar(20) NULL,
	Montacarga                      varchar(20) NULL,
	Prioridad                       varchar(10) NULL,
	Almacen                         varchar(20) NULL,
	Modificar                       bit,
	Clave                           varchar(20) NULL,
	Movimiento                      varchar(30) NULL,
	Empresa                         char(5) NULL,
	NoCajas                         float NULL,
	Zona                            varchar(50) NULL,
	Descripcion1                    varchar(255) NULL,
	Nombre                          varchar(255) NULL, 
	OrigenTipo                      varchar(20) NULL,
	Origen                          varchar(20) NULL,
	OrigenID                        varchar(20) NULL,
	Cuenta                          varchar(20) NULL
	)
   
AS BEGIN
   	    INSERT INTO @fnWMSMontacargaTareaAgrupado 	
		     SELECT  DENSE_RANK() OVER(ORDER BY 
			                WMSMontacargaTarea.Almacen,
							WMSMontacargaTarea.Mov,
							WMSMontacargaTarea.Tarima,
							WMSMontacargaTarea.Sucursal,
							WMSMontacargaTarea.NomSucursal,
							WMSMontacargaTarea.Pasillo,
							WMSMontacargaTarea.PosicionOrigen,
							WMSMontacargaTarea.PosicionDestino,
							WMSMontacargaTarea.Articulo,
							Art.Descripcion1,
							WMSMontacargaTarea.Montacarga,
							Cuenta ) 'Guia',
					WMSMontacargaTarea.Estacion,
					WMSMontacargaTarea.IDLista,
					WMSMontacargaTarea.ID,
					WMSMontacargaTarea.Renglon,
					WMSMontacargaTarea.Mov,
					WMSMontacargaTarea.MovID,
					WMSMontacargaTarea.FechaEmision,
					WMSMontacargaTarea.Tarima,
					WMSMontacargaTarea.Sucursal,
					WMSMontacargaTarea.NomSucursal,
					WMSMontacargaTarea.Pasillo,
					WMSMontacargaTarea.PosicionOrigen,
					WMSMontacargaTarea.PosicionDestino,
					WMSMontacargaTarea.Articulo,
					WMSMontacargaTarea.Montacarga,
					WMSMontacargaTarea.Prioridad,
					WMSMontacargaTarea.Almacen,
					WMSMontacargaTarea.Modificar,
					WMSMontacargaTarea.Clave,
					WMSMontacargaTarea.Movimiento,
					WMSMontacargaTarea.Empresa,
					WMSMontacargaTarea.NoCajas,
					WMSMontacargaTarea.Zona,
					Art.Descripcion1,
					Agente.Nombre,
					TMA.OrigenTipo,
					TMA.Origen,
					TMA.OrigenID,
					Cuenta = (CASE WHEN TMA.OrigenTipo = 'VTAS' THEN (SELECT Cliente FROM Venta WHERE Mov=TMA.Origen AND MovID = TMA.OrigenID) ELSE NULL END)
			FROM WMSMontacargaTarea
				 LEFT OUTER JOIN Art ON WMSMontacargaTarea.Articulo=Art.Articulo
				 LEFT OUTER JOIN Agente ON WMSMontacargaTarea.Montacarga=Agente.Agente
				 JOIN TMA ON WMSMontacargaTarea.ID=TMA.ID
           WHERE Estacion=@Estacion
 	  
  RETURN 
	 
END
GO

  -- SELECT * FROM dbo.fnWMSMontacargaTareaAgrupado (1)

IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnWMSMontacargaTareaAgrupadoD') DROP FUNCTION dbo.fnWMSMontacargaTareaAgrupadoD
GO
CREATE FUNCTION dbo.fnWMSMontacargaTareaAgrupadoD(@Estacion int)
RETURNS @WMSMontacargaTareaAgrupadoD TABLE
   (ID                              int identity,
    Mov                             varchar(20) NULL,
    Estacion						int NULL,   
	Almacen                         varchar(20) NULL,
	Tarima                          varchar(20) NULL,
	NoCajas                         float NULL,
	Sucursal                        int NULL, 
	NomSucursal                     varchar(20) NULL,
	Pasillo                         varchar(20) NULL,
	PosicionOrigen                  varchar(10) NULL,
	PosicionDestino                 varchar(10) NULL,
	Articulo                        varchar(20) NULL,
	Descripcion1                    varchar(255) NULL,	
	Montacarga                      varchar(20) NULL,
	Cuenta                          varchar(20) NULL,
	Guia                            int NULL	
	)
   
AS BEGIN
DECLARE
     @IDAgrupar AS TABLE (ID int, IDO int)


   	    INSERT INTO @WMSMontacargaTareaAgrupadoD 			     
             SELECT Mov,
					Estacion,					
					Almacen,
					Tarima,
					SUM(ISNULL(NoCajas,0)),
					Sucursal,
					NomSucursal,
					Pasillo,
					PosicionOrigen,
					PosicionDestino,
					Articulo,
					Descripcion1,
					Montacarga,
					Cuenta,
					Guia			
			  FROM  dbo.fnWMSMontacargaTareaAgrupado (@Estacion)
		  GROUP BY  Mov,
		            Estacion,
					Almacen,
					Tarima,
					Sucursal,
					NomSucursal,
					Pasillo,
					PosicionOrigen,
					PosicionDestino,
					Articulo,
					Descripcion1,
					Montacarga,
					Cuenta,
					Guia
           
 	  
  RETURN 
	 
END
GO

-- SELECT * FROM dbo.fnWMSMontacargaTareaAgrupado (1) WHERE Guia=9
-- SELECT * FROM dbo.fnWMSMontacargaTareaAgrupadoD (1) WHERE Guia=9

if exists (select * from sysobjects where id = object_id('dbo.spMontacargaListST') and type = 'P') drop procedure dbo.spMontacargaListST
GO
CREATE PROC spMontacargaListST 
	@Estacion       int
--//WITH ENCRYPTION
AS BEGIN 
	DELETE ListaID WHERE Estacion=@Estacion 
	INSERT INTO ListaID (Estacion, ID) 
  		 SELECT @Estacion, IDLista 
		   FROM dbo.fnWMSMontacargaTareaAgrupado (@Estacion)
		  WHERE Guia IN (SELECT Clave 
					       FROM ListaSt 
					      WHERE Estacion=@Estacion)



	 
RETURN
END
GO 
-- EXEC spMontacargaListST 1
