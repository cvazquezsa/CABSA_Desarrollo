[Forma]
Clave=ProyAlm
Nombre=<T>Proyectos de <T>+Info.Almacen
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=198
PosicionInicialArriba=204
PosicionInicialAltura=353
PosicionInicialAncho=627
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaEscCerrar=S
PosicionInicialAlturaCliente=326

[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Proy
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=Proy.Descripcion
CarpetaVisible=S
Filtros=S
FiltroPredefinido=S
FiltroGrupo1=(Validaciones Memoria)
FiltroValida1=ProyCat
FiltroAplicaEn1=Proy.Categoria
FiltroNullNombre=(sin clasificar)
FiltroTodo=S
FiltroEnOrden=S
FiltroTodoNombre=Todos
FiltroNull=S
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Proyecto<T>
ElementosPorPagina=200
PestanaOtroNombre=S
PestanaNombre=Proyectos
BusquedaRapidaControles=S
FiltroFechas=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasCampo=Proy.FechaFin
FiltroFechasVencimiento=S
FiltroFechasNombre=&Vencimiento
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
FiltroFechasDefault=(Todo)
IconosNombre=Proy:Proy.Proyecto
FiltroGeneral=Proy.Proyecto LIKE <T>%{Info.Almacen}%<T>

[Lista.Columnas]
Proyecto=258
0=72
1=192

[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Lista.Proy.Descripcion]
Carpeta=Lista
Clave=Proy.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Personalizar]
Nombre=Personalizar
Boton=45
NombreDesplegar=Personalizar Vista
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Acciones.ProyInfo]
Nombre=ProyInfo
Boton=34
NombreDesplegar=&Información
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=ProyInfo
Activo=S
ConCondicion=S
Antes=S
Visible=S
EspacioPrevio=S
NombreEnBoton=S
EjecucionCondicion=ConDatos(Proy:Proy.Proyecto)
AntesExpresiones=Asigna(Info.Proyecto, Proy:Proy.Proyecto)

[Forma.ListaAcciones]
(Inicio)=Seleccionar
Seleccionar=ProyInfo
ProyInfo=Personalizar
Personalizar=(Fin)
