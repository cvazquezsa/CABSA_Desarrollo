
[Forma]
Clave=CFDINominaConcepto
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=CFDI Nómina - Conceptos
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=(Lista)
ListaCarpetas=(Lista)
CarpetaPrincipal=Lista
PosicionInicialIzquierda=314
PosicionInicialArriba=112
PosicionInicialAlturaCliente=464
PosicionInicialAncho=737
PosicionCol1=269
Menus=S
MenuPrincipal=&Maestros
[Acciones.GuardarCerrar]
Nombre=GuardarCerrar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Lista]
Estilo=Hoja
PestanaOtroNombre=S
PestanaNombre=Lista
Clave=Lista
OtroOrden=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CFDINominaConcepto
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=CFDINominaConcepto.Concepto

ListaOrden=CFDINominaConcepto.Concepto<TAB>(Acendente)
CarpetaVisible=S
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
[Lista.CFDINominaConcepto.Concepto]
Carpeta=Lista
Clave=CFDINominaConcepto.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco



[Lista.Columnas]
Concepto=203
ClaveSAT=82
ConceptoSAT=249

NominaConcepto=203
0=300
1=-2


Clave=64
Descripcion=391
[Lista.ListaEnCaptura]
(Inicio)=CFDINominaConcepto.Concepto
CFDINominaConcepto.Concepto=CFDINominaConcepto.ClaveSAT
CFDINominaConcepto.ClaveSAT=CFDINominaConcepto.ConceptoSAT
CFDINominaConcepto.ConceptoSAT=(Fin)

[Detalle]
Estilo=Ficha
Clave=Detalle
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=CFDINominaConcepto
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S

PestanaOtroNombre=S
PestanaNombre=Detalle
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
[Detalle.CFDINominaConcepto.ClaveSAT]
Carpeta=Detalle
Clave=CFDINominaConcepto.ClaveSAT
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=12
ColorFondo=Blanco

EspacioPrevio=S

[Detalle.Columnas]
ClaveSAT=94
ConceptoSAT=304












[Detalle.CFDINominaConcepto.CampoTotalizar]
Carpeta=Detalle
Clave=CFDINominaConcepto.CampoTotalizar
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=12
ColorFondo=Blanco





[Detalle.CFDINominaConcepto.CfgDiasPagados]
Carpeta=Detalle
Clave=CFDINominaConcepto.CfgDiasPagados
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
EspacioPrevio=S
ColorFondo=Blanco

Tamano=30

[Detalle.CFDINominaConcepto.CfgPercepcionesGravadas]
Carpeta=Detalle
Clave=CFDINominaConcepto.CfgPercepcionesGravadas
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco

Tamano=30








EspacioPrevio=S
[Detalle.CFDINominaConcepto.Concepto]
Carpeta=Detalle
Clave=CFDINominaConcepto.Concepto
Editar=N
LineaNueva=N
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=60
ColorFondo=Blanco



























[Detalle.CFDINominaConcepto.CfgDeduccionesGravadas]
Carpeta=Detalle
Clave=CFDINominaConcepto.CfgDeduccionesGravadas
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco

EspacioPrevio=S
[Detalle.CFDINominaConcepto.CfgDeduccionesExcentas]
Carpeta=Detalle
Clave=CFDINominaConcepto.CfgDeduccionesExcentas
Editar=S
3D=S
Tamano=30
ColorFondo=Blanco

[Detalle.CFDINominaConcepto.CfgPercepcionesExcentas]
Carpeta=Detalle
Clave=CFDINominaConcepto.CfgPercepcionesExcentas
Editar=S
3D=S
Tamano=30
ColorFondo=Blanco





[Detalle.CFDINominaConcepto.CfgIncapacidad]
Carpeta=Detalle
Clave=CFDINominaConcepto.CfgIncapacidad
Editar=S
ValidaNombre=N
3D=S
Tamano=30
ColorFondo=Blanco

LineaNueva=S
EspacioPrevio=S
[Detalle.CFDINominaConcepto.CfgHoraExtra]
Carpeta=Detalle
Clave=CFDINominaConcepto.CfgHoraExtra
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco





EspacioPrevio=S
[Detalle.CFDINominaConcepto.CfgTipoHoraExtra]
Carpeta=Detalle
Clave=CFDINominaConcepto.CfgTipoHoraExtra
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=18
ColorFondo=Blanco









[Detalle.CFDINominaConcepto.CfgTipoIncapacidad]
Carpeta=Detalle
Clave=CFDINominaConcepto.CfgTipoIncapacidad
Editar=S
ValidaNombre=S
3D=S
Tamano=18
ColorFondo=Blanco













[Detalle.CFDINominaConcepto.CfgDescuento]
Carpeta=Detalle
Clave=CFDINominaConcepto.CfgDescuento
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco

EspacioPrevio=S






[Detalle.CFDINominaConcepto.TipoSAT]
Carpeta=Detalle
Clave=CFDINominaConcepto.TipoSAT
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=12
ColorFondo=Blanco















[Detalle.CFDINominaConcepto.CfgSDI]
Carpeta=Detalle
Clave=CFDINominaConcepto.CfgSDI
Editar=S
3D=S
Tamano=30
ColorFondo=Blanco










[Acciones.TipoPercepcion]
Nombre=TipoPercepcion
Boton=0
Menu=&Maestros
NombreDesplegar=Tipos de Percepción
EnMenu=S
TipoAccion=Formas
ClaveAccion=CFDINominaTipoPercepcion
Activo=S
Visible=S



[Acciones.TipoDeduccion]
Nombre=TipoDeduccion
Boton=0
Menu=&Maestros
NombreDesplegar=Tipos de Deducción
EnMenu=S
TipoAccion=Formas
ClaveAccion=CFDINominaTipoDeduccion
Activo=S
Visible=S


















[Detalle.CFDINominaConcepto.TipoDeduccionSAT]
Carpeta=Detalle
Clave=CFDINominaConcepto.TipoDeduccionSAT
Editar=S
ValidaNombre=S
3D=S
Tamano=12
ColorFondo=Blanco




































































































[Detalle.CFDINominaConcepto.CfgDiasHorasDobles]
Carpeta=Detalle
Clave=CFDINominaConcepto.CfgDiasHorasDobles
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco

Tamano=30
[Detalle.CFDINominaConcepto.CfgDiasHorasTriples]
Carpeta=Detalle
Clave=CFDINominaConcepto.CfgDiasHorasTriples
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
ColorFondo=Blanco

Tamano=30












[Detalle.CFDINominaConcepto.EsValesDespensa]
Carpeta=Detalle
Clave=CFDINominaConcepto.EsValesDespensa
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco

Tamano=30








[Detalle.ListaEnCaptura]
(Inicio)=CFDINominaConcepto.Concepto
CFDINominaConcepto.Concepto=CFDINominaConcepto.ClaveSAT
CFDINominaConcepto.ClaveSAT=CFDINominaConcepto.TipoSAT
CFDINominaConcepto.TipoSAT=CFDINominaConcepto.TipoDeduccionSAT
CFDINominaConcepto.TipoDeduccionSAT=CFDINominaConcepto.CampoTotalizar
CFDINominaConcepto.CampoTotalizar=CFDINominaConcepto.CfgDescuento
CFDINominaConcepto.CfgDescuento=CFDINominaConcepto.CfgDeduccionesGravadas
CFDINominaConcepto.CfgDeduccionesGravadas=CFDINominaConcepto.CfgDeduccionesExcentas
CFDINominaConcepto.CfgDeduccionesExcentas=CFDINominaConcepto.CfgPercepcionesGravadas
CFDINominaConcepto.CfgPercepcionesGravadas=CFDINominaConcepto.CfgPercepcionesExcentas
CFDINominaConcepto.CfgPercepcionesExcentas=CFDINominaConcepto.CfgDiasPagados
CFDINominaConcepto.CfgDiasPagados=CFDINominaConcepto.CfgSDI
CFDINominaConcepto.CfgSDI=CFDINominaConcepto.CfgIncapacidad
CFDINominaConcepto.CfgIncapacidad=CFDINominaConcepto.CfgTipoIncapacidad
CFDINominaConcepto.CfgTipoIncapacidad=CFDINominaConcepto.CfgHoraExtra
CFDINominaConcepto.CfgHoraExtra=CFDINominaConcepto.CfgTipoHoraExtra
CFDINominaConcepto.CfgTipoHoraExtra=CFDINominaConcepto.CfgDiasHorasDobles
CFDINominaConcepto.CfgDiasHorasDobles=CFDINominaConcepto.CfgDiasHorasTriples
CFDINominaConcepto.CfgDiasHorasTriples=CFDINominaConcepto.EsValesDespensa
CFDINominaConcepto.EsValesDespensa=(Fin)



[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Detalle
Detalle=(Fin)

[Forma.ListaAcciones]
(Inicio)=GuardarCerrar
GuardarCerrar=TipoPercepcion
TipoPercepcion=TipoDeduccion
TipoDeduccion=(Fin)
