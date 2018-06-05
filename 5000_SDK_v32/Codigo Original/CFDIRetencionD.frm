

[Forma]
Clave=CFDIRetencionD
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=CFDI Retenciones
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=(Lista)
CarpetaPrincipal=Lista
PosicionInicialIzquierda=204
PosicionInicialArriba=70
PosicionInicialAlturaCliente=550
PosicionInicialAncho=958
Menus=S


ListaCarpetas=Lista
ExpresionesAlMostrar=EjecutarSQL(<T>EXEC spCFDIRetencionBorrar :nEstacion<T>, EstacionTrabajo)
MenuPrincipal=(Lista)
[Acciones.ClavesPagos]
Nombre=ClavesPagos
Boton=30
NombreEnBoton=S
Menu=&Pagos
NombreDesplegar=&Claves de Afectación Pagos
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=CFDIRetPagoClave
Activo=S














[Acciones.ExcepcionarPagos]
Nombre=ExcepcionarPagos
Boton=0
NombreDesplegar=&Excepcionar Pagos
EnMenu=S
TipoAccion=Formas
ClaveAccion=CFDIRetPagoExcepcion
Activo=S





Menu=&Pagos













EspacioPrevio=S
[Acciones.AdicionarPagos]
Nombre=AdicionarPagos
Boton=0
NombreDesplegar=&Adicionar Pagos
EnMenu=S
TipoAccion=Formas
ClaveAccion=CFDIRetPagoAdicion
Activo=S





Menu=&Pagos












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
Vista=CFDIRetencion
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
FiltroTipo=Múltiple (por Grupos)
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
FiltroFechas=S
FiltroSucursales=S
FiltroFechasCampo=CFDIRetencion.FechaEmision
FiltroFechasDefault=Este Mes
MenuLocal=S
ListaAcciones=(Lista)
IconosSeleccionMultiple=S
IconosNombre=CFDIRetencion:CFDIRetencion.Mov+<T> <T>+CFDIRetencion:CFDIRetencion.MovID
FiltroGeneral=CFDIRetencion.Empresa = <T>{Empresa}<T> AND CFDIRetencion.EstacionTrabajo = {EstacionTrabajo}
[Acciones.CFDIRetSATRetencion]
Nombre=CFDIRetSATRetencion
Boton=0
Menu=&Maestros
NombreDesplegar=SAT -Tipos de Retenciones
EnMenu=S
TipoAccion=Formas
ClaveAccion=CFDIRetSATRetencion
Activo=S
Visible=S





[Acciones.CFDIRetSATDividendo]
Nombre=CFDIRetSATDividendo
Boton=0
Menu=&Maestros
NombreDesplegar=SAT - Dividendos
EnMenu=S
TipoAccion=Formas
ClaveAccion=CFDIRetSATDividendo
Activo=S
Visible=S



[Acciones.CFDIRetSATTipoContribuyente]
Nombre=CFDIRetSATTipoContribuyente
Boton=0
Menu=&Maestros
NombreDesplegar=SAT - Tipos de Contribuyente
EnMenu=S
TipoAccion=Formas
ClaveAccion=CFDIRetSATTipoContribuyente
Activo=S
Visible=S



[Acciones.CFDIRetSATPais]
Nombre=CFDIRetSATPais
Boton=0
Menu=&Maestros
NombreDesplegar=SAT - Países
EnMenu=S
TipoAccion=Formas
ClaveAccion=CFDIRetSATPais
Activo=S
Visible=S



[Acciones.CFDIRetSATEstado]
Nombre=CFDIRetSATEstado
Boton=0
NombreDesplegar=SAT - Estados
EnMenu=S
TipoAccion=Formas
ClaveAccion=CFDIRetSATEstado
Activo=S
Visible=S



Menu=&Maestros
[Acciones.CFDIRetSATTipoImpuesto]
Nombre=CFDIRetSATTipoImpuesto
Boton=0
NombreDesplegar=SAT - Tipos de Impuesto
EnMenu=S
TipoAccion=Formas
ClaveAccion=CFDIRetSATTipoImpuesto
Activo=S
Visible=S









Menu=&Maestros























[Lista.CFDIRetencion.FechaEmision]
Carpeta=Lista
Clave=CFDIRetencion.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco



[Lista.CFDIRetencion.Proveedor]
Carpeta=Lista
Clave=CFDIRetencion.Proveedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.CFDIRetencion.Importe]
Carpeta=Lista
Clave=CFDIRetencion.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Totalizador=1
[Lista.CFDIRetencion.IVA]
Carpeta=Lista
Clave=CFDIRetencion.IVA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Totalizador=1
[Lista.CFDIRetencion.Retencion2]
Carpeta=Lista
Clave=CFDIRetencion.Retencion2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco



Totalizador=1
[Lista.Columnas]
0=126
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
11=36
12=569
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



[Acciones.Calcular]
Nombre=Calcular
Boton=20
NombreEnBoton=S
NombreDesplegar=&Calcular
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Visible=S







Expresion=Si Forma(<T>CFDIRetEspecificarFechas<T>)<BR>Entonces<BR>  Informacion(SQL(<T>EXEC spCFDIRetencionCalc :nEstacion, :tEmpresa, :tFechaD, :tFechaA, :tProveedor<T>, EstacionTrabajo, Empresa, FechaFormatoServidor(Info.FechaD), FechaFormatoServidor(Info.FechaA), Info.Proveedor))<BR>  ActualizarVista<BR>  ActualizarForma<BR>   Forma.ActualizarArbol(<T>Lista<T>)             <BR>Fin
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









[Acciones.Afectar]
Nombre=Afectar
Boton=7
NombreDesplegar=Afectar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Visible=S


























ConfirmarAntes=S
Expresion=RegistrarSeleccionModuloID(<T>Lista<T>,<T>CFDIRetencion.ConceptoSAT<T>, <T>CFDIRetencion.ModuloID<T>)Informacion(SQL(<T>EXEC spCFDIRetencionAfectar :nEstacion, :tEmpresa, :nSucursal, :tUsuario<T>, EstacionTrabajo, Empresa, Sucursal, Usuario))<BR>ActualizarVista<BR>ActualizarForma<BR>Forma.ActualizarArbol(<T>Lista<T>)
[Lista.CFDIRetencion.Retencion1]
Carpeta=Lista
Clave=CFDIRetencion.Retencion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco



Totalizador=1












[Acciones.CFDIRetGastoAdicion]
Nombre=CFDIRetGastoAdicion
Boton=0
Menu=&Gastos
NombreDesplegar=Adicionar Gastos sin Cxp
EnMenu=S
TipoAccion=Formas
ClaveAccion=CFDIRetGastoAdicion
Activo=S





















[Acciones.CFDIRetencionCfg]
Nombre=CFDIRetencionCfg
Boton=0
Menu=&Configuración
NombreDesplegar=General
EnMenu=S
TipoAccion=Formas
ClaveAccion=CFDIRetencionCfg
Activo=S
Visible=S

































EspacioPrevio=S
[Acciones.CFDIRetencionConcepto]
Nombre=CFDIRetencionConcepto
Boton=0
Menu=&Configuración
NombreDesplegar=Conceptos
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=CFDIRetencionConcepto
Activo=S
Visible=S





[Acciones.CFDIRetencionArt]
Nombre=CFDIRetencionArt
Boton=0
Menu=&Configuración
NombreDesplegar=Artículos
EnMenu=S
TipoAccion=Formas
ClaveAccion=CFDIRetencionArt
Activo=S
Visible=S










[Lista.CFDIRetencion.ConceptoSAT]
Carpeta=Lista
Clave=CFDIRetencion.ConceptoSAT
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco





[Acciones.CFDIRetencionXMLPlantilla]
Nombre=CFDIRetencionXMLPlantilla
Boton=0
Menu=&Configuración
NombreDesplegar=Plantilla XML
EnMenu=S
TipoAccion=Formas
ClaveAccion=CFDIRetencionXMLPlantilla
Activo=S
Visible=S




































EspacioPrevio=S
[Lista.CFDIRetencion.IEPS]
Carpeta=Lista
Clave=CFDIRetencion.IEPS
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Totalizador=1




[Acciones.CFDIRetencionImpuestoTipo]
Nombre=CFDIRetencionImpuestoTipo
Boton=0
Menu=&Configuración
NombreDesplegar=Tipos de Impuestos
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=CFDIRetencionImpuestoTipo
Activo=S
Visible=S





























[Acciones.CFDIRetencionEmpresa]
Nombre=CFDIRetencionEmpresa
Boton=0
Menu=&Configuración
NombreDesplegar=Timbrado
EnMenu=S
TipoAccion=Formas
ClaveAccion=CFDIRetencionEmpresa
Activo=S
Visible=S

















[Acciones.MovPropiedades]
Nombre=MovPropiedades
Boton=47
NombreEnBoton=S
NombreDesplegar=&Movimiento
TipoAccion=Formas
ClaveAccion=MovPropiedades
Activo=S
Antes=S
Visible=S

























EspacioPrevio=S






EnBarraHerramientas=S
ConCondicion=S

EjecucionCondicion=ConDatos(CFDIRetencion:CFDIRetencion.ModuloID)
AntesExpresiones=Asigna(Info.Modulo, CFDIRetencion:CFDIRetencion.Modulo)<BR>Asigna(Info.ID, CFDIRetencion:CFDIRetencion.ModuloID)

[Lista.Prov.RFC]
Carpeta=Lista
Clave=Prov.RFC
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco












































[Acciones.CFDIRetencionPais]
Nombre=CFDIRetencionPais
Boton=0
Menu=&Configuración
NombreDesplegar=Países
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=CFDIRetencionPais
Activo=S
Visible=S

















































































































[Acciones.CFDIRetencionRegenerar]
Nombre=CFDIRetencionRegenerar
Boton=0
Menu=&Herramientas
NombreDesplegar=&Generar Constancia PDF
EnMenu=S
TipoAccion=Formas
ClaveAccion=CFDIRetencionRegenerar
Activo=S
Visible=S



[Acciones.CFDIRetencionCancelar]
Nombre=CFDIRetencionCancelar
Boton=0
Menu=&Herramientas
NombreDesplegar=Cancelar Timbrado
EnMenu=S
TipoAccion=Formas
ClaveAccion=CFDIRetencionCancelar
Activo=S
Visible=S












































































[Acciones.CFDIRetencionProv]
Nombre=CFDIRetencionProv
Boton=0
Menu=&Configuración
NombreDesplegar=&Proveedores
EnMenu=S
TipoAccion=Formas
ClaveAccion=CFDIRetencionProv
Activo=S
Visible=S









































[Acciones.CFDIRetFiscalRegimen]
Nombre=CFDIRetFiscalRegimen
Boton=0
Menu=&Maestros
NombreDesplegar=Regímenes Fiscales
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=CFDIRetFiscalRegimen
Activo=S
Visible=S




























[Lista.Prov.Nombre]
Carpeta=Lista
Clave=Prov.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco































[Acciones.CFDIRetencionCompXMLPlantilla]
Nombre=CFDIRetencionCompXMLPlantilla
Boton=0
Menu=&Configuración
NombreDesplegar=Plantilla Complementos
EnMenu=S
TipoAccion=Formas
ClaveAccion=CFDIRetencionCompXMLPlantilla
Activo=S
Visible=S












































[Acciones.Retenciones]
Nombre=Retenciones
Boton=61
NombreEnBoton=S
NombreDesplegar=&Retenciones
EnBarraHerramientas=S
EspacioPrevio=S
Visible=S





TipoAccion=Expresion
Antes=S
Expresion=Forma(<T>CFDIRetencionDRet<T>)<BR>ActualizarVista<BR>ActualizarForma
ActivoCondicion=CFDIRetencion:CFDIRetencion.Retencion1 <> 0 o CFDIRetencion:CFDIRetencion.Retencion2 <> 0
AntesExpresiones=Asigna(Info.Modulo, CFDIRetencion:CFDIRetencion.Modulo)<BR>Asigna(Info.ID, CFDIRetencion:CFDIRetencion.ModuloID)<BR>Asigna(Info.Mov, CFDIRetencion:CFDIRetencion.Mov)<BR>Asigna(Info.MovID, CFDIRetencion:CFDIRetencion.MovID)<BR>Asigna(Info.Anuncio, CFDIRetencion:CFDIRetencion.ConceptoSAT)<BR>Asigna(Info.Proveedor, CFDIRetencion:CFDIRetencion.Proveedor)
[Acciones.IEPS]
Nombre=IEPS
Boton=96
NombreEnBoton=S
NombreDesplegar=&IEPS
EnBarraHerramientas=S
Visible=S



EspacioPrevio=S






Antes=S
TipoAccion=Expresion



Expresion=Forma(<T>CFDIRetencionDIEPS<T>)<BR>ActualizarVista<BR>ActualizarForma
ActivoCondicion=CFDIRetencion:CFDIRetencion.IEPS <> 0
AntesExpresiones=Asigna(Info.Modulo, CFDIRetencion:CFDIRetencion.Modulo)<BR>Asigna(Info.ID, CFDIRetencion:CFDIRetencion.ModuloID)<BR>Asigna(Info.Mov, CFDIRetencion:CFDIRetencion.Mov)<BR>Asigna(Info.MovID, CFDIRetencion:CFDIRetencion.MovID)<BR>Asigna(Info.Anuncio, CFDIRetencion:CFDIRetencion.ConceptoSAT)<BR>Asigna(Info.Proveedor, CFDIRetencion:CFDIRetencion.Proveedor)
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

[Acciones.EliminarMovimiento]
Nombre=EliminarMovimiento
Boton=0
NombreDesplegar=&Eliminar Movimiento
EnLote=S
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S

Antes=S












EspacioPrevio=S




Expresion=EjecutarSQL(<T>EXEC spCFDIRetencionBorrarMov :nEstacion, :tModulo, :nModuloID<T>, EstacionTrabajo, CFDIRetencion:CFDIRetencion.Modulo, CFDIRetencion:CFDIRetencion.ModuloID)<BR><BR>Si SQL(<T>SELECT CASE WHEN COUNT(ID) <= 0 THEN 1 ELSE  0 END FROM ListaModuloID WHERE Estacion = :tEstacion <T>, EstacionTrabajo)<BR>Entonces<BR>  ActualizarForma<BR>  ActualizarVista<BR>Fin
AntesExpresiones=RegistrarSeleccionModuloID(<T>Lista<T>, <T>CFDIRetencion.Modulo<T>, <T>CFDIRetencion.ModuloID<T>)






[Acciones.MostrarCampos]
Nombre=MostrarCampos
Boton=45
NombreDesplegar=Personalizar Vista
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S















[Lista.ListaEnCaptura]
(Inicio)=CFDIRetencion.FechaEmision
CFDIRetencion.FechaEmision=CFDIRetencion.Proveedor
CFDIRetencion.Proveedor=Prov.Nombre
Prov.Nombre=Prov.RFC
Prov.RFC=CFDIRetencion.ConceptoSAT
CFDIRetencion.ConceptoSAT=CFDIRetencion.Importe
CFDIRetencion.Importe=CFDIRetencion.IVA
CFDIRetencion.IVA=CFDIRetencion.IEPS
CFDIRetencion.IEPS=CFDIRetencion.Retencion1
CFDIRetencion.Retencion1=CFDIRetencion.Retencion2
CFDIRetencion.Retencion2=CFDIRetencion.Ok
CFDIRetencion.Ok=CFDIRetencion.OkRef
CFDIRetencion.OkRef=(Fin)

[Lista.ListaAcciones]
(Inicio)=SeleccionarTodo
SeleccionarTodo=QuitarSeleccion
QuitarSeleccion=EliminarMovimiento
EliminarMovimiento=(Fin)

[Lista.CFDIRetencion.Ok]
Carpeta=Lista
Clave=CFDIRetencion.Ok
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.CFDIRetencion.OkRef]
Carpeta=Lista
Clave=CFDIRetencion.OkRef
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco























































































[Forma.ListaAcciones]
(Inicio)=ClavesPagos
ClavesPagos=ExcepcionarPagos
ExcepcionarPagos=AdicionarPagos
AdicionarPagos=CFDIRetSATRetencion
CFDIRetSATRetencion=CFDIRetSATDividendo
CFDIRetSATDividendo=CFDIRetSATTipoContribuyente
CFDIRetSATTipoContribuyente=CFDIRetSATPais
CFDIRetSATPais=CFDIRetSATEstado
CFDIRetSATEstado=CFDIRetSATTipoImpuesto
CFDIRetSATTipoImpuesto=Cerrar
Cerrar=Calcular
Calcular=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=Afectar
Afectar=CFDIRetGastoAdicion
CFDIRetGastoAdicion=CFDIRetencionCfg
CFDIRetencionCfg=CFDIRetencionEmpresa
CFDIRetencionEmpresa=CFDIRetencionXMLPlantilla
CFDIRetencionXMLPlantilla=CFDIRetencionCompXMLPlantilla
CFDIRetencionCompXMLPlantilla=CFDIRetencionConcepto
CFDIRetencionConcepto=CFDIRetencionArt
CFDIRetencionArt=CFDIRetencionProv
CFDIRetencionProv=CFDIRetencionImpuestoTipo
CFDIRetencionImpuestoTipo=MovPropiedades
MovPropiedades=CFDIRetencionPais
CFDIRetencionPais=CFDIRetencionRegenerar
CFDIRetencionRegenerar=CFDIRetencionCancelar
CFDIRetencionCancelar=CFDIRetFiscalRegimen
CFDIRetFiscalRegimen=Retenciones
Retenciones=IEPS
IEPS=MostrarCampos
MostrarCampos=(Fin)

[Forma.MenuPrincipal]
(Inicio)=&Configuración
&Configuración=&Pagos
&Pagos=&Maestros
&Maestros=&Gastos
&Gastos=&Herramientas
&Herramientas=(Fin)
