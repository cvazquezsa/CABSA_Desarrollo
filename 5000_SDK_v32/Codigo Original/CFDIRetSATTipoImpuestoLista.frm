

[Forma]
Clave=CFDIRetSATTipoImpuestoLista
Icono=0
BarraHerramientas=S
Modulos=(Todos)
Nombre=SAT - Tipos de Impuestos
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=Seleccionar
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialAlturaCliente=528
PosicionInicialAncho=698
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=334
PosicionInicialArriba=81

[Lista]
Estilo=Hoja
PestanaOtroNombre=S
PestanaNombre=Lista
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CFDIRetSATTipoImpuesto
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
BusquedaRapidaControles=S

ListaOrden=CFDIRetSATTipoImpuesto.Clave<TAB>(Acendente)
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
[Lista.CFDIRetSATTipoImpuesto.Clave]
Carpeta=Lista
Clave=CFDIRetSATTipoImpuesto.Clave
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=2
ColorFondo=Blanco


[Lista.Columnas]
Clave=41
Retencion=604



Impuesto=604

[Lista.CFDIRetSATTipoImpuesto.Impuesto]
Carpeta=Lista
Clave=CFDIRetSATTipoImpuesto.Impuesto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[Lista.ListaEnCaptura]
(Inicio)=CFDIRetSATTipoImpuesto.Clave
CFDIRetSATTipoImpuesto.Clave=CFDIRetSATTipoImpuesto.Impuesto
CFDIRetSATTipoImpuesto.Impuesto=(Fin)

[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Seleccionar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Seleccionar
Activo=S
Visible=S
