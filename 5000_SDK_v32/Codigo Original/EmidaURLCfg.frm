
[Forma]
Clave=EmidaURLCfg
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=Emida - Configuración URL
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=(Lista)
Comentarios=Empresa
ListaCarpetas=Datos
CarpetaPrincipal=Datos
PosicionInicialIzquierda=328
PosicionInicialArriba=138
PosicionInicialAlturaCliente=334
PosicionInicialAncho=535
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
PestanaOtroNombre=S
PestanaNombre=Datos
Clave=Datos
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmidaURLCfg
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
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S

FiltroGeneral=EmidaURLCfg.Empresa = <T>{Empresa}<T>
[Datos.EmidaURLCfg.URL]
Carpeta=Datos
Clave=EmidaURLCfg.URL
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[Datos.Columnas]
URL=376

ClerkID=58


MerchantID=129


CtaDinero=96
[Datos.ListaEnCaptura]
(Inicio)=EmidaURLCfg.URL
EmidaURLCfg.URL=EmidaURLCfg.CtaDinero
EmidaURLCfg.CtaDinero=(Fin)

[Datos.EmidaURLCfg.CtaDinero]
Carpeta=Datos
Clave=EmidaURLCfg.CtaDinero
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.Columnas]
0=84
1=111
2=-2

[Acciones.EmidaCarrierCfg]
Nombre=EmidaCarrierCfg
Boton=104
NombreDesplegar=&Proveedores
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=EmidaCarrierCfg
Activo=S
Visible=S



NombreEnBoton=S


Antes=S






EspacioPrevio=S









AntesExpresiones=Asigna(Info.Pagina, EmidaURLCfg:EmidaURLCfg.URL)
[Acciones.EmidaMerchantID]
Nombre=EmidaMerchantID
Boton=94
NombreEnBoton=S
NombreDesplegar=&Configuración de Sucursal
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=EmidaMerchandIDCfg
Activo=S
Visible=S





Antes=S




















AntesExpresiones=Asigna(Info.Pagina, EmidaURLCfg:EmidaURLCfg.URL)












[Forma.ListaAcciones]
(Inicio)=GuardarCerrar
GuardarCerrar=EmidaMerchantID
EmidaMerchantID=EmidaCarrierCfg
EmidaCarrierCfg=(Fin)
