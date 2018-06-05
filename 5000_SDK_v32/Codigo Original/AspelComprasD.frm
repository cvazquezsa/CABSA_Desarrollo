[Forma]
Clave=AspelComprasD
Nombre=Detalle de compras
Icono=0
Modulos=(Todos)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
Comentarios=Lista(Info.Fecha,Info.Mov,Info.Proveedor,Info.Almacen)
PosicionInicialIzquierda=470
PosicionInicialArriba=295
PosicionInicialAlturaCliente=273
PosicionInicialAncho=443
ListaAcciones=Cerrar

[Lista]
Estilo=Hoja
Pestana=S
Clave=Lista
Filtros=S
RefrescarAlEntrar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=AspelComprasD
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
ListaEnCaptura=(Lista)
FiltroGeneral=Empresa = <T>{Info.Empresa}<T> AND<BR>Sucursal = {Info.Sucursal} AND<BR>Modulo = <T>{Info.Modulo}<T> AND<BR>FechaEmision = <T>{Info.Fecha}<T> AND<BR>Proveedor = <T>{Info.Proveedor}<T> AND<BR>Mov = <T>{Info.Mov}<T> AND<BR>Moneda = <T>{Info.Moneda}<T> AND<BR>TipoCambio = {Info.TipoCambio} AND<BR>Estatus = <T>{Info.Estatus}<T> AND<BR>Almacen = <T>{Info.Almacen}<T>

[Lista.Articulo]
Carpeta=Lista
Clave=Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Cantidad]
Carpeta=Lista
Clave=Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Costo]
Carpeta=Lista
Clave=Costo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Descuento1]
Carpeta=Lista
Clave=Descuento1
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
Costo=64
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
(Inicio)=Articulo
Articulo=Cantidad
Cantidad=Costo
Costo=Descuento1
Descuento1=Importe
Importe=(Fin)
