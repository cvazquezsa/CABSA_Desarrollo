
[Forma]
Clave=POSLDISeleccioFormaPMeses
Icono=0
Modulos=(Todos)
Nombre=Meses sin Intereses

ListaCarpetas=POSLDIFormaPagoT
CarpetaPrincipal=POSLDIFormaPagoT
PosicionInicialIzquierda=512
PosicionInicialArriba=224
PosicionInicialAlturaCliente=273
PosicionInicialAncho=255
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
ListaAcciones=Aceptar
VentanaSiempreAlFrente=S
[POSLDIFormaPagoT]
Estilo=Iconos
Clave=POSLDIFormaPagoT
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=POSLDIFormaPagoT
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=POSLDIFormaPagoDMeses.Meses
CarpetaVisible=S

Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
ValidarCampos=S
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=Forma Pago
ElementosPorPaginaEsp=200
IconosSeleccionPorLlave=S
IconosNombre=POSLDIFormaPagoT:POSLDIFormaPago.FormaPago
FiltroGeneral=POSLDIFormaPago.FormaPago = <T>{Info.CodigoFormaPago}<T>
[POSLDIFormaPagoT.POSLDIFormaPagoDMeses.Meses]
Carpeta=POSLDIFormaPagoT
Clave=POSLDIFormaPagoDMeses.Meses
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[POSLDIFormaPagoT.Columnas]
0=152
1=65
Meses=64


[Acciones.Aceptar]
Nombre=Aceptar
Boton=53
NombreEnBoton=S
NombreDesplegar=Aplica Promocion
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Seleccionar/Aceptar
Activo=S
Visible=S

Multiple=S
ListaAccionesMultiples=(Lista)
[Acciones.Aceptar.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.Aceptar.Cerrar]
Nombre=Cerrar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S


[Acciones.Aceptar.Seleccionar]
Nombre=Seleccionar
Boton=0
TipoAccion=Ventana
ClaveAccion=Seleccionar
Activo=S
Visible=S


[Acciones.Aceptar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Expresion=Asigna(Info.Cantidad2, POSLDIFormaPagoT:POSLDIFormaPagoDMeses.Meses)
Activo=S
Visible=S



[Acciones.Aceptar.ListaAccionesMultiples]
(Inicio)=Variables Asignar
Variables Asignar=Seleccionar
Seleccionar=Expresion
Expresion=Cerrar
Cerrar=(Fin)
