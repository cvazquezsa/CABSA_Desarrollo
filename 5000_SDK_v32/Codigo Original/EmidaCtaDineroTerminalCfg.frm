
[Forma]
Clave=EmidaCtaDineroTerminalCfg
Icono=0
Modulos=(Todos)
Nombre=Emida - Configuración Terminales por Caja
MovModulo=(Todos)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=GuardarCerrar
PosicionInicialIzquierda=335
PosicionInicialArriba=158
PosicionInicialAlturaCliente=374
PosicionInicialAncho=609
ListaCarpetas=Datos
CarpetaPrincipal=Datos
Comentarios=Lista(Info.CtaDinero, Info.Sucursal, Empresa)
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

[Datos]
Estilo=Hoja
Clave=Datos
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmidaTerminalCfg
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
PestanaOtroNombre=S
PestanaNombre=Datos

OtroOrden=S
ListaOrden=EmidaTerminalCfg.URL<TAB>(Acendente)
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General

FiltroGeneral=EmidaTerminalCfg.Empresa = <T>{Empresa}<T> AND<BR>EmidaTerminalCfg.CtaDinero = <T>{Info.CtaDinero}<T>
[Datos.EmidaTerminalCfg.SiteID]
Carpeta=Datos
Clave=EmidaTerminalCfg.SiteID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=9
ColorFondo=Blanco

[Datos.Columnas]
SiteID=91









URL=350

ClerkID=65
InvoiceNo=106

[Datos.EmidaTerminalCfg.InvoiceNo]
Carpeta=Datos
Clave=EmidaTerminalCfg.InvoiceNo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco






[Datos.EmidaTerminalCfg.URL]
Carpeta=Datos
Clave=EmidaTerminalCfg.URL
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[Datos.ListaEnCaptura]
(Inicio)=EmidaTerminalCfg.URL
EmidaTerminalCfg.URL=EmidaTerminalCfg.SiteID
EmidaTerminalCfg.SiteID=EmidaTerminalCfg.InvoiceNo
EmidaTerminalCfg.InvoiceNo=(Fin)
