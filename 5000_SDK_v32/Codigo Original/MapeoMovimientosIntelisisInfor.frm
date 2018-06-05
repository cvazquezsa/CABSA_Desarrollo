
[Forma]
Clave=MapeoMovimientosIntelisisInfor
Icono=0
CarpetaPrincipal=Mapeo Movimientos Intelisis-Infor
Modulos=(Todos)
Nombre=Mapeo Movimientos Intelisis-Factory

ListaCarpetas=Mapeo Movimientos Intelisis-Infor
PosicionInicialAlturaCliente=273
PosicionInicialAncho=351
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=507
PosicionInicialArriba=208
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Guardar Cambios




[MapeoMovIntelisisMes.Columnas]
Modulo=60
Movimiento=124
ReferenciaIntelisisMes=130



[MapeoMovIntelisisMes.ListaEnCaptura]
(Inicio)=MapeoMovIntelisisMes.Modulo
MapeoMovIntelisisMes.Modulo=MapeoMovIntelisisMes.Movimiento
MapeoMovIntelisisMes.Movimiento=MapeoMovIntelisisMes.ReferenciaIntelisisMes
MapeoMovIntelisisMes.ReferenciaIntelisisMes=(Fin)

[Acciones.Guardar Cambios]
Nombre=Guardar Cambios
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar Y Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Mapeo Movimientos Intelisis-Infor]
Estilo=Hoja
Clave=Mapeo Movimientos Intelisis-Infor
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MapeoMovimientosIntelisisInfor
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




PestanaOtroNombre=S
PestanaNombre=Mapeo Movimientos Intelisis-MES

[Mapeo Movimientos Intelisis-Infor.MapeoMovimientosIntelisisInfor.Modulo]
Carpeta=Mapeo Movimientos Intelisis-Infor
Clave=MapeoMovimientosIntelisisInfor.Modulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[Mapeo Movimientos Intelisis-Infor.MapeoMovimientosIntelisisInfor.Movimiento]
Carpeta=Mapeo Movimientos Intelisis-Infor
Clave=MapeoMovimientosIntelisisInfor.Movimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Mapeo Movimientos Intelisis-Infor.MapeoMovimientosIntelisisInfor.ReferenciaIntelisisMes]
Carpeta=Mapeo Movimientos Intelisis-Infor
Clave=MapeoMovimientosIntelisisInfor.ReferenciaIntelisisMes
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Mapeo Movimientos Intelisis-Infor.Columnas]
Modulo=63
Movimiento=124
ReferenciaIntelisisMes=124





[Mapeo Movimientos Intelisis-Infor.ListaEnCaptura]
(Inicio)=MapeoMovimientosIntelisisInfor.Modulo
MapeoMovimientosIntelisisInfor.Modulo=MapeoMovimientosIntelisisInfor.Movimiento
MapeoMovimientosIntelisisInfor.Movimiento=MapeoMovimientosIntelisisInfor.ReferenciaIntelisisMes
MapeoMovimientosIntelisisInfor.ReferenciaIntelisisMes=(Fin)
