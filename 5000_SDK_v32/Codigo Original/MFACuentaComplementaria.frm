
[Forma]
Clave=MFACuentaComplementaria
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=MFA - Cuentas Complementarias
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=GuardarCerrar
PosicionInicialIzquierda=470
PosicionInicialArriba=182
PosicionInicialAlturaCliente=325
PosicionInicialAncho=425
ListaCarpetas=MFACuentaComplementaria
CarpetaPrincipal=MFACuentaComplementaria
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

[MFACuentaComplementaria]
Estilo=Hoja
PestanaOtroNombre=S
PestanaNombre=Lista
Clave=MFACuentaComplementaria
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MFACuentaComplementaria
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
OtroOrden=S
BusquedaRapidaControles=S

ListaOrden=(Lista)
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
ValidarCampos=S
ListaCamposAValidar=Cta.Descripcion
[MFACuentaComplementaria.MFACuentaComplementaria.Cuenta]
Carpeta=MFACuentaComplementaria
Clave=MFACuentaComplementaria.Cuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[MFACuentaComplementaria.MFACuentaComplementaria.Moneda]
Carpeta=MFACuentaComplementaria
Clave=MFACuentaComplementaria.Moneda
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[MFACuentaComplementaria.Columnas]
Cuenta=173
Moneda=123




Empresa=58
[Lista.Columnas]
0=207

[MFACuentaComplementaria.ListaEnCaptura]
(Inicio)=MFACuentaComplementaria.Empresa
MFACuentaComplementaria.Empresa=MFACuentaComplementaria.Cuenta
MFACuentaComplementaria.Cuenta=MFACuentaComplementaria.Moneda
MFACuentaComplementaria.Moneda=(Fin)

[MFACuentaComplementaria.ListaOrden]
(Inicio)=MFACuentaComplementaria.Empresa	(Acendente)
MFACuentaComplementaria.Empresa	(Acendente)=MFACuentaComplementaria.Cuenta	(Acendente)
MFACuentaComplementaria.Cuenta	(Acendente)=(Fin)

[MFACuentaComplementaria.MFACuentaComplementaria.Empresa]
Carpeta=MFACuentaComplementaria
Clave=MFACuentaComplementaria.Empresa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco
