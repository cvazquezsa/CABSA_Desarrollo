
[Forma]
Clave=WMSModuloMovimiento
Icono=0
Modulos=(Todos)
Nombre=Movimientos de surtido WMS

ListaCarpetas=WMSModuloMovimiento
CarpetaPrincipal=WMSModuloMovimiento
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
PosicionInicialAlturaCliente=273
PosicionInicialAncho=338
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=471
PosicionInicialArriba=246
[WMSModuloMovimiento]
Estilo=Hoja
Clave=WMSModuloMovimiento
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=WMSModuloMovimiento
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

[WMSModuloMovimiento.WMSModuloMovimiento.Modulo]
Carpeta=WMSModuloMovimiento
Clave=WMSModuloMovimiento.Modulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[WMSModuloMovimiento.WMSModuloMovimiento.Movimiento]
Carpeta=WMSModuloMovimiento
Clave=WMSModuloMovimiento.Movimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
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

[WMSModuloMovimiento.Columnas]
Modulo=78
Movimiento=124

Estatus=94
[WMSModuloMovimiento.ListaEnCaptura]
(Inicio)=WMSModuloMovimiento.Modulo
WMSModuloMovimiento.Modulo=WMSModuloMovimiento.Movimiento
WMSModuloMovimiento.Movimiento=WMSModuloMovimiento.Estatus
WMSModuloMovimiento.Estatus=(Fin)

[WMSModuloMovimiento.WMSModuloMovimiento.Estatus]
Carpeta=WMSModuloMovimiento
Clave=WMSModuloMovimiento.Estatus
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
