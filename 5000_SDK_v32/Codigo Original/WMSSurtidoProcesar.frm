



[Forma]
Clave=WMSSurtidoProcesar
Icono=0
Modulos=(Todos)
Nombre=Procesar
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S
VentanaEstadoInicial=Normal

CarpetaPrincipal=WMSSurtidoProcesarD
PosicionInicialIzquierda=11
PosicionInicialArriba=9
PosicionInicialAlturaCliente=672
PosicionInicialAncho=1344
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaCarpetas=WMSSurtidoProcesarD
ListaAcciones=(Lista)
BarraAyuda1=Conteo(WMSSurtidoProcesarD:WMSSurtidoProcesarD.Articulo)
Totalizadores=S
PosicionSec1=596
[WMSSurtidoProcesar.WMSSurtidoProcesar.Articulo]
Carpeta=WMSSurtidoProcesar
Clave=WMSSurtidoProcesar.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[WMSSurtidoProcesar.WMSSurtidoProcesar.Tarima]
Carpeta=WMSSurtidoProcesar
Clave=WMSSurtidoProcesar.Tarima
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[WMSSurtidoProcesar.WMSSurtidoProcesar.Tipo]
Carpeta=WMSSurtidoProcesar
Clave=WMSSurtidoProcesar.Tipo
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[WMSSurtidoProcesar.WMSSurtidoProcesar.PosicionOrigen]
Carpeta=WMSSurtidoProcesar
Clave=WMSSurtidoProcesar.PosicionOrigen
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[WMSSurtidoProcesar.WMSSurtidoProcesar.PosicionDestino]
Carpeta=WMSSurtidoProcesar
Clave=WMSSurtidoProcesar.PosicionDestino
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[WMSSurtidoProcesar.WMSSurtidoProcesar.Acomodador]
Carpeta=WMSSurtidoProcesar
Clave=WMSSurtidoProcesar.Acomodador
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[WMSSurtidoProcesar.WMSSurtidoProcesar.CantidadTarima]
Carpeta=WMSSurtidoProcesar
Clave=WMSSurtidoProcesar.CantidadTarima
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[WMSSurtidoProcesar.WMSSurtidoProcesar.Zona]
Carpeta=WMSSurtidoProcesar
Clave=WMSSurtidoProcesar.Zona
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


[WMSSurtidoProcesar.Columnas]
0=-2
1=-2
2=-2
3=-2
4=-2
5=-2
6=-2
7=-2
8=-2

[WMSSurtidoProcesar.ListaEnCaptura]
(Inicio)=WMSSurtidoProcesar.Articulo
WMSSurtidoProcesar.Articulo=WMSSurtidoProcesar.Tarima
WMSSurtidoProcesar.Tarima=WMSSurtidoProcesar.Tipo
WMSSurtidoProcesar.Tipo=WMSSurtidoProcesar.PosicionOrigen
WMSSurtidoProcesar.PosicionOrigen=WMSSurtidoProcesar.PosicionDestino
WMSSurtidoProcesar.PosicionDestino=WMSSurtidoProcesar.Acomodador
WMSSurtidoProcesar.Acomodador=WMSSurtidoProcesar.CantidadTarima
WMSSurtidoProcesar.CantidadTarima=WMSSurtidoProcesar.Zona
WMSSurtidoProcesar.Zona=(Fin)

[WMSSurtidoProcesarD]
Estilo=Hoja
Clave=WMSSurtidoProcesarD
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=WMSSurtidoProcesarD
Fuente={Tahoma, 8, Negro, []}
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S

PestanaOtroNombre=S
OtroOrden=S
BusquedaRapidaControles=S
ListaOrden=(Lista)
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
MenuLocal=S
ListaAcciones=TarimaModificar
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=WMSSurtidoProcesarD.Estacion = {EstacionTrabajo} AND WMSSurtidoProcesarD.Procesado = 0
[WMSSurtidoProcesarD.WMSSurtidoProcesarD.Tarima]
Carpeta=WMSSurtidoProcesarD
Clave=WMSSurtidoProcesarD.Tarima
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[WMSSurtidoProcesarD.WMSSurtidoProcesarD.Tipo]
Carpeta=WMSSurtidoProcesarD
Clave=WMSSurtidoProcesarD.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[WMSSurtidoProcesarD.WMSSurtidoProcesarD.PosicionOrigen]
Carpeta=WMSSurtidoProcesarD
Clave=WMSSurtidoProcesarD.PosicionOrigen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[WMSSurtidoProcesarD.WMSSurtidoProcesarD.PosicionDestino]
Carpeta=WMSSurtidoProcesarD
Clave=WMSSurtidoProcesarD.PosicionDestino
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[WMSSurtidoProcesarD.WMSSurtidoProcesarD.Acomodador]
Carpeta=WMSSurtidoProcesarD
Clave=WMSSurtidoProcesarD.Acomodador
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[WMSSurtidoProcesarD.WMSSurtidoProcesarD.CantidadTarima]
Carpeta=WMSSurtidoProcesarD
Clave=WMSSurtidoProcesarD.CantidadTarima
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[WMSSurtidoProcesarD.WMSSurtidoProcesarD.Zona]
Carpeta=WMSSurtidoProcesarD
Clave=WMSSurtidoProcesarD.Zona
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Acciones.Acomodador.EspecificarAgente]
Nombre=EspecificarAgente
Boton=0
TipoAccion=Formas
ClaveAccion=EspecificarAgente
Activo=S
Visible=S

[Acciones.Acomodador]
Nombre=Acomodador
Boton=74
NombreEnBoton=S
NombreDesplegar=Especificar Acomodador
Multiple=S
EnBarraHerramientas=S
TipoAccion=Formas
ListaAccionesMultiples=(Lista)
Activo=S






VisibleCondicion=1=2
[WMSSurtidoProcesarD.Columnas]
0=-2
1=-2
2=-2
3=-2
4=-2
5=-2
6=-2
7=84


8=49
9=-2
Articulo=67
Tarima=72
Tipo=74
PosicionOrigen=90
PosicionDestino=86
Acomodador=72
CantidadTarima=96
Zona=116
Unidad=63
CantidadUnidad=83
SubCuenta=124
TarimaFechaCaducidad=121
SerieLote=124
Modulo=60
Movimiento=142
Mov=124
MovID=124
[Acciones.Acomodador.spWMSAsignaAcomodador]
Nombre=spWMSAsignaAcomodador
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S



Expresion=RegistrarSeleccion(<T>WMSSurtidoProcesarD<T>)<BR>EjecutarSQL(<T>spWMSAsignaAcomodador :tAgente, :nEstacion, :tTipo, :tMontacarga<T>,Info.Agente, EstacionTrabajo, <T>WMSSurtidoProcesarD<T>, info.Agente)
[Acciones.Acomodador.Actualizar Vista]
Nombre=Actualizar Vista
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S

ConCondicion=S

EjecucionCondicion=1=1
[Acciones.GeneraSurtido]
Nombre=GeneraSurtido
Boton=7
NombreEnBoton=S
NombreDesplegar=Afectar
EnBarraHerramientas=S
TipoAccion=Expresion
Visible=S













Multiple=S
ListaAccionesMultiples=(Lista)


EspacioPrevio=S
ActivoCondicion=ConDatos(WMSSurtidoProcesarD:WMSSurtidoProcesarD.PosicionDestino)
[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=0
NombreEnBoton=S
NombreDesplegar=&Seleccionar Todo
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Seleccionar Todo






[Acciones.GeneraSurtido.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=EjecutarSQL(<T>EXEC spTMAArtListaSt :nE<T>, EstacionTrabajo)<BR>ProcesarSQL(<T>spWMSGeneraSurtido :nE, :tU<T>, EstacionTrabajo, Usuario)
[Acciones.GeneraSurtido.Cerrar]
Nombre=Cerrar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S








[Acciones.Posicion]
Nombre=Posicion
Boton=100
NombreEnBoton=S
NombreDesplegar=Especificar Posición Surtido
Multiple=S
EnBarraHerramientas=S



ListaAccionesMultiples=(Lista)

Antes=S

Activo=S
Visible=S
EspacioPrevio=S
AntesExpresiones=Asigna(Info.Tipo, <T>Surtido<T>)
[Acciones.Posicion.spWMSAsignaPosicion]
Nombre=spWMSAsignaPosicion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S



Expresion=Asigna(Info.Tipo, <T>Surtido<T>)<BR>Si Forma(<T>EspecificarPosicion<T>)<BR>Entonces<BR>  RegistrarSeleccion(<T>WMSSurtidoProcesarD<T>)<BR>  EjecutarSQL(<T>spWMSAsignaPosicion :tPosicion, :nEstacion<T>,Info.Posicion, EstacionTrabajo)<BR>Fin
[Acciones.Posicion.Actualizar Vista]
Nombre=Actualizar Vista
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
ConCondicion=S
Visible=S





EjecucionCondicion=1=1
[Acciones.Posicion.EspecificarAlmacen]
Nombre=EspecificarAlmacen
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S







Expresion=RegistrarSeleccion(<T>WMSSurtidoProcesarD<T>)<BR>Asigna(Info.Almacen, SQL(<T>SELECT TOP 1 Almacen FROM WMSSurtidoProcesarD WHERE Procesado = :nProcesado AND Estacion = :nEstacion<T>, 0, EstacionTrabajo))
[Acciones.WMSSurtidoPendiente]
Nombre=WMSSurtidoPendiente
Boton=101
NombreEnBoton=S
NombreDesplegar=Surtidos Pendientes
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=WMSSurtidoPendiente





























































Visible=S









EspacioPrevio=S
ActivoCondicion=SQL(<T>IF EXISTS(SELECT * FROM WMSSurtidoPendiente WHERE Estacion = :Estacion) SELECT 1 ELSE SELECT 0<T>,  EstacionTrabajo )

[WMSSurtidoProcesarD.WMSSurtidoProcesarD.Unidad]
Carpeta=WMSSurtidoProcesarD
Clave=WMSSurtidoProcesarD.Unidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[WMSSurtidoProcesarD.WMSSurtidoProcesarD.CantidadUnidad]
Carpeta=WMSSurtidoProcesarD
Clave=WMSSurtidoProcesarD.CantidadUnidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
















[WMSSurtidoProcesarD.WMSSurtidoProcesarD.Articulo]
Carpeta=WMSSurtidoProcesarD
Clave=WMSSurtidoProcesarD.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco









[(Carpeta Totalizadores)]
PestanaOtroNombre=S
PestanaNombre=Totalizadores
Clave=(Carpeta Totalizadores)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
Totalizadores1=Renglon
Totalizadores2=Conteo(WMSSurtidoProcesarD:WMSSurtidoProcesarD.Articulo)
Totalizadores=S
TotCarpetaRenglones=WMSSurtidoProcesarD
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=Renglon
CarpetaVisible=S

[(Carpeta Totalizadores).Renglon]
Carpeta=(Carpeta Totalizadores)
Clave=Renglon
Editar=S
3D=S
Tamano=15
ColorFondo=Plata














[WMSSurtidoProcesarD.WMSSurtidoProcesarD.SubCuenta]
Carpeta=WMSSurtidoProcesarD
Clave=WMSSurtidoProcesarD.SubCuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco






[WMSSurtidoProcesarD.WMSSurtidoProcesarD.TarimaFechaCaducidad]
Carpeta=WMSSurtidoProcesarD
Clave=WMSSurtidoProcesarD.TarimaFechaCaducidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco








































[Acciones.TarimaModificar]
Nombre=TarimaModificar
Boton=0
NombreDesplegar=Modificar Tarima
EnMenu=S
TipoAccion=Formas
ClaveAccion=EspecificarTarimaWMS
Antes=S




















































AntesExpresiones=Asigna(Info.Almacen,WMSSurtidoProcesarD:WMSSurtidoProcesarD.Almacen)<BR>Asigna(Info.Articulo,WMSSurtidoProcesarD:WMSSurtidoProcesarD.Articulo)<BR>Asigna(Info.SubCuenta,WMSSurtidoProcesarD:WMSSurtidoProcesarD.SubCuenta)<BR>//Asigna(Info.Posicion,WMSSurtidoProcesarD:WMSSurtidoProcesarD.PosicionOrigen)<BR>Asigna(Info.Tipo,WMSSurtidoProcesarD:WMSSurtidoProcesarD.Tipo)<BR>Asigna(Info.Cantidad,WMSSurtidoProcesarD:WMSSurtidoProcesarD.CantidadTarima)






















[Lista.Columnas]
Posicion=127
Tipo=139
ArticuloEsp=124
Pasillo=45
Nivel=37
Zona=112
Descripcion=130
Estatus=54




























Almacen=100
Tarima=121
[Acciones.Posicion.ListaAccionesMultiples]
(Inicio)=EspecificarAlmacen
EspecificarAlmacen=spWMSAsignaPosicion
spWMSAsignaPosicion=Actualizar Vista
Actualizar Vista=(Fin)























[WMSSurtidoProcesarD.Movimiento]
Carpeta=WMSSurtidoProcesarD
Clave=Movimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco










[Acciones.Excel]
Nombre=Excel
Boton=115
NombreDesplegar=&Excel
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S












[Acciones.Acomodador.ListaAccionesMultiples]
(Inicio)=EspecificarAgente
EspecificarAgente=spWMSAsignaAcomodador
spWMSAsignaAcomodador=Actualizar Vista
Actualizar Vista=(Fin)




[Acciones.GeneraSurtido.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Cerrar
Cerrar=(Fin)






























[WMSSurtidoProcesarD.ListaEnCaptura]
(Inicio)=WMSSurtidoProcesarD.Articulo
WMSSurtidoProcesarD.Articulo=WMSSurtidoProcesarD.SubCuenta
WMSSurtidoProcesarD.SubCuenta=WMSSurtidoProcesarD.Tarima
WMSSurtidoProcesarD.Tarima=WMSSurtidoProcesarD.TarimaFechaCaducidad
WMSSurtidoProcesarD.TarimaFechaCaducidad=WMSSurtidoProcesarD.CantidadUnidad
WMSSurtidoProcesarD.CantidadUnidad=WMSSurtidoProcesarD.Unidad
WMSSurtidoProcesarD.Unidad=WMSSurtidoProcesarD.Tipo
WMSSurtidoProcesarD.Tipo=WMSSurtidoProcesarD.PosicionOrigen
WMSSurtidoProcesarD.PosicionOrigen=WMSSurtidoProcesarD.PosicionDestino
WMSSurtidoProcesarD.PosicionDestino=WMSSurtidoProcesarD.Acomodador
WMSSurtidoProcesarD.Acomodador=WMSSurtidoProcesarD.CantidadTarima
WMSSurtidoProcesarD.CantidadTarima=WMSSurtidoProcesarD.Zona
WMSSurtidoProcesarD.Zona=Movimiento
Movimiento=(Fin)

[WMSSurtidoProcesarD.ListaOrden]
(Inicio)=WMSSurtidoProcesarD.Articulo	(Acendente)
WMSSurtidoProcesarD.Articulo	(Acendente)=WMSSurtidoProcesarD.Tipo	(Acendente)
WMSSurtidoProcesarD.Tipo	(Acendente)=(Fin)











[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=WMSSurtidoPendiente
WMSSurtidoPendiente=Posicion
Posicion=GeneraSurtido
GeneraSurtido=Excel
Excel=Acomodador
Acomodador=Seleccionar
Seleccionar=(Fin)
