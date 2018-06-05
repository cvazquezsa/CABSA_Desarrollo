
[Forma]
Clave=CFDINominaInstitucionFin
Icono=0
Modulos=(Todos)
BarraHerramientas=S
Nombre=CFDI Nómina - Instituciones Financieras
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=(Lista)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialAlturaCliente=310
PosicionInicialAncho=363
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=501
PosicionInicialArriba=190
MovModulo=(Todos)
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
BusquedaRapidaControles=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CFDINominaInstitucionFin
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

ListaOrden=CFDINominaInstitucionFin.Institucion<TAB>(Acendente)
BusquedaRapida=S
BusquedaEnLinea=S
PermiteEditar=S
[Lista.CFDINominaInstitucionFin.Institucion]
Carpeta=Lista
Clave=CFDINominaInstitucionFin.Institucion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


[Lista.CFDINominaInstitucionFin.ClaveSAT]
Carpeta=Lista
Clave=CFDINominaInstitucionFin.ClaveSAT
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco


[Lista.Columnas]
Institucion=128
Nombre=308
ClaveSAT=156

Ciudad=63
Estado=48




Clave=56

[Acciones.Claves]
Nombre=Claves
Boton=0
Menu=&Maestros
NombreDesplegar=&Claves
EnMenu=S
TipoAccion=Formas
ClaveAccion=CFDINominaSATInstitucionFin
Activo=S
Visible=S




































[Lista.ListaEnCaptura]
(Inicio)=CFDINominaInstitucionFin.Institucion
CFDINominaInstitucionFin.Institucion=CFDINominaInstitucionFin.ClaveSAT
CFDINominaInstitucionFin.ClaveSAT=(Fin)









































[Forma.ListaAcciones]
(Inicio)=GuardarCerrar
GuardarCerrar=Claves
Claves=(Fin)
