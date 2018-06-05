
[Forma]
Clave=MFACteTipoOperacion
Icono=0
Modulos=(Todos)
Nombre=Clientes Tipo Operación

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
PosicionInicialArriba=186
PosicionInicialAlturaCliente=468
PosicionInicialAncho=661
[Hoja]
Estilo=Hoja
PestanaOtroNombre=S
Clave=Hoja
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MFACteTipoOperacion
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
[Hoja.MFACteTipoOperacion.Cliente]
Carpeta=Hoja
Clave=MFACteTipoOperacion.Cliente
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Plata

[Hoja.MFACteTipoOperacion.Nombre]
Carpeta=Hoja
Clave=MFACteTipoOperacion.Nombre
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Plata

[Hoja.MFACteTipoOperacion.MFATipoOperacion]
Carpeta=Hoja
Clave=MFACteTipoOperacion.MFATipoOperacion
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
Cliente=64
Nombre=380
MFATipoOperacion=166





[Hoja.ListaEnCaptura]
(Inicio)=MFACteTipoOperacion.Cliente
MFACteTipoOperacion.Cliente=MFACteTipoOperacion.Nombre
MFACteTipoOperacion.Nombre=MFACteTipoOperacion.MFATipoOperacion
MFACteTipoOperacion.MFATipoOperacion=(Fin)
