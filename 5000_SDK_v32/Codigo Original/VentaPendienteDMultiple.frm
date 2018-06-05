[Forma]
Clave=VentaPendienteDMultiple
Nombre=<T>Ventas Pendientes<T>
Icono=4
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=184
PosicionInicialArriba=226
PosicionInicialAltura=479
PosicionInicialAncho=911
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Si(ConDatos(Info.Cliente), Lista(<T>Cliente: <T>+Info.Cliente, Si(ConDatos(Info.EnviarA), <T>Sucursal Cliente: <T>+Info.EnviarA, <T><T>), Info.Moneda),<T><T>)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S
EsConsultaExclusiva=S
EsMovimiento=S
TituloAuto=S
MovModulo=VTAS
MovEspecificos=Todos
PosicionInicialAlturaCliente=544

[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=VentaPendienteD
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
PestanaOtroNombre=S
PestanaNombre=Pendientes
ListaEnCaptura=(Lista)
Filtros=S
FiltroTipo=Múltiple (por Grupos)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroAncho=15
FiltroPredefinido=S
MenuLocal=S
ListaAcciones=Actualizar
BusquedaRapidaControles=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroMovs=S
FiltroMovsTodos=S
FiltroMovDefault=(Todos)
BusquedaRapida=S
BusquedaAncho=15
BusquedaEnLinea=S
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Movimiento<T>
ElementosPorPagina=200
IconosSeleccionMultiple=S
FiltroGrupo1=VentaPendienteD.Articulo
FiltroValida1=VentaPendienteD.Articulo
FiltroTodo=S
FiltroFechas=S
FiltroFechasDefault=Esta Semana
FiltroFechasVencimiento=S
FiltroFechasNombre=Fecha &Requerida
FiltroFechasCampo=VentaPendienteD.FechaRequerida
IconosNombre=VentaPendienteD:Movimiento
FiltroGeneral={Si<BR>  ConDatos(Info.Cliente)<BR>Entonces<BR>  <T>VentaPendienteD.Empresa = <T>+Comillas(Empresa) +<BR>  <T> AND VentaPendienteD.Estatus = <T>+Comillas(EstatusPendiente)+<BR>  <T> AND VentaPendienteD.Cliente = <T>+Comillas(Info.Cliente)+<BR>  <T> AND VentaPendienteD.Moneda = <T>+Comillas(Info.Moneda) +<BR>  <T> AND VentaPendienteD.Mov NOT IN (<T>+MovListaSQL(<T>VTAS<T>, VTAS.F, VTAS.FAR, VTAS.FC, VTAS.FG, VTAS.FX, VTAS.FB) + <T>) <T>+<BR>  <T> AND (VentaPendienteD.CantidadPendiente > 0 OR VentaPendienteD.CantidadReservada > 0)<T>+<BR>  Si(ConDatos(Info.EnviarA), <T> AND VentaPendienteD.EnviarA = <T>+Info.EnviarA, <T><T>)<BR>Sino<BR>  <T>VentaPendienteD.Empresa = <T>+Comillas(Empresa)+<BR>  <T> AND VentaPendienteD.Estatus = <T>+Comillas(EstatusPendiente)+<BR>  <T> AND VentaPendienteD.CantidadPendiente > 0 <T>+<BR>  <T> AND Art.Tipo NOT IN (<T>+Comillas(TipoServicio)+<T>, <T>+Comillas(TipoJuego)+<T>)<T>+<BR>  <T> AND VentaPendienteD.Mov IN (<T> + MovListaSQL(<T>VTAS<T>, VTAS.P, VTAS.S, VTAS.F, VTAS.FAR, VTAS.FC, VTAS.FG, VTAS.FX, VTAS.FB) + <T>)<T> <BR>Fin<BR>}

[Lista.Columnas]
0=135
1=69
Mov=106
MovID=64
FechaEmision=74
Articulo=88
CantidadPendiente=54
Precio=80
DescuentoTipo=29
DescuentoLinea=35
SubCuenta=92
Cliente=69
Movimiento=114
Almacen=64
CantidadReservada=57
CantidadOrdenada=51
Unidad=43

[Lista.VentaPendienteD.Articulo]
Carpeta=Lista
Clave=VentaPendienteD.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VentaPendienteD.CantidadPendiente]
Carpeta=Lista
Clave=VentaPendienteD.CantidadPendiente
Editar=S
Totalizador=0
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VentaPendienteD.Precio]
Carpeta=Lista
Clave=VentaPendienteD.Precio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VentaPendienteD.DescuentoLinea]
Carpeta=Lista
Clave=VentaPendienteD.DescuentoLinea
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

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

[Lista.VentaPendienteD.Cliente]
Carpeta=Lista
Clave=VentaPendienteD.Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VentaPendienteD.Almacen]
Carpeta=Lista
Clave=VentaPendienteD.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VentaPendienteD.Unidad]
Carpeta=Lista
Clave=VentaPendienteD.Unidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Propiedades]
Nombre=Propiedades
Boton=35
NombreDesplegar=Propiedades
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(VentaPendienteD:VentaPendienteD.ID)
Antes=S
AntesExpresiones=Asigna(Info.Modulo, <T>VTAS<T>)<BR>Asigna(Info.ID, VentaPendienteD:VentaPendienteD.ID)
Visible=S

[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
NombreDesplegar=Imprimir
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S

[Acciones.Preliminar]
Nombre=Preliminar
Boton=6
NombreDesplegar=Presentación preliminar
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S

[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=Enviar a Excel
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
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

[Acciones.Cancelar]
Nombre=Cancelar
Boton=36
NombreEnBoton=S
NombreDesplegar=<T>&Cancelar<T>
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S

[Lista.VentaPendienteD.CantidadReservada]
Carpeta=Lista
Clave=VentaPendienteD.CantidadReservada
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VentaPendienteD.FechaRequerida]
Carpeta=Lista
Clave=VentaPendienteD.FechaRequerida
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Seleccionar Todo]
Nombre=Seleccionar Todo
Boton=55
NombreEnBoton=S
NombreDesplegar=Seleccionar &Todo
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Seleccionar Todo
Activo=S
Visible=S

[Acciones.Agregar]
Nombre=Agregar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Agregar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
Antes=S
AntesExpresiones=RegistrarSeleccionIDRenglon(<T>Lista<T>, <T>VTAS<T>, <T>VentaPendienteD.ID<T>, <T>VentaPendienteD.Renglon<T>, <T>VentaPendienteD.RenglonSub<T>) <BR>EjecutarSQL(<T>spVentaPendienteAceptar :nEstacion, :nID<T>, EstacionTrabajo, Info.ID)

[Acciones.TodasSucursales]
Nombre=TodasSucursales
Boton=16
NombreEnBoton=S
NombreDesplegar=Todas &Sucursales
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Antes=S
AntesExpresiones=Asigna(Info.EnviarA, Nulo)
VisibleCondicion=ConDatos(Info.EnviarA)

[Forma.ListaAcciones]
(Inicio)=Agregar
Agregar=Cancelar
Cancelar=Seleccionar Todo
Seleccionar Todo=Propiedades
Propiedades=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=Campos
Campos=TodasSucursales
TodasSucursales=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=VentaPendienteD.Cliente
VentaPendienteD.Cliente=VentaPendienteD.Almacen
VentaPendienteD.Almacen=VentaPendienteD.FechaRequerida
VentaPendienteD.FechaRequerida=VentaPendienteD.Articulo
VentaPendienteD.Articulo=VentaPendienteD.CantidadReservada
VentaPendienteD.CantidadReservada=VentaPendienteD.CantidadPendiente
VentaPendienteD.CantidadPendiente=VentaPendienteD.Unidad
VentaPendienteD.Unidad=VentaPendienteD.Precio
VentaPendienteD.Precio=VentaPendienteD.DescuentoLinea
VentaPendienteD.DescuentoLinea=(Fin)
