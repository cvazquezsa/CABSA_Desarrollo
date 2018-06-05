
[Forma]
Clave=ClavePresupuestalCatalogoLista
Icono=0
BarraHerramientas=S
Modulos=(Todos)
Nombre=Lista de Catalogos
AccionesTamanoBoton=15x5
AccionesDerecha=S
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEstadoInicial=Normal

ListaCarpetas=Lista
CarpetaPrincipal=Lista
ListaAcciones=Seleccionar
Comentarios=Lista(Info.Proyecto,Info.Categoria)
PosicionInicialIzquierda=374
PosicionInicialArriba=124
PosicionInicialAlturaCliente=453
PosicionInicialAncho=531
[Lista]
Estilo=Iconos
Clave=Lista
Filtros=S
BusquedaRapidaControles=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ClavePresupuestalCatalogo
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Clave<T>
ElementosPorPaginaEsp=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Arbol
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
CarpetaVisible=S

ListaEnCaptura=(Lista)
FiltroArbolClave=ClavePresupuestalCatalogo.RID
FiltroArbolValidar=ClavePresupuestalCatalogo.Clave
FiltroArbolRama=ClavePresupuestalCatalogo.RamaNumerica
FiltroArbolAcumulativas=ClavePresupuestalCatalogo.EsAcumulativa
FiltroTodo=S
RefrescarAlEntrar=S
FiltroNull=S
IconosNombre=ClavePresupuestalCatalogo:ClavePresupuestalCatalogo.Clave
FiltroGeneral=ClavePresupuestalCatalogo.Proyecto = {Comillas(Info.Proyecto)} AND<BR>ClavePresupuestalCatalogo.Categoria = {Comillas(Info.Categoria)}
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
0=83

1=185
2=120
3=127

[Lista.ClavePresupuestalCatalogo.Nombre]
Carpeta=Lista
Clave=ClavePresupuestalCatalogo.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.ClavePresupuestalCatalogo.Tipo]
Carpeta=Lista
Clave=ClavePresupuestalCatalogo.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.ClavePresupuestalCatalogo.TechoPresupuesto]
Carpeta=Lista
Clave=ClavePresupuestalCatalogo.TechoPresupuesto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

















[Lista.ListaEnCaptura]
(Inicio)=ClavePresupuestalCatalogo.Nombre
ClavePresupuestalCatalogo.Nombre=ClavePresupuestalCatalogo.Tipo
ClavePresupuestalCatalogo.Tipo=ClavePresupuestalCatalogo.TechoPresupuesto
ClavePresupuestalCatalogo.TechoPresupuesto=(Fin)
