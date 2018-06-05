
[Forma]
Clave=EmidaCarrierLista
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=Emida - Configuración de Proveedores
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=269
PosicionInicialArriba=98
PosicionInicialAlturaCliente=447
PosicionInicialAncho=753
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=Seleccionar
Comentarios=Empresa
ListaCarpetas=Datos
CarpetaPrincipal=Datos

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
BusquedaRapidaControles=S

ListaOrden=(Lista)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=50
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaEnLinea=S
FiltroGrupo1=EmidaCarrierCfg.URL
FiltroValida1=EmidaCarrierCfg.URL
FiltroTodo=S

FiltroGeneral=EmidaCarrierCfg.Empresa = <T>{Empresa}<T>
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
CarrierId=130
Description=128
ProductCount=131













[Datos.ListaEnCaptura]
(Inicio)=EmidaCarrierCfg.CarrierId
EmidaCarrierCfg.CarrierId=EmidaCarrierCfg.Description
EmidaCarrierCfg.Description=EmidaCarrierCfg.ProductCount
EmidaCarrierCfg.ProductCount=(Fin)

[Datos.ListaOrden]
(Inicio)=EmidaCarrierCfg.URL	(Acendente)
EmidaCarrierCfg.URL	(Acendente)=EmidaCarrierCfg.CarrierId	(Acendente)
EmidaCarrierCfg.CarrierId	(Acendente)=(Fin)

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
