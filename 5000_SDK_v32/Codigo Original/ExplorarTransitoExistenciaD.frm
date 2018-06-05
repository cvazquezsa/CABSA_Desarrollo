
[Forma]
Clave=ExplorarTransitoExistenciaD
Icono=4
BarraHerramientas=S
Modulos=(Todos)
Nombre=Explorar - Detalle Existencias Tránsito
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=(Lista)
Comentarios=Lista(Info.Articulo,Info.Opcion,Info.Almacen,Info.AlmacenDestino,Info.Costo)
ListaCarpetas=Lista
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEstadoInicial=Normal
VentanaExclusivaOpcion=2
CarpetaPrincipal=Lista
PosicionInicialIzquierda=224
PosicionInicialArriba=99
PosicionInicialAlturaCliente=505
PosicionInicialAncho=832
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

[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
NombreDesplegar=&Imprimir
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S


[Acciones.VistaPrevia]
Nombre=VistaPrevia
Boton=6
NombreDesplegar=&Presentación Preliminar
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S


[Acciones.Excel]
Nombre=Excel
Boton=115
NombreDesplegar=&Enviar a Excel
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S


[Acciones.MostrarCampos]
Nombre=MostrarCampos
Boton=45
NombreDesplegar=&Personalizar Vista
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S


[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=TransitoExistenciaD
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
ElementosPorPaginaEsp=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S

IconosSubTitulo=<T>Movimiento<T>
ListaEnCaptura=(Lista)
Filtros=S
OtroOrden=S
BusquedaRapidaControles=S
ListaOrden=(Lista)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha

FiltroFechas=S
FiltroFechasCampo=TransitoExistenciaD.FechaEmision
BusquedaRapida=S
BusquedaEnLinea=S

FiltroFechasDefault=(Todo)
PestanaOtroNombre=S
PestanaNombre=Registros
IconosNombre=TransitoExistenciaD:TransitoExistenciaD.Movimiento
FiltroGeneral=TransitoExistenciaD.Empresa = {Comillas(Empresa)}<BR>AND TransitoExistenciaD.Articulo = {Comillas(Info.Articulo)}<BR>AND TransitoExistenciaD.Opcion = {Comillas(Info.Opcion)}<BR>AND TransitoExistenciaD.AlmacenOrigen = {Comillas(Info.Almacen)}<BR>AND TransitoExistenciaD.AlmacenDestino = {Comillas(Info.AlmacenDestino)}<BR>AND TransitoExistenciaD.Costo = {Info.Costo}
[Lista.TransitoExistenciaD.FechaEmision]
Carpeta=Lista
Clave=TransitoExistenciaD.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.TransitoExistenciaD.Articulo]
Carpeta=Lista
Clave=TransitoExistenciaD.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.TransitoExistenciaD.Opcion]
Carpeta=Lista
Clave=TransitoExistenciaD.Opcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.TransitoExistenciaD.AlmacenOrigen]
Carpeta=Lista
Clave=TransitoExistenciaD.AlmacenOrigen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.TransitoExistenciaD.AlmacenDestino]
Carpeta=Lista
Clave=TransitoExistenciaD.AlmacenDestino
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.TransitoExistenciaD.Cantidad]
Carpeta=Lista
Clave=TransitoExistenciaD.Cantidad
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.TransitoExistenciaD.Unidad]
Carpeta=Lista
Clave=TransitoExistenciaD.Unidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.TransitoExistenciaD.Costo]
Carpeta=Lista
Clave=TransitoExistenciaD.Costo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.TransitoExistenciaD.CostoTotal]
Carpeta=Lista
Clave=TransitoExistenciaD.CostoTotal
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco




[Lista.Columnas]
0=89
1=85
2=76
3=72
4=-2
5=-2
6=-2
7=-2
8=83
9=-2
10=-2
















[Lista.ListaEnCaptura]
(Inicio)=TransitoExistenciaD.FechaEmision
TransitoExistenciaD.FechaEmision=TransitoExistenciaD.Articulo
TransitoExistenciaD.Articulo=TransitoExistenciaD.Opcion
TransitoExistenciaD.Opcion=TransitoExistenciaD.AlmacenOrigen
TransitoExistenciaD.AlmacenOrigen=TransitoExistenciaD.AlmacenDestino
TransitoExistenciaD.AlmacenDestino=TransitoExistenciaD.Cantidad
TransitoExistenciaD.Cantidad=TransitoExistenciaD.Unidad
TransitoExistenciaD.Unidad=TransitoExistenciaD.Costo
TransitoExistenciaD.Costo=TransitoExistenciaD.CostoTotal
TransitoExistenciaD.CostoTotal=(Fin)

[Lista.ListaOrden]
(Inicio)=TransitoExistenciaD.Movimiento	(Acendente)
TransitoExistenciaD.Movimiento	(Acendente)=TransitoExistenciaD.FechaEmision	(Acendente)
TransitoExistenciaD.FechaEmision	(Acendente)=TransitoExistenciaD.Articulo	(Acendente)
TransitoExistenciaD.Articulo	(Acendente)=TransitoExistenciaD.Opcion	(Acendente)
TransitoExistenciaD.Opcion	(Acendente)=TransitoExistenciaD.AlmacenOrigen	(Acendente)
TransitoExistenciaD.AlmacenOrigen	(Acendente)=TransitoExistenciaD.AlmacenDestino	(Acendente)
TransitoExistenciaD.AlmacenDestino	(Acendente)=TransitoExistenciaD.Costo	(Acendente)
TransitoExistenciaD.Costo	(Acendente)=(Fin)



[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=VistaPrevia
VistaPrevia=Excel
Excel=MostrarCampos
MostrarCampos=(Fin)
