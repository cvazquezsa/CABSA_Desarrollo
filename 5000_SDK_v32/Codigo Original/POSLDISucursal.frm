
[Forma]
Clave=POSLDISucursal
Icono=0
BarraHerramientas=S
Modulos=(Todos)
Nombre=Configuración de Sucursal LDI
AccionesTamanoBoton=15x5
AccionesDerecha=S
VentanaSiempreAlFrente=S
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal

ListaCarpetas=Campos
CarpetaPrincipal=Campos
Comentarios=Empresa
ListaAcciones=Guardar
PosicionInicialIzquierda=566
PosicionInicialArriba=229
PosicionInicialAlturaCliente=273
PosicionInicialAncho=233
[Campos]
Estilo=Hoja
Clave=Campos
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=POSLDISucursal
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
PermiteEditar=S

FiltroGeneral=POSLDISucursal.Empresa = <T>{Empresa}<T>
[Campos.POSLDISucursal.Sucursal]
Carpeta=Campos
Clave=POSLDISucursal.Sucursal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Campos.POSLDISucursal.SucursalLDI]
Carpeta=Campos
Clave=POSLDISucursal.SucursalLDI
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Campos.Columnas]
Sucursal=64
SucursalLDI=129

[Campos.ListaEnCaptura]
(Inicio)=POSLDISucursal.Sucursal
POSLDISucursal.Sucursal=POSLDISucursal.SucursalLDI
POSLDISucursal.SucursalLDI=(Fin)
