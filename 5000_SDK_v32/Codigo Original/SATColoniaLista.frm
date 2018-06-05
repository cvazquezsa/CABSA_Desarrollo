[Forma]
Clave=SATColoniaLista
Nombre=Catálogo de Colonias
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Seleccionar
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
PosicionInicialIzquierda=469
PosicionInicialArriba=200
PosicionInicialAltura=346
PosicionInicialAncho=501
PosicionInicialAlturaCliente=421

VentanaEstadoInicial=Normal
VentanaExclusivaOpcion=0
[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=SATColonia
Fuente={MS Sans Serif, 8, Negro, []}
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
ListaOrden=SATColonia.ClaveColonia<TAB>(Acendente)
BusquedaRapidaControles=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha





BusquedaRapida=S
BusquedaEnLinea=S
BusquedaAncho=20

[Lista.Columnas]
LimiteInferior=102
LimiteSuperior=98
Cuota=87
Porcentaje=59
TablaImpuesto=96
PeriodoTipo=82
Fecha=122

ClaveColonia=84
ClaveCP=95
Descripcion=196

[Lista.SATColonia.ClaveColonia]
Carpeta=Lista
Clave=SATColonia.ClaveColonia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=4
ColorFondo=Blanco

[Lista.SATColonia.ClaveCP]
Carpeta=Lista
Clave=SATColonia.ClaveCP
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[Lista.SATColonia.Descripcion]
Carpeta=Lista
Clave=SATColonia.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco





[Lista.ListaEnCaptura]
(Inicio)=SATColonia.ClaveColonia
SATColonia.ClaveColonia=SATColonia.ClaveCP
SATColonia.ClaveCP=SATColonia.Descripcion
SATColonia.Descripcion=(Fin)



[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Excel
Excel=(Fin)

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
