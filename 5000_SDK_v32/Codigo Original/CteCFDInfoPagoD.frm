
[Forma]
Clave=CteCFDInfoPagoD
Icono=0
Modulos=(Todos)
Nombre=Información de Pago (Detalle)

ListaCarpetas=Hoja
CarpetaPrincipal=Hoja
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
Comentarios=Lista(Info.Cliente, Info.FormaPago)
ListaAcciones=Aceptar
PosicionInicialAlturaCliente=273
PosicionInicialAncho=500
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=552
PosicionInicialArriba=286
[Hoja]
Estilo=Hoja
Clave=Hoja
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CteCFDInfoPagoD
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


Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroGeneral=CteCFDInfoPagoD.Cliente = <T>{Info.Cliente}<T> AND<BR>CteCFDInfoPagoD.InfoPago = <T>{Info.FormaPago}<T>
FiltroRespetar=S
FiltroTipo=General
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
InfoPago=385

FormaPago=304
CuentaPago=156

[Hoja.CteCFDInfoPagoD.FormaPago]
Carpeta=Hoja
Clave=CteCFDInfoPagoD.FormaPago
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Hoja.CteCFDInfoPagoD.CuentaPago]
Carpeta=Hoja
Clave=CteCFDInfoPagoD.CuentaPago
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Hoja.ListaEnCaptura]
(Inicio)=CteCFDInfoPagoD.FormaPago
CteCFDInfoPagoD.FormaPago=CteCFDInfoPagoD.CuentaPago
CteCFDInfoPagoD.CuentaPago=(Fin)
