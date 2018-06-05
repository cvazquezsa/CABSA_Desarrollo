[Forma]
Clave=aroProcedimientoUnidad
Nombre=Unidades Organizacionales del Procedimiento
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
Comentarios=Info.Procedimiento
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
PosicionInicialIzquierda=698
PosicionInicialArriba=353
PosicionInicialAlturaCliente=460
PosicionInicialAncho=524

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
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
CampoColorLetras=Gris
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
OtroOrden=S
ListaOrden=aroUnidad.Orden<TAB>(Acendente)
FiltroGeneral=aroProcedimientoUnidad.Procedimiento=<T>{Info.Procedimiento}<T>

[Lista.aroProcedimientoUnidad.UnidadOrganizacional]
Carpeta=Lista
Clave=aroProcedimientoUnidad.UnidadOrganizacional
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.aroUnidad.Nombre]
Carpeta=Lista
Clave=aroUnidad.Nombre
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Gris

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

[Lista.Columnas]
UnidadOrganizacional=116
Nombre=378

[Lista.ListaEnCaptura]
(Inicio)=aroProcedimientoUnidad.UnidadOrganizacional
aroProcedimientoUnidad.UnidadOrganizacional=aroUnidad.Nombre
aroUnidad.Nombre=(Fin)
