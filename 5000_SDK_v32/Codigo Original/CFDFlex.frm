
[Forma]
Clave=CFDFlex
Icono=256
BarraHerramientas=S
Modulos=(Todos)
MovModulo=CFDFlex
Nombre=Si(General.CFDI,<T>Monitor CFDI<T>, <T>Generar CFDI<T>)
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=59
PosicionInicialArriba=90
PosicionInicialAlturaCliente=522
PosicionInicialAncho=1272
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
ListaAcciones=(Lista)
ExpresionesAlMostrar=Asigna(Info.Accion, <T>Todos<T>)
[Lista]
Estilo=Iconos
Clave=Lista
Filtros=S
BusquedaRapidaControles=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CFDFlex
Fuente={Tahoma, 8, Negro, []}
IconosCampo=CFDFlex.Icono
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
ElementosPorPaginaEsp=500
CampoColorLetras=Negro
CampoColorFondo=Blanco
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Múltiple (por grupos)
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
CarpetaVisible=S
ListaEnCaptura=(Lista)

FiltroFechas=S
FiltroFechasCampo=CFDFlex.FechaSinHora
FiltroFechasDefault=Hoy
BusquedaRapida=S
BusquedaEnLinea=S
IconosSubTitulo=<T>Empresa<T>

FiltroGrupo1=CFDFlex.Serie
FiltroValida1=CFDFlex.Serie
FiltroTodo=S
IconosConSenales=S
FiltroEstatus=S
IconosSeleccionMultiple=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=PENDIENTE
IconosConPaginas=S
MenuLocal=S
ListaAcciones=(Lista)
PestanaOtroNombre=S
PestanaNombre=CFDI
FuenteBusqueda={MS Sans Serif, 8, Negro, []}
IconosNombre=CFDFlex:CFDFlex.Empresa
FiltroGeneral={Si 1=1  Entonces <T> CFDFlex.Empresa = <T>+Comillas(Empresa)+<T> AND dbo.fnCFDFlexMonitorVista (CFDFlex.Modulo, CFDFlex.ModuloID, CFDFlex.Empresa) = 1 <T>  Fin}<BR>{SI Info.Accion = <T>Timbrados<T> ENTONCES <T> AND Timbrado = 1<T> SINO <T><T>}<BR>{SI Info.Accion = <T>Cancelados<T> ENTONCES <T> AND Cancelado = 1 <T> SINO <T><T>}<BR>{SI Info.Accion = <T>No Timbrados<T> ENTONCES <T> AND Timbrado = 0<T> SINO <T><T>}
[Lista.CFDFlex.Modulo]
Carpeta=Lista
Clave=CFDFlex.Modulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[Lista.CFDFlex.Fecha]
Carpeta=Lista
Clave=CFDFlex.Fecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco


[Lista.CFDFlex.Serie]
Carpeta=Lista
Clave=CFDFlex.Serie
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.CFDFlex.Folio]
Carpeta=Lista
Clave=CFDFlex.Folio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=5
[Lista.CFDFlex.Importe]
Carpeta=Lista
Clave=CFDFlex.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco



Tamano=5
[Lista.Columnas]
0=74
1=71
2=75
3=61
4=68
5=70
6=76
7=92










8=-2
9=-2
10=-2
11=-2
12=332
13=-2
14=-2
15=-2
16=-2
17=-2
18=-2
[Lista.CFDFlex.RFC]
Carpeta=Lista
Clave=CFDFlex.RFC
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

















[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
NombreDesplegar=&Imprimir
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S


[Acciones.Preeliminar]
Nombre=Preeliminar
Boton=6
NombreDesplegar=&Vista Previa
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S


[Acciones.Excel]
Nombre=Excel
Boton=115
NombreDesplegar=&Excel
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S




[Acciones.Personalizar]
Nombre=Personalizar
Boton=45
NombreDesplegar=&Personalizar Vista
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S





[Lista.CFDFlex.Impuesto1]
Carpeta=Lista
Clave=CFDFlex.Impuesto1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=5
[Lista.CFDFlex.Impuesto2]
Carpeta=Lista
Clave=CFDFlex.Impuesto2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco




[Lista.ImporteTotal]
Carpeta=Lista
Clave=ImporteTotal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco


































[Acciones.Timbrar]
Nombre=Timbrar
Boton=70
NombreDesplegar=&Timbrar CFDI
EnBarraHerramientas=S
EspacioPrevio=S















TipoAccion=Expresion


RefrescarDespues=S
Expresion=RegistrarSeleccionModuloID(<T>Lista<T>,<T>CFDFlex.Modulo<T>,<T>CFDFlex.ModuloID<T> )<BR>ProcesarSQL(<T>spCFDFlexTimbrarCFDILote :nEstacion, :tEmpresa, :tUsuario<T>, EstacionTrabajo, Empresa, Usuario)
ActivoCondicion=(CFDFlex:CFDFlex.Cancelado = 0)<BR>y (CFDFlex:CFDFlex.Timbrado = 0)
VisibleCondicion=General.CFDI
[Lista.CFDFlex.Timbrado]
Carpeta=Lista
Clave=CFDFlex.Timbrado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco










[Lista.CFDFlex.FechaTimbrado]
Carpeta=Lista
Clave=CFDFlex.FechaTimbrado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.CFDFlex.OrigenSerie]
Carpeta=Lista
Clave=CFDFlex.OrigenSerie
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.CFDFlex.OrigenFolio]
Carpeta=Lista
Clave=CFDFlex.OrigenFolio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.CFDFlex.ParcialidadNumero]
Carpeta=Lista
Clave=CFDFlex.ParcialidadNumero
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco






[Acciones.Seleccionar Todo]
Nombre=Seleccionar Todo
Boton=0
NombreDesplegar=Seleccionar Todo
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Seleccionar Todo
Activo=S
Visible=S

[Acciones.Quitar Seleccion]
Nombre=Quitar Seleccion
Boton=0
NombreDesplegar=Quitar Selección
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Quitar Seleccion
Activo=S
Visible=S

[Acciones.PDFIntelisis.Generar]
Nombre=Generar
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S


Expresion=SI (General.CFDI o Empresa.CFD) Entonces<BR>Asigna(Info.Mensaje,<T>No es posible generar PDF revisar configuración del Movimiento<T>)<BR>  Si SQL(<T>spMovReporteIntelisis :tEmpresa, :tModulo, :tMov, :nID, :nAfectar<T>, Empresa, CFDFlex:CFDFlex.Modulo, <T><T>, CFDFlex:CFDFlex.ModuloID, 0) Entonces<BR>    Asigna(Info.Reporte, SQL(<T>spMovFormatoIntelisis :tEmpresa, :tModulo, :tMov, :nID<T>, Empresa, CFDFlex:CFDFlex.Modulo, <T><T>, CFDFlex:CFDFlex.ModuloID))<BR>    Asigna(Info.Ruta, SQL(<T>spMovRutaIntelisis :tEmpresa, :tModulo, :tMov, :nID<T>, Empresa,CFDFlex:CFDFlex.Modulo,<T><T>, CFDFlex:CFDFlex.ModuloID))<BR>    ReportePDF(Info.Reporte,CFDFlex:CFDFlex.ModuloID,Info.Ruta)<BR>    EjecutarSQL(<T>spMovEnviarIntelisis :tEmpresa,:tModulo,:tMov,:nID<T>,Empresa, CFDFlex:CFDFlex.Modulo, <T><T>, CFDFlex:CFDFlex.ModuloID)<BR>    Asigna(Info.Mensaje,<T>Proceso Concluido<T>)<BR>  Fin<BR>Informacion(Info.Mensaje)<BR>Fin

[Lista.CFDFlex.Cancelado]
Carpeta=Lista
Clave=CFDFlex.Cancelado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco


[Acciones.Cancelar]
Nombre=Cancelar
Boton=0
NombreDesplegar=Cancelar Movimiento y Timbre
RefrescarIconos=S
EnLote=S
EnMenu=S
TipoAccion=Expresion























Expresion=Cancelar(CFDFlex:CFDFlex.Modulo, CFDFlex:CFDFlex.ModuloID, CFDFlex:CFDFlex.Mov, CFDFlex:CFDFlex.MovID, <T>TODO<T>, <T><T>, <T>ProcesarVenta<T>)<BR> Si CFDFlex:CFDFlex.Cancelado = 1 entonces<BR>  EjecutarSQL(<T>spCancelarCFD :tModulo, :nID<T>,CFDFlex:CFDFlex.Modulo, CFDFlex:CFDFlex.ModuloID )<BR> Fin
ActivoCondicion=PuedeAfectar(Usuario.Cancelar, Usuario.CancelarOtrosMovs,Usuario) y ConDatos(CFDFlex:CFDFlex.ModuloID) y ConDatos(CFDFlex:CFDFlex.MovID) y CFDFlex:CFDFlex.Cancelado = 0
VisibleCondicion=CFDFlex:CFDFlex.Timbrado
[Lista.CFDFlex.RutaAcuse]
Carpeta=Lista
Clave=CFDFlex.RutaAcuse
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco









































[Acciones.Acuse.Refrescar]
Nombre=Refrescar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S






[Acciones.Acuse.RutaAcuse]
Nombre=RutaAcuse
Boton=0
TipoAccion=Formas
ClaveAccion=RutaAcuse
Activo=S
Visible=S



















[Acciones.Acuse.ListaAccionesMultiples]
(Inicio)=RutaAcuse
RutaAcuse=Refrescar
Refrescar=(Fin)


[Lista.CFDFlex.OrigenUUID]
Carpeta=Lista
Clave=CFDFlex.OrigenUUID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=16
ColorFondo=Blanco

[Lista.CFDFlex.UUIDTexto]
Carpeta=Lista
Clave=CFDFlex.UUIDTexto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco





















































































































































































[Acciones.PDFIntelisis.ListaAccionesMultiples]
(Inicio)=Generar
Generar=Refrescar
Refrescar=(Fin)














[Acciones.GeneraXML]
Nombre=GeneraXML
Boton=0
NombreDesplegar=Recuperar Archivo XML de BD
EnMenu=S
TipoAccion=Expresion




























RefrescarIconos=S
EnLote=S
Expresion=Si CFDFlex:CFDFlex.Timbrado = true<BR>Entonces<BR>  Asigna(Info.Ruta, SQL(<T>spCFDRutaArchivos :tEmpresa, :tModulo, :tMov,:bRutaCancelacion, :nID<T>, Empresa,CFDFlex:CFDFlex.Modulo,CFDFlex:CFDFlex.Mov,0, CFDFlex:CFDFlex.ModuloID))<BR>  Si Vacio(Info.Ruta)<BR>  Entonces<BR>     Informacion(<T>La ruta de Almacenamiento no existe<T>)<BR>  Sino<BR>     Directorio.Verificar(Info.Ruta,Verdadero)<BR>     Asigna(Info.Ruta, SQL(<T>spCFDRutaArchivos :tEmpresa, :tModulo, :tMov,:bRutaCancelacion, :nID,:tTipo<T>, Empresa,CFDFlex:CFDFlex.Modulo,CFDFlex:CFDFlex.Mov,0, CFDFlex:CFDFlex.ModuloID,<T>XML<T>))<BR>     EjecutarSQL(<T>spCFDIRegenerarXml :tEmpresa, :tMov, :tModuloId, :tModulo, :tRuta, :bAcuse<T>,Empresa,CFDFlex:CFDFlex.Mov,CFDFlex:CFDFlex.ModuloID,CFDFlex:CFDFlex.Modulo,Info.Ruta,0)<BR>     Informacion(<T>Proceso Concluido<T>)<BR>  Fin<BR>Sino<BR>   informacion(<T>No es posible generar XML, porque el movimiento no esta timbrado.<T>)<BR>Fin
ActivoCondicion=CFDFlex:CFDFlex.Cancelado = 0
VisibleCondicion=CFDFlex:CFDFlex.Timbrado
[Acciones.CrearPDF]
Nombre=CrearPDF
Boton=97
NombreDesplegar=Genera PDF
EnBarraHerramientas=S
TipoAccion=Expresion










RefrescarDespues=S
Antes=S
Visible=S
Expresion=Si    CFDFlex:CFDFlex.Timbrado = true<BR>entonces<BR>Si<BR> Empresa.CFD<BR>Entonces<BR>  CFD.Enviar(CFDFlex:CFDFlex.Modulo,CFDFlex:CFDFlex.ModuloID)<BR>Sino<BR> RegistrarSeleccionModuloID(<T>Lista<T>,<T>CFDFlex.Modulo<T>,<T>CFDFlex.ModuloID<T> )<BR> EjecutarSQL(<T>spCFDFlexGenerarPDFS :nEstacion, :tEmpresa, :tUsuario<T>, EstacionTrabajo, Empresa, Usuario)<BR>Fin<BR>sino informacion(<T>El movimiento debe estar timbrado<T>)fin
ActivoCondicion=SQL(<T>SELECT CASE WHEN Reporteador = :tReporteador THEN 1 WHEN Reporteador = :tReporteador2 THEN 1 ELSE 0 END FROM EmpresaCFD WHERE Empresa=:tEmpresa<T>,<T>Jasper Reports<T>,<T>Report Builder<T>,Empresa)<BR>y (CFDFlex:CFDFlex.Cancelado = 0)
[Acciones.Reenviar]
Nombre=Reenviar
Boton=84
NombreDesplegar=Reenviar Correo
EnBarraHerramientas=S
TipoAccion=Expresion
Visible=S


Antes=S
RefrescarDespues=S
Expresion=RegistrarSeleccionModuloID(<T>Lista<T>,<T>CFDFlex.Modulo<T>, <T>CFDFlex.ModuloID<T>)<BR>EjecutarSQL(<T>spMovEnviarIntelisisMonitor  :nEstacion,:tEmpresa,:tMov<T>,EstacionTrabajo,Empresa, <T><T>)<BR><BR>EjecutarSQL(<T>EXEC spCFDIBorrarListaID :tModulo, :nID, :nEstacion<T>,CFDFlex:CFDFlex.Modulo, CFDFlex:CFDFlex.ModuloID,  EstacionTrabajo )<BR>SI Vacio(SQL(<T>SELECT top 1 ID FROM ListaModuloID WHERE Estacion = :nEstacion<T>, EstacionTrabajo))<BR>Entonces<BR>Informacion(<T>Proceso Concluido<T>)<BR>Fin
ActivoCondicion=CFDFlex:CFDFlex.Cancelado = 0<BR>y CFDFlex:CFDFlex.Timbrado
AntesExpresiones=RegistrarSeleccionModuloID(<T>Lista<T>,<T>CFDFlex.Modulo<T>, <T>CFDFlex.ModuloID<T>)
[Acciones.CrearXML]
Nombre=CrearXML
Boton=124
NombreDesplegar=Crear XML
EnBarraHerramientas=S
TipoAccion=Expresion















Visible=S
RefrescarDespues=S
Expresion=Si CFDFlex:CFDFlex.Timbrado = true<BR>Entonces<BR>RegistrarSeleccionModuloID(<T>Lista<T>,<T>CFDFlex.Modulo<T>, <T>CFDFlex.ModuloID<T>)<BR><BR>EjecutarSQL(<T>spMovXMLIntelisisMonitor  :nEstacion<T>,EstacionTrabajo)<BR><BR>SI Vacio(SQL(<T>SELECT top 1 ID FROM ListaModuloID WHERE Estacion = :nEstacion<T>, EstacionTrabajo))<BR>Entonces<BR>Informacion(<T>Proceso Concluido<T>)<BR>Fin<BR>sino informacion(<T>El movimiento debe estar timbrado<T>)
ActivoCondicion=CFDFlex:CFDFlex.Cancelado = 0
[Acciones.Enviar Correo]
Nombre=Enviar Correo
Boton=0
NombreDesplegar=Envia Correo
RefrescarIconos=S
EnMenu=S
TipoAccion=Expresion
Antes=S


Expresion=EjecutarSQL(<T>spMovEnviarIntelisis :tEmpresa,:tModulo,:tMov,:nID<T>,Empresa, CFDFlex:CFDFlex.Modulo, <T><T>, CFDFlex:CFDFlex.ModuloID)<BR>EjecutarSQL(<T>EXEC spCFDIBorrarListaID :tModulo, :nID, :nEstacion<T>,CFDFlex:CFDFlex.Modulo, CFDFlex:CFDFlex.ModuloID,  EstacionTrabajo )<BR>SI Vacio(SQL(<T>SELECT top 1 ID FROM ListaModuloID WHERE Estacion = :nEstacion<T>, EstacionTrabajo))<BR>Entonces<BR>  Informacion(<T>Proceso Concluido<T>)<BR>Fin
Activo=S
AntesExpresiones=RegistrarSeleccionModuloID(<T>Lista<T>,<T>CFDFlex.Modulo<T>, <T>CFDFlex.ModuloID<T>)
VisibleCondicion=(CFDFlex:CFDFlex.Cancelado = 0) y (CFDFlex:CFDFlex.Timbrado)
[Acciones.GenerarPDF Intelisis]
Nombre=GenerarPDF Intelisis
Boton=0
NombreDesplegar=Generar PDF
RefrescarDespues=S
EnMenu=S
TipoAccion=Expresion

RefrescarIconos=S
EnLote=S
Expresion=Si CFDFlex:CFDFlex.Timbrado = true<BR>Entonces<BR>   SI (General.CFDI o Empresa.CFD) Entonces<BR>      Asigna(Info.Mensaje,<T>No es posible generar PDF revisar configuración del Movimiento<T>)<BR>   Si SQL(<T>spMovReporteIntelisis :tEmpresa, :tModulo, :tMov, :nID, :nAfectar<T>, Empresa, CFDFlex:CFDFlex.Modulo, <T><T>, CFDFlex:CFDFlex.ModuloID, 0) Entonces<BR>      Asigna(Info.Reporte, SQL(<T>spMovFormatoIntelisis :tEmpresa, :tModulo, :tMov, :nID<T>, Empresa, CFDFlex:CFDFlex.Modulo, <T><T>, CFDFlex:CFDFlex.ModuloID))<BR>      Asigna(Info.Ruta, SQL(<T>spMovRutaIntelisis :tEmpresa, :tModulo, :tMov, :nID<T>, Empresa,CFDFlex:CFDFlex.Modulo,<T><T>, CFDFlex:CFDFlex.ModuloID))<BR>      ReportePDF(Info.Reporte,CFDFlex:CFDFlex.ModuloID,Info.Ruta)<BR>      Asigna(Info.Mensaje,<T>Proceso Concluido<T>)<BR>   Fin<BR>  Informacion(Info.Mensaje)<BR>  Fin<BR>Sino<BR>  Asigna(Info.Mensaje,<T>No es posible generar PDF, porque el movimiento no esta timbrado.<T>)<BR>  Informacion(Info.Mensaje)<BR>Fin
ActivoCondicion=CFDFlex:CFDFlex.Cancelado = 0
VisibleCondicion=SQL(<T>SELECT CASE WHEN Reporteador = :tReporteador THEN 1 ELSE 0 END FROM EmpresaCFD WHERE Empresa=:tEmpresa<T>,<T>Reporteador Intelisis<T>,Empresa)<BR>y CFDFlex:CFDFlex.Timbrado
[Acciones.GenerarPDF Jasper]
Nombre=GenerarPDF Jasper
Boton=0
NombreDesplegar=Generar PDF
EnMenu=S
TipoAccion=Expresion

RefrescarIconos=S
Expresion=Asigna(Temp.Num,1)<BR>Si  CFDFlex:CFDFlex.Timbrado  <> True  entonces   Asigna(Temp.Num,0) Asigna(Temp.Texto, <T>no esta timbrado.<T>)  Fin<BR>Si  CFDFlex:CFDFlex.Cancelado = True  entonces   Asigna(Temp.Num,0) Asigna(Temp.Texto, <T>esta cancelado.<T>)  Fin<BR><BR>Si  Temp.Num = 1  entonces<BR> Si Empresa.CFD<BR> Entonces<BR>  CFD.Enviar(CFDFlex:CFDFlex.Modulo,CFDFlex:CFDFlex.ModuloID)<BR> Sino<BR>  RegistrarSeleccionModuloID(<T>Lista<T>,<T>CFDFlex.Modulo<T>,<T>CFDFlex.ModuloID<T> )<BR>  ProcesarSQL(<T>spCFDFlexGenerarPDFS :nEstacion, :tEmpresa, :tUsuario<T>, EstacionTrabajo, Empresa, Usuario)<BR> Fin<BR>Sino<BR>  Asigna(Info.Mensaje,<T>No es posible generar PDF, porque el movimiento <T>+Temp.Texto)<BR>  Informacion(Info.Mensaje)<BR>Fin
ActivoCondicion=CFDFlex:CFDFlex.Cancelado = 0
VisibleCondicion=SQL(<T>SELECT CASE WHEN Reporteador = :tReporteador THEN 1 ELSE 0 END FROM EmpresaCFD WHERE Empresa=:tEmpresa<T>,<T>Jasper Reports<T>,Empresa)<BR>y CFDFlex:CFDFlex.Timbrado
[Acciones.GenerarPDF Builder]
Nombre=GenerarPDF Builder
Boton=0
NombreDesplegar=Generar PDF
EnMenu=S
TipoAccion=Expresion

























































































RefrescarIconos=S






Expresion=Si CFDFlex:CFDFlex.Timbrado = true<BR>Entonces<BR> Si Empresa.CFD<BR> Entonces<BR>  CFD.Enviar(CFDFlex:CFDFlex.Modulo,CFDFlex:CFDFlex.ModuloID)<BR> Sino<BR>  RegistrarSeleccionModuloID(<T>Lista<T>,<T>CFDFlex.Modulo<T>,<T>CFDFlex.ModuloID<T> )<BR>  ProcesarSQL(<T>spCFDFlexGenerarPDFS :nEstacion, :tEmpresa, :tUsuario<T>, EstacionTrabajo, Empresa, Usuario)<BR> Fin<BR>Sino<BR>  Asigna(Info.Mensaje,<T>No es posible generar PDF, porque el movimiento no esta timbrado.<T>)<BR>  Informacion(Info.Mensaje)<BR>Fin
ActivoCondicion=CFDFlex:CFDFlex.Cancelado = 0
VisibleCondicion=SQL(<T>SELECT CASE WHEN Reporteador = :tReporteador THEN 1 ELSE 0 END FROM EmpresaCFD WHERE Empresa=:tEmpresa<T>,<T>Report Builder<T>,Empresa)<BR>y CFDFlex:CFDFlex.Timbrado
[Acciones.Generar CFDI]
Nombre=Generar CFDI
Boton=0
NombreDesplegar=Generar CFDI (timbrar), PDF y Envio
RefrescarIconos=S
EnMenu=S
TipoAccion=Expresion
Antes=S








EnLote=S
Expresion=Si CFDFlex:CFDFlex.Timbrado = TRUE<BR>Entonces<BR> Asigna(Info.Ruta, SQL(<T>spCFDRutaArchivos :tEmpresa, :tModulo, :tMov,:bRutaCancelacion, :nID<T>, Empresa,CFDFlex:CFDFlex.Modulo,CFDFlex:CFDFlex.Mov,0, CFDFlex:CFDFlex.ModuloID))<BR> Si Vacio(Info.Ruta)<BR>  Entonces<BR>     Informacion(<T>La ruta de Almacenamiento no existe<T>)<BR>  Sino<BR>     Directorio.Verificar(Info.Ruta,Verdadero)<BR>     Asigna(Info.Ruta, SQL(<T>spCFDRutaArchivos :tEmpresa, :tModulo, :tMov,:bRutaCancelacion, :nID,:tTipo<T>, Empresa,CFDFlex:CFDFlex.Modulo,CFDFlex:CFDFlex.Mov,0, CFDFlex:CFDFlex.ModuloID,<T>XML<T>))<BR>    EjecutarSQL(<T>spCFDIRegenerarXml :tEmpresa, :tMov, :tModuloId, :tModulo, :tRuta<T>,Empresa,CFDFlex:CFDFlex.Mov,CFDFlex:CFDFlex.ModuloID,CFDFlex:CFDFlex.Modulo,Info.Ruta)<BR>     Informacion(<T>Proceso Concluido<T>)<BR>  Fin<BR>Sino<BR>  Si SQL(<T>SELECT ISNULL(eDoc, 0) FROM EmpresaGral WHERE ISNULL(eDoc, 0) = 1 AND ISNULL(CFDFlex, 0) =1 AND Empresa = :tEmpresa<T>, Empresa)= TRUE<BR>   Entonces<BR>      // SQL(<T>EXEC spRegenerarCFDFlex :nEstacion, :tEmpresa, :tModulo, :nID, :tEstatus<T>, EstacionTrabajo, Empresa, CFDFlex:CFDFlex.Modulo, CFDFlex:CFDFlex.ModuloID,<T>CONCLUIDO<T>)<BR>       ProcesarSQL(<T>EXEC spRegenerarCFDFlex :nEstacion, :tEmpresa, :tModulo, :nID, :tEstatus<T>, EstacionTrabajo, Empresa, CFDFlex:CFDFlex.Modulo, CFDFlex:CFDFlex.ModuloID,<T>CONCLUIDO<T> )<BR><BR>          Si SQL(<T>spMovReporteIntelisis :tEmpresa, :tModulo, :tMov, :nID, :nAfectar<T>, Empresa, CFDFlex:CFDFlex.Modulo, <T><T>, CFDFlex:CFDFlex.ModuloID, 0) Entonces<BR>            Asigna(Info.Reporte, SQL(<T>spMovFormatoIntelisis :tEmpresa, :tModulo, :tMov, :nID<T>, Empresa, CFDFlex:CFDFlex.Modulo, <T><T>, CFDFlex:CFDFlex.ModuloID))<BR>            Asigna(Info.Ruta, SQL(<T>spMovRutaIntelisis :tEmpresa, :tModulo, :tMov, :nID<T>, Empresa,CFDFlex:CFDFlex.Modulo,<T><T>, CFDFlex:CFDFlex.ModuloID))<BR>            ReportePDF(Info.Reporte,CFDFlex:CFDFlex.ModuloID,Info.Ruta)<BR>            EjecutarSQL(<T>spMovEnviarIntelisis :tEmpresa,:tModulo,:tMov,:nID<T>,Empresa, CFDFlex:CFDFlex.Modulo, <T><T>, CFDFlex:CFDFlex.ModuloID)<BR>          Fin<BR>      // EjecutarSQL(<T>spMovEnviarIntelisis :tEmpresa,:tModulo,:tMov,:nID<T>,Empresa, CFDFlex:CFDFlex.Modulo, <T><T>, CFDFlex:CFDFlex.ModuloID)<BR>   Fin<BR>  EjecutarSQL(<T>EXEC spCFDIBorrarListaID :tModulo, :nID, :nEstacion<T>,CFDFlex:CFDFlex.Modulo, CFDFlex:CFDFlex.ModuloID,  EstacionTrabajo )<BR>  SI Vacio(SQL(<T>SELECT top 1 ID FROM ListaModuloID WHERE Estacion = :nEstacion<T>, EstacionTrabajo))<BR>  Entonces<BR>     Informacion(<T>Proceso Concluido<T>)<BR>  Fin<BR>Fin
ActivoCondicion=CFDFlex:CFDFlex.Cancelado = 0
AntesExpresiones=RegistrarSeleccionModuloID(<T>Lista<T>,<T>CFDFlex.Modulo<T>, <T>CFDFlex.ModuloID<T>)
VisibleCondicion=CFDFlex:CFDFlex.Timbrado = 0
[Acciones.Timbrados]
Nombre=Timbrados
Boton=71
NombreEnBoton=S
NombreDesplegar=Timbrados
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Visible=S

Antes=S






ActivoCondicion=Info.Accion <> <T>Timbrados<T>
AntesExpresiones=Asigna(Info.Accion, <T>Timbrados<T>)





[Acciones.NoTimbrados]
Nombre=NoTimbrados
Boton=71
NombreEnBoton=S
NombreDesplegar=No Timbrados
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Visible=S




ActivoCondicion=Info.Accion <> <T>No Timbrados<T>     
Antes=S
AntesExpresiones=Asigna(Info.Accion,  <T>No Timbrados<T> )
[Acciones.Cancelados]
Nombre=Cancelados
Boton=71
NombreEnBoton=S
NombreDesplegar=Cancelados
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Visible=S


Antes=S
ActivoCondicion=Info.Accion <>  <T>Cancelados<T>
AntesExpresiones=Asigna(Info.Accion,  <T>Cancelados<T> )
[Acciones.Todos]
Nombre=Todos
Boton=71
NombreEnBoton=S
NombreDesplegar=Todos
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Visible=S































ActivoCondicion=Info.Accion <>  <T>Todos<T> 
Antes=S
AntesExpresiones=Asigna(Info.Accion,   <T>Todos<T> )


































































































































































































































































































[Acciones.AcuseCancelacion]
Nombre=AcuseCancelacion
Boton=0
NombreDesplegar=Recuperar Acuse de timbrado cancelado
EnMenu=S
TipoAccion=Expresion
Activo=S

EnLote=S
















RefrescarIconos=S












Expresion=Si CFDFlex:CFDFlex.Timbrado = true<BR>Entonces<BR>  Asigna(Info.Ruta, SQL(<T>spCFDRutaArchivos :tEmpresa, :tModulo, :tMov,:bRutaCancelacion, :nID <T>, Empresa,CFDFlex:CFDFlex.Modulo,CFDFlex:CFDFlex.Mov,1, CFDFlex:CFDFlex.ModuloID))<BR>  Si Vacio(Info.Ruta)<BR>  Entonces<BR>     Informacion(<T>La ruta de Almacenamiento no existe<T>)<BR>  Sino<BR>     Directorio.Verificar(Info.Ruta,Verdadero)<BR>     Asigna(Info.Ruta, SQL(<T>spCFDRutaArchivos :tEmpresa, :tModulo, :tMov,:bRutaCancelacion, :nID,:tTipo<T>, Empresa,CFDFlex:CFDFlex.Modulo,CFDFlex:CFDFlex.Mov,1, CFDFlex:CFDFlex.ModuloID,<T>XML<T>))<BR>     EjecutarSQL(<T>spCFDIRegenerarXml :tEmpresa, :tMov, :tModuloId, :tModulo, :tRuta, :bAcuse<T>,Empresa,CFDFlex:CFDFlex.Mov,CFDFlex:CFDFlex.ModuloID,CFDFlex:CFDFlex.Modulo,Info.Ruta,1)<BR>     Informacion(<T>Proceso Concluido<T>)<BR>  Fin<BR>Sino<BR>   informacion(<T>No es posible generar XML de acuse, porque el movimiento no fue timbrado.<T>)<BR>Fin
VisibleCondicion=CFDFlex:CFDFlex.Cancelado
[Acciones.CancelarTimbre]
Nombre=CancelarTimbre
Boton=0
NombreDesplegar=Cancelar Timbre
RefrescarIconos=S
EnMenu=S
TipoAccion=Expresion





























































































































Expresion=//SI (CFDFlex:CFDFlex.Timbrado=1) ENTONCES<BR><BR>// EjecutarSQL(<T>spCFDICancelacion :tModulo, :nID, :tEstatus, :tEmpresa, :tSucursal<T>,CFDFlex:CFDFlex.Modulo, CFDFlex:CFDFlex.ModuloID,<T>CANCELADO<T>,empresa,sucursal)<BR> ProcesarSQL(<T>spCFDICancelacion :tModulo, :nID, :tEstatus, :tEmpresa, :tSucursal<T>,CFDFlex:CFDFlex.Modulo, CFDFlex:CFDFlex.ModuloID,<T>CANCELADO<T>,empresa,sucursal  )<BR>//FIN
ActivoCondicion=no CFDFlex:CFDFlex.Cancelado
VisibleCondicion=CFDFlex:CFDFlex.Timbrado
















[Lista.ListaEnCaptura]
(Inicio)=CFDFlex.Modulo
CFDFlex.Modulo=CFDFlex.Fecha
CFDFlex.Fecha=CFDFlex.Serie
CFDFlex.Serie=CFDFlex.Folio
CFDFlex.Folio=CFDFlex.RFC
CFDFlex.RFC=CFDFlex.Importe
CFDFlex.Importe=CFDFlex.Impuesto1
CFDFlex.Impuesto1=CFDFlex.Impuesto2
CFDFlex.Impuesto2=ImporteTotal
ImporteTotal=CFDFlex.Timbrado
CFDFlex.Timbrado=CFDFlex.Cancelado
CFDFlex.Cancelado=CFDFlex.RutaAcuse
CFDFlex.RutaAcuse=CFDFlex.FechaTimbrado
CFDFlex.FechaTimbrado=CFDFlex.OrigenSerie
CFDFlex.OrigenSerie=CFDFlex.OrigenFolio
CFDFlex.OrigenFolio=CFDFlex.ParcialidadNumero
CFDFlex.ParcialidadNumero=CFDFlex.OrigenUUID
CFDFlex.OrigenUUID=CFDFlex.UUIDTexto
CFDFlex.UUIDTexto=(Fin)

[Lista.FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=PENDIENTE
PENDIENTE=CONCLUIDO
CONCLUIDO=CANCELADO
CANCELADO=(Fin)

[Lista.ListaAcciones]
(Inicio)=Seleccionar Todo
Seleccionar Todo=Quitar Seleccion
Quitar Seleccion=Generar CFDI
Generar CFDI=GenerarPDF Intelisis
GenerarPDF Intelisis=GenerarPDF Jasper
GenerarPDF Jasper=GenerarPDF Builder
GenerarPDF Builder=Enviar Correo
Enviar Correo=GeneraXML
GeneraXML=Cancelar
Cancelar=AcuseCancelacion
AcuseCancelacion=CancelarTimbre
CancelarTimbre=(Fin)



[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Preeliminar
Preeliminar=Excel
Excel=Personalizar
Personalizar=Timbrar
Timbrar=CrearPDF
CrearPDF=Reenviar
Reenviar=CrearXML
CrearXML=Timbrados
Timbrados=NoTimbrados
NoTimbrados=Cancelados
Cancelados=Todos
Todos=(Fin)
