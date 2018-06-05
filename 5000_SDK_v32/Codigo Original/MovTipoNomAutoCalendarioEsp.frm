[Forma]
Clave=MovTipoNomAutoCalendarioEsp
Nombre=Calendario Especial
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=441
PosicionInicialArriba=241
PosicionInicialAlturaCliente=515
PosicionInicialAncho=398
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
Comentarios=Info.Mov
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
BusquedaRapidaControles=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MovTipoNomAutoCalendarioEsp
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
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroFechas=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasCampo=MovTipoNomAutoCalendarioEsp.FechaNomina
FiltroFechasDefault=Este Año
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
CarpetaVisible=S
PermiteEditar=S
ListaEnCaptura=(Lista)
FiltroGeneral=MovTipoNomAutoCalendarioEsp.Modulo=<T>{Info.Modulo}<T> AND<BR>MovTipoNomAutoCalendarioEsp.Mov=<T>{Info.Mov}<T>

[Lista.MovTipoNomAutoCalendarioEsp.FechaNomina]
Carpeta=Lista
Clave=MovTipoNomAutoCalendarioEsp.FechaNomina
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.MovTipoNomAutoCalendarioEsp.IncidenciaD]
Carpeta=Lista
Clave=MovTipoNomAutoCalendarioEsp.IncidenciaD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.MovTipoNomAutoCalendarioEsp.IncidenciaA]
Carpeta=Lista
Clave=MovTipoNomAutoCalendarioEsp.IncidenciaA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.MovTipoNomAutoCalendarioEsp.Cerrado]
Carpeta=Lista
Clave=MovTipoNomAutoCalendarioEsp.Cerrado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
FechaNomina=94
IncidenciaD=94
IncidenciaA=94
Cerrado=85

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

[Lista.ListaEnCaptura]
(Inicio)=MovTipoNomAutoCalendarioEsp.FechaNomina
MovTipoNomAutoCalendarioEsp.FechaNomina=MovTipoNomAutoCalendarioEsp.IncidenciaD
MovTipoNomAutoCalendarioEsp.IncidenciaD=MovTipoNomAutoCalendarioEsp.IncidenciaA
MovTipoNomAutoCalendarioEsp.IncidenciaA=MovTipoNomAutoCalendarioEsp.Cerrado
MovTipoNomAutoCalendarioEsp.Cerrado=(Fin)
