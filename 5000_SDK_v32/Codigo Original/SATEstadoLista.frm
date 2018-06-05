[Forma]
Clave=SATEstadoLista
Nombre=Catálogo de Entidades o Estados
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
PosicionInicialIzquierda=493
PosicionInicialArriba=196
PosicionInicialAltura=346
PosicionInicialAncho=501
PosicionInicialAlturaCliente=421

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=SATEstado
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
ListaOrden=(Lista)






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
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral={Si(ConDatos(Info.Pais), <T>SATEstado.ClavePais=<T>+Comillas(Info.Pais), <T>1=1<T>)}
[Lista.Columnas]
LimiteInferior=102
LimiteSuperior=98
Cuota=87
Porcentaje=59
TablaImpuesto=96
PeriodoTipo=82
Fecha=111

ClaveEstado=115
ClavePais=143
Descripcion=184


[Lista.SATEstado.ClaveEstado]
Carpeta=Lista
Clave=SATEstado.ClaveEstado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[Lista.SATEstado.ClavePais]
Carpeta=Lista
Clave=SATEstado.ClavePais
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=3
ColorFondo=Blanco

[Lista.SATEstado.Descripcion]
Carpeta=Lista
Clave=SATEstado.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco



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







[Lista.ListaEnCaptura]
(Inicio)=SATEstado.ClaveEstado
SATEstado.ClaveEstado=SATEstado.ClavePais
SATEstado.ClavePais=SATEstado.Descripcion
SATEstado.Descripcion=(Fin)

[Lista.ListaOrden]
(Inicio)=SATEstado.ClavePais	(Acendente)
SATEstado.ClavePais	(Acendente)=SATEstado.ClaveEstado	(Acendente)
SATEstado.ClaveEstado	(Acendente)=(Fin)
