
[Forma]
Clave=MFACtaEstructuraTipo
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=MFA - Tipos de Cuenta Estructura
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal

ListaCarpetas=MFACtaEstructuraTipo
CarpetaPrincipal=MFACtaEstructuraTipo
PosicionInicialIzquierda=406
PosicionInicialArriba=164
PosicionInicialAlturaCliente=337
PosicionInicialAncho=493
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=GuardarCerrar
[MFACtaEstructuraTipo]
Estilo=Hoja
PestanaOtroNombre=S
PestanaNombre=Lista
Clave=MFACtaEstructuraTipo
OtroOrden=S
ValidarCampos=S
BusquedaRapidaControles=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MFACtaEstructuraTipo
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

ListaCamposAValidar=Cta.Descripcion
ListaOrden=MFACtaEstructuraTipo.Cuenta<TAB>(Acendente)
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

[MFACtaEstructuraTipo.MFACtaEstructuraTipo.Cuenta]
Carpeta=MFACtaEstructuraTipo
Clave=MFACtaEstructuraTipo.Cuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[MFACtaEstructuraTipo.MFACtaEstructuraTipo.Tipo]
Carpeta=MFACtaEstructuraTipo
Clave=MFACtaEstructuraTipo.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[MFACtaEstructuraTipo.Columnas]
Cuenta=124
Tipo=304

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

[Lista.Columnas]
0=207

[MFACtaEstructuraTipo.ListaEnCaptura]
(Inicio)=MFACtaEstructuraTipo.Cuenta
MFACtaEstructuraTipo.Cuenta=MFACtaEstructuraTipo.Tipo
MFACtaEstructuraTipo.Tipo=(Fin)
