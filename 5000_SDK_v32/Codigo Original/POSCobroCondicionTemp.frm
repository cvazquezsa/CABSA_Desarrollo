
[Forma]
Clave=POSCobroCondicionTemp
Icono=0
CarpetaPrincipal=POSCobroCondicionTemp
Modulos=(Todos)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal

ListaCarpetas=POSCobroCondicionTemp
PosicionInicialIzquierda=256
PosicionInicialArriba=259
PosicionInicialAlturaCliente=273
PosicionInicialAncho=790
Nombre=Condiciones Cobro
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
[POSCobroCondicionTemp]
Estilo=Hoja
Clave=POSCobroCondicionTemp
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=POSCobroCondicionTemp
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S

HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaVistaOmision=Automática
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroGeneral=POSCobroCondicionTemp.Estacion = {EstacionTrabajo}
FiltroRespetar=S
FiltroTipo=General
[POSCobroCondicionTemp.POSCobroCondicionTemp.Articulo]
Carpeta=POSCobroCondicionTemp
Clave=POSCobroCondicionTemp.Articulo
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[POSCobroCondicionTemp.Art.Descripcion1]
Carpeta=POSCobroCondicionTemp
Clave=Art.Descripcion1
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco


[POSCobroCondicionTemp.POSCobroCondicionTemp.PrecioTotal]
Carpeta=POSCobroCondicionTemp
Clave=POSCobroCondicionTemp.PrecioTotal
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[POSCobroCondicionTemp.POSCobroCondicionTemp.FormaPago]
Carpeta=POSCobroCondicionTemp
Clave=POSCobroCondicionTemp.FormaPago
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[POSCobroCondicionTemp.Columnas]
Articulo=124
Descripcion1=184
Precio=64
PrecioTotal=69
FormaPago=304


Cantidad=64
[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S






[POSCobroCondicionTemp.POSCobroCondicionTemp.Cantidad]
Carpeta=POSCobroCondicionTemp
Clave=POSCobroCondicionTemp.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[POSCobroCondicionTemp.ListaEnCaptura]
(Inicio)=POSCobroCondicionTemp.Cantidad
POSCobroCondicionTemp.Cantidad=POSCobroCondicionTemp.Articulo
POSCobroCondicionTemp.Articulo=Art.Descripcion1
Art.Descripcion1=POSCobroCondicionTemp.PrecioTotal
POSCobroCondicionTemp.PrecioTotal=POSCobroCondicionTemp.FormaPago
POSCobroCondicionTemp.FormaPago=(Fin)
