
[Forma]
Clave=LDIMovLog
Icono=0
Modulos=(Todos)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
CarpetaPrincipal=LDIMovLog
Nombre=LDI Log

ListaCarpetas=LDIMovLog
PosicionInicialIzquierda=328
PosicionInicialArriba=139
PosicionInicialAlturaCliente=543
PosicionInicialAncho=943
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
[LDIMovLog]
Estilo=Hoja
Clave=LDIMovLog
Filtros=S
OtroOrden=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=LDIMovLog
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

ListaOrden=(Lista)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S


FiltroGeneral=LDIMovLog.IDModulo = {Info.ID} AND LDIMovLog.Modulo = <T>{Info.Modulo}<T>
[LDIMovLog.LDIMovLog.Fecha]
Carpeta=LDIMovLog
Clave=LDIMovLog.Fecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[LDIMovLog.LDIMovLog.Servicio]
Carpeta=LDIMovLog
Clave=LDIMovLog.Servicio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[LDIMovLog.LDIMovLog.CodigoRespuesta]
Carpeta=LDIMovLog
Clave=LDIMovLog.CodigoRespuesta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[LDIMovLog.LDIMovLog.DescripcionRespuesta]
Carpeta=LDIMovLog
Clave=LDIMovLog.DescripcionRespuesta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[LDIMovLog.LDIMovLog.IDTransaccion]
Carpeta=LDIMovLog
Clave=LDIMovLog.IDTransaccion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[LDIMovLog.LDIMovLog.CodigoAutorizacion]
Carpeta=LDIMovLog
Clave=LDIMovLog.CodigoAutorizacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[LDIMovLog.LDIMovLog.Importe]
Carpeta=LDIMovLog
Clave=LDIMovLog.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[LDIMovLog.Columnas]
Fecha=86
Servicio=179
CodigoRespuesta=169
DescripcionRespuesta=138
IDTransaccion=120
CodigoAutorizacion=115
Importe=89

[LDIMovLog.ListaEnCaptura]
(Inicio)=LDIMovLog.Fecha
LDIMovLog.Fecha=LDIMovLog.Servicio
LDIMovLog.Servicio=LDIMovLog.CodigoRespuesta
LDIMovLog.CodigoRespuesta=LDIMovLog.DescripcionRespuesta
LDIMovLog.DescripcionRespuesta=LDIMovLog.IDTransaccion
LDIMovLog.IDTransaccion=LDIMovLog.CodigoAutorizacion
LDIMovLog.CodigoAutorizacion=LDIMovLog.Importe
LDIMovLog.Importe=(Fin)

[LDIMovLog.ListaOrden]
(Inicio)=LDIMovLog.ID	(Acendente)
LDIMovLog.ID	(Acendente)=LDIMovLog.Fecha	(Acendente)
LDIMovLog.Fecha	(Acendente)=(Fin)

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aceptar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
