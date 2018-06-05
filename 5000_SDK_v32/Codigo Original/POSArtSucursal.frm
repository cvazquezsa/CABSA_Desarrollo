
[Forma]
Clave=POSArtSucursal
Icono=0
CarpetaPrincipal=POSArtSucursal
Modulos=(Todos)
Nombre=Artículos Por Sucursal

ListaCarpetas=POSArtSucursal
PosicionInicialAlturaCliente=521
PosicionInicialAncho=789
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=405
PosicionInicialArriba=150
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
[POSArtSucursal]
Estilo=Iconos
Clave=POSArtSucursal
Filtros=S
BusquedaRapidaControles=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=POSArtSucursal2
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

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
FiltroAplicaEn1=POSArSucursal2.Categoria
FiltroAplicaEn2=POSArSucursal2.Grupo
FiltroAplicaEn3=POSArSucursal2.Familia
FiltroAplicaEn4=POSArSucursal2.Linea
FiltroAplicaEn5=POSArSucursal2.Fabricante
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
FiltroListasAplicaEn=POSArSucursal2.Articulo
FiltroRespetar=S
FiltroArbol=Articulos
FiltroArbolAplica=POSArSucursal2.Rama
FiltroSucursalesSinTodas=S


IconosNombre=POSArtSucursal2:POSArSucursal2.Articulo
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
NombreDesplegar=Aceptar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S




[Acciones.Presentacion preliminar]
Nombre=Presentacion preliminar
Boton=6
NombreDesplegar=Presentacion preliminar
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S



EspacioPrevio=S



[Acciones.Enviar a Excel]
Nombre=Enviar a Excel
Boton=115
NombreDesplegar=Enviar a Excel
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S











[POSArtSucursal.POSArSucursal2.Descripcion1]
Carpeta=POSArtSucursal
Clave=POSArSucursal2.Descripcion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[POSArtSucursal.POSArSucursal2.Codigo]
Carpeta=POSArtSucursal
Clave=POSArSucursal2.Codigo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco


[POSArtSucursal.ListaEnCaptura]
(Inicio)=POSArSucursal2.Descripcion1
POSArSucursal2.Descripcion1=POSArSucursal2.Codigo
POSArSucursal2.Codigo=(Fin)

[POSArtSucursal.ListaOrden]
(Inicio)=POSArSucursal2.Articulo	(Acendente)
POSArSucursal2.Articulo	(Acendente)=POSArSucursal2.Sucursal	(Acendente)
POSArSucursal2.Sucursal	(Acendente)=(Fin)



































[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Enviar a Excel
Enviar a Excel=Presentacion preliminar
Presentacion preliminar=(Fin)
