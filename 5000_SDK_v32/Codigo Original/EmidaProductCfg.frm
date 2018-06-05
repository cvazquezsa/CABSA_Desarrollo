
[Forma]
Clave=EmidaProductCfg
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=Emida - Configuración de Productos
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=(Lista)
ListaCarpetas=Datos
CarpetaPrincipal=Datos
PosicionInicialIzquierda=263
PosicionInicialArriba=101
PosicionInicialAlturaCliente=487
PosicionInicialAncho=754
Comentarios=Lista(Info.Proveedor, Info.Pagina, Empresa)

[Datos]
Estilo=Hoja
Clave=Datos
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmidaProductCfg
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S
PestanaOtroNombre=S
PestanaNombre=Datos Generales

Filtros=S
OtroOrden=S
ListaOrden=(Lista)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=40
FiltroRespetar=S
FiltroTipo=General
FiltroGrupo1=EmidaProductCfg.URL
FiltroValida1=EmidaProductCfg.URL
FiltroGrupo2=EmidaCarrierCfg.Description
FiltroValida2=EmidaCarrierCfg.Description
FiltroAplicaEn=EmidaProductCfg.URL
FiltroTodo=S

PermiteEditar=S
HojaConfirmarEliminar=S
FiltroGeneral=EmidaProductCfg.Empresa = <T>{Empresa}<T> AND<BR>EmidaProductCfg.URL = <T>{Info.Pagina}<T> AND<BR>EmidaProductCfg.CarrierId = <T>{Info.Proveedor}<T>
[Datos.EmidaProductCfg.ProductId]
Carpeta=Datos
Clave=EmidaProductCfg.ProductId
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[Datos.EmidaProductCfg.Description]
Carpeta=Datos
Clave=EmidaProductCfg.Description
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[Datos.EmidaProductCfg.ShortDescription]
Carpeta=Datos
Clave=EmidaProductCfg.ShortDescription
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[Datos.EmidaProductCfg.Amount]
Carpeta=Datos
Clave=EmidaProductCfg.Amount
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco







[Datos.Columnas]
URL=315
ProductId=79
Description=195
ShortDescription=151
Amount=66
CarrierId=67
CategoryId=78
TransTypeId=87
DiscountRate=71
CurrencyCode=76
CurrencySymbol=85



























Articulo=124

Comision=64
[Otros.EmidaProductCfg.CarrierId]
Carpeta=Otros
Clave=EmidaProductCfg.CarrierId
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[Otros.EmidaProductCfg.CategoryId]
Carpeta=Otros
Clave=EmidaProductCfg.CategoryId
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[Otros.EmidaProductCfg.TransTypeId]
Carpeta=Otros
Clave=EmidaProductCfg.TransTypeId
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[Otros.EmidaProductCfg.DiscountRate]
Carpeta=Otros
Clave=EmidaProductCfg.DiscountRate
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Otros.EmidaProductCfg.CurrencyCode]
Carpeta=Otros
Clave=EmidaProductCfg.CurrencyCode
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Otros.EmidaProductCfg.CurrencySymbol]
Carpeta=Otros
Clave=EmidaProductCfg.CurrencySymbol
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Otros.ListaEnCaptura]
(Inicio)=EmidaProductCfg.CarrierId
EmidaProductCfg.CarrierId=EmidaProductCfg.CategoryId
EmidaProductCfg.CategoryId=EmidaProductCfg.TransTypeId
EmidaProductCfg.TransTypeId=EmidaProductCfg.DiscountRate
EmidaProductCfg.DiscountRate=EmidaProductCfg.CurrencyCode
EmidaProductCfg.CurrencyCode=EmidaProductCfg.CurrencySymbol
EmidaProductCfg.CurrencySymbol=(Fin)



[Datos.EmidaProductCfg.Articulo]
Carpeta=Datos
Clave=EmidaProductCfg.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


[Otros.Columnas]
CarrierId=604
CategoryId=604
TransTypeId=604
DiscountRate=71
CurrencyCode=76
CurrencySymbol=85



[Forma.ListaCarpetas]
(Inicio)=Datos
Datos=Otros
Otros=(Fin)

[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreEnBoton=S
NombreDesplegar=&Eliminar
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Activo=S
Visible=S

















ConfirmarAntes=S
Carpeta=(Carpeta principal)
DialogoMensaje=EstaSeguro
[Lista.Columnas]
Articulo=131
Descripcion1=244






[Acciones.GuardarCerrar]
Nombre=GuardarCerrar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S


































[Datos.EmidaProductCfg.Comision]
Carpeta=Datos
Clave=EmidaProductCfg.Comision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco








[Datos.ListaEnCaptura]
(Inicio)=EmidaProductCfg.ProductId
EmidaProductCfg.ProductId=EmidaProductCfg.Description
EmidaProductCfg.Description=EmidaProductCfg.ShortDescription
EmidaProductCfg.ShortDescription=EmidaProductCfg.Amount
EmidaProductCfg.Amount=EmidaProductCfg.Articulo
EmidaProductCfg.Articulo=EmidaProductCfg.Comision
EmidaProductCfg.Comision=(Fin)

[Datos.ListaOrden]
(Inicio)=EmidaProductCfg.URL	(Acendente)
EmidaProductCfg.URL	(Acendente)=EmidaProductCfg.CarrierId	(Acendente)
EmidaProductCfg.CarrierId	(Acendente)=EmidaProductCfg.ProductId	(Acendente)
EmidaProductCfg.ProductId	(Acendente)=(Fin)





























[Forma.ListaAcciones]
(Inicio)=GuardarCerrar
GuardarCerrar=Eliminar
Eliminar=(Fin)
