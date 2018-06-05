
[Forma]
Clave=LDIServicio
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
PosicionInicialIzquierda=163
PosicionInicialArriba=233
PosicionInicialAlturaCliente=415
PosicionInicialAncho=953
VentanaExclusiva=S
[Campos]
Estilo=Hoja
Clave=Campos
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=LDIServicio
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

[Campos.LDIServicio.Servicio]
Carpeta=Campos
Clave=LDIServicio.Servicio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Campos.LDIServicio.DireccionIP]
Carpeta=Campos
Clave=LDIServicio.DireccionIP
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[Campos.LDIServicio.Puerto]
Carpeta=Campos
Clave=LDIServicio.Puerto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Campos.LDIServicio.TrxType]
Carpeta=Campos
Clave=LDIServicio.TrxType
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Campos.LDIServicio.TrxSubType]
Carpeta=Campos
Clave=LDIServicio.TrxSubType
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Campos.LDIServicio.EntryMode]
Carpeta=Campos
Clave=LDIServicio.EntryMode
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Campos.LDIServicio.GeneraVoucher]
Carpeta=Campos
Clave=LDIServicio.GeneraVoucher
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Campos.LDIServicio.AnchoVoucher]
Carpeta=Campos
Clave=LDIServicio.AnchoVoucher
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




ServicioInverso=124
Tipo=124

POSForma=146
[Campos.LDIServicio.ServicioInverso]
Carpeta=Campos
Clave=LDIServicio.ServicioInverso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco





[Campos.ListaEnCaptura]
(Inicio)=LDIServicio.Servicio
LDIServicio.Servicio=LDIServicio.DireccionIP
LDIServicio.DireccionIP=LDIServicio.Puerto
LDIServicio.Puerto=LDIServicio.TrxType
LDIServicio.TrxType=LDIServicio.TrxSubType
LDIServicio.TrxSubType=LDIServicio.EntryMode
LDIServicio.EntryMode=LDIServicio.GeneraVoucher
LDIServicio.GeneraVoucher=LDIServicio.AnchoVoucher
LDIServicio.AnchoVoucher=LDIServicio.ServicioInverso
LDIServicio.ServicioInverso=LDIServicio.POSForma
LDIServicio.POSForma=(Fin)

[Campos.LDIServicio.POSForma]
Carpeta=Campos
Clave=LDIServicio.POSForma
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Acciones.LDIServicioEstacion]
Nombre=LDIServicioEstacion
Boton=94
NombreEnBoton=S
NombreDesplegar=IP Estación
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=LDIServicioEstacion
Activo=S
VisibleCondicion=LDIServicio:LDIServicio.Servicio = <T>TDCLDI<T>



[Forma.ListaAcciones]
(Inicio)=Guardar
Guardar=LDIServicioEstacion
LDIServicioEstacion=(Fin)
