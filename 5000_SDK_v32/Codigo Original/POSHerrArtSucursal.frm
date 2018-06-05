
[Forma]
Clave=POSHerrArtSucursal
Nombre=Herramienta Asignar Artículos Por Sucursal
Icono=44
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=204
PosicionInicialArriba=108
PosicionInicialAltura=425
PosicionInicialAncho=958
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S
MovModulo=INV
PosicionInicialAlturaCliente=473

VentanaEstadoInicial=Normal
VentanaExclusivaOpcion=0
ExpresionesAlMostrar=EjecutarSQL(<T>spPOSBorrarPOSArtSucursalTemp :nEstacion<T>,EstacionTrabajo)
[Lista]
Estilo=Iconos
Clave=Lista
BusquedaRapidaControles=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=POSArt
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
BusquedaRapida=S
BusquedaInicializar=S
BusquedaAncho=25
BusquedaEnLinea=S
CarpetaVisible=S
Filtros=S
FiltroGrupo1=(Validaciones Memoria)
FiltroPredefinido=S
FiltroAplicaEn=Art.Categoria
FiltroTipo=Múltiple (por Grupos)
FiltroTodo=S
FiltroEnOrden=S
FiltroTodoNombre=Todos
FiltroTodoFinal=S
FiltroNullNombre=(sin familia)
FiltroRespetar=S
FiltroAncho=25
FiltroClase=S
FiltroClaseTodo=S
FiltroFechasNormal=S
FiltroListas=S
FiltroListasRama=INV
FiltroListasAplicaEn=Art.Articulo
FiltroGrupo2=(Validaciones Memoria)
FiltroValida2=ArtGrupo
FiltroGrupo3=(Validaciones Memoria)
FiltroValida3=ArtFam
FiltroGrupo4=(Validaciones Memoria)
FiltroValida4=ArtLinea
FiltroAplicaEn2=Art.Grupo
FiltroAplicaEn3=Art.Familia
FiltroAplicaEn4=Art.Linea
MenuLocal=S
ListaAcciones=(Lista)
OtroOrden=S
ListaOrden=Art.Articulo<TAB>(Acendente)
PermiteLocalizar=S
PestanaNombre=Artículos
FiltroEstatus=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=ALTA
FiltroGrupo5=(Validaciones Memoria)
FiltroValida5=Fabricante
FiltroAplicaEn5=Art.Fabricante
FiltroArbol=Articulos
FiltroArbolAplica=Art.Rama
FiltroSituacion=S
FiltroSituacionTodo=S

IconosCampo=CtaSituacion.Icono
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSeleccionMultiple=S
IconosSubTitulo=<T>Artículo<T>

PestanaOtroNombre=S

ListaEnCaptura=Art.Descripcion1
FiltroValida1=ArtCat
FiltroAplicaEn1=Art.Categoria
Paginacion=S
PaginacionTamano=200

IconosNombre=POSArt:Art.Articulo
FiltroGeneral=Art.Tipo<><T>Estructura<T>
BusquedaRespetarControles=S

[Lista.Columnas]
Articulo=131
Descripcion1=244

0=260
1=-2


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

[Acciones.Todo]
Nombre=Todo
Boton=0
NombreDesplegar=Seleccionar &Todo
EnMenu=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Seleccionar Todo
Activo=S
Visible=S

[Acciones.Quitar]
Nombre=Quitar
Boton=0
NombreDesplegar=&Quitar Selección
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Quitar Seleccion
Activo=S
Visible=S














[Lista.ListaEnCaptura]
(Inicio)=Art.Articulo
Art.Articulo=Art.Descripcion1
Art.Descripcion1=(Fin)












[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aceptar
EnBarraHerramientas=S
EnBarraAcciones=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S


[Acciones.Sucursales]
Nombre=Sucursales
Boton=16
NombreEnBoton=S
NombreDesplegar=&Sucursales
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S






EspacioPrevio=S
Expresion=FormaModal(<T>POSArtSucursalTemp<T>)
[POSArtSucursalTemp.Columnas]
Sucursal=64
Nombre=300






[Acciones.Generar]
Nombre=Generar
Boton=7
NombreEnBoton=S
NombreDesplegar=&Generar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Visible=S





















































Expresion=Asigna(Temp.Logico,SQL(<T>SELECT dbo.fnPOSvalidarPOSArtSucursalTemp(:nEstacion)<T>,EstacionTrabajo))<BR>Si<BR>  Temp.Logico<BR>Entonces<BR>  RegistrarSeleccion(<T>POSHerrArtSucursal<T>)<BR>  ProcesarSQL(<T>spPOSInsertarPOSArtSucursal :nEstacion<T>,EstacionTrabajo)  <BR>Sino<BR>   Error( <T>Es Necesario Asignar Una o Mas sucursales<T> ) <BR>Fin
[Lista.Art.Descripcion1]
Carpeta=Lista
Clave=Art.Descripcion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco



















[Acciones.Pagina Avanzar]
Nombre=Pagina Avanzar
Boton=25
NombreEnBoton=S
NombreDesplegar=Página Avanzar
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Pagina Avanzar
Activo=S
Visible=S



EspacioPrevio=S



[Acciones.Pagina Retroceder]
Nombre=Pagina Retroceder
Boton=24
NombreEnBoton=S
NombreDesplegar=Página Retroceder
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Pagina Retroceder
Activo=S
Visible=S











































[Lista.FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=PROTOTIPO
PROTOTIPO=ALTA
ALTA=BLOQUEADO
BLOQUEADO=DESCONTINUADO
DESCONTINUADO=BAJA
BAJA=(Fin)

[Lista.ListaAcciones]
(Inicio)=Actualizar
Actualizar=Todo
Todo=Quitar
Quitar=(Fin)



















[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Sucursales
Sucursales=Generar
Generar=Pagina Retroceder
Pagina Retroceder=Pagina Avanzar
Pagina Avanzar=(Fin)
