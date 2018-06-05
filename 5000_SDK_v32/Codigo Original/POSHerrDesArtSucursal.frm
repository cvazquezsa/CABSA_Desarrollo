
[Forma]
Clave=POSHerrDesArtSucursal
Icono=44
Modulos=(Todos)

ListaCarpetas=POSArtSucursal
PosicionInicialAlturaCliente=521
PosicionInicialAncho=803
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=398
PosicionInicialArriba=150
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
CarpetaPrincipal=POSArtSucursal
Nombre=Herramienta Desasignar Artículos Por Sucursal
[POSArtSucursal]
Estilo=Iconos
Clave=POSArtSucursal
Filtros=S
BusquedaRapidaControles=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=POSArtSucursal
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=Art.Descripcion1

FiltroPredefinido=S
FiltroGrupo1=(Validaciones Memoria)
FiltroValida1=ArtCat
FiltroGrupo2=(Validaciones Memoria)
FiltroValida2=ArtGrupo
FiltroGrupo3=(Validaciones Memoria)
FiltroValida3=ArtFam
FiltroGrupo4=(Validaciones Memoria)
FiltroValida4=ArtLinea
FiltroGrupo5=(Validaciones Memoria)
FiltroValida5=Fabricante
FiltroAplicaEn1=Art.Categoria
FiltroAplicaEn2=Art.Grupo
FiltroAplicaEn3=Art.Familia
FiltroAplicaEn4=Art.Linea
FiltroAplicaEn5=Art.Fabricante
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroTipo=Múltiple (por Grupos)
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroSucursales=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
CarpetaVisible=S
PestanaOtroNombre=S
PestanaNombre=Artículos
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Clave<T>
ElementosPorPaginaEsp=200
FiltroTodo=S
FiltroTodoFinal=S
OtroOrden=S
ListaOrden=(Lista)
FiltroListas=S
FiltroListasRama=INV
FiltroListasAplicaEn=POSArtSucursal.Articulo
FiltroRespetar=S
FiltroArbol=Articulos
FiltroArbolAplica=Art.Rama
FiltroSucursalesSinTodas=S

IconosSeleccionMultiple=S
MenuLocal=S
ListaAcciones=(Lista)
IconosNombre=POSArtSucursal:POSArtSucursal.Articulo
[POSArtSucursal.Art.Descripcion1]
Carpeta=POSArtSucursal
Clave=Art.Descripcion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[POSArtSucursal.Columnas]
Articulo=124
Descripcion1=415
0=145
1=303




2=174
[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aceptar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S




[Acciones.Expresion]
Nombre=Expresion
Boton=40
NombreDesplegar=&Desasignar
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S



NombreEnBoton=S




EspacioPrevio=S










Expresion=RegistrarSeleccion(<T>POSHerrDesArtSucursal<T>)<BR>ProcesarSQL(<T>spPOSEliminarPOSArtSucursal :nEstacion,:nSucursal<T>,EstacionTrabajo,POSArtSucursal:POSArtSucursal.Sucursal)<BR>ActualizarForma





[Acciones.Seleccionar Todo]
Nombre=Seleccionar Todo
Boton=0
NombreDesplegar=Seleccionar Todo
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Seleccionar Todo
Activo=S
Visible=S

[Acciones.Quitar Seleccion]
Nombre=Quitar Seleccion
Boton=0
NombreDesplegar=Quitar Seleccion
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Quitar Seleccion
Activo=S
Visible=S









[POSArtSucursal.ListaEnCaptura]
(Inicio)=Art.Descripcion1
Art.Descripcion1=CB.Codigo
CB.Codigo=(Fin)













[POSArtSucursal.ListaOrden]
(Inicio)=POSArtSucursal.Articulo	(Acendente)
POSArtSucursal.Articulo	(Acendente)=POSArtSucursal.Sucursal	(Acendente)
POSArtSucursal.Sucursal	(Acendente)=(Fin)

[POSArtSucursal.ListaAcciones]
(Inicio)=Seleccionar Todo
Seleccionar Todo=Quitar Seleccion
Quitar Seleccion=(Fin)







[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Expresion
Expresion=(Fin)
