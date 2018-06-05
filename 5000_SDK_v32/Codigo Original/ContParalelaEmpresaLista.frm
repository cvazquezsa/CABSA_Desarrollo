
[Forma]
Clave=ContParalelaEmpresaLista
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=Empresas
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=Seleccionar
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=472
PosicionInicialArriba=152
PosicionInicialAlturaCliente=386
PosicionInicialAncho=421

[Lista]
Estilo=Hoja
PestanaOtroNombre=S
PestanaNombre=Empresa
Clave=Lista
OtroOrden=S
ValidarCampos=S
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

ListaCamposAValidar=Empresa.Nombre
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

[Lista.ContParalelaEmpresa.Empresa]
Carpeta=Lista
Clave=ContParalelaEmpresa.Empresa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

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

[Lista.Columnas]
Empresa=75
BaseDatosRemota=145
EmpresaRemota=105

Nombre=371

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

[Lista.ListaEnCaptura]
(Inicio)=ContParalelaEmpresa.Empresa
ContParalelaEmpresa.Empresa=ContParalelaEmpresa.BaseDatosRemota
ContParalelaEmpresa.BaseDatosRemota=ContParalelaEmpresa.EmpresaRemota
ContParalelaEmpresa.EmpresaRemota=(Fin)
