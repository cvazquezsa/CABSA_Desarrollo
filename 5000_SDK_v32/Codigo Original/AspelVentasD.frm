[Forma]
Clave=AspelVentasD
Nombre=Detalla de venta
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialAlturaCliente=273
PosicionInicialAncho=440
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
Comentarios=Lista(Info.Fecha,Info.Mov,Info.Cliente,Info.Almacen)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
PosicionInicialIzquierda=500
PosicionInicialArriba=295
ListaAcciones=Cerrar

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=AspelVentasD
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
PestanaOtroNombre=S
PestanaNombre=Detalle de ventas
FiltroGeneral=AspelVentasD.Empresa = <T>{Info.Empresa}<T> AND<BR>AspelVentasD.Sucursal = {Info.Sucursal} AND<BR>AspelVentasD.Modulo = <T>{Info.Modulo}<T> AND<BR>AspelVentasD.FechaEmision = <T>{Info.Fecha}<T> AND<BR>AspelVentasD.Cliente = <T>{Info.Cliente}<T> AND<BR>AspelVentasD.Mov = <T>{Info.Mov}<T> AND<BR>AspelVentasD.Moneda = <T>{Info.Moneda}<T> AND<BR>AspelVentasD.TipoCambio = {Info.TipoCambio} AND<BR>AspelVentasD.Estatus = <T>{Info.Estatus}<T> AND<BR>AspelVentasD.Almacen = <T>{Info.Almacen}<T>

[Lista.AspelVentasD.Articulo]
Carpeta=Lista
Clave=AspelVentasD.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.AspelVentasD.Cantidad]
Carpeta=Lista
Clave=AspelVentasD.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.AspelVentasD.Precio]
Carpeta=Lista
Clave=AspelVentasD.Precio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.AspelVentasD.Descuento1]
Carpeta=Lista
Clave=AspelVentasD.Descuento1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Importe]
Carpeta=Lista
Clave=Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Articulo=124
Cantidad=64
Precio=64
Descuento1=64
Importe=64

[Acciones.Cerrar]
Nombre=Cerrar
Boton=40
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Lista.ListaEnCaptura]
(Inicio)=AspelVentasD.Articulo
AspelVentasD.Articulo=AspelVentasD.Cantidad
AspelVentasD.Cantidad=AspelVentasD.Precio
AspelVentasD.Precio=AspelVentasD.Descuento1
AspelVentasD.Descuento1=Importe
Importe=(Fin)
