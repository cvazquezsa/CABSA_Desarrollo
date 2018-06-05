
[Forma]
Clave=EmidaCompraD
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=Emida - Detalle Recargas Telefónicas
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=(Lista)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=203
PosicionInicialArriba=77
PosicionInicialAlturaCliente=536
PosicionInicialAncho=874

Comentarios=Lista(Info.Mov + <T> <T> + Info.MovID, Info.Fecha, Info.Proveedor)
[Lista]
Estilo=Iconos
PestanaOtroNombre=S
PestanaNombre=Lista
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmidaCompraD
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
ElementosPorPaginaEsp=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
IconosSubTitulo=<T>Movimiento<T>
ListaEnCaptura=(Lista)


Filtros=S
OtroOrden=S
BusquedaRapidaControles=S
ListaOrden=EmidaCompraD.IDVTAS<TAB>(Acendente)
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
BusquedaRapida=S
BusquedaEnLinea=S
IconosNombre=EmidaCompraD:Venta.Mov + <T> <T> + EmidaCompraD:Venta.MovID
FiltroGeneral=EmidaCompraD.FechaEmision = <T>{FechaFormatoServidor(Info.Fecha)}<T> AND<BR>EmidaCompraD.URL = <T>{Info.Pagina}<T> AND<BR>EmidaCarrierCfg.Description = <T>{Info.Proveedor}<T> AND<BR>EmidaCompraD.ID = {Info.ID}
[Lista.EmidaCompraD.Articulo]
Carpeta=Lista
Clave=EmidaCompraD.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.EmidaCompraD.Cantidad]
Carpeta=Lista
Clave=EmidaCompraD.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Totalizador=1
[Lista.EmidaCompraD.Precio]
Carpeta=Lista
Clave=EmidaCompraD.Precio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Totalizador=1
[Lista.EmidaCompraD.FechaEmision]
Carpeta=Lista
Clave=EmidaCompraD.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.EmidaCarrierCfg.Description]
Carpeta=Lista
Clave=EmidaCarrierCfg.Description
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[Lista.Venta.EmidaControlNo]
Carpeta=Lista
Clave=Venta.EmidaControlNo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.Venta.EmidaTransactionId]
Carpeta=Lista
Clave=Venta.EmidaTransactionId
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.Venta.EmidaResponseMessage]
Carpeta=Lista
Clave=Venta.EmidaResponseMessage
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[Lista.Venta.EmidaTransactionDateTime]
Carpeta=Lista
Clave=Venta.EmidaTransactionDateTime
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.Venta.RecargaTelefono]
Carpeta=Lista
Clave=Venta.RecargaTelefono
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.Venta.EmidaResponseCode]
Carpeta=Lista
Clave=Venta.EmidaResponseCode
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=2
ColorFondo=Blanco

[Lista.Columnas]
0=128
1=93
2=58
3=66
4=87
5=81
6=138
7=100
8=119
9=86
10=102
11=1262








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
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S


EspacioPrevio=S
[Acciones.Preliminar]
Nombre=Preliminar
Boton=6
NombreDesplegar=Presentación Preliminar
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








[Acciones.InfoMovimiento]
Nombre=InfoMovimiento
Boton=35
NombreEnBoton=S
NombreDesplegar=Movimiento
EnBarraHerramientas=S
Activo=S
Visible=S









EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
Antes=S
AntesExpresiones=Asigna(Info.Modulo, <T>VTAS<T>)<BR>Asigna(Info.ID, EmidaCompraD:EmidaCompraD.IDVTAS)

















[Lista.ListaEnCaptura]
(Inicio)=EmidaCompraD.Articulo
EmidaCompraD.Articulo=EmidaCompraD.Cantidad
EmidaCompraD.Cantidad=EmidaCompraD.Precio
EmidaCompraD.Precio=EmidaCompraD.FechaEmision
EmidaCompraD.FechaEmision=EmidaCarrierCfg.Description
EmidaCarrierCfg.Description=Venta.EmidaTransactionDateTime
Venta.EmidaTransactionDateTime=Venta.RecargaTelefono
Venta.RecargaTelefono=Venta.EmidaControlNo
Venta.EmidaControlNo=Venta.EmidaTransactionId
Venta.EmidaTransactionId=Venta.EmidaResponseCode
Venta.EmidaResponseCode=Venta.EmidaResponseMessage
Venta.EmidaResponseMessage=(Fin)





















[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=InfoMovimiento
InfoMovimiento=(Fin)
