
[Forma]
Clave=EmidaCarrierCfg
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=Emida - Configuración de Proveedores
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=351
PosicionInicialArriba=186
PosicionInicialAlturaCliente=318
PosicionInicialAncho=480
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=(Lista)
Comentarios=Lista(Info.Pagina, Empresa)
ListaCarpetas=Datos
CarpetaPrincipal=Datos
[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aceptar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Datos]
Estilo=Hoja
PestanaOtroNombre=S
PestanaNombre=Datos
Clave=Datos
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmidaCarrierCfg
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
ListaEnCaptura=(Lista)

CarpetaVisible=S
Filtros=S
OtroOrden=S

ListaOrden=(Lista)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=50
FiltroRespetar=S
FiltroTipo=General
FiltroGrupo1=EmidaCarrierCfg.URL
FiltroValida1=EmidaCarrierCfg.URL
FiltroTodo=S

FiltroGeneral=EmidaCarrierCfg.Empresa = <T>{Empresa}<T> AND<BR>EmidaCarrierCfg.URL = <T>{Info.Pagina}<T>
[Datos.EmidaCarrierCfg.CarrierId]
Carpeta=Datos
Clave=EmidaCarrierCfg.CarrierId
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[Datos.EmidaCarrierCfg.Description]
Carpeta=Datos
Clave=EmidaCarrierCfg.Description
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[Datos.EmidaCarrierCfg.ProductCount]
Carpeta=Datos
Clave=EmidaCarrierCfg.ProductCount
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Datos.Columnas]
URL=307
CarrierId=109
Description=145
ProductCount=121



















[Acciones.Productos]
Nombre=Productos
Boton=13
NombreEnBoton=S
NombreDesplegar=&Productos
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=EmidaProductCfg
Activo=S
Visible=S



EspacioPrevio=S






Antes=S
AntesExpresiones=Asigna(Info.Proveedor, EmidaCarrierCfg:EmidaCarrierCfg.CarrierId)







[Datos.ListaEnCaptura]
(Inicio)=EmidaCarrierCfg.CarrierId
EmidaCarrierCfg.CarrierId=EmidaCarrierCfg.Description
EmidaCarrierCfg.Description=EmidaCarrierCfg.ProductCount
EmidaCarrierCfg.ProductCount=(Fin)

[Datos.ListaOrden]
(Inicio)=EmidaCarrierCfg.URL	(Acendente)
EmidaCarrierCfg.URL	(Acendente)=EmidaCarrierCfg.CarrierId	(Acendente)
EmidaCarrierCfg.CarrierId	(Acendente)=(Fin)











[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Productos
Productos=(Fin)
