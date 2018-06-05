
[Forma]
Clave=ActivoFListaGasto
Icono=0
Modulos=(Todos)
Nombre=Activos Fijos

ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=316
PosicionInicialArriba=140
PosicionInicialAlturaCliente=311
PosicionInicialAncho=645
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=por Diseño
VentanaEstadoInicial=Normal
ExpresionesAlMostrar=Asigna(Info.Mensaje,<T><T>)
[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ActivoFLista
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S
PestanaOtroNombre=S
PestanaNombre=Activos Fijos
OtroOrden=S
BusquedaRapidaControles=S
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Artículo<T>
IconosSeleccionPorLlave=S
IconosSeleccionMultiple=S
ElementosPorPaginaEsp=200

ListaOrden=ActivoF.Articulo<TAB>(Acendente)
FiltroEstatus=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=ACTIVO
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaEnLinea=S
MenuLocal=S
IconosNombre=ActivoFLista:ActivoF.Articulo
ListaAcciones=(Lista)
[Lista.Art.Descripcion1]
Carpeta=Lista
Clave=Art.Descripcion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Lista.ActivoF.Serie]
Carpeta=Lista
Clave=ActivoF.Serie
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.ActivoF.Almacen]
Carpeta=Lista
Clave=ActivoF.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco





[Lista.Columnas]
0=104
1=241
2=76
3=103


4=-2
5=-2
6=-2
7=-2
8=-2


[Acciones.Seleccionar.RegistrarID]
Nombre=RegistrarID
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=RegistrarSeleccionID(<T>Lista<T>)
[Acciones.Seleccionar.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S











[Acciones.Seleccionar.spActualizaRegistros]
Nombre=spActualizaRegistros
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S











[Acciones.Seleccionar.ListaAccionesMultiples]
(Inicio)=spActualizaRegistros
spActualizaRegistros=RegistrarID
RegistrarID=Aceptar
Aceptar=(Fin)
















[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreDesplegar=&Aceptar
EnBarraHerramientas=S
Activo=S
Visible=S

NombreEnBoton=S
GuardarAntes=S






Multiple=S
ListaAccionesMultiples=(Lista)

[Acciones.Aceptar.ResgitrarLista]
Nombre=ResgitrarLista
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=RegistrarSeleccionID( <T>Lista<T> )
[Acciones.Aceptar.spActivosFijos]
Nombre=spActivosFijos
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Asigna(Info.Mensaje,SQL(<T>spCalculoValorAdquisicionAF :nEstacion, :nIdMov, :nRenglon, :tEmpresa, :tModulo, :nBandera<T>, EstacionTrabajo, Info.ID, Info.Renglon,  Empresa, Info.Modulo, 1))<BR>Si<BR>  Info.Mensaje <> <T>Proceso concluido.<T><BR>Entonces<BR>  Informacion(<T>La Fecha de Inicio de la depreciación del Artículo AF dede ser mayor o igual a la fecha emisión del movimiento<T>)<BR>Fin
[Acciones.Aceptar.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S






[Acciones.Cancelar]
Nombre=Cancelar
Boton=21
NombreEnBoton=S
NombreDesplegar=Cancelar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Ventana
ClaveAccion=Cancelar/Cancelar Cambios
Activo=S
Visible=S









[Acciones.SeleccionarTodo]
Nombre=SeleccionarTodo
Boton=0
NombreDesplegar=Seleccionar Todo
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Seleccionar Todo
Activo=S
Visible=S

[Acciones.QuitarTodo]
Nombre=QuitarTodo
Boton=0
NombreDesplegar=Quitar Todo
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Quitar Seleccion
ActivoCondicion=ListaSeleccion( <T>Lista<T> ) <> <T><T>
Visible=S

[Lista.ListaEnCaptura]
(Inicio)=Art.Descripcion1
Art.Descripcion1=ActivoF.Serie
ActivoF.Serie=ActivoF.Almacen
ActivoF.Almacen=(Fin)

[Lista.FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=ACTIVO
ACTIVO=INACTIVO
INACTIVO=(Fin)

[Lista.ListaAcciones]
(Inicio)=SeleccionarTodo
SeleccionarTodo=QuitarTodo
QuitarTodo=(Fin)












[Acciones.Aceptar.ListaAccionesMultiples]
(Inicio)=ResgitrarLista
ResgitrarLista=spActivosFijos
spActivosFijos=Aceptar
Aceptar=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=(Fin)
