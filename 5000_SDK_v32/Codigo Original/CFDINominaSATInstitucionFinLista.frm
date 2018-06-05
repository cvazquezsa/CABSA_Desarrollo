
[Forma]
Clave=CFDINominaSATInstitucionFinLista
Icono=0
Modulos=(Todos)
BarraHerramientas=S
Nombre=CFDI Nómina - SAT Claves Instituciones Financieras
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=Seleccionar
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialAlturaCliente=367
PosicionInicialAncho=434
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=466
PosicionInicialArriba=161
MovModulo=(Todos)

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
Vista=CFDINominaSATInstitucionFin
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

ListaOrden=CFDINominaSATInstitucionFin.Clave<TAB>(Acendente)
BusquedaRapida=S
BusquedaEnLinea=S
ValidarCampos=S


[Lista.Columnas]
Institucion=128
Nombre=308
ClaveSAT=156

Ciudad=63
Estado=48







Clave=56
[Lista.CFDINominaSATInstitucionFin.Clave]
Carpeta=Lista
Clave=CFDINominaSATInstitucionFin.Clave
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[Lista.CFDINominaSATInstitucionFin.Nombre]
Carpeta=Lista
Clave=CFDINominaSATInstitucionFin.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco



[Lista.ListaEnCaptura]
(Inicio)=CFDINominaSATInstitucionFin.Clave
CFDINominaSATInstitucionFin.Clave=CFDINominaSATInstitucionFin.Nombre
CFDINominaSATInstitucionFin.Nombre=(Fin)

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
