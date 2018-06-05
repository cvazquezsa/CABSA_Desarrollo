
[Forma]
Clave=CteCFDInfoPago
Icono=0
BarraHerramientas=S
Modulos=(Todos)
Nombre=Información de Pago
AccionesTamanoBoton=15x5
AccionesDerecha=S
Comentarios=Lista(Info.Cliente, Info.Nombre)

ListaCarpetas=Hoja
CarpetaPrincipal=Hoja
ListaAcciones=(Lista)
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
Vista=CteCFDInfoPago
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
ListaEnCaptura=CteCFDInfoPago.InfoPago
CarpetaVisible=S
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=CteCFDInfoPago.Cliente = <T>{Info.Cliente}<T>

[Hoja.CteCFDInfoPago.InfoPago]
Carpeta=Hoja
Clave=CteCFDInfoPago.InfoPago
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
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

[Acciones.Detalle]
Nombre=Detalle
Boton=47
NombreDesplegar=&Detalle
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=CteCFDInfoPagoD
Activo=S
Visible=S




Antes=S
AntesExpresiones=Asigna(Info.FormaPago, CteCFDInfoPago:CteCFDInfoPago.InfoPago)
[Hoja.Columnas]
InfoPago=604



















































[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Detalle
Detalle=(Fin)
