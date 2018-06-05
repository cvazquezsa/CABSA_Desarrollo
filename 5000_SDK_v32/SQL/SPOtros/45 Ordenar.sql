/* Ordenar Maestros */

/**************** xpOrdenarMaestroWMS ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpOrdenarMaestroWMS') and type = 'P') drop procedure dbo.xpOrdenarMaestroWMS
GO             
CREATE PROCEDURE xpOrdenarMaestroWMS
					@Estacion	int			= NULL,
					@Tabla		varchar(50) = NULL,
					@Llave		varchar(50) = NULL
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Orden		int,
    @Clave		varchar(255)

  SELECT @Tabla = UPPER(@Tabla)
--  CREATE TABLE #Log (ID int NULL)
    SELECT @Orden = 0
    DECLARE crListaSt CURSOR FOR SELECT Clave FROM ListaSt WHERE Estacion = @Estacion ORDER BY ID 
    OPEN crListaSt
    FETCH NEXT FROM crListaSt INTO @Clave
    WHILE @@FETCH_STATUS <> -1 
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        SELECT @Orden = @Orden + 1
  
        IF @Tabla = 'ALMPOS' UPDATE AlmPos SET Orden = @Orden WHERE Posicion = @Clave AND Almacen = @Llave
      END
      FETCH NEXT FROM crListaSt INTO @Clave
    END -- While
    CLOSE crListaSt
    DEALLOCATE crListaSt
    
  RETURN
END
GO

/**************** spOrdenarMaestro ****************/
if exists (select * from sysobjects where id = object_id('dbo.spOrdenarMaestro') and type = 'P') drop procedure dbo.spOrdenarMaestro
GO             
CREATE PROCEDURE spOrdenarMaestro
                    @Estacion	int,
		    @Tabla	varchar(50),
                    @Modulo     char(5)  	= NULL,
		    @ID		int      	= NULL,
		    @Cuenta	char(50) 	= NULL,
		    @Llave	varchar(50)	= NULL
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Orden		int,
    @Clave		varchar(255),
    @Actividad		varchar(10),
    @ActividadID	int

  SELECT @Tabla = UPPER(@Tabla)
--  CREATE TABLE #Log (ID int NULL)
  BEGIN TRANSACTION
    SELECT @Orden = 0
    DECLARE crListaSt CURSOR FOR SELECT Clave FROM ListaSt WHERE Estacion = @Estacion ORDER BY ID 
    OPEN crListaSt
    FETCH NEXT FROM crListaSt INTO @Clave
    WHILE @@FETCH_STATUS <> -1 
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        SELECT @Orden = @Orden + 1
        IF @Tabla = 'ALM'             UPDATE Alm            	SET Orden = @Orden WHERE Almacen      = @Clave ELSE
        IF @Tabla = 'MON'             UPDATE Mon            	SET Orden = @Orden WHERE Moneda       = @Clave ELSE
        IF @Tabla = 'UNIDAD'          UPDATE Unidad           	SET Orden = @Orden WHERE Unidad       = @Clave ELSE
        IF @Tabla = 'CONDICION'       UPDATE Condicion      	SET Orden = @Orden WHERE Condicion    = @Clave ELSE
        IF @Tabla = 'CENTRO'          UPDATE Centro         	SET Orden = @Orden WHERE Centro       = @Clave ELSE
        IF @Tabla = 'CONDICION'       UPDATE Condicion      	SET Orden = @Orden WHERE Condicion    = @Clave ELSE
        IF @Tabla = 'ARTSUSTITUTO'    UPDATE ArtSustituto   	SET Orden = @Orden WHERE Sustituto    = @Clave ELSE
        IF @Tabla = 'EMBARQUEESTADO'  UPDATE EmbarqueEstado 	SET Orden = @Orden WHERE Estado       = @Clave ELSE
	IF @Tabla = 'NACIONALIDAD'    UPDATE Nacionalidad  	SET Orden = @Orden WHERE Nacionalidad = @Clave ELSE
	IF @Tabla = 'IDIOMA'          UPDATE Idioma       	SET Orden = @Orden WHERE Idioma       = @Clave ELSE
	IF @Tabla = 'ACTIVIDAD'       UPDATE Actividad       	SET Orden = @Orden WHERE Actividad    = @Clave ELSE
	IF @Tabla = 'FORMAPAGO'       UPDATE FormaPago       	SET Orden = @Orden WHERE FormaPago    = @Clave ELSE
	IF @Tabla = 'PERSONALPROP'    UPDATE PersonalProp  	SET Orden = @Orden WHERE Propiedad    = @Clave ELSE
	IF @Tabla = 'SOPORTEESTADO'   UPDATE SoporteEstado 	SET Orden = @Orden WHERE Estado       = @Clave ELSE
	IF @Tabla = 'ZONA'            UPDATE Zona     		SET OrdenEmbarque = @Orden WHERE Zona = @Clave ELSE
	IF @Tabla = 'TAREAESTADO'     UPDATE TareaEstado 	SET Orden = @Orden WHERE Estado       = @Clave ELSE
	IF @Tabla = 'CMPESTADO'       UPDATE CMPEstado 	        SET Orden = @Orden WHERE Estado       = @Clave ELSE
        IF @Tabla = 'PRECIOCALC'      UPDATE PrecioCalc    	SET Orden = @Orden WHERE ListaPrecios = @Clave ELSE
        IF @Tabla = 'MOVCTE'          UPDATE MovCte           	SET Orden = @Orden WHERE Nombre       = @Clave ELSE
        IF @Tabla = 'MOVPROY'         UPDATE MovProy           	SET Orden = @Orden WHERE Nombre       = @Clave ELSE
        IF @Tabla = 'MOVPROV'         UPDATE MovProv          	SET Orden = @Orden WHERE Nombre       = @Clave ELSE
        IF @Tabla = 'FORMAVIRTUALCARPETA' UPDATE FormaVirtualCarpeta 	SET Orden = @Orden WHERE Carpeta      = @Clave AND FormaVirtual = @Llave ELSE

        IF @Tabla = 'AUTORUTAD' 		UPDATE AutoRutaD   		SET Orden = @Orden WHERE Ruta = @Cuenta AND Localidad = @Clave ELSE
        IF @Tabla = 'AUTOCORRIDAPLANTILLA' 	UPDATE AutoCorridaPlantilla 	SET Orden = @Orden WHERE Corrida = @Cuenta AND ID = CONVERT(int, @Clave) ELSE
        IF @Tabla = 'SERVICIOTIPOPLANTILLA' 	UPDATE ServicioTipoPlantilla 	SET Orden = @Orden WHERE Tipo = @Cuenta    AND ID = CONVERT(int, @Clave) ELSE
        IF @Tabla = 'EVALUACIONFORMATO' 	UPDATE EvaluacionFormato 	SET Orden = @Orden WHERE Evaluacion = @Cuenta AND Punto = @Clave ELSE

        IF @Tabla = 'CAUSA'        UPDATE Causa        SET Orden = @Orden WHERE Modulo = @Modulo AND Causa    = @Clave ELSE
        IF @Tabla = 'CLASE'        UPDATE Clase        SET Orden = @Orden WHERE Modulo = @Modulo AND Clase    = @Clave ELSE
        IF @Tabla = 'CONCEPTO'     UPDATE Concepto     SET Orden = @Orden WHERE Modulo = @Modulo AND Concepto = @Clave ELSE
        IF @Tabla = 'MOVTIPO'      UPDATE MovTipo      SET Orden = @Orden WHERE Modulo = @Modulo AND Mov      = @Clave ELSE
        IF @Tabla = 'MOVTIPOFORMA' UPDATE MovTipoForma SET Orden = @Orden WHERE Modulo = @Modulo AND Mov      = @Cuenta AND Campo = @Clave ELSE
        IF @Tabla = 'MOVTIPOFORMAAYUDA' UPDATE MovTipoFormaAyuda SET Orden = @Orden WHERE Modulo = @Modulo AND Mov = @Cuenta AND Campo = @Llave AND Ayuda = @Clave ELSE

        IF @Tabla = 'CFGMOVFLUJO'  UPDATE CfgMovFlujo  SET Orden = @Orden WHERE Modulo = @Modulo AND OMov = @Cuenta AND DMov = @Clave ELSE
        IF @Tabla = 'LISTAGRUPO'   UPDATE ListaGrupo   SET Orden = @Orden WHERE Rama   = @Modulo AND Grupo    = @Clave ELSE

        IF @Tabla = 'NOMXFORMULA'   UPDATE NomXFormula   SET Orden = @Orden WHERE ID = @ID AND Formula  = @Clave ELSE
        IF @Tabla = 'NOMXBASE'      UPDATE NomXBase      SET Orden = @Orden WHERE Formula  = @Clave 	         ELSE
        IF @Tabla = 'NOMXPERSONAL'  UPDATE NomXPersonal  SET Orden = @Orden WHERE ID = @ID AND Concepto = @Clave ELSE
        IF @Tabla = 'SERVICIOTAREA' UPDATE ServicioTarea SET Orden = @Orden WHERE ID = @ID AND Tarea = @Clave    ELSE
        IF @Tabla = 'MOVTAREA'      UPDATE MovTarea      SET Orden = @Orden WHERE Modulo = @Modulo AND ID = @ID AND Tarea = @Clave ELSE

        IF @Tabla = 'ANEXOCTA'     UPDATE AnexoCta     SET Orden = @Orden WHERE Rama   = @Modulo AND Cuenta = @Cuenta AND Nombre = @Clave ELSE
        IF @Tabla = 'ANEXOMOV'     UPDATE AnexoMov     SET Orden = @Orden WHERE Rama   = @Modulo AND ID = @ID AND Nombre = @Clave 	  ELSE
        IF @Tabla = 'ANEXOMOVD'    UPDATE AnexoMovD    SET Orden = @Orden WHERE Rama   = @Modulo AND ID = @ID AND Cuenta = @Cuenta AND Nombre = @Clave ELSE
 
        IF @Tabla = 'CTERUTA'      UPDATE Cte          SET RutaOrden = @Orden WHERE Cliente = @Clave ELSE
        IF @Tabla = 'ARTINFOADICIONAL' UPDATE ArtInfoAdicional  SET Orden = @Orden WHERE Articulo = @Cuenta AND Datos = @Clave ELSE

        IF @Tabla = 'MOVTIPOCONTAUTO' 		UPDATE MovTipoContAuto 		SET Orden = @Orden WHERE Modulo = @Modulo AND Clave = @Cuenta AND Nombre = @Clave AND Empresa = @Llave ELSE
        IF @Tabla = 'CAMPOEXTRAAYUDALISTA' 	UPDATE CampoExtraAyudaLista 	SET Orden = @Orden WHERE CampoExtra = @Llave AND Opcion = @Clave ELSE
        /*IF @Tabla = 'COMPETENCIAFORMATO' 	UPDATE CompetenciaFormato 	SET Orden = @Orden WHERE Punto = @Clave*/
        IF @Tabla = 'ACTIVOFTIPOINDICADORLISTA'	UPDATE ActivoFTipoIndicadorLista SET Orden = @Orden WHERE Valor = @Clave AND Tipo = @Cuenta AND Indicador = @Llave ELSE
        /*IF @Tabla = 'GESTIONPLANTILLAACTIVIDAD'
        BEGIN
          SELECT @Actividad = Actividad FROM GestionPlantillaActividad WHERE Plantilla = @Cuenta AND Fase=@ID AND ID = CONVERT(int, @Clave)
          UPDATE GestionPlantillaActividad SET Actividad = @Orden WHERE Plantilla = @Cuenta AND Fase=@ID AND ID = CONVERT(int, @Clave)

          SELECT @ActividadID = NULL
          UPDATE GestionPlantillaActividad SET @ActividadID = ID, Predecesora = @Orden WHERE Plantilla = @Cuenta AND Fase=@ID AND Predecesora = @Actividad AND ID NOT IN (SELECT ID FROM #Log)
          IF @ActividadID IS NOT NULL INSERT #Log (ID) VALUES (@ActividadID)
        END*/
        IF @Tabla = 'VisorWeb'		UPDATE VisorWebConfigD SET Orden = @Orden WHERE Formato = @Cuenta AND RID = @Clave ELSE --REQ12615 WMS
        IF @Tabla = 'ALMPOS'		UPDATE AlmPos SET Orden = @Orden WHERE Posicion = @Clave AND Almacen = @Llave --REQ12615 WMS
      END
      FETCH NEXT FROM crListaSt INTO @Clave
    END -- While
    CLOSE crListaSt
    DEALLOCATE crListaSt

    --EXEC xpOrdenarMaestroWMS @Estacion, @Tabla, @Llave --REQ12615 WMS

   -- DELETE ListaSt WHERE Estacion = @Estacion
  COMMIT TRANSACTION
--ROLLBACK TRAN
  RETURN
END
GO

/* Ordenar Modulos */

/**************** spOrdenarModulo ****************/
if exists (select * from sysobjects where id = object_id('dbo.spOrdenarModulo') and type = 'P') drop procedure dbo.spOrdenarModulo
GO             
CREATE PROCEDURE spOrdenarModulo
                    @Estacion	int,
                    @Modulo     char(5)
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Orden	int,
    @ID		int

  BEGIN TRANSACTION
    SELECT @Orden = 0
    DECLARE crListaID CURSOR 
        FOR SELECT ID FROM ListaID WHERE Estacion = @Estacion ORDER BY IDInterno
    OPEN crListaID
    FETCH NEXT FROM crListaID INTO @ID
    WHILE @@FETCH_STATUS <> -1 
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        SELECT @Orden = @Orden + 1
        IF @Modulo = 'ST' UPDATE Soporte SET Orden = @Orden WHERE ID = @ID      
      END
      FETCH NEXT FROM crListaID INTO @ID
    END -- While
    CLOSE crListaID
    DEALLOCATE crListaID

   -- DELETE ListaSt WHERE Estacion = @Estacion
  COMMIT TRANSACTION
  RETURN
END
GO
