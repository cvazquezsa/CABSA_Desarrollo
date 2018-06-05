
[Forma]
Clave=ContParalelaEmpresaCta
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=Contabilidad Paralela - Empresas
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=(Lista)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=413
PosicionInicialArriba=152
PosicionInicialAlturaCliente=386
PosicionInicialAncho=540

PosicionSec1=314
[Lista]
Estilo=Hoja
PestanaOtroNombre=S
PestanaNombre=Empresa
Clave=Lista
OtroOrden=S
BusquedaRapidaControles=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ContParalelaEmpresa
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

ListaOrden=ContParalelaEmpresa.Empresa<TAB>(Acendente)
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
CarpetaVisible=S

Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=ContParalelaEmpresa.Empresa = <T>{Empresa}<T>
[Lista.ContParalelaEmpresa.Empresa]
Carpeta=Lista
Clave=ContParalelaEmpresa.Empresa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco



[Lista.Columnas]
Empresa=58
BaseDatosRemota=105
EmpresaRemota=105

Nombre=211



Clave=140
Descripcion=292
[Lista.Empresa.Nombre]
Carpeta=Lista
Clave=Empresa.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Acciones.Cta]
Nombre=Cta
Boton=64
NombreEnBoton=S
NombreDesplegar=Cuentas Contables
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=ContParalelaCta
Activo=S
Visible=S

Antes=S
























































AntesExpresiones=Asigna(Info.ID, ContParalelaEmpresa:ContParalelaEmpresa.ID)<BR>Asigna(Info.Empresa, ContParalelaEmpresa:ContParalelaEmpresa.Empresa + <T> | <T> + ContParalelaEmpresa:ContParalelaEmpresa.BaseDatosRemota + <T> | <T> + ContParalelaEmpresa:ContParalelaEmpresa.EmpresaRemota)
[Lista.ContParalelaEmpresa.BaseDatosRemota]
Carpeta=Lista
Clave=ContParalelaEmpresa.BaseDatosRemota
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[Lista.ContParalelaEmpresa.EmpresaRemota]
Carpeta=Lista
Clave=ContParalelaEmpresa.EmpresaRemota
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

























































[Lista.ListaEnCaptura]
(Inicio)=ContParalelaEmpresa.Empresa
ContParalelaEmpresa.Empresa=Empresa.Nombre
Empresa.Nombre=ContParalelaEmpresa.BaseDatosRemota
ContParalelaEmpresa.BaseDatosRemota=ContParalelaEmpresa.EmpresaRemota
ContParalelaEmpresa.EmpresaRemota=(Fin)





[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Cta
Cta=(Fin)
