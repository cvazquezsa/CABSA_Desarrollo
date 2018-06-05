
[Forma]
Clave=ContParalelaEmpresaFiltro
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

VentanaExclusiva=S
VentanaExclusivaOpcion=2
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


[Lista.ListaEnCaptura]
(Inicio)=ContParalelaEmpresa.Empresa
ContParalelaEmpresa.Empresa=ContParalelaEmpresa.BaseDatosRemota
ContParalelaEmpresa.BaseDatosRemota=ContParalelaEmpresa.EmpresaRemota
ContParalelaEmpresa.EmpresaRemota=(Fin)

[Acciones.Seleccionar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Asigna(Info.ID, ContParalelaEmpresa:ContParalelaEmpresa.ID)<BR>Asigna(Info.Empresa, ContParalelaEmpresa:ContParalelaEmpresa.Empresa + <T> | <T> + ContParalelaEmpresa:ContParalelaEmpresa.BaseDatosRemota + <T> | <T> + ContParalelaEmpresa:ContParalelaEmpresa.EmpresaRemota)
[Acciones.Seleccionar.Cerrar]
Nombre=Cerrar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Seleccionar
GuardarAntes=S
Multiple=S
EnBarraHerramientas=S
TipoAccion=Expresion
ListaAccionesMultiples=(Lista)

Activo=S
Visible=S








[Acciones.Seleccionar.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Cerrar
Cerrar=(Fin)
