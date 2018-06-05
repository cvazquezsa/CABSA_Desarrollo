[Forma]
Clave=SincroLog
Nombre=Bitácora Sincronización
Icono=6
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=347
PosicionInicialArriba=225
PosicionInicialAlturaCliente=488
PosicionInicialAncho=634
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=por Diseño

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=SincroLog
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
FiltroFechas=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasCampo=SincroLog.Fecha
FiltroFechasDefault=Esta Semana
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
OtroOrden=S
ListaOrden=SincroLog.OrdenID<TAB>(Decendente)

[Lista.SincroLog.Sucursal]
Carpeta=Lista
Clave=SincroLog.Sucursal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.SincroLog.Accion]
Carpeta=Lista
Clave=SincroLog.Accion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.SincroLog.Origen]
Carpeta=Lista
Clave=SincroLog.Origen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.SincroLog.Consecutivo]
Carpeta=Lista
Clave=SincroLog.Consecutivo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.SincroLog.Tablas]
Carpeta=Lista
Clave=SincroLog.Tablas
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.SincroLog.Registros]
Carpeta=Lista
Clave=SincroLog.Registros
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Sucursal=83
Accion=124
Origen=79
Consecutivo=64
Tablas=64
Registros=64
Fecha=121

[Acciones.Detalles]
Nombre=Detalles
Boton=47
NombreEnBoton=S
NombreDesplegar=&Detalles
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=SincroLogLista
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(SincroLog:SincroLog.OrdenID)
Antes=S
AntesExpresiones=Asigna(Info.ID, SincroLog:SincroLog.OrdenID)
Visible=S

[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Lista.SincroLog.Fecha]
Carpeta=Lista
Clave=SincroLog.Fecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Detalles
Detalles=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=SincroLog.Fecha
SincroLog.Fecha=SincroLog.Sucursal
SincroLog.Sucursal=SincroLog.Accion
SincroLog.Accion=SincroLog.Origen
SincroLog.Origen=SincroLog.Consecutivo
SincroLog.Consecutivo=SincroLog.Tablas
SincroLog.Tablas=SincroLog.Registros
SincroLog.Registros=(Fin)
