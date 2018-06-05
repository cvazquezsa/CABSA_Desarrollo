[Forma]
Clave=ServiciosPendientesAgente
Nombre=<T>Servicios Pendientes del Agente<T>
Icono=4
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=82
PosicionInicialArriba=146
PosicionInicialAltura=406
PosicionInicialAncho=860
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Lista(Info.Agente, Info.Nombre)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
ExpresionesAlMostrar=
ExpresionesAlCerrar=
VentanaExclusiva=S
VentanaEscCerrar=S
EsConsultaExclusiva=S
EsMovimiento=S
TituloAuto=S
MovModulo=VTAS
MovEspecificos=Todos
PosicionInicialAlturaCliente=441

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
FiltroTipo=General
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroAncho=30
FiltroPredefinido=S
MenuLocal=S
ListaAcciones=Actualizar
BusquedaRapidaControles=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
FiltroMovs=S
FiltroMovsTodos=S
FiltroMovDefault=(Todos)
BusquedaRapida=S
BusquedaAncho=20
BusquedaEnLinea=S
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Movimiento<T>
ElementosPorPagina=200
IconosNombre=VentaPendienteD:Movimiento
FiltroGeneral=VentaPendienteD.Empresa = <T>{Empresa}<T> AND Art.Tipo=<T>{TipoServicio}<T> AND VentaPendienteD.Agente=<T>{Info.Agente}<T>

[Lista.Columnas]
0=100
1=96
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

[Lista.VentaPendienteD.FechaEmision]
Carpeta=Lista
Clave=VentaPendienteD.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

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

[Lista.VentaPendienteD.SubCuenta]
Carpeta=Lista
Clave=VentaPendienteD.SubCuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
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

[Lista.VentaPendienteD.CantidadReservada]
Carpeta=Lista
Clave=VentaPendienteD.CantidadReservada
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VentaPendienteD.CantidadOrdenada]
Carpeta=Lista
Clave=VentaPendienteD.CantidadOrdenada
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
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

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Propiedades
Propiedades=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=Campos
Campos=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=VentaPendienteD.Cliente
VentaPendienteD.Cliente=VentaPendienteD.Almacen
VentaPendienteD.Almacen=VentaPendienteD.FechaEmision
VentaPendienteD.FechaEmision=VentaPendienteD.Articulo
VentaPendienteD.Articulo=VentaPendienteD.SubCuenta
VentaPendienteD.SubCuenta=VentaPendienteD.CantidadReservada
VentaPendienteD.CantidadReservada=VentaPendienteD.CantidadOrdenada
VentaPendienteD.CantidadOrdenada=VentaPendienteD.CantidadPendiente
VentaPendienteD.CantidadPendiente=VentaPendienteD.Unidad
VentaPendienteD.Unidad=VentaPendienteD.Precio
VentaPendienteD.Precio=VentaPendienteD.DescuentoLinea
VentaPendienteD.DescuentoLinea=(Fin)
