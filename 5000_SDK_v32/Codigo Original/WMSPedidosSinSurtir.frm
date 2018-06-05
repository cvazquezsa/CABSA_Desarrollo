
[Forma]
Clave=WMSPedidosSinSurtir
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=WMS - Surtidos Pendientes

ListaCarpetas=(Lista)
CarpetaPrincipal=Lista
PosicionInicialIzquierda=345
PosicionInicialArriba=132
PosicionInicialAlturaCliente=425
PosicionInicialAncho=675
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionSec1=263
PosicionCol1=105
ExpresionesAlMostrar=EjecutarSQL(<T>EXEC spWMSValidaTarimaSurtido :nEstacion, 1<T>, EstacionTrabajo)<BR>EjecutarSQL(<T>EXEC spWMSPedidosPendientes :nEstacion, :tEmpresa<T>, EstacionTrabajo, Empresa)
[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=WMSPedidosSinSurtir
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosSubTitulo=<T>Movimiento<T>
IconosSeleccionPorLlave=S
IconosSeleccionMultiple=S
ElementosPorPaginaEsp=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S

MenuLocal=S
ListaAcciones=(Lista)
IconosCambiarOrden=S
OtroOrden=S
ListaOrden=WMSPedidosSinSurtir.ID<TAB>(Acendente)
Paginacion=S
PaginacionTamano=25
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
IconosNombre=WMSPedidosSinSurtir.Mov+<T> <T>+WMSPedidosSinSurtir.MovID
FiltroGeneral=WMSPedidosSinSurtir.Estacion = {EstacionTrabajo}
[Lista.WMSPedidosSinSurtir.Modulo]
Carpeta=Lista
Clave=WMSPedidosSinSurtir.Modulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.WMSPedidosSinSurtir.Almacen]
Carpeta=Lista
Clave=WMSPedidosSinSurtir.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.WMSPedidosSinSurtir.Articulo]
Carpeta=Lista
Clave=WMSPedidosSinSurtir.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.WMSPedidosSinSurtir.SubCuenta]
Carpeta=Lista
Clave=WMSPedidosSinSurtir.SubCuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.WMSPedidosSinSurtir.Tarima]
Carpeta=Lista
Clave=WMSPedidosSinSurtir.Tarima
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.WMSPedidosSinSurtir.Cantidad]
Carpeta=Lista
Clave=WMSPedidosSinSurtir.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.Columnas]
0=109
1=79
2=94
3=-2
4=65
5=-2
6=98






Almacen=64
Articulo=89
SubCuenta=68
Tarima=77
SerieLote=76
Disponible=64
CantidadA=64
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

[Acciones.VerTarimas.Tarimas]
Nombre=Tarimas
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=RegistrarSeleccionID( <T>ListaID<T> )<BR>EjecutarSQL(<T>EXEC spWMSMostrarTarimas :nEstacion<T>, EstacionTrabajo )<BR>FormaModal(<T>WMSTarimaDisponible<T>)<BR>ActualizarForma
[Acciones.VerTarimas]
Nombre=VerTarimas
Boton=0
NombreDesplegar=&Ver Tarimas
Multiple=S
EnMenu=S
ListaAccionesMultiples=Tarimas
Visible=S



ActivoCondicion=CuantosSeleccionID( <T>Lista<T> ) > 0
[Acciones.SeleccionarTodo]
Nombre=SeleccionarTodo
Boton=0
NombreDesplegar=&Seleccionar Todo
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=SeleccionarTodo( <T>Lista<T> )
[Acciones.QuitarSeleccion]
Nombre=QuitarSeleccion
Boton=0
NombreDesplegar=&Quitar Selección
EnMenu=S
TipoAccion=Expresion
Visible=S
Expresion=QuitarSeleccion( <T>Lista<T> )
ActivoCondicion=CuantosSeleccionID( <T>Lista<T> ) > 0









[Detalle]
Estilo=Hoja
Clave=Detalle
Detalle=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=WMSTarimaDisponible
Fuente={Tahoma, 8, Negro, []}
VistaMaestra=WMSPedidosSinSurtir
LlaveLocal=WMSTarimaDisponible.ID
LlaveMaestra=WMSPedidosSinSurtir.ID
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S

Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=WMSTarimaDisponible.CantidadA > 0
[Detalle.WMSTarimaDisponible.Almacen]
Carpeta=Detalle
Clave=WMSTarimaDisponible.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Detalle.WMSTarimaDisponible.Articulo]
Carpeta=Detalle
Clave=WMSTarimaDisponible.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.WMSTarimaDisponible.SubCuenta]
Carpeta=Detalle
Clave=WMSTarimaDisponible.SubCuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Detalle.WMSTarimaDisponible.SerieLote]
Carpeta=Detalle
Clave=WMSTarimaDisponible.SerieLote
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Detalle.WMSTarimaDisponible.Tarima]
Carpeta=Detalle
Clave=WMSTarimaDisponible.Tarima
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.WMSTarimaDisponible.Disponible]
Carpeta=Detalle
Clave=WMSTarimaDisponible.Disponible
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.WMSTarimaDisponible.CantidadA]
Carpeta=Detalle
Clave=WMSTarimaDisponible.CantidadA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco


[Detalle.Columnas]
Almacen=64
Articulo=72
SubCuenta=77
SerieLote=90
Tarima=83
Disponible=64
CantidadA=86







[Detalle.ListaEnCaptura]
(Inicio)=WMSTarimaDisponible.Almacen
WMSTarimaDisponible.Almacen=WMSTarimaDisponible.Articulo
WMSTarimaDisponible.Articulo=WMSTarimaDisponible.SubCuenta
WMSTarimaDisponible.SubCuenta=WMSTarimaDisponible.SerieLote
WMSTarimaDisponible.SerieLote=WMSTarimaDisponible.Tarima
WMSTarimaDisponible.Tarima=WMSTarimaDisponible.Disponible
WMSTarimaDisponible.Disponible=WMSTarimaDisponible.CantidadA
WMSTarimaDisponible.CantidadA=(Fin)


























[Acciones.Procesar]
Nombre=Procesar
Boton=7
NombreEnBoton=S
NombreDesplegar=&Procesar
Multiple=S
EnBarraHerramientas=S
EspacioPrevio=S
Activo=S
Visible=S





ListaAccionesMultiples=(Lista)


[Acciones.Procesar.Procesar]
Nombre=Procesar
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=GuardarCambios<BR>Asigna(Info.Mensaje, SQL(<T>EXEC spWMSValidaTarimaSurtido :nEstacion, 0<T>, EstacionTrabajo))<BR>Si<BR>    Info.Mensaje = <T><T><BR>Entonces<BR>    EjecutarSQL(<T>EXEC spWMSRegeneraSurtidos :nEstacion, :tUsuario<T>, EstacionTrabajo, Usuario)<BR>    EjecutarSQL(<T>EXEC spWMSValidaTarimaSurtido :nEstacion, 1<T>, EstacionTrabajo)<BR>    EjecutarSQL(<T>EXEC spWMSPedidosPendientes :nEstacion, :tEmpresa<T>, EstacionTrabajo, Empresa)<BR>SiNo<BR>    Informacion(Info.Mensaje)<BR>Fin
[Acciones.Procesar.Actualizar]
Nombre=Actualizar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S


[Acciones.Paginacion]
Nombre=Paginacion
Boton=0
NombreDesplegar=Paginacion
EnBarraHerramientas=S
TipoAccion=Herramientas Captura
ClaveAccion=Navegador Paginacion
Activo=S
Visible=S



EspacioPrevio=S




[Acciones.Procesar.ListaAccionesMultiples]
(Inicio)=Procesar
Procesar=Actualizar
Actualizar=(Fin)





































[Lista.ListaEnCaptura]
(Inicio)=WMSPedidosSinSurtir.Modulo
WMSPedidosSinSurtir.Modulo=WMSPedidosSinSurtir.Almacen
WMSPedidosSinSurtir.Almacen=WMSPedidosSinSurtir.Articulo
WMSPedidosSinSurtir.Articulo=WMSPedidosSinSurtir.SubCuenta
WMSPedidosSinSurtir.SubCuenta=WMSPedidosSinSurtir.Tarima
WMSPedidosSinSurtir.Tarima=WMSPedidosSinSurtir.Cantidad
WMSPedidosSinSurtir.Cantidad=(Fin)

[Lista.ListaAcciones]
(Inicio)=VerTarimas
VerTarimas=SeleccionarTodo
SeleccionarTodo=QuitarSeleccion
QuitarSeleccion=(Fin)



[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Detalle
Detalle=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Procesar
Procesar=Paginacion
Paginacion=(Fin)
