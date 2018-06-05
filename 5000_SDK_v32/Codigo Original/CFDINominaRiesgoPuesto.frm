
[Forma]
Clave=CFDINominaRiesgoPuesto
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=CFDI Nómina - Riesgos
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=GuardarCerrar
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=424
PosicionInicialArriba=143
PosicionInicialAlturaCliente=403
PosicionInicialAncho=517
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
Vista=CFDINominaRiesgoPuesto
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

ListaOrden=CFDINominaRiesgoPuesto.Clave<TAB>(Acendente)
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


[Lista.Columnas]
Puesto=208
Riesgo=223




Clave=64
Descripcion=391
[Lista.CFDINominaRiesgoPuesto.Clave]
Carpeta=Lista
Clave=CFDINominaRiesgoPuesto.Clave
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.CFDINominaRiesgoPuesto.Descripcion]
Carpeta=Lista
Clave=CFDINominaRiesgoPuesto.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco





[Lista.ListaEnCaptura]
(Inicio)=CFDINominaRiesgoPuesto.Clave
CFDINominaRiesgoPuesto.Clave=CFDINominaRiesgoPuesto.Descripcion
CFDINominaRiesgoPuesto.Descripcion=(Fin)
