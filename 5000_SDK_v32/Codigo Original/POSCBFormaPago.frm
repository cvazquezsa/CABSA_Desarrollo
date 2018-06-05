
[Forma]
Clave=POSCBFormaPago
Icono=0
BarraHerramientas=S
Modulos=(Todos)
Nombre=POS Formas de Pago
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaCarpetas=POSCBFormaPago
CarpetaPrincipal=POSCBFormaPago
PosicionInicialAlturaCliente=273
PosicionInicialAncho=315
ListaAcciones=Guardar y Cerrar
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=610
PosicionInicialArriba=261
[POSCBFormaPago]
Estilo=Hoja
Clave=POSCBFormaPago
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=POSCBFormaPago
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
CarpetaVisible=S
Filtros=S
PermiteEditar=S
ListaEnCaptura=(Lista)

FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General

FiltroGeneral=POSCBFormaPago.TipoCuenta = <T>Forma Pago<T>
[POSCBFormaPago.POSCBFormaPago.Codigo]
Carpeta=POSCBFormaPago
Clave=POSCBFormaPago.Codigo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco


[POSCBFormaPago.Columnas]
Codigo=100
Accion=154


FormaPago=172
[Acciones.Guardar y Cerrar]
Nombre=Guardar y Cerrar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S




Multiple=S
ListaAccionesMultiples=(Lista)
[POSCBFormaPago.POSCBFormaPago.FormaPago]
Carpeta=POSCBFormaPago
Clave=POSCBFormaPago.FormaPago
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco





[POSCBFormaPago.ListaEnCaptura]
(Inicio)=POSCBFormaPago.Codigo
POSCBFormaPago.Codigo=POSCBFormaPago.FormaPago
POSCBFormaPago.FormaPago=(Fin)

[Acciones.Guardar y Cerrar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Expresion=Asigna(Temp.TextoTemp03,nulo)<BR>Asigna(Temp.TextoTemp03,SQL(<T>EXEC spPOSVerificaCBFormaPago :tEmpresa<T>, Empresa))<BR>Si<BR>  ConDatos(Temp.TextoTemp03)<BR>Entonces<BR>  Informacion(Temp.TextoTemp03)<BR>Fin
Activo=S
Visible=S

[Acciones.Guardar y Cerrar.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
ConCondicion=S
EjecucionCondicion=Vacio(Temp.TextoTemp03)
EjecucionMensaje=<T>Elimine la Forma Pago para continuar<T>
EjecucionConError=S
Visible=S

[Acciones.Guardar y Cerrar.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Aceptar
Aceptar=(Fin)
