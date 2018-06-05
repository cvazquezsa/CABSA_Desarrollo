--------------------------------------------------------------------------------------------------------------------
-----------------------------------------   I  M  P  O  R  T  A  N  T  E   -----------------------------------------
--------------------------------------------------------------------------------------------------------------------
-- Antes de continuar la instalación ejecute las siguientes instrucciones.
-- Esta accion puede tardar, por tal motivo no se ejeccuta dentro del Instalador. 
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------

SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
GO
EXEC spAlter_Table 'VentaD', 'TipoRetencion1', 'varchar(10) NULL' 
EXEC spAlter_Table 'VentaD', 'TipoRetencion2', 'varchar(10) NULL'  
EXEC spAlter_Table 'VentaD', 'TipoRetencion3', 'varchar(10) NULL'  
EXEC spAlter_Table 'VentaD', 'Retencion1',     'float NULL' 
EXEC spAlter_Table 'VentaD', 'Retencion2',     'float NULL' 
EXEC spAlter_Table 'VentaD', 'Retencion3',     'float NULL' 
EXEC spALTER_TABLE 'Cxc',    'Retencion2',     'float NULL'
EXEC spALTER_TABLE 'Cxc',    'Retencion3',     'float NULL'
GO
