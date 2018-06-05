[Forma]
Clave=TablaImpuestoHist
Nombre=Info.Tabla+<T> - <T>+Info.PeriodoTipo
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
PosicionInicialIzquierda=261
PosicionInicialArriba=156
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
Vista=TablaImpuestoHist
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
Filtros=S
OtroOrden=S
ListaOrden=TablaImpuestoHist.ID<TAB>(Decendente)
FiltroPredefinido=S
FiltroAncho=30
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=General
BusquedaRapidaControles=S
FiltroFechas=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasCampo=TablaImpuestoHist.Fecha
FiltroFechasDefault=Este Año
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
FiltroGeneral=TablaImpuestoHist.TablaImpuesto=<T>{Info.Tabla}<T> AND<BR>TablaImpuestoHist.PeriodoTipo=<T>{Info.PeriodoTipo}<T>

[Lista.TablaImpuestoHist.LimiteInferior]
Carpeta=Lista
Clave=TablaImpuestoHist.LimiteInferior
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.TablaImpuestoHist.LimiteSuperior]
Carpeta=Lista
Clave=TablaImpuestoHist.LimiteSuperior
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.TablaImpuestoHist.Cuota]
Carpeta=Lista
Clave=TablaImpuestoHist.Cuota
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.TablaImpuestoHist.Porcentaje]
Carpeta=Lista
Clave=TablaImpuestoHist.Porcentaje
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Lista.Columnas]
LimiteInferior=102
LimiteSuperior=98
Cuota=87
Porcentaje=59
TablaImpuesto=96
PeriodoTipo=82
Fecha=122

[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=Enviar Excel
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Visible=S
ActivoCondicion=Usuario.EnviarExcel

[Lista.TablaImpuestoHist.Fecha]
Carpeta=Lista
Clave=TablaImpuestoHist.Fecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Excel
Excel=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=TablaImpuestoHist.Fecha
TablaImpuestoHist.Fecha=TablaImpuestoHist.LimiteInferior
TablaImpuestoHist.LimiteInferior=TablaImpuestoHist.LimiteSuperior
TablaImpuestoHist.LimiteSuperior=TablaImpuestoHist.Cuota
TablaImpuestoHist.Cuota=TablaImpuestoHist.Porcentaje
TablaImpuestoHist.Porcentaje=(Fin)
