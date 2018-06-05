
[Forma]
Clave=DIOTProvTipoOperacion
Icono=0
Modulos=(Todos)
Nombre=DPIVA - Tipo Operación

ListaCarpetas=Hoja
CarpetaPrincipal=Hoja
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
PosicionInicialIzquierda=439
PosicionInicialArriba=150
PosicionInicialAlturaProveedor=273
PosicionInicialAncho=487
PosicionInicialAlturaCliente=390

[Hoja]
Estilo=Hoja
PestanaOtroNombre=S
Clave=Hoja
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=DIOTProvTipoOperacion
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
BusquedaRapidaControles=S

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
BusquedaAutoAsterisco=S

ValidarCampos=S
ListaCamposAValidar=Prov.Nombre
[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Hoja.Columnas]
Proveedor=95
Nombre=380
MFATipoOperacion=166









TipoOperacion=321

[Hoja.DIOTProvTipoOperacion.TipoOperacion]
Carpeta=Hoja
Clave=DIOTProvTipoOperacion.TipoOperacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco


[Hoja.DIOTProvTipoOperacion.Proveedor]
Carpeta=Hoja
Clave=DIOTProvTipoOperacion.Proveedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.Columnas]
0=116
1=266

[Hoja.ListaEnCaptura]
(Inicio)=DIOTProvTipoOperacion.Proveedor
DIOTProvTipoOperacion.Proveedor=DIOTProvTipoOperacion.TipoOperacion
DIOTProvTipoOperacion.TipoOperacion=(Fin)
