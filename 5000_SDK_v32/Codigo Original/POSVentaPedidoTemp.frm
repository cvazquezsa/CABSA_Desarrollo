
[Forma]
Clave=POSVentaPedidoTemp
Icono=0
CarpetaPrincipal=POSVentaPedidoTemp
Modulos=(Todos)
ListaCarpetas=POSVentaPedidoTemp
PosicionInicialIzquierda=339
PosicionInicialArriba=41
PosicionInicialAlturaCliente=607
PosicionInicialAncho=687
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
Comentarios=Info.Cliente
ListaAcciones=(Lista)
Nombre=Pedidos
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEscCerrar=S
VentanaEstadoInicial=Normal
VentanaExclusiva=S
VentanaExclusivaOpcion=3


[POSVentaPedidoTemp]
Estilo=Iconos
Clave=POSVentaPedidoTemp
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=POSVentaPedidoTemp
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Movimiento<T>
ElementosPorPaginaEsp=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
PestanaOtroNombre=S
PestanaNombre=Pedidos
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
MenuLocal=S
FiltroDistintos=S
ListaAcciones=Seleccionar
IconosNombre=POSVentaPedidoTemp:POSVentaPedidoTemp.Mov
FiltroGeneral=POSVentaPedidoTemp.Estacion = {EstacionTrabajo}


[POSVentaPedidoTemp.POSVentaPedidoTemp.MovID]
Carpeta=POSVentaPedidoTemp
Clave=POSVentaPedidoTemp.MovID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


[POSVentaPedidoTemp.POSVentaPedidoTemp.FechaEmision]
Carpeta=POSVentaPedidoTemp
Clave=POSVentaPedidoTemp.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco



[POSVentaPedidoTemp.Columnas]
0=93
1=115
2=-2
3=157
4=-2
5=-2


[POSVentaPedidoTemp.ImporteTotal]
Carpeta=POSVentaPedidoTemp
Clave=ImporteTotal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco



[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Seleccionar
Multiple=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
GuardarAntes=S
ListaAccionesMultiples=(Lista)


[Acciones.Expresion]
Nombre=Expresion
Boton=6
NombreEnBoton=S
NombreDesplegar=&Preliminar
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S
EspacioPrevio=S
Expresion=Asigna(Info.ID,POSVentaPedidoTemp:POSVentaPedidoTemp.ID)<BR>ReportePantalla(<T>POSPedido<T>)


[Acciones.Aceptar.Insertar]
Nombre=Insertar
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=Asigna(Info.IDTexto,SQL(<T>spPOSImportarPedidoFactura :nID,:tIdPOS,:nEstacion<T>,POSVentaPedidoTemp:POSVentaPedidoTemp.ID,Info.IDTexto,EstacionTrabajo))<BR><BR>Asigna(Temp.Reg,SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID, :nImporte, :tCodigoCambio, :nImporteCambio, :nCobro, :tLecturaTarjeta<T>,EstacionTrabajo, Nulo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto, Nulo, Nulo, Nulo, 0, Nulo))<BR>/*La variable Info.Observaciones indica si el sp mando algun Mensaje de error*/<BR>Asigna(Info.Observaciones, Temp.Reg[5])<BR>Si ConDatos(Info.Observaciones)<BR>  Entonces Error( Info.Observaciones )<BR>  Sino <T><T><BR>Fin<BR><BR>/*La variable Info.PuedeEditar indica si Se recalculo todo el ticket (1) o solamente debe tomar la ultima linea (0)*/<BR>Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>Asigna(Ver.Total, Temp.Reg[8])<BR>Asigna(Info.Saldo, Temp.Reg[9])<BR>Asigna(Info.Importe, Temp.Reg[9])<BR>Asigna(Ver.Saldo, Temp.Reg[9])<BR>Asigna(Ver.Imagen,Temp.Reg[11])
[Acciones.Aceptar.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S



[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=0
NombreDesplegar=Seleccionar
EnMenu=S
TipoAccion=Ventana
ClaveAccion=Seleccionar
Activo=S
Visible=S
Multiple=S
ListaAccionesMultiples=(Lista)



[Acciones.Seleccionar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Expresion=Asigna(Info.IDTexto,SQL(<T>spPOSImportarPedidoFactura :nID,:tIdPOS,:nEstacion<T>,POSVentaPedidoTemp:POSVentaPedidoTemp.ID,Info.IDTexto,EstacionTrabajo))
Activo=S
Visible=S


[Acciones.Seleccionar.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S


[Acciones.Seleccionar.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Aceptar
Aceptar=(Fin)


[POSVentaPedidoTemp.POSVentaPedidoTemp.Anticipos]
Carpeta=POSVentaPedidoTemp
Clave=POSVentaPedidoTemp.Anticipos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco



[POSVentaPedidoTemp.SaldoReferencia]
Carpeta=POSVentaPedidoTemp
Clave=SaldoReferencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco



[Acciones.Aceptar.ListaAccionesMultiples]
(Inicio)=Insertar
Insertar=Aceptar
Aceptar=(Fin)



[POSVentaPedidoTemp.ListaEnCaptura]
(Inicio)=POSVentaPedidoTemp.MovID
POSVentaPedidoTemp.MovID=POSVentaPedidoTemp.FechaEmision
POSVentaPedidoTemp.FechaEmision=ImporteTotal
ImporteTotal=POSVentaPedidoTemp.Anticipos
POSVentaPedidoTemp.Anticipos=SaldoReferencia
SaldoReferencia=(Fin)







[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Expresion
Expresion=(Fin)
