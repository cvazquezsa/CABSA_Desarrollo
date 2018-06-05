/*
  Se tiene que integrar la linea EXEC spValidarDevolucionFactura @ID, @Empresa, @Ok OUTPUT, @OkRef OUTPUT al xpInvVerificar para la Herramienta de Factura Global
*/

/**************** xpInvVerificar ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpInvVerificar') and type = 'P') drop procedure dbo.xpInvVerificar
GO
CREATE PROCEDURE xpInvVerificar
@ID             int,
@Accion         char(20),
@Base           char(20),
@Empresa        char(5),
@Usuario        char(10),
@Modulo         char(5),
@Mov            char(20),
@MovID          varchar(20),
@MovTipo        char(20),
@MovMoneda      char(10),
@MovTipoCambio  float,
@Estatus        char(15),
@EstatusNuevo   char(15),
@FechaEmision   datetime,
@Ok             int           OUTPUT,
@OkRef          varchar(255)  OUTPUT
AS
BEGIN
  EXEC spValidarDevolucionFactura @ID, @Empresa, @Ok OUTPUT, @OkRef OUTPUT
RETURN
END
GO