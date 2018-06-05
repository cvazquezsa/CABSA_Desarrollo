[Forma]
Clave=ActivoFAsignar
Nombre=Asignar Activos Fijos de la Empresa
Icono=6
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=277
PosicionInicialArriba=282
PosicionInicialAltura=459
PosicionInicialAncho=726
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S
EsConsultaExclusiva=S
PosicionInicialAlturaCliente=432
Comentarios=Lista(Info.Personal, Info.Espacio, Info.Nombre)

[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ActivoFLista
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
Filtros=S
OtroOrden=S
ListaOrden=(Lista)
FiltroPredefinido=S
FiltroGrupo1=ActivoF.Categoria
FiltroGrupo2=ActivoF.Almacen
FiltroAncho=20
FiltroTodo=S
FiltroEnOrden=S
FiltroTodoNombre=Todos
FiltroTodoFinal=S
FiltroNullNombre=(sin clasificar)
FiltroNull=S
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Artículo<T>
ElementosPorPagina=200
PestanaOtroNombre=S
PestanaNombre=Activos Fijos
BusquedaRapidaControles=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=ACTIVO
FiltroFechasNormal=S
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
FiltroEstatus=S
IconosSeleccionMultiple=S
MenuLocal=S
ListaAcciones=(Lista)
IconosNombre=ActivoFLista:ActivoF.Articulo
FiltroGeneral=ActivoF.Empresa=<T>{Empresa}<T> AND ActivoFCat.Propietario=<T>Empresa<T><BR>{Si(Info.MovTipo en (AF.DP, AF.DT), <T> AND ISNULL(ActivoF.VidaUtil, 0)>ISNULL(ActivoF.DepreciacionMeses, 0)<T>, <T><T>)}<BR>{Si(Info.MovTipo=AF.A,  <T> AND ActivoF.Responsable IS NULL AND ActivoF.Espacio IS NULL<T>, <T><T>)}<BR>{Si(ConDatos(Info.Personal), <T> AND ActivoF.Responsable=<T>+Comillas(Info.Personal), <T><T>)}<BR>{Si(ConDatos(Info.Espacio), <T> AND ActivoF.Espacio=<T>+Comillas(Info.Espacio), <T><T>)}

[Lista.Art.Descripcion1]
Carpeta=Lista
Clave=Art.Descripcion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ActivoF.Almacen]
Carpeta=Lista
Clave=ActivoF.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Articulo=124
Descripcion1=244
SubCuenta=124
SerieLote=124
Almacen=64
0=118
1=158

[Lista.ActivoF.Serie]
Carpeta=Lista
Clave=ActivoF.Serie
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Agregar]
Nombre=Agregar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Agregar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Antes=S
Visible=S
AntesExpresiones=RegistrarSeleccionID(<T>Lista<T>)<BR>EjecutarSQL(<T>spActivoFijoAsignar :nEstacion, :nID<T>, EstacionTrabajo, Info.ID)

[Acciones.Cancelar]
Nombre=Cancelar
Boton=36
NombreEnBoton=S
NombreDesplegar=<T>&Cancelar<T>
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S

[Acciones.Seleccionar Todo]
Nombre=Seleccionar Todo
Boton=0
NombreDesplegar=Seleccionar &Todo
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Seleccionar Todo
Activo=S
Visible=S

[Acciones.Quitar Seleccion]
Nombre=Quitar Seleccion
Boton=0
NombreDesplegar=&Quitar Seleccion
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Quitar Seleccion
Activo=S
Visible=S

[Forma.ListaAcciones]
(Inicio)=Agregar
Agregar=Cancelar
Cancelar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=Art.Descripcion1
Art.Descripcion1=ActivoF.Serie
ActivoF.Serie=ActivoF.Almacen
ActivoF.Almacen=(Fin)

[Lista.ListaOrden]
(Inicio)=ActivoF.Articulo<TAB>(Acendente)
ActivoF.Articulo<TAB>(Acendente)=ActivoF.Serie<TAB>(Acendente)
ActivoF.Serie<TAB>(Acendente)=(Fin)

[Lista.FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=ACTIVO
ACTIVO=INACTIVO
INACTIVO=(Fin)

[Lista.ListaAcciones]
(Inicio)=Seleccionar Todo
Seleccionar Todo=Quitar Seleccion
Quitar Seleccion=(Fin)
