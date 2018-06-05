
[Forma]
Clave=CFDINominaMov
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=CFDI Nómina - Movimientos
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=(Lista)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=420
PosicionInicialArriba=168
PosicionInicialAlturaCliente=394
PosicionInicialAncho=639
Menus=S
MenuPrincipal=&Maestros
[Acciones.GuardarCerrrar]
Nombre=GuardarCerrrar
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
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CFDINominaMov
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
ListaEnCaptura=(Lista)

CarpetaVisible=S
OtroOrden=S

ListaOrden=CFDINominaMov.Mov<TAB>(Acendente)
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
[Lista.CFDINominaMov.Mov]
Carpeta=Lista
Clave=CFDINominaMov.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.CFDINominaMov.tipoRegimen]
Carpeta=Lista
Clave=CFDINominaMov.tipoRegimen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.Columnas]
Mov=152
tipoRegimen=134





Version=53

TipoComprobante=116
Reporte=116
ReporteMov=127
[Lista.CFDINominaMov.Version]
Carpeta=Lista
Clave=CFDINominaMov.Version
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco





[Lista.CFDINominaMov.Reporte]
Carpeta=Lista
Clave=CFDINominaMov.Reporte
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco


[Acciones.TipoRegimen]
Nombre=TipoRegimen
Boton=0
NombreDesplegar=Tipos de Régimen
EnMenu=S
TipoAccion=Formas
ClaveAccion=CFDINominaSATTipoRegimen
Activo=S
Visible=S



Menu=&Maestros



































[Lista.ListaEnCaptura]
(Inicio)=CFDINominaMov.Mov
CFDINominaMov.Mov=CFDINominaMov.Version
CFDINominaMov.Version=CFDINominaMov.tipoRegimen
CFDINominaMov.tipoRegimen=CFDINominaMov.Reporte
CFDINominaMov.Reporte=CFDINominaMov.ReporteMov
CFDINominaMov.ReporteMov=(Fin)

[Lista.CFDINominaMov.ReporteMov]
Carpeta=Lista
Clave=CFDINominaMov.ReporteMov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco



[Forma.ListaAcciones]
(Inicio)=GuardarCerrrar
GuardarCerrrar=TipoRegimen
TipoRegimen=(Fin)
