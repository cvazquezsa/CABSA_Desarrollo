

[Forma]
Clave=CFDIRetSATTipoContribuyente
Icono=0
BarraHerramientas=S
Modulos=(Todos)
Nombre=SAT - Tipos de Contribuyentes
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=GuardarCerrar
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialAlturaCliente=528
PosicionInicialAncho=698
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=334
PosicionInicialArriba=81
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
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CFDIRetSATTipoContribuyente
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

ListaOrden=CFDIRetSATTipoContribuyente.Clave<TAB>(Acendente)
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
[Lista.CFDIRetSATTipoContribuyente.Clave]
Carpeta=Lista
Clave=CFDIRetSATTipoContribuyente.Clave
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=2
ColorFondo=Blanco


[Lista.Columnas]
Clave=41
Retencion=604



Sujeto=604
[Lista.ListaEnCaptura]
(Inicio)=CFDIRetSATTipoContribuyente.Clave
CFDIRetSATTipoContribuyente.Clave=CFDIRetSATTipoContribuyente.Sujeto
CFDIRetSATTipoContribuyente.Sujeto=(Fin)

[Lista.CFDIRetSATTipoContribuyente.Sujeto]
Carpeta=Lista
Clave=CFDIRetSATTipoContribuyente.Sujeto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco
