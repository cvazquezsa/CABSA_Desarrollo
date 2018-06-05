
[Forma]
Clave=EmidaMerchandIDCfg
Icono=0
Modulos=(Todos)
Nombre=Emida - Configuración de Sucursal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
Comentarios=Lista(Info.Pagina, Empresa)

ListaAcciones=(Lista)
ListaCarpetas=Datos
CarpetaPrincipal=Datos
PosicionInicialIzquierda=465
PosicionInicialArriba=222
PosicionInicialAlturaCliente=246
PosicionInicialAncho=350
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraAyuda=S
[Acciones.GuardarCerrar]
Nombre=GuardarCerrar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

GuardarAntes=S
[Datos]
Estilo=Hoja
PestanaOtroNombre=S
PestanaNombre=Datos
Clave=Datos
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmidaMerchandIDCfg
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
FiltroGrupo1=EmidaMerchantIDCfg.URL
FiltroValida1=EmidaMerchantIDCfg.URL
FiltroGrupo2=EmidaMerchantIDCfg.Sucursal
FiltroValida2=EmidaMerchantIDCfg.Sucursal
FiltroAplicaEn=EmidaMerchantIDCfg.URL
FiltroTodo=S

FiltroGeneral=EmidaMerchantIDCfg.Empresa = <T>{Empresa}<T> AND<BR>EmidaMerchantIDCfg.URL = <T>{Info.Pagina}<T>
[Datos.EmidaMerchantIDCfg.Sucursal]
Carpeta=Datos
Clave=EmidaMerchantIDCfg.Sucursal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Datos.EmidaMerchantIDCfg.MerchantID]
Carpeta=Datos
Clave=EmidaMerchantIDCfg.MerchantID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Datos.Columnas]
URL=378
Sucursal=141
MerchantID=107















[Lista.Columnas]
0=91
1=267





[Acciones.EmidaTerminalCfg]
Nombre=EmidaTerminalCfg
Boton=16
NombreDesplegar=Terminales
EnBarraHerramientas=S
Activo=S



EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=EmidaSucursalTerminalCfg




Antes=S












































NombreEnBoton=S
AntesExpresiones=Asigna(Info.Sucursal, EmidaMerchandIDCfg:EmidaMerchantIDCfg.Sucursal)
VisibleCondicion=fnEmidaNivelCfgSiteID(Empresa) = <T>Sucursal<T>







[Datos.ListaEnCaptura]
(Inicio)=EmidaMerchantIDCfg.Sucursal
EmidaMerchantIDCfg.Sucursal=EmidaMerchantIDCfg.MerchantID
EmidaMerchantIDCfg.MerchantID=(Fin)

[Datos.ListaOrden]
(Inicio)=EmidaMerchantIDCfg.Empresa	(Acendente)
EmidaMerchantIDCfg.Empresa	(Acendente)=EmidaMerchantIDCfg.Sucursal	(Acendente)
EmidaMerchantIDCfg.Sucursal	(Acendente)=EmidaMerchantIDCfg.URL	(Acendente)
EmidaMerchantIDCfg.URL	(Acendente)=(Fin)



















[Forma.ListaAcciones]
(Inicio)=GuardarCerrar
GuardarCerrar=EmidaTerminalCfg
EmidaTerminalCfg=(Fin)
