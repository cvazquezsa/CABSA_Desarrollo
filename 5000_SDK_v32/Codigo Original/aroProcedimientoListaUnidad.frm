[Forma]
Clave=aroProcedimientoListaUnidad
Nombre=Procedimientos de la Unidad Organizacional
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Seleccionar
Comentarios=Usuario.UnidadOrganizacional
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
PosicionInicialIzquierda=715
PosicionInicialArriba=353
PosicionInicialAlturaCliente=460
PosicionInicialAncho=489

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=aroProcedimientoUnidad
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
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
FiltroGeneral=aroProcedimientoUnidad.UnidadOrganizacional=<T>{Usuario.UnidadOrganizacional}<T>

[Lista.Columnas]
UnidadOrganizacional=116
Nombre=378
Procedimiento=124
Nombre_1=335

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

[Lista.aroProcedimientoUnidad.Procedimiento]
Carpeta=Lista
Clave=aroProcedimientoUnidad.Procedimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.aroProcedimiento.Nombre]
Carpeta=Lista
Clave=aroProcedimiento.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ListaEnCaptura]
(Inicio)=aroProcedimientoUnidad.Procedimiento
aroProcedimientoUnidad.Procedimiento=aroProcedimiento.Nombre
aroProcedimiento.Nombre=(Fin)
