[Forma]
Clave=VentaPendienteDLista
Nombre=<T>Ventas Pendientes<T>
Icono=4
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=210
PosicionInicialArriba=123
PosicionInicialAltura=406
PosicionInicialAncho=860
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Si(ConDatos(Info.Cliente), Lista(<T>Cliente: <T>+Info.Cliente, Si(ConDatos(Info.EnviarA), <T>Sucursal Cliente: <T>+Info.EnviarA, <T><T>), Info.Moneda),<T><T>)
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
PosicionInicialAlturaCliente=458

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
FiltroGeneral={Si<BR>  ConDatos(Info.Cliente)<BR>Entonces<BR>  <T>VentaPendienteD.Empresa = <T>+Comillas(Empresa) +<BR>  <T> AND VentaPendienteD.Estatus = <T>+Comillas(EstatusPendiente)+<BR>  <T> AND VentaPendienteD.Cliente = <T>+Comillas(Info.Cliente)+<BR>  <T> AND VentaPendienteD.Moneda = <T>+Comillas(Info.Moneda) +<BR>  <T> AND VentaPendienteD.Mov NOT IN (<T>+MovListaSQL(<T>VTAS<T>, VTAS.F, VTAS.FAR, VTAS.FC, VTAS.FG, VTAS.FX, VTAS.FB) + <T>) <T>+<BR>  <T> AND (VentaPendienteD.CantidadPendiente > 0 OR VentaPendienteD.CantidadReservada > 0)<T>+<BR>  Si(ConDatos(Info.EnviarA), <T> AND VentaPendienteD.EnviarA = <T>+Info.EnviarA, <T><T>)<BR>Sino<BR>  <T>VentaPendienteD.Empresa = <T>+Comillas(Empresa)+<BR>  <T> AND VentaPendienteD.Estatus = <T>+Comillas(EstatusPendiente)+<BR>  <T> AND VentaPendienteD.CantidadPendiente > 0 <T>+<BR>  <T> AND Art.Tipo NOT IN (<T>+Comillas(TipoServicio)+<T>, <T>+Comillas(TipoJuego)+<T>)<T>+<BR>  <T> AND VentaPendienteD.Mov IN (<T> + MovListaSQL(<T>VTAS<T>, VTAS.P, VTAS.S, VTAS.F, VTAS.FAR, VTAS.FC, VTAS.FG, VTAS.FX, VTAS.FB) + <T>)<T> <BR>Fin<BR>}
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

2=-2
3=-2
4=-2
5=-2
6=-2
7=-2
8=-2
9=-2
10=-2
11=-2
[Lista.VentaPendienteD.FechaEmision]
Carpeta=Lista
Clave=VentaPendienteD.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[Lista.VentaPendienteD.Articulo]
Carpeta=Lista
Clave=VentaPendienteD.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

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

[Lista.VentaPendienteD.Precio]
Carpeta=Lista
Clave=VentaPendienteD.Precio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.VentaPendienteD.DescuentoLinea]
Carpeta=Lista
Clave=VentaPendienteD.DescuentoLinea
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.VentaPendienteD.SubCuenta]
Carpeta=Lista
Clave=VentaPendienteD.SubCuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Seleccionar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Seleccionar
Activo=S
Visible=S
Antes=S

AntesExpresiones=Asigna(Info.MovID, VentaPendienteD:VentaPendienteD.MovID)<BR>Asigna(Info.OrigenTipo, <T>VTAS<T>)<BR>Asigna(Info.OrigenID, VentaPendienteD:VentaPendienteD.MovID)<BR>Asigna(Info.Almacen, VentaPendienteD:VentaPendienteD.Almacen)<BR>Asigna(Info.EnviarA, VentaPendienteD:VentaPendienteD.EnviarA)<BR>Asigna(Info.Articulo, VentaPendienteD:VentaPendienteD.Articulo)<BR>Asigna(Info.SubCuenta, VentaPendienteD:VentaPendienteD.SubCuenta)<BR>Asigna(Info.Cantidad, VentaPendienteD:VentaPendienteD.CantidadPendiente+VentaPendienteD:VentaPendienteD.CantidadReservada)<BR>Asigna(Info.CantidadPendiente, VentaPendienteD:VentaPendienteD.CantidadPendiente)<BR>Asigna(Info.Precio, VentaPendienteD:VentaPendienteD.Precio)<BR>Asigna(Info.DescTipo, VentaPendienteD:VentaPendienteD.DescuentoTipo)<BR>Asigna(Info.Desc, VentaPendienteD:VentaPendienteD.DescuentoLinea)<BR>Asigna(Info.Impuesto1, VentaPendienteD:VentaPendienteD.Impuesto1)<BR>Asigna(Info.Impuesto2, VentaPendienteD:VentaPendienteD.Impuesto2)<BR>Asigna(Info.Impuesto3, VentaPendienteD:VentaPendienteD.Impuesto3)<BR>Asigna(Info.Retencion1, VentaPendienteD:VentaPendienteD.Retencion1)<BR>Asigna(Info.Retencion2, VentaPendienteD:VentaPendienteD.Retencion2)<BR>Asigna(Info.Retencion3, VentaPendienteD:VentaPendienteD.Retencion3)<BR>Asigna(Info.Unidad, VentaPendienteD:VentaPendienteD.Unidad)<BR>Asigna(Info.Factor, VentaPendienteD:VentaPendienteD.Factor)<BR>Asigna(Info.Descripcion, VentaPendienteD:VentaPendienteD.DescripcionExtra)<BR>Asigna(Info.CantidadInventario, VentaPendienteD:VentaPendienteD.CantidadInventario)<BR>Asigna(Info.CantidadInventarioPendiente, VentaPendienteD:VentaPendienteD.CantidadPendiente*VentaPendienteD:VentaPendienteD.CantidadInventario/VentaPendienteD:VentaPendienteD.Cantidad)<BR>Asigna(Info.FechaRequerida, VentaPendienteD:VentaPendienteD.FechaRequerida)<BR>Asigna(Info.Agente, VentaPendienteD:VentaPendienteD.Agente)<BR>Asigna(Info.PoliticaPrecios, VentaPendienteD:VentaPendienteD.PoliticaPrecios)<BR>Asigna(Info.PrecioMoneda, VentaPendienteD:VentaPendienteD.PrecioMoneda)<BR>Asigna(Info.PrecioTipoCambio, VentaPendienteD:VentaPendienteD.PrecioTipoCambio)<BR>Si<BR>  ConDatos(VentaPendienteD:VentaPendienteD.ServicioArticulo)<BR>Entonces<BR>  Asigna(Info.ArticuloCopia, VentaPendienteD:VentaPendienteD.ServicioArticulo)<BR>  Asigna(Info.SerieLote, VentaPendienteD:VentaPendienteD.ServicioSerie)<BR>  Asigna(Info.Descripcion, FechaEnTexto(VentaPendienteD:VentaPendienteD.ServicioFecha, <T>dd/mmm/aaaa<T>))<BR>Fin<BR>Asigna(Info.Copiar, Verdadero)
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

[Lista.VentaPendienteD.Almacen]
Carpeta=Lista
Clave=VentaPendienteD.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.VentaPendienteD.CantidadReservada]
Carpeta=Lista
Clave=VentaPendienteD.CantidadReservada
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.VentaPendienteD.CantidadOrdenada]
Carpeta=Lista
Clave=VentaPendienteD.CantidadOrdenada
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.VentaPendienteD.Unidad]
Carpeta=Lista
Clave=VentaPendienteD.Unidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

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



[Forma.ListaAcciones]
(Inicio)=Seleccionar
Seleccionar=Propiedades
Propiedades=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=Campos
Campos=TodasSucursales
TodasSucursales=(Fin)
