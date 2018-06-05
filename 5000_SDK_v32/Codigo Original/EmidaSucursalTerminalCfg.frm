
[Forma]
Clave=EmidaSucursalTerminalCfg
Icono=0
Modulos=(Todos)
Nombre=Emida - Configuración Terminales
MovModulo=(Todos)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=GuardarCerrar
PosicionInicialIzquierda=462
PosicionInicialArriba=231
PosicionInicialAlturaCliente=227
PosicionInicialAncho=356
ListaCarpetas=Datos
CarpetaPrincipal=Datos
Comentarios=Lista(Info.Sucursal, Info.Pagina, Empresa)
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
Estilo=Ficha
Clave=Datos
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmidaTerminalCfg
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S
PestanaOtroNombre=S
PestanaNombre=Datos

OtroOrden=S
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General

FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
FiltroGeneral=EmidaTerminalCfg.Empresa = <T>{Empresa}<T> AND<BR>EmidaTerminalCfg.URL = <T>{Info.Pagina}<T> AND<BR>EmidaTerminalCfg.Sucursal = {Info.Sucursal}
[Datos.EmidaTerminalCfg.SiteID]
Carpeta=Datos
Clave=EmidaTerminalCfg.SiteID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=18
ColorFondo=Blanco

[Datos.Columnas]
SiteID=91









URL=350

ClerkID=65
InvoiceNo=64

[Datos.EmidaTerminalCfg.InvoiceNo]
Carpeta=Datos
Clave=EmidaTerminalCfg.InvoiceNo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco







Tamano=18
[Datos.ListaEnCaptura]
(Inicio)=EmidaTerminalCfg.SiteID
EmidaTerminalCfg.SiteID=EmidaTerminalCfg.InvoiceNo
EmidaTerminalCfg.InvoiceNo=(Fin)
