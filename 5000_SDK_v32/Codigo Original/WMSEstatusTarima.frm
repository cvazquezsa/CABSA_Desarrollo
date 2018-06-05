
[Forma]
Clave=WMSEstatusTarima
Icono=0
Modulos=(Todos)
Nombre=Control Calidad Cambiar Estatus

ListaCarpetas=WMSEstatusTarima
CarpetaPrincipal=WMSEstatusTarima
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
PosicionInicialAlturaCliente=706
PosicionInicialAncho=1382
PosicionInicialIzquierda=-8
PosicionInicialArriba=-8
ListaAcciones=(Lista)
Comentarios=Lista(Si(ConDatos(Info.WMSCambiarEstatus), <T>Estaus Aplicar: <T>+Info.WMSCambiarEstatus, <T><T>), Si(ConDatos(Info.WMSFechaCaducidad), <T>Fecha Caducidad: <T>+ FechaEnTexto(Info.WMSFechaCaducidad, <T>dd-mmm-aa<T>), <T><T>), Si(ConDatos(Info.WMSEstatusControlCalidad), <T>Estatus Cont.Cal.: <T>+Info.WMSEstatusControlCalidad), Si(ConDatos(Info.WMSSerieLoteD) y ConDatos(Info.WMSSerieLoteA), <T>Del Lote: <T>+Info.WMSSerieLoteD+<T> Al <T>+Info.WMSSerieLoteA), Si(ConDatos(Info.Almacen), <T>Almacén.: <T>+Info.Almacen))
VentanaTipoMarco=Normal
VentanaPosicionInicial=por Diseño
VentanaEstadoInicial=Maximizado
ExpresionesAlMostrar=Asigna(Info.WMSEstatusControlCalidad, Nulo)<BR>Asigna(Info.WMSSerieLoteD, Nulo)               <BR>Asigna(Info.WMSSerieLoteA, Nulo)<BR>Asigna(Info.WMSFechaCaducidad, Nulo)<BR>Asigna(Info.WMSCambiarEstatus, Nulo)<BR>Asigna(Info.Almacen, Nulo)
[WMSEstatusTarima]
Estilo=Iconos
Clave=WMSEstatusTarima
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=WMSEstatusTarima
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Tarima<T>
IconosSeleccionMultiple=S
ElementosPorPaginaEsp=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S
Filtros=S

FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroTipo=Múltiple (por Grupos)
FiltroGrupo2=WMSEstatusTarima.Zona
FiltroValida2=WMSEstatusTarima.Zona
OtroOrden=S
ListaOrden=(Lista)
BusquedaRapidaControles=S
FiltroFechas=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasCampo=WMSEstatusTarima.TarimaAlta
FiltroFechasDefault=Esta Semana
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
FiltroEstatusDefault=ALTA
MenuLocal=S
ListaAcciones=(Lista)
PestanaOtroNombre=S
PestanaNombre=Tarimas


FiltroEstatus=S
FiltroListaEstatus=(Lista)
FiltroRespetar=S
FiltroGrupo1=WMSEstatusTarima.Almacen
FiltroValida1=WMSEstatusTarima.Almacen
FiltroEnOrden=S
FiltroTodoFinal=S
FiltroTodo=S
BusquedaEnLinea=S
IconosNombre=WMSEstatusTarima:WMSEstatusTarima.Tarima
FiltroGeneral=WMSEstatusTarima.Empresa=<T>{Empresa}<T><BR>{Si(ConDatos(Info.WMSEstatusControlCalidad),<BR><T> AND WMSEstatusTarima.EstatusControlCalidad=<T>+Comillas(Info.WMSEstatusControlCalidad),<T><T>)}<BR>{Si(ConDatos(Info.WMSSerieLoteD) y ConDatos(Info.WMSSerieLoteA),<BR><T> AND WMSEstatusTarima.SerieLote BETWEEN <T>+Comillas(Info.WMSSerieLoteD)+<T> AND <T>+Comillas(Info.WMSSerieLoteA),<T><T>)}<BR>{Si(ConDatos(Info.WMSFechaCaducidad),<BR><T> AND WMSEstatusTarima.FechaCaducidad = <T>+Comillas(FechaFormatoServidor(Info.WMSFechaCaducidad)),<T><T>)}<BR>{Si(ConDatos(Info.Almacen),<BR><T> AND WMSEstatusTarima.Almacen=<T>+Comillas(Info.Almacen),<T><T>)}
[WMSEstatusTarima.WMSEstatusTarima.ArtDescripcion1]
Carpeta=WMSEstatusTarima
Clave=WMSEstatusTarima.ArtDescripcion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[WMSEstatusTarima.WMSEstatusTarima.ArtUnidad]
Carpeta=WMSEstatusTarima
Clave=WMSEstatusTarima.ArtUnidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco



[WMSEstatusTarima.Columnas]
0=79
1=95
2=221
3=98
4=118
5=91
6=75
7=221
8=67
9=86
10=101




11=110
12=-2
13=72
14=81
[Acciones.Cerrar]
Nombre=Cerrar
Boton=21
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S



[WMSEstatusControlCalidad.Columnas]
EstatusControlCalidad=180




























[Lista.Columnas]
SerieLote=188
Existencia=75
Fecha1=97




[WMSSerieLoteLista.Columnas]
SerieLote=202








[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=0
NombreDesplegar=&Seleccionar Todo
EnMenu=S
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






[Acciones.CambiarEstatus]
Nombre=CambiarEstatus
Boton=39
NombreEnBoton=S
NombreDesplegar=&Especificar Estatus Nuevo
EnBarraHerramientas=S
Activo=S
Visible=S



EspacioPrevio=S








TipoAccion=Expresion









Expresion=FormaModal(<T>WMSEspecificarEstatusNuevo<T>)<BR>ActualizarForma
[Acciones.ModificarEstatus]
Nombre=ModificarEstatus
Boton=0
NombreDesplegar=Modificar Estatus en Lote
RefrescarIconos=S
EnLote=S
EnMenu=S
TipoAccion=Expresion
Visible=S

EspacioPrevio=S



























































Expresion=EjecutarSQLAnimado(<T>EXEC spWMSTarimaCambioEstatus :tEmpresa, :nSucursal, :tUsuario, :tAlmacen, :tTarima, :tTipo, :tEstatus<T>,<BR>Empresa, Sucursal, Usuario, WMSEstatusTarima:WMSEstatusTarima.Almacen, WMSEstatusTarima:WMSEstatusTarima.Tarima, WMSEstatusTarima:WMSEstatusTarima.UbicacionTipo, Info.WMSCambiarEstatus) AbortarOperacion
ActivoCondicion=ConDatos(Info.WMSCambiarEstatus)
[Acciones.Filtro]
Nombre=Filtro
Boton=107
NombreEnBoton=S
NombreDesplegar=&Filtros
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S













EspacioPrevio=S





































Expresion=FormaModal(<T>WMSControlCalidadFiltro<T>)<BR>ActualizarForma









[WMSEstatusTarima.WMSEstatusTarima.Posicion]
Carpeta=WMSEstatusTarima
Clave=WMSEstatusTarima.Posicion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[WMSEstatusTarima.WMSEstatusTarima.UbicacionDescripcion]
Carpeta=WMSEstatusTarima
Clave=WMSEstatusTarima.UbicacionDescripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[WMSEstatusTarima.WMSEstatusTarima.UbicacionTipo]
Carpeta=WMSEstatusTarima
Clave=WMSEstatusTarima.UbicacionTipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[WMSEstatusTarima.WMSEstatusTarima.EstatusControlCalidad]
Carpeta=WMSEstatusTarima
Clave=WMSEstatusTarima.EstatusControlCalidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[WMSEstatusTarima.WMSEstatusTarima.Estatus]
Carpeta=WMSEstatusTarima
Clave=WMSEstatusTarima.Estatus
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[WMSEstatusTarima.WMSEstatusTarima.Articulo]
Carpeta=WMSEstatusTarima
Clave=WMSEstatusTarima.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[WMSEstatusTarima.WMSEstatusTarima.Disponible]
Carpeta=WMSEstatusTarima
Clave=WMSEstatusTarima.Disponible
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Totalizador=1
[WMSEstatusTarima.WMSEstatusTarima.TarimaAlta]
Carpeta=WMSEstatusTarima
Clave=WMSEstatusTarima.TarimaAlta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[WMSEstatusTarima.WMSEstatusTarima.FechaCaducidad]
Carpeta=WMSEstatusTarima
Clave=WMSEstatusTarima.FechaCaducidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco



























































































































[WMSEstatusTarima.WMSEstatusTarima.Tarima]
Carpeta=WMSEstatusTarima
Clave=WMSEstatusTarima.Tarima
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco























[WMSEstatusTarima.WMSEstatusTarima.SerieLote]
Carpeta=WMSEstatusTarima
Clave=WMSEstatusTarima.SerieLote
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco






[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=&Excel
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S
















[WMSEstatusTarima.WMSEstatusTarima.Almacen]
Carpeta=WMSEstatusTarima
Clave=WMSEstatusTarima.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco













[WMSEstatusTarima.ListaEnCaptura]
(Inicio)=WMSEstatusTarima.Posicion
WMSEstatusTarima.Posicion=WMSEstatusTarima.UbicacionDescripcion
WMSEstatusTarima.UbicacionDescripcion=WMSEstatusTarima.UbicacionTipo
WMSEstatusTarima.UbicacionTipo=WMSEstatusTarima.EstatusControlCalidad
WMSEstatusTarima.EstatusControlCalidad=WMSEstatusTarima.Estatus
WMSEstatusTarima.Estatus=WMSEstatusTarima.Articulo
WMSEstatusTarima.Articulo=WMSEstatusTarima.ArtDescripcion1
WMSEstatusTarima.ArtDescripcion1=WMSEstatusTarima.Disponible
WMSEstatusTarima.Disponible=WMSEstatusTarima.SerieLote
WMSEstatusTarima.SerieLote=WMSEstatusTarima.TarimaAlta
WMSEstatusTarima.TarimaAlta=WMSEstatusTarima.ArtUnidad
WMSEstatusTarima.ArtUnidad=WMSEstatusTarima.FechaCaducidad
WMSEstatusTarima.FechaCaducidad=WMSEstatusTarima.Tarima
WMSEstatusTarima.Tarima=WMSEstatusTarima.Almacen
WMSEstatusTarima.Almacen=(Fin)

[WMSEstatusTarima.ListaOrden]
(Inicio)=WMSEstatusTarima.Almacen	(Acendente)
WMSEstatusTarima.Almacen	(Acendente)=WMSEstatusTarima.Tarima	(Acendente)
WMSEstatusTarima.Tarima	(Acendente)=(Fin)

[WMSEstatusTarima.FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=ALTA
ALTA=BAJA
BAJA=(Fin)

[WMSEstatusTarima.ListaAcciones]
(Inicio)=Seleccionar
Seleccionar=Quitar
Quitar=ModificarEstatus
ModificarEstatus=(Fin)



[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Filtro
Filtro=CambiarEstatus
CambiarEstatus=Excel
Excel=(Fin)
