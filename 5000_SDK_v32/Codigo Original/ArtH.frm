[Forma]
Clave=ArtH
Nombre=Artículos - Datos Planeación
Icono=4
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=240
PosicionInicialArriba=258
PosicionInicialAltura=508
PosicionInicialAncho=800
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
PosicionInicialAlturaCliente=481
SinCondicionDespliege=S

[Lista]
Estilo=Hoja
Clave=Lista
ValidarCampos=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ArtH
Fuente={MS Sans Serif, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
ListaCamposAValidar=(Lista)
CarpetaVisible=S
Filtros=S
BusquedaRapidaControles=S
FiltroPredefinido=S
FiltroGrupo1=(Validaciones Memoria)
FiltroValida1=ArtCat
FiltroGrupo2=(Validaciones Memoria)
FiltroValida2=ArtGrupo
FiltroGrupo3=(Validaciones Memoria)
FiltroValida3=ArtFam
FiltroGrupo4=(Validaciones Memoria)
FiltroValida4=ArtLinea
FiltroAplicaEn1=Art.Categoria
FiltroAplicaEn2=Art.Grupo
FiltroAplicaEn3=Art.Familia
FiltroAplicaEn4=Art.Linea
FiltroNullNombre=(sin clasificar)
FiltroTodo=S
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroTodoFinal=S
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
FiltroArbol=Articulos
FiltroArbolAplica=Art.Rama
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
HojaAjustarColumnas=S
FiltroGrupo5=(Validaciones Memoria)
FiltroValida5=Fabricante
FiltroAplicaEn5=Art.Fabricante

[Lista.Art.Articulo]
Carpeta=Lista
Clave=Art.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Art.SeCompra]
Carpeta=Lista
Clave=Art.SeCompra
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Art.SeVende]
Carpeta=Lista
Clave=Art.SeVende
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Art.SeProduce]
Carpeta=Lista
Clave=Art.SeProduce
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Art.TiempoEntrega]
Carpeta=Lista
Clave=Art.TiempoEntrega
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Art.TiempoEntregaUnidad]
Carpeta=Lista
Clave=Art.TiempoEntregaUnidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Art.InvSeguridad]
Carpeta=Lista
Clave=Art.InvSeguridad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Art.LoteOrdenar]
Carpeta=Lista
Clave=Art.LoteOrdenar
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Art.CantidadOrdenar]
Carpeta=Lista
Clave=Art.CantidadOrdenar
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Art.MultiplosOrdenar]
Carpeta=Lista
Clave=Art.MultiplosOrdenar
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Articulo=110
SeCompra=60
SeVende=54
SeProduce=62
TiempoEntrega=81
TiempoEntregaUnidad=62
InvSeguridad=106
LoteOrdenar=143
CantidadOrdenar=72
MultiplosOrdenar=70
AlmacenROP=164
Ruta=82
ProdRuta=88

[Lista.Art.ProdRuta]
Carpeta=Lista
Clave=Art.ProdRuta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

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

[Lista.Art.AlmacenROP]
Carpeta=Lista
Clave=Art.AlmacenROP
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ListaEnCaptura]
(Inicio)=Art.Articulo
Art.Articulo=Art.SeCompra
Art.SeCompra=Art.SeVende
Art.SeVende=Art.SeProduce
Art.SeProduce=Art.TiempoEntrega
Art.TiempoEntrega=Art.TiempoEntregaUnidad
Art.TiempoEntregaUnidad=Art.InvSeguridad
Art.InvSeguridad=Art.LoteOrdenar
Art.LoteOrdenar=Art.CantidadOrdenar
Art.CantidadOrdenar=Art.MultiplosOrdenar
Art.MultiplosOrdenar=Art.AlmacenROP
Art.AlmacenROP=Art.ProdRuta
Art.ProdRuta=(Fin)

[Lista.ListaCamposAValidar]
(Inicio)=Art.Articulo
Art.Articulo=Art.Descripcion1
Art.Descripcion1=ProdRuta.Descripcion
ProdRuta.Descripcion=(Fin)
