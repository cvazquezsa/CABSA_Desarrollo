SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
GO

/****************** xrmGetClientNextNum *************************/
IF OBJECT_ID (N'dbo.xrmGetClientNextNum', N'FN') IS NOT NULL DROP FUNCTION xrmGetClientNextNum  
GO  
CREATE FUNCTION dbo.xrmGetClientNextNum(@Prefix varchar(3))  
RETURNS varchar(10)
--//WITH ENCRYPTION	
AS   
-- Returns the stock level for the product.  
BEGIN  
    DECLARE @ret varchar(10);  
	Declare @nextNum int;
	select 
	 @nextNum=((max(cast(SUBSTRING(cliente, CHARINDEX('-', cliente) + 1, LEN(cliente)) as integer)   ) + 1))	
	from cte where cliente like @Prefix+'-%'

	 set @ret = @Prefix+"-"+ RIGHT('00000'+ cast(@nextNum as varchar(5)),5)

	 --print @ret
    RETURN @ret  
END  
GO  

/****************** xcrm_pedido *************************/
IF OBJECT_ID ('xcrm_pedido', 'P') IS NOT NULL DROP PROCEDURE xcrm_pedido
GO	
CREATE PROCEDURE xcrm_pedido
	@Data xcrm_pedidoType READONLY,
	@R1 xcrm_VentaDType READONLY,
	@RowsAffected INT OUTPUT,
	@ErrorCode int OUTPUT,
	@ErrorMsg varchar(500) OUTPUT
--//WITH ENCRYPTION	
As Begin
	--Declare @RowsAffected as int
	--Declare @ErrorCode as VARCHAR(MAX)
	--Declare @Data as xcrm_pedidoType
	--Insert into @Data(concepto,ultimocambio,usuario, estatus) values ('','','','')
	----Insert into @Data(concepto,ultimocambio,usuario, estatus) values ('',GETDATE(),'2','3')
	----Insert into @Data(concepto,ultimocambio,usuario, estatus) values ('1',GETDATE(),'2','3')
	--select * from @Data
	----20,datetime,10,50
	Declare @LastId as int
	Declare @RowsAffected_tmp as int
	Declare @ErrorCode_tmp as VARCHAR(MAX)

	BEGIN TRANSACTION;

		BEGIN TRY

		--Busca si ya se inserto el pedido
			Declare  @CountPedido as int
			set @CountPedido=0
			select @CountPedido=count(*) from venta where crmobjectid in (select crmobjectid from @R1)
			   
			if(@CountPedido>0) begin 
				set @RowsAffected=0
				set @ErrorCode=1
				set @ErrorMsg='Registro duplicado '
			end 
			else begin
						
				INSERT INTO venta(mov,ultimocambio,usuario, Empresa,Moneda,Cliente,Almacen,CRMObjectId,referencia,observaciones,agente,listapreciosesp,estatus,FechaEmision,concepto,tipocambio,prioridad,fecharequerida,condicion,vencimiento,zonaImpuesto,Sucursal,SucursalVenta,sucursalorigen,foliocrm )
				select substring(movimiento,1,20),GETDATE(),usuario, empresa,moneda,cliente,almacen,substring(crmobjectid,1,100),substring(referencia,1,50),observaciones,agente,listaprecios ,'SINAFECTAR',GETDATE(),concepto,1,'Normal',GETDATE(),'(Fecha)',GETDATE(),'16%',1,1,1,substring(referencia,1,50) from @Data
				SELECT @LastId=@@IDENTITY;
			
				if(@LastId>0) begin
				 
					Declare @Almacen as varchar(20)
					Declare @Agente as varchar(10)
					Declare @Moneda as varchar(10)

					select @Almacen=Almacen,@Agente=Agente,@Moneda=Moneda from @Data
					INSERT INTO ventad(ID,articulo,fecharequerida,renglon,precio,cantidad,cantidadInventario,sucursal,
					renglonid,Almacen,agente,preciomoneda,precioTipocambio,DescuentoTipo,DescuentoLinea,Impuesto1,unidad,crmobjectid,DescuentoImporte)
					select @LastId,productosku,getdate(), (ROW_NUMBER() OVER(ORDER BY producto))*2048,
					cast(precio as float) ,
					cast (cantidad as float),
					cast (cantidad as float),
					0, 
					(ROW_NUMBER() OVER(ORDER BY producto)),
					@Almacen,@Agente,@Moneda,1,'%',
					(cast (descuento as float)/(cast (cantidad as float)*cast (precio as float)))*100,
					16,
					(select top 1 unidad from art where articulo=Articulo),
					crmobjectid,
					descuento
						
					from @R1

					Declare @maxRenglonID as varchar(10)
						--Actualiza encabezado
			    
					SELECT @RowsAffected = @@ROWCOUNT, @ErrorCode = @@ERROR
				
				end

				set @RowsAffected=1
				set @ErrorCode=0
				set @ErrorMsg=''
			end

		END TRY
		BEGIN CATCH
			--select * from tablaprueba
				
			SELECT 
				@ErrorCode=ERROR_NUMBER() 		
				,@ErrorMsg=substring('ERR'+ CONVERT(VARCHAR(25),ERROR_LINE()) + '-' + ERROR_MESSAGE() + '-' + ERROR_PROCEDURE(),1,500)

				--select * from IntelisisLinkage.dbo.errorlogs
			INSERT INTO IntelisisLinkage.dbo.errorLogs(integrationid,mapid,entity,attributes,description,date_error)	
			select 999,ERROR_NUMBER(),ERROR_PROCEDURE() ,ERROR_MESSAGE(),ERROR_LINE(),GETDATE() 
		  
			set @RowsAffected=0
			--set @ErrorCode=0
			IF @@TRANCOUNT > 0
				ROLLBACK TRANSACTION;
		END CATCH;

		IF @@TRANCOUNT > 0
			COMMIT TRANSACTION;

	--  Print 'Rpws='
	-- Print @RowsAffected 
	--Print 'Error' + @ErrorCode
	  
END
GO

/****************** xcrm_proyectos_admin *************************/
IF OBJECT_ID ('xcrm_proyectos_admin', 'P') IS NOT NULL DROP PROCEDURE xcrm_proyectos_admin 
GO	
CREATE PROCEDURE xcrm_proyectos_admin
	@Data xcrm_proyectos_adminType READONLY,
	@R1 xcrm_VentaD_proyectosType READONLY,
	@RowsAffected INT OUTPUT,
	@ErrorCode int OUTPUT,
	@ErrorMsg varchar(500) OUTPUT
--//WITH ENCRYPTION		
As Begin
	--Declare @RowsAffected as int
	--Declare @ErrorCode as VARCHAR(MAX)
	--Declare @Data as xcrm_pedidoType
	--Insert into @Data(concepto,ultimocambio,usuario, estatus) values ('','','','')
	----Insert into @Data(concepto,ultimocambio,usuario, estatus) values ('',GETDATE(),'2','3')
	----Insert into @Data(concepto,ultimocambio,usuario, estatus) values ('1',GETDATE(),'2','3')
	--select * from @Data
	----20,datetime,10,50
	Declare @LastId as int
	Declare @RowsAffected_tmp as int
	Declare @ErrorCode_tmp as VARCHAR(MAX)

	BEGIN TRANSACTION;

		BEGIN TRY

		--Busca si ya se inserto el pedido
			Declare  @CountPedido as int
			set @CountPedido=0
			select @CountPedido=count(*) from venta where crmobjectid in (select crmobjectid from @R1)
			   
			if(@CountPedido>0) begin 
				set @RowsAffected=0
				set @ErrorCode=1
				set @ErrorMsg='Registro duplicado '
			end 
			else begin
						
				INSERT INTO venta(mov,ultimocambio,usuario, Empresa,Moneda,Cliente,Almacen,CRMObjectId,referencia,observaciones,agente,listapreciosesp,estatus )
				select substring(movimiento,1,20),GETDATE(),usuario, empresa,'',cliente,almacen,substring(crmobjectid,1,100),substring(referencia,1,50),observaciones,agente,'' ,'SINAFECTAR' from @Data
				SELECT @LastId=@@IDENTITY;
			
				if(@LastId>0) begin
				 
				   
					INSERT INTO ventad(ID,articulo,fecharequerida,renglon,precio,cantidad,renglonid)
					select @LastId,productosku,getdate(), (ROW_NUMBER() OVER(ORDER BY producto))*2048,
					cast(precio as float) ,
					cast (cantidad as float),
					(ROW_NUMBER() OVER(ORDER BY producto))
					from @R1
						

					SELECT @RowsAffected = @@ROWCOUNT, @ErrorCode = @@ERROR
				
				end

				set @RowsAffected=1
				set @ErrorCode=0
				set @ErrorMsg=''
			end

		END TRY
		BEGIN CATCH
			--select * from tablaprueba
			SELECT 
				@ErrorCode=ERROR_NUMBER() 		
				,@ErrorMsg=substring('ERR'+ CONVERT(varchar(25),ERROR_LINE()) + '-' + ERROR_MESSAGE() + '-' + ERROR_PROCEDURE(),1,500)

			--select * from IntelisisLinkage.dbo.errorlogs
			INSERT INTO IntelisisLinkage.dbo.errorLogs(integrationid,mapid,entity,attributes,description,date_error)	
			select 999,ERROR_NUMBER(),ERROR_PROCEDURE() ,ERROR_MESSAGE(),ERROR_LINE(),GETDATE() 
		  
			set @RowsAffected=0
			--set @ErrorCode=0
			IF @@TRANCOUNT > 0
				ROLLBACK TRANSACTION;
		END CATCH;

		IF @@TRANCOUNT > 0
			COMMIT TRANSACTION;
	
	--  Print 'Rpws='
	-- Print @RowsAffected 
	--Print 'Error' + @ErrorCode
	  
END
GO

