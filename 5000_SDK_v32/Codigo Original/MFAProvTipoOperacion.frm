
[Forma]
Clave=MFAProvTipoOperacion
Icono=0
Modulos=(Todos)
Nombre=Proveedores Tipo Operación

ListaCarpetas=Hoja
CarpetaPrincipal=Hoja
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
PosicionInicialIzquierda=469
PosicionInicialArriba=182
PosicionInicialAlturaProveedor=273
PosicionInicialAncho=661
PosicionInicialAlturaCliente=468

[Hoja]
Estilo=Hoja
PestanaOtroNombre=S
Clave=Hoja
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MFAProvTipoOperacion
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Plata
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
[Hoja.MFAProvTipoOperacion.Proveedor]
Carpeta=Hoja
Clave=MFAProvTipoOperacion.Proveedor
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Plata

[Hoja.MFAProvTipoOperacion.Nombre]
Carpeta=Hoja
Clave=MFAProvTipoOperacion.Nombre
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Plata

[Hoja.MFAProvTipoOperacion.MFATipoOperacion]
Carpeta=Hoja
Clave=MFAProvTipoOperacion.MFATipoOperacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

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
Proveedor=64
Nombre=380
MFATipoOperacion=166





[Hoja.ListaEnCaptura]
(Inicio)=MFAProvTipoOperacion.Proveedor
MFAProvTipoOperacion.Proveedor=MFAProvTipoOperacion.Nombre
MFAProvTipoOperacion.Nombre=MFAProvTipoOperacion.MFATipoOperacion
MFAProvTipoOperacion.MFATipoOperacion=(Fin)
