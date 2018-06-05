
[Forma]
Clave=CFDINominaSATTipoRegimen
Icono=0
Modulos=(Todos)
BarraHerramientas=S
Nombre=CFDI Nómina - Tipo de Régimen
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=GuardarCerrar
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialAlturaCliente=378
PosicionInicialAncho=602
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=382
PosicionInicialArriba=156
MovModulo=(Todos)
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
BusquedaRapidaControles=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CFDINominaSATTipoRegimen
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

FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
CarpetaVisible=S

ListaOrden=CFDINominaSATTipoRegimen.Clave<TAB>(Acendente)
BusquedaRapida=S
BusquedaEnLinea=S
PermiteEditar=S


[Lista.Columnas]
Institucion=128
Nombre=494
ClaveSAT=156

Ciudad=63
Estado=48




Clave=58


[Lista.CFDINominaSATTipoRegimen.Clave]
Carpeta=Lista
Clave=CFDINominaSATTipoRegimen.Clave
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.CFDINominaSATTipoRegimen.Nombre]
Carpeta=Lista
Clave=CFDINominaSATTipoRegimen.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco



[Forma.ListaAcciones]
(Inicio)=GuardarCerrar
GuardarCerrar=Claves
Claves=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=CFDINominaSATTipoRegimen.Clave
CFDINominaSATTipoRegimen.Clave=CFDINominaSATTipoRegimen.Nombre
CFDINominaSATTipoRegimen.Nombre=(Fin)
