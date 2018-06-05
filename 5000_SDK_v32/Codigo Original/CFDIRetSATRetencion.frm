

[Forma]
Clave=CFDIRetSATRetencion
Icono=0
BarraHerramientas=S
Modulos=(Todos)
Nombre=SAT - Tipos de Retenciones
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=GuardarCerrar
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialAlturaCliente=706
PosicionInicialAncho=1382
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=0
PosicionInicialArriba=0
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
Vista=CFDIRetSATRetencion
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

ListaOrden=CFDIRetSATRetencion.Clave<TAB>(Acendente)
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
[Lista.CFDIRetSATRetencion.Clave]
Carpeta=Lista
Clave=CFDIRetSATRetencion.Clave
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=2
ColorFondo=Blanco

[Lista.CFDIRetSATRetencion.Retencion]
Carpeta=Lista
Clave=CFDIRetSATRetencion.Retencion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[Lista.Columnas]
Clave=41
Retencion=604





Complemento=124

RetmontoTotGrav=130
RetmontoTotExent=125
[Lista.CFDIRetSATRetencion.Complemento]
Carpeta=Lista
Clave=CFDIRetSATRetencion.Complemento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.ListaEnCaptura]
(Inicio)=CFDIRetSATRetencion.Clave
CFDIRetSATRetencion.Clave=CFDIRetSATRetencion.Retencion
CFDIRetSATRetencion.Retencion=CFDIRetSATRetencion.Complemento
CFDIRetSATRetencion.Complemento=CFDIRetSATRetencion.RetmontoTotGrav
CFDIRetSATRetencion.RetmontoTotGrav=CFDIRetSATRetencion.RetmontoTotExent
CFDIRetSATRetencion.RetmontoTotExent=(Fin)

[Lista.CFDIRetSATRetencion.RetmontoTotGrav]
Carpeta=Lista
Clave=CFDIRetSATRetencion.RetmontoTotGrav
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.CFDIRetSATRetencion.RetmontoTotExent]
Carpeta=Lista
Clave=CFDIRetSATRetencion.RetmontoTotExent
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
