
[Forma]
Clave=POSLTipoCambioRef
Icono=0
BarraHerramientas=S
Modulos=(Todos)
Nombre=POS Tipo de Cambio por Sucursal
AccionesTamanoBoton=15x5
AccionesDerecha=S
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal

ListaCarpetas=Campos
CarpetaPrincipal=Campos
ListaAcciones=Guardar
PosicionInicialIzquierda=596
PosicionInicialArriba=274
PosicionInicialAlturaCliente=273
PosicionInicialAncho=404
Comentarios=Info.Sucursal
[Campos]
Estilo=Hoja
Clave=Campos
OtroOrden=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=POSLTipoCambioRef
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
CarpetaVisible=S
ValidarCampos=S

ListaCamposAValidar=Sucursal.Nombre
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General

FiltroGeneral=POSLTipoCambioRef.Sucursal = {Info.Sucursal}
[Campos.POSLTipoCambioRef.TipoCambio]
Carpeta=Campos
Clave=POSLTipoCambioRef.TipoCambio
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
Sucursal=126
TipoCambio=97





Moneda=196


EsPrincipal=64
[Campos.POSLTipoCambioRef.Moneda]
Carpeta=Campos
Clave=POSLTipoCambioRef.Moneda
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco





[Campos.POSLTipoCambioRef.EsPrincipal]
Carpeta=Campos
Clave=POSLTipoCambioRef.EsPrincipal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco





[Campos.ListaEnCaptura]
(Inicio)=POSLTipoCambioRef.TipoCambio
POSLTipoCambioRef.TipoCambio=POSLTipoCambioRef.Moneda
POSLTipoCambioRef.Moneda=POSLTipoCambioRef.EsPrincipal
POSLTipoCambioRef.EsPrincipal=(Fin)

[Campos.ListaOrden]
(Inicio)=POSLTipoCambioRef.TipoCambio	(Acendente)
POSLTipoCambioRef.TipoCambio	(Acendente)=POSLTipoCambioRef.EsPrincipal	(Decendente)
POSLTipoCambioRef.EsPrincipal	(Decendente)=POSLTipoCambioRef.Sucursal	(Acendente)
POSLTipoCambioRef.Sucursal	(Acendente)=Sucursal.Nombre	(Acendente)
Sucursal.Nombre	(Acendente)=(Fin)
