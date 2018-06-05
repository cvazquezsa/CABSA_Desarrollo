

[Forma]
Clave=CFDIRetencionDIEPS
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=CFDI Retenciones - Información IEPS
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=(Lista)
CarpetaPrincipal=Lista
PosicionInicialIzquierda=223
PosicionInicialArriba=69
PosicionInicialAlturaCliente=551
PosicionInicialAncho=920
Menus=S


ListaCarpetas=Lista



Comentarios=Lista(Info.Mov + <T> <T>+ Info.MovID, Info.Proveedor, Info.Anuncio)
VentanaExclusiva=S
VentanaExclusivaOpcion=2
[Configuracion.DIOTCfg.CalcularBaseImportacion]
Carpeta=Configuracion
Clave=DIOTCfg.CalcularBaseImportacion
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco

Tamano=50




























[Configuracion.DIOTCfg.CxpAnticiposPagadosPeriodo]
Carpeta=Configuracion
Clave=DIOTCfg.CxpAnticiposPagadosPeriodo
Editar=S
LineaNueva=S
3D=S
Tamano=50
ColorFondo=Blanco












EspacioPrevio=S
[Configuracion.DIOTCfg.GASIncluirComprobantes]
Carpeta=Configuracion
Clave=DIOTCfg.GASIncluirComprobantes
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco

Tamano=50






EspacioPrevio=S
[Configuracion.DIOTCfg.GASIncluirMovSinCxp]
Carpeta=Configuracion
Clave=DIOTCfg.GASIncluirMovSinCxp
Editar=S
LineaNueva=S
3D=S
Tamano=50
ColorFondo=Blanco









[Configuracion.DIOTCfg.COMSIVAImportacionAnticipado]
Carpeta=Configuracion
Clave=DIOTCfg.COMSIVAImportacionAnticipado
Editar=S
LineaNueva=S
3D=S
Tamano=50
ColorFondo=Blanco






[Configuracion.ListaEnCaptura]
(Inicio)=DIOTCfg.CalcularBaseImportacion
DIOTCfg.CalcularBaseImportacion=DIOTCfg.COMSIVAImportacionAnticipado
DIOTCfg.COMSIVAImportacionAnticipado=DIOTCfg.CxpAnticiposPagadosPeriodo
DIOTCfg.CxpAnticiposPagadosPeriodo=DIOTCfg.GASIncluirComprobantes
DIOTCfg.GASIncluirComprobantes=DIOTCfg.GASIncluirMovSinCxp
DIOTCfg.GASIncluirMovSinCxp=(Fin)































































[Lista]
Estilo=Iconos
PestanaOtroNombre=S
PestanaNombre=Lista
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CFDIRetencionD
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S











IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Movimiento<T>
ElementosPorPaginaEsp=200
ListaEnCaptura=(Lista)
Filtros=S
FiltroPredefinido=S
FiltroGrupo1=Modulo.Nombre
FiltroValida1=Modulo.Nombre
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroTodo=S
BusquedaRapidaControles=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
FiltroFechasCampo=CFDIRetencionD.FechaEmision
FiltroFechasDefault=Este Mes






MenuLocal=S
IconosSeleccionMultiple=S
ListaAcciones=(Lista)
IconosNombre=CFDIRetencionD:CFDIRetencionD.Mov+<T> <T>+CFDIRetencionD:CFDIRetencionD.MovID
FiltroGeneral=CFDIRetencionD.Empresa = <T>{Empresa}<T><BR>AND CFDIRetencionD.EstacionTrabajo = {EstacionTrabajo}<BR>AND CFDIRetencionD.Modulo = <T>{Info.Modulo}<T><BR>AND CFDIRetencionD.ModuloID = {Info.ID}<BR>AND CFDIRetencionD.Proveedor = <T>{Info.Proveedor}<T><BR>AND CFDIRetencionD.ConceptoSAT = <T>{Info.Anuncio}<T><BR>AND (ISNULL(CFDIRetencionD.EsIEPS, 0) = 1 OR ISNULL(CFDIRetencionD.EsComplemento, 0) = 1)
[Lista.CFDIRetencionD.FechaEmision]
Carpeta=Lista
Clave=CFDIRetencionD.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco



[Lista.CFDIRetencionD.Proveedor]
Carpeta=Lista
Clave=CFDIRetencionD.Proveedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.CFDIRetencionD.Importe]
Carpeta=Lista
Clave=CFDIRetencionD.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Totalizador=0
[Lista.CFDIRetencionD.IVA]
Carpeta=Lista
Clave=CFDIRetencionD.IVA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Totalizador=0

[Lista.Columnas]
0=113
1=81
2=87
3=92
4=70
5=77
6=86
7=87











8=89
9=91
10=102
11=84
12=82
13=98
14=42
15=1273
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
Carpeta=Lista
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S





[Acciones.Preliminar]
Nombre=Preliminar
Boton=6
NombreDesplegar=Presentación Preliminar
EnBarraHerramientas=S
Carpeta=Lista
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S



[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=Enviar a Excel
EnBarraHerramientas=S
Carpeta=Lista
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S











[Lista.CFDIRetencionD.ConceptoClave]
Carpeta=Lista
Clave=CFDIRetencionD.ConceptoClave
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco


























[Lista.CFDIRetencionD.ImportePago]
Carpeta=Lista
Clave=CFDIRetencionD.ImportePago
Editar=S
Totalizador=0
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco










[Lista.CFDIRetencionD.IEPS]
Carpeta=Lista
Clave=CFDIRetencionD.IEPS
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Totalizador=1






[Lista.NumeroPago]
Carpeta=Lista
Clave=NumeroPago
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco


[Lista.CFDIRetencionD.Ok]
Carpeta=Lista
Clave=CFDIRetencionD.Ok
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.CFDIRetencionD.OkRef]
Carpeta=Lista
Clave=CFDIRetencionD.OkRef
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco















[Forma.MenuPrincipal]
(Inicio)=&Configuración
&Configuración=&Pagos
&Pagos=&Maestros
&Maestros=&Gastos
&Gastos=&Herramientas
&Herramientas=(Fin)


































































[Acciones.SeleccionarTodo]
Nombre=SeleccionarTodo
Boton=0
NombreDesplegar=Seleccionar Todo
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Seleccionar Todo
Activo=S
Visible=S

[Acciones.QuitarSeleccion]
Nombre=QuitarSeleccion
Boton=0
NombreDesplegar=Quitar Selección
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Quitar Seleccion
Activo=S
Visible=S

[Acciones.Eliminar]
Nombre=Eliminar
Boton=0
NombreDesplegar=Eliminar IEPS
EnMenu=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Visible=S

Antes=S






EnLote=S











Expresion=EjecutarSQL(<T>EXEC spCFDIRetencionDBorrar :nEstacion, :nRID<T>, EstacionTrabajo, CFDIRetencionD:CFDIRetencionD.RID)<BR><BR>Si SQL(<T>SELECT CASE WHEN COUNT(ID) <= 0 THEN 1 ELSE  0 END FROM ListaID WHERE Estacion = :tEstacion <T>, EstacionTrabajo)<BR>Entonces<BR>  ActualizarForma<BR>  ActualizarVista<BR>  EjecutarSQL(<T>EXEC spCFDIRetencionRecalcEncabezado :nEstacion<T>, EstacionTrabajo)<BR>Fin
AntesExpresiones=RegistrarSeleccionID(<T>Lista<T>)
[Acciones.MostrarCampos]
Nombre=MostrarCampos
Boton=45
NombreDesplegar=&Personalizar Vista
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta Abrir)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

















[Lista.ListaEnCaptura]
(Inicio)=CFDIRetencionD.FechaEmision
CFDIRetencionD.FechaEmision=NumeroPago
NumeroPago=CFDIRetencionD.ImportePago
CFDIRetencionD.ImportePago=CFDIRetencionD.Proveedor
CFDIRetencionD.Proveedor=CFDIRetencionD.ConceptoClave
CFDIRetencionD.ConceptoClave=CFDIRetencionD.Importe
CFDIRetencionD.Importe=CFDIRetencionD.IVA
CFDIRetencionD.IVA=CFDIRetencionD.IEPS
CFDIRetencionD.IEPS=CFDIRetencionD.Ok
CFDIRetencionD.Ok=CFDIRetencionD.OkRef
CFDIRetencionD.OkRef=(Fin)

[Lista.ListaAcciones]
(Inicio)=SeleccionarTodo
SeleccionarTodo=QuitarSeleccion
QuitarSeleccion=Eliminar
Eliminar=(Fin)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=MostrarCampos
MostrarCampos=(Fin)
