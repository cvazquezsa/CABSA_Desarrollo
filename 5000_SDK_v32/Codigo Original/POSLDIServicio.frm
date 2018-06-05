
[Forma]
Clave=POSLDIServicio
Icono=0
BarraHerramientas=S
Modulos=(Todos)
Nombre=Configuración de Servicios LDI
AccionesTamanoBoton=15x5
AccionesDerecha=S
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal

ListaCarpetas=Campos
CarpetaPrincipal=Campos
ListaAcciones=(Lista)
PosicionInicialIzquierda=231
PosicionInicialArriba=65
PosicionInicialAlturaCliente=463
PosicionInicialAncho=818
VentanaExclusiva=S
[Campos]
Estilo=Hoja
Clave=Campos
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=POSLDIServicio
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

[Campos.POSLDIServicio.Servicio]
Carpeta=Campos
Clave=POSLDIServicio.Servicio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Campos.POSLDIServicio.DireccionIP]
Carpeta=Campos
Clave=POSLDIServicio.DireccionIP
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[Campos.POSLDIServicio.Puerto]
Carpeta=Campos
Clave=POSLDIServicio.Puerto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Campos.POSLDIServicio.TrxType]
Carpeta=Campos
Clave=POSLDIServicio.TrxType
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Campos.POSLDIServicio.TrxSubType]
Carpeta=Campos
Clave=POSLDIServicio.TrxSubType
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Campos.POSLDIServicio.EntryMode]
Carpeta=Campos
Clave=POSLDIServicio.EntryMode
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Campos.POSLDIServicio.GeneraVoucher]
Carpeta=Campos
Clave=POSLDIServicio.GeneraVoucher
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Campos.POSLDIServicio.AnchoVoucher]
Carpeta=Campos
Clave=POSLDIServicio.AnchoVoucher
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
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
Servicio=124
DireccionIP=94
Puerto=64
TrxType=64
TrxSubType=64
EntryMode=64
GeneraVoucher=81
AnchoVoucher=76
FormaPago=140




[Acciones.CFGSevicios]
Nombre=CFGSevicios
Boton=95
NombreEnBoton=S
NombreDesplegar=&Configuración de Servicios
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=POSLDIArtRecargaTel
Activo=S
Visible=S








[Campos.ListaEnCaptura]
(Inicio)=POSLDIServicio.Servicio
POSLDIServicio.Servicio=POSLDIServicio.DireccionIP
POSLDIServicio.DireccionIP=POSLDIServicio.Puerto
POSLDIServicio.Puerto=POSLDIServicio.TrxType
POSLDIServicio.TrxType=POSLDIServicio.TrxSubType
POSLDIServicio.TrxSubType=POSLDIServicio.EntryMode
POSLDIServicio.EntryMode=POSLDIServicio.GeneraVoucher
POSLDIServicio.GeneraVoucher=POSLDIServicio.AnchoVoucher
POSLDIServicio.AnchoVoucher=(Fin)




















































[Acciones.POSLDIServicioEstacion]
Nombre=POSLDIServicioEstacion
Boton=94
NombreEnBoton=S
NombreDesplegar=IP Estación
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=POSLDIServicioEstacion
Activo=S
VisibleCondicion=POSLDIServicio:POSLDIServicio.Servicio = <T>TDCLDI<T>

[Forma.ListaAcciones]
(Inicio)=Guardar
Guardar=CFGSevicios
CFGSevicios=POSLDIServicioEstacion
POSLDIServicioEstacion=(Fin)
