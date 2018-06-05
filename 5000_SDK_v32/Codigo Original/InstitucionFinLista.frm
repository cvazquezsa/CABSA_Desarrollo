[Forma]
Clave=InstitucionFinLista
Nombre=Instituciones Financieras
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Seleccionar
PosicionInicialIzquierda=672
PosicionInicialArriba=405
PosicionInicialAltura=381
PosicionInicialAncho=576
EsConsultaExclusiva=S
PosicionInicialAlturaCliente=354

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=InstitucionFin
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
BusquedaRapidaControles=S
FiltroPredefinido=S
FiltroAncho=20
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControlesNum=S
BusquedaAncho=20
BusquedaEnLinea=S
FiltroGrupo1=InstitucionFin.Pais
FiltroGrupo2=InstitucionFin.Estado
FiltroGrupo3=InstitucionFin.Ciudad
FiltroTodo=S
ValidarCampos=
MenuLocal=S
ListaAcciones=Actualizar
PermiteLocalizar=S

[Lista.InstitucionFin.Institucion]
Carpeta=Lista
Clave=InstitucionFin.Institucion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S

[Lista.InstitucionFin.Nombre]
Carpeta=Lista
Clave=InstitucionFin.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S

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

[Lista.Columnas]
Institucion=87
Nombre=190
Ciudad=63
Estado=48
Pais=26

[Lista.InstitucionFin.Ciudad]
Carpeta=Lista
Clave=InstitucionFin.Ciudad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40

[Lista.InstitucionFin.Estado]
Carpeta=Lista
Clave=InstitucionFin.Estado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40

[Acciones.Actualizar]
Nombre=Actualizar
Boton=0
UsaTeclaRapida=S
TeclaRapida=F5
NombreDesplegar=Actualizar
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S

[Lista.ListaEnCaptura]
(Inicio)=InstitucionFin.Institucion
InstitucionFin.Institucion=InstitucionFin.Nombre
InstitucionFin.Nombre=InstitucionFin.Ciudad
InstitucionFin.Ciudad=InstitucionFin.Estado
InstitucionFin.Estado=(Fin)
