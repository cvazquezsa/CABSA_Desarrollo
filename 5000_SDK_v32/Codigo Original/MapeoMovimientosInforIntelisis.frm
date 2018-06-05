
[Forma]
Clave=MapeoMovimientosInforIntelisis
Icono=0
CarpetaPrincipal=MapeoMovimientosInforIntelisis
Modulos=(Todos)
Nombre=Mapeo Movimiento Factory-Intelisis

ListaCarpetas=MapeoMovimientosInforIntelisis
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=Cerrar
PosicionInicialAlturaCliente=273
PosicionInicialAncho=500
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=433
PosicionInicialArriba=208
[Mapeo Movimientos Infor Intelisis.ListaEnCaptura]
(Inicio)=MapeoMovimientosInforIntelisis.INFORMov
MapeoMovimientosInforIntelisis.INFORMov=MapeoMovimientosInforIntelisis.Mov
MapeoMovimientosInforIntelisis.Mov=(Fin)



[Acciones.Cerrar]
Nombre=Cerrar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[MapeoMovimientosInforIntelisis]
Estilo=Hoja
PestanaOtroNombre=S
PestanaNombre=Mape oMovimientos MES-Intelisis
Clave=MapeoMovimientosInforIntelisis
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MapeoMovimientosInforIntelisis
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

[MapeoMovimientosInforIntelisis.MapeoMovimientosInforIntelisis.INFORMov]
Carpeta=MapeoMovimientosInforIntelisis
Clave=MapeoMovimientosInforIntelisis.INFORMov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[MapeoMovimientosInforIntelisis.MapeoMovimientosInforIntelisis.Mov]
Carpeta=MapeoMovimientosInforIntelisis
Clave=MapeoMovimientosInforIntelisis.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[MapeoMovimientosInforIntelisis.Columnas]
INFORMov=124
Mov=141









Modulo=56

[MapeoMovimientosInforIntelisis.MapeoMovimientosInforIntelisis.Modulo]
Carpeta=MapeoMovimientosInforIntelisis
Clave=MapeoMovimientosInforIntelisis.Modulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[MapeoMovimientosInforIntelisis.ListaEnCaptura]
(Inicio)=MapeoMovimientosInforIntelisis.Modulo
MapeoMovimientosInforIntelisis.Modulo=MapeoMovimientosInforIntelisis.INFORMov
MapeoMovimientosInforIntelisis.INFORMov=MapeoMovimientosInforIntelisis.Mov
MapeoMovimientosInforIntelisis.Mov=(Fin)
