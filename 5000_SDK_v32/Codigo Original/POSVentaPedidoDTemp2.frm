
[Forma]
Clave=POSVentaPedidoDTemp2
Icono=0
CarpetaPrincipal=POSVentaPedidoDTemp2
Modulos=(Todos)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaCarpetas=(Lista)
PosicionInicialIzquierda=140
PosicionInicialArriba=131
PosicionInicialAlturaCliente=427
PosicionInicialAncho=1085
ListaAcciones=(Lista)
PosicionSec1=97
Nombre=Devolución Referenciada
VentanaSinIconosMarco=S

[POSVentaPedidoDTemp2]
Estilo=Hoja
Clave=POSVentaPedidoDTemp2
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=POSVentaPedidoDTemp2
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S

HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=POSVentaPedidoDTemp2.Estacion = {EstacionTrabajo} AND POSVentaPedidoDTemp2.RenglonTipo NOT IN( <T>K<T>,<T>O<T>)


[POSVentaPedidoDTemp2.POSVentaPedidoDTemp2.Cantidad]
Carpeta=POSVentaPedidoDTemp2
Clave=POSVentaPedidoDTemp2.Cantidad
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[POSVentaPedidoDTemp2.POSVentaPedidoDTemp2.Articulo]
Carpeta=POSVentaPedidoDTemp2
Clave=POSVentaPedidoDTemp2.Articulo
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[POSVentaPedidoDTemp2.POSVentaPedidoDTemp2.SubCuenta]
Carpeta=POSVentaPedidoDTemp2
Clave=POSVentaPedidoDTemp2.SubCuenta
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[POSVentaPedidoDTemp2.POSVentaPedidoDTemp2.Precio]
Carpeta=POSVentaPedidoDTemp2
Clave=POSVentaPedidoDTemp2.Precio
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[POSVentaPedidoDTemp2.Columnas]
Cantidad=64
Articulo=124
SubCuenta=304
Precio=64



CantidadAplicar=119
Importe=64

Unidad=101
Codigo=184

[POSVentaPedidoDTemp2.POSVentaPedidoDTemp2.CantidadAplicar]
Carpeta=POSVentaPedidoDTemp2
Clave=POSVentaPedidoDTemp2.CantidadAplicar
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[POSVentaPedidoDTemp2.POSVentaPedidoDTemp2.Importe]
Carpeta=POSVentaPedidoDTemp2
Clave=POSVentaPedidoDTemp2.Importe
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco



[POSVentaPedidoDTemp2.POSVentaPedidoDTemp2.Unidad]
Carpeta=POSVentaPedidoDTemp2
Clave=POSVentaPedidoDTemp2.Unidad
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco




[(Variables)]
Estilo=Ficha
Clave=(Variables)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=(Variables)
Fuente={Tahoma, 12, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=Info.Codigo
CarpetaVisible=S

FichaEspacioEntreLineas=0
FichaEspacioNombres=0
FichaColorFondo=Negro
PermiteEditar=S
ConFuenteEspecial=S

CampoAccionAlEnter=Expresion

[Lista.Columnas]
Articulo=131
Descripcion1=244


[(Variables).Info.Codigo]
Carpeta=(Variables)
Clave=Info.Codigo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
AccionAlEnter=Expresion



[POSVentaPedidoDTemp2.POSVentaPedidoDTemp2.Codigo]
Carpeta=POSVentaPedidoDTemp2
Clave=POSVentaPedidoDTemp2.Codigo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco










[Acciones.Generar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=EjecutarSQL(<T>spPOSImportarDevRef  :tID, :nEstacion, :tEmpresa, :nSucursal<T>,Info.IDTexto,EstacionTrabajo,Empresa,Sucursal)
[Acciones.Generar.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Acciones.Generar]
Nombre=Generar
Boton=7
NombreEnBoton=S
NombreDesplegar=&Generar
GuardarAntes=S
Multiple=S
EnBarraHerramientas=S
TipoAccion=Expresion
ListaAccionesMultiples=(Lista)

Activo=S
Visible=S
EspacioPrevio=S




Antes=S
DespuesGuardar=S
ConCondicion=S
EjecucionCondicion=SumaTotal((POSVentaPedidoDTemp2:POSVentaPedidoDTemp2.CantidadAplicar)>0.0
[Acciones.Cancelar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Expresion=Asigna(Info.Codigo,SQL(<T>SELECT Codigo FROM CB WHERE Accion = :tAccion<T>,<T>ELIMINAR MOVIMIENTO<T>))<BR>Asigna(Temp.Reg,SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID, :nImporte, :tCodigoCambio, :nImporteCambio, :nCobro, :tLecturaTarjeta<T>,EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto, Nulo, Nulo, Nulo, 0, Nulo))<BR>/*La variable Info.Observaciones indica si el sp mando algun Mensaje de error*/<BR>Asigna(Info.Observaciones, Temp.Reg[5])<BR><BR>/*La variable Info.PuedeEditar indica si Se recalculo todo el ticket (1) o solamente debe tomar la ultima linea (0)*/<BR>Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>Asigna(Ver.Total, Temp.Reg[8])<BR>Asigna(Info.Saldo, Temp.Reg[9])<BR>Asigna(Info.Importe, Temp.Reg[9])<BR>Asigna(Ver.Saldo, Temp.Reg[9])<BR>Asigna(Ver.Imagen,Temp.Reg[11])
Activo=S
Visible=S

[Acciones.Cancelar]
Nombre=Cancelar
Boton=21
NombreEnBoton=S
NombreDesplegar=&Cancelar
Multiple=S
EnBarraHerramientas=S
ConfirmarAntes=S
DialogoMensaje=POSCancelarCxcPendiemte
TipoAccion=Ventana
ClaveAccion=Aceptar
ListaAccionesMultiples=(Lista)
Activo=S
Visible=S









[Acciones.Cancelar.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S


[Acciones.Localizar]
Nombre=Localizar
Boton=0
NombreDesplegar=Expresion
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=Forma.VariablesAplicar<BR>Forma.LocalizarValor(<T>POSVentaPedidoDTemp2<T>,<T>Codigo<T>,Info.Codigo,0)<BR>Asigna(Info.Codigo,Nulo)<BR>Forma.VariablesAplicar




[Acciones.Cancelar.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Aceptar
Aceptar=(Fin)











[(Carpeta Totalizadores)]
Pestana=S
Clave=(Carpeta Totalizadores)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
Totalizadores1=Cantidad Devolución
Totalizadores2=POSVentaPedidoDTemp2:POSVentaPedidoDTemp2.CantidadAplicar
Totalizadores3=0.00
Totalizadores=S
TotCarpetaRenglones=POSVentaPedidoDTemp2
TotExpresionesEnSumas=S
TotAlCambiar=S
CampoColorLetras=Negro
CampoColorFondo=Plata
CarpetaVisible=S





ListaEnCaptura=Cantidad Devolución

[(Carpeta Totalizadores).Cantidad Devolución]
Carpeta=(Carpeta Totalizadores)
Clave=Cantidad Devolución
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata












[Acciones.Generar.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Aceptar
Aceptar=(Fin)














[POSVentaPedidoDTemp2.ListaEnCaptura]
(Inicio)=POSVentaPedidoDTemp2.Cantidad
POSVentaPedidoDTemp2.Cantidad=POSVentaPedidoDTemp2.Codigo
POSVentaPedidoDTemp2.Codigo=POSVentaPedidoDTemp2.Articulo
POSVentaPedidoDTemp2.Articulo=POSVentaPedidoDTemp2.SubCuenta
POSVentaPedidoDTemp2.SubCuenta=POSVentaPedidoDTemp2.Unidad
POSVentaPedidoDTemp2.Unidad=POSVentaPedidoDTemp2.Precio
POSVentaPedidoDTemp2.Precio=POSVentaPedidoDTemp2.Importe
POSVentaPedidoDTemp2.Importe=POSVentaPedidoDTemp2.CantidadAplicar
POSVentaPedidoDTemp2.CantidadAplicar=(Fin)











[Forma.ListaCarpetas]
(Inicio)=(Variables)
(Variables)=POSVentaPedidoDTemp2
POSVentaPedidoDTemp2=(Fin)

[Forma.ListaAcciones]
(Inicio)=Cancelar
Cancelar=Localizar
Localizar=Generar
Generar=(Fin)
