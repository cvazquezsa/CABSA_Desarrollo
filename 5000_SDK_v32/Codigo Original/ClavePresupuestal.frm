
[Forma]
Clave=ClavePresupuestal
Icono=0
Modulos=(Todos)
Nombre=Claves Presupuestales

ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=546
PosicionInicialArriba=378
PosicionInicialAlturaCliente=409
PosicionInicialAncho=827
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ClavePresupuestal
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
CarpetaVisible=S
ListaEnCaptura=(Lista)

PermiteEditar=S

BusquedaRapidaControles=S
FiltroEstatus=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=ALTA
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
ValidarCampos=S
ListaCamposAValidar=CPObjetoGasto.Nombre
[Lista.ClavePresupuestal.ClavePresupuestal]
Carpeta=Lista
Clave=ClavePresupuestal.ClavePresupuestal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ClavePresupuestal.Nombre]
Carpeta=Lista
Clave=ClavePresupuestal.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ClavePresupuestal.Descripcion]
Carpeta=Lista
Clave=ClavePresupuestal.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco
ColorFuente=Negro


[Lista.Columnas]
ClavePresupuestal=116
Nombre=155
Descripcion=267


Estatus=87
TieneArticulosEsp=100
ObjetoGasto=68
0=64
1=-2
[Lista.ClavePresupuestal.Estatus]
Carpeta=Lista
Clave=ClavePresupuestal.Estatus
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro


[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S





[Lista.ClavePresupuestal.TieneArticulosEsp]
Carpeta=Lista
Clave=ClavePresupuestal.TieneArticulosEsp
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro



[Lista.ClavePresupuestal.ObjetoGasto]
Carpeta=Lista
Clave=ClavePresupuestal.ObjetoGasto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ClavePresupuestal.Proyecto]
Carpeta=Lista
Clave=ClavePresupuestal.Proyecto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.ListaEnCaptura]
(Inicio)=ClavePresupuestal.Proyecto
ClavePresupuestal.Proyecto=ClavePresupuestal.ClavePresupuestal
ClavePresupuestal.ClavePresupuestal=ClavePresupuestal.Nombre
ClavePresupuestal.Nombre=ClavePresupuestal.Descripcion
ClavePresupuestal.Descripcion=ClavePresupuestal.ObjetoGasto
ClavePresupuestal.ObjetoGasto=ClavePresupuestal.TieneArticulosEsp
ClavePresupuestal.TieneArticulosEsp=ClavePresupuestal.Estatus
ClavePresupuestal.Estatus=(Fin)

[Lista.FiltroListaEstatus]
(Inicio)=ALTA
ALTA=BLOQUEADO
BLOQUEADO=BAJA
BAJA=(Fin)
