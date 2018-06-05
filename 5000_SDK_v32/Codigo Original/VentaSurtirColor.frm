[Forma]
Clave=VentaSurtirColor
Icono=0
Modulos=(Todos)
Nombre=Surtir por Artículo/Color
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=113
PosicionInicialArriba=140
PosicionInicialAltura=488
PosicionInicialAncho=798
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Lista(Info.Almacen, Info.Articulo, Info.Color, <T>Disponible: <T>+SQL(<T>SELECT SUM(Disponible) FROM ArtSubDisponible WHERE Empresa=:tEmp AND Almacen=:tAlm AND Articulo=:tArt AND UPPER(SUBSTRING(SubCuenta, 1, CHARINDEX(<T>+Comillas(<T>/<T>)+<T>, SubCuenta)-1)) = UPPER(:tColor)<T>,Empresa, Info.Almacen, Info.Articulo, Info.Color))
ExpresionesAlMostrar=Si(no Forma(<T>EspecificarArticuloColor<T>), AbortarOperacion)<BR>Asigna(Info.Cantidad, 100)<BR>Asigna(Info.TipoCantidad, <T>%<T>)

[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=VentaSurtirColor
Fuente={MS Sans Serif, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Movimiento<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
PestanaOtroNombre=S
PestanaNombre=Pendientes
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todos
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
FiltroGrupo1=VentaSurtirColor.Cliente
FiltroValida1=VentaSurtirColor.Cliente
FiltroGrupo2=VentaSurtirColor.Talla
FiltroValida2=VentaSurtirColor.Talla
FiltroTodoFinal=S
FiltroTodo=S
IconosSeleccionMultiple=S
MenuLocal=S
ListaAcciones=(Lista)
FiltroGrupo3=VentaSurtirColor.EnviarA
FiltroValida3=VentaSurtirColor.EnviarA
IconosNombre=VentaSurtirColor:VentaSurtirColor.Mov+<T> <T>+VentaSurtirColor:VentaSurtirColor.MovID
IconosConRejilla=S
FiltroGeneral=VentaSurtirColor.Empresa=<T>{Empresa}<T> AND <BR>VentaSurtirColor.Almacen=<T>{Info.Almacen}<T> AND<BR>VentaSurtirColor.Articulo=<T>{Info.Articulo}<T> AND<BR>VentaSurtirColor.Color=<T>{Info.Color}<T> AND<BR>(VentaSurtirColor.CantidadOrdenada IS NOT NULL OR VentaSurtirColor.CantidadReservada IS NOT NULL OR VentaSurtirColor.CantidadPendiente IS NOT NULL)

[Lista.Columnas]
0=110
1=74

[Lista.VentaSurtirColor.Cliente]
Carpeta=Lista
Clave=VentaSurtirColor.Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VentaSurtirColor.EnviarA]
Carpeta=Lista
Clave=VentaSurtirColor.EnviarA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VentaSurtirColor.Cantidad]
Carpeta=Lista
Clave=VentaSurtirColor.Cantidad
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VentaSurtirColor.CantidadOrdenada]
Carpeta=Lista
Clave=VentaSurtirColor.CantidadOrdenada
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VentaSurtirColor.CantidadReservada]
Carpeta=Lista
Clave=VentaSurtirColor.CantidadReservada
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VentaSurtirColor.CantidadPendiente]
Carpeta=Lista
Clave=VentaSurtirColor.CantidadPendiente
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

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

[Acciones.DesReservar]
Nombre=DesReservar
Boton=72
NombreDesplegar=&Des-Reservar
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
ConCondicion=S
EjecucionConError=S
Antes=S
Visible=S
EjecucionCondicion=CuantosSeleccionID(<T>Lista<T>)>0
EjecucionMensaje=<T>Falta Seleccionar<T>
AntesExpresiones=Si(no Forma(<T>VentaSurtirCantidad<T>), AbortarOperacion)<BR>RegistrarSeleccionIDRenglon(<T>Lista<T>, <T>VTAS<T>, <T>VentaSurtirColor.ID<T>, <T>VentaSurtirColor.Renglon<T>, <T>VentaSurtirColor.RenglonSub<T>)<BR>ProcesarSQL(<T>spVentaSurtirColor :nEstacion, :tAccion, :rCantidad, :tTipo<T>, EstacionTrabajo, <T>DESRESERVAR<T>, Info.Cantidad, Info.TipoCantidad)

[Acciones.Seleccionar Todo]
Nombre=Seleccionar Todo
Boton=0
NombreDesplegar=Seleccionar &Todo
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Seleccionar Todo
Activo=S
Visible=S

[Acciones.Campos]
Nombre=Campos
Boton=45
NombreDesplegar=Personalizar &Vista
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Acciones.Todo]
Nombre=Todo
Boton=55
NombreDesplegar=Seleccionar &Todo
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Seleccionar Todo
Activo=S
Visible=S
EspacioPrevio=S

[Acciones.Propiedades]
Nombre=Propiedades
Boton=35
NombreDesplegar=Propiedades
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
Activo=S
Antes=S
Visible=S
AntesExpresiones=Asigna(Info.Modulo, <T>VTAS<T>)<BR>Asigna(Info.ID, VentaSurtirColor:VentaSurtirColor.ID)

[Lista.VentaSurtirColor.Talla]
Carpeta=Lista
Clave=VentaSurtirColor.Talla
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Disponible]
Nombre=Disponible
Boton=68
NombreEnBoton=S
NombreDesplegar=&Disponible
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Reportes Pantalla
ClaveAccion=ArtSubDisponibleTabla
ListaParametros1=Empresa<BR>Info.Articulo<BR>Info.Almacen
ListaParametros=S
Activo=S
Visible=S

[Acciones.Quitar Seleccion]
Nombre=Quitar Seleccion
Boton=0
NombreDesplegar=&Quitar Seleccion
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Quitar Seleccion
Activo=S
Visible=S

[Acciones.Reservado]
Nombre=Reservado
Boton=68
NombreEnBoton=S
NombreDesplegar=Reser&vado
EnBarraHerramientas=S
TipoAccion=Reportes Pantalla
ClaveAccion=ArtSubReservadoTabla
ListaParametros1=Empresa<BR>Info.Articulo<BR>Info.Almacen
ListaParametros=S
Activo=S
Visible=S
EspacioPrevio=S

[Acciones.VentaPendiente]
Nombre=VentaPendiente
Boton=68
NombreEnBoton=S
NombreDesplegar=&Pendiente
EnBarraHerramientas=S
TipoAccion=Reportes Pantalla
ClaveAccion=ArtSubVentaPendienteTabla
ListaParametros1=Empresa<BR>Info.Articulo<BR>Info.Almacen
ListaParametros=S
Activo=S
Visible=S

[Acciones.Reservar]
Nombre=Reservar
Boton=7
NombreEnBoton=S
NombreDesplegar=&Reservar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
ConCondicion=S
EjecucionConError=S
Antes=S
Visible=S
EjecucionCondicion=CuantosSeleccionID(<T>Lista<T>)>0
EjecucionMensaje=<T>Falta Seleccionar<T>
AntesExpresiones=Si(no Forma(<T>VentaSurtirCantidad<T>), AbortarOperacion)<BR>RegistrarSeleccionIDRenglon(<T>Lista<T>, <T>VTAS<T>, <T>VentaSurtirColor.ID<T>, <T>VentaSurtirColor.Renglon<T>, <T>VentaSurtirColor.RenglonSub<T>)<BR>ProcesarSQL(<T>spVentaSurtirColor :nEstacion, :tAccion, :rCantidad, :tTipo<T>, EstacionTrabajo, <T>RESERVAR<T>, Info.Cantidad, Info.TipoCantidad)

[Acciones.Refrescar]
Nombre=Refrescar
Boton=82
NombreDesplegar=Refrescar
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S
EspacioPrevio=S

[Acciones.LocalRefrescar]
Nombre=LocalRefrescar
Boton=0
UsaTeclaRapida=S
TeclaRapida=F5
NombreDesplegar=&Refrescar
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S
EspacioPrevio=S

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Todo
Todo=Reservar
Reservar=DesReservar
DesReservar=Reservado
Reservado=VentaPendiente
VentaPendiente=Disponible
Disponible=Refrescar
Refrescar=Propiedades
Propiedades=Campos
Campos=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=VentaSurtirColor.Cliente
VentaSurtirColor.Cliente=VentaSurtirColor.EnviarA
VentaSurtirColor.EnviarA=VentaSurtirColor.Talla
VentaSurtirColor.Talla=VentaSurtirColor.Cantidad
VentaSurtirColor.Cantidad=VentaSurtirColor.CantidadOrdenada
VentaSurtirColor.CantidadOrdenada=VentaSurtirColor.CantidadReservada
VentaSurtirColor.CantidadReservada=VentaSurtirColor.CantidadPendiente
VentaSurtirColor.CantidadPendiente=(Fin)

[Lista.ListaAcciones]
(Inicio)=Seleccionar Todo
Seleccionar Todo=Quitar Seleccion
Quitar Seleccion=LocalRefrescar
LocalRefrescar=(Fin)
