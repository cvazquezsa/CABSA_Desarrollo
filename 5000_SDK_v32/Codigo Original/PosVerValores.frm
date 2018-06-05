
[Forma]
Clave=PosVerValores
Icono=54
Modulos=(Todos)

ListaCarpetas=(Lista)
CarpetaPrincipal=Ticket
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Cerrar
PosicionInicialIzquierda=484
PosicionInicialArriba=197
PosicionInicialAlturaCliente=606
PosicionInicialAncho=951
PosicionSec1=378
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionCol2=537
PosicionSec2=546
PosicionCol3=581
PosicionCol1=826
Menus=S

Nombre=<T>Ver valores<T>
VentanaExclusiva=S
VentanaExclusivaOpcion=0
VentanaSinIconosMarco=S
VentanaColor=$00804000
ExpresionesAlMostrar=Asigna(Info.Empresa, Empresa)<BR>Asigna(Info.Codigo, Nulo)<BR>Asigna(Ver.Memo, Nulo)<BR><BR>Asigna(Info.MovClaveAfecta, SQL(<T>SELECT mt.Clave FROM POSL p INNER JOIN MovTipo mt ON p.Mov = mt.Mov AND mt.Modulo = :tPOS WHERE p.ID = :tID<T>, <T>POS<T>, Info.IDTexto))<BR>Si<BR>  Info.MovClaveAfecta = <T>POS.ACM<T><BR>Entonces<BR>  Asigna(Ver.Memo, <T>En los Movimientos Mutimoneda recuerde capturar en la Apertura de Caja la Cuenta de Dinero Multimoneda y la Forma de Pago Utilizando la Tecla F2...<T>)<BR>Sino<BR>  <T><T><BR>Fin<BR>Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR><BR>Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR><BR>Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>Asigna(Ver.Total, Temp.Reg[8])<BR>Asigna(Info.Saldo, Temp.Reg[9])<BR>Asigna(Info.Importe, Temp.Reg[9])<BR>Asigna(Ver.Saldo, Temp.Reg[9])<BR>Asigna(Ver.Imagen,Temp.Reg[11])
ExpresionesAlCerrar=Asigna(Info.Torreta,SQL(<T>SELECT TieneTorreta FROM POSCfg WHERE Empresa = :tEmpresa<T>,Empresa))<BR>Si<BR>  Info.Torreta<BR>Entonces<BR>   Torreta.Cerrar<BR>Fin<BR>Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)
ExpresionesAlActivar=Asigna(Info.Torreta,SQL(<T>SELECT TieneTorreta FROM POSCfg WHERE Empresa = :tEmpresa<T>,Empresa))<BR>Si<BR>  Info.Torreta<BR>Entonces<BR>  Asigna(Info.TorretaPuerto,SQL(<T>SELECT PuertoTorreta FROM POSCfg WHERE Empresa = :tEmpresa<T>,Empresa))<BR>   Torreta.Abrir(Info.TorretaPuerto)<BR>Asigna(Info.TorretaMensaje1,<T>*** BIENVENIDO ***<T>)<BR>Asigna(Info.TorretaPosicion1,<T>Centrado<T>)<BR>Asigna(Info.TorretaMensaje2,NULO))<BR>Asigna(Info.TorretaPosicion2,<T>Derecha<T>)<BR><BR>    Torreta.Escribir( Info.TorretaMensaje1,Info.TorretaMensaje2,Info.TorretaPosicion1,Info.TorretaPosicion2)   <BR>Fin<BR><BR>Asigna(Info.Codigo, SQL(<T>SELECT Codigo FROM CB WHERE TipoCuenta = :tTipoCuenta AND Accion = :tAccion<T>, <T>Accion<T>, <T>VER CORTE CAJA<T>))<BR>Asigna(Temp.Reg,SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  nulo, Info.IDTexto))<BR>Asigna(Info.IDTexto, Temp.Reg[1])<BR>Asigna(Info.Observaciones, Temp.Reg[5])<BR>Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR><BR>Asigna(Pos.TextoSubtotal, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 1))<BR>Asigna(Pos.TextoDescuento, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 2))<BR>Asigna(Pos.TextoImpuestos, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 3))<BR><BR>Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>Asigna(Ver.Total, Temp.Reg[8])<BR>Asigna(Info.Saldo, Temp.Reg[9])<BR>Asigna(Info.Importe, Temp.Reg[9])<BR>Asigna(Ver.Saldo, Temp.Reg[9])<BR>SI(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>Asigna(Info.Codigo, Nulo)<BR>Asigna(Ver.Imagen,Temp.Reg[11])
[Lista.Alm.Almacen]
Carpeta=Lista
Clave=Alm.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.Alm.Nombre]
Carpeta=Lista
Clave=Alm.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco


[Lista.Columnas]
Almacen=90
Nombre=293








Sucursal=46
Nombre_1=304

Articulo=131
Descripcion1=244
0=127
1=211
Cliente=117
RFC=107
Estado=236
Delegacion=126
Colonia=216
CodigoPostal=71
Ruta=109
Grupo=100
Codigo=184
2=-2
3=-2
SerieLote=153
Unidad=122
[Acciones.Send.ListaAccionesMultiples]
(Inicio)=Asignar
Asignar=Expresion
Expresion=(Fin)

































































































































































[(Variables).ListaEnCaptura]
(Inicio)=Info.Codigo
Info.Codigo=Ver.Lista
Ver.Lista=(Fin)






[Ticket]
Estilo=Ficha
Clave=Ticket
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=(Variables)
Fuente={Segoe UI, 10, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Rojo obscuro
CampoColorFondo=Blanco
ListaEnCaptura=Ver.Ticket
CarpetaVisible=S
AlinearTodaCarpeta=S

ConFuenteEspecial=S




[Codigo.Info.Codigo]
Carpeta=Codigo
Clave=Info.Codigo
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
AccionAlEnter=Enter
Tamano=50
ColorFondo=$00FFE8E8












AccionAlEnterBloquearAvance=S
OcultaNombre=N
Pegado=N
ConScroll=N
SinRecapitular=N
ColorFuente=Rojo obscuro
[Totales.]
Carpeta=Totales
ColorFondo=Negro
ColorFuente=Lima













































































[Alm.ListaEnCaptura]
(Inicio)=Alm.Almacen
Alm.Almacen=Alm.Nombre
Alm.Nombre=(Fin)




[Lista.ListaEnCaptura]
(Inicio)=Alm.Almacen
Alm.Almacen=Alm.Nombre
Alm.Nombre=(Fin)












































[Ticket.Ver.Ticket]
Carpeta=Ticket
Clave=Ver.Ticket
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20










































































IgnoraFlujo=S
ColorFuente=Rojo obscuro

[Campos.Columnas]
Articulo=114
SubCuenta=115
Precio=86
DescuentoLinea=96
Cantidad=79













































FormaPago=171
Importe=114
Referencia=177
Opcion=124
ArtSubCuenta=237
Componente=213
[FormaExtraValor.Columnas]
VerCampo=370
VerValor=370

[SituacionCta.Columnas]
0=188
1=148
2=-2
3=-2
4=-2

[(Carpeta Abrir).Columnas]
0=106
1=283



































































































































































[Foto.ListaEnCaptura]
(Inicio)=Ver.FormasPago
Ver.FormasPago=Ver.Imagen
Ver.Imagen=(Fin)












































[DescripcionSaldo.ListaEnCaptura]
(Inicio)=Ver.Memo
Ver.Memo=Ver.Saldo
Ver.Saldo=(Fin)


















[Imagen.Ver.Imagen]
Carpeta=Imagen
Clave=Ver.Imagen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco































































[Hoja.Columnas]
Mov=124
MovID=124
FechaEmision=94
Importe=64



















































































Cliente=64


















[UsoServicio.Columnas]
Servicio=293
Fecha=94
Porcentaje=38
Evaluacion=87
Observaciones=189




















































































































































































































































































































































































[Acciones.Encabezado.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=FormaModal(<T>POSL<T>)<BR><BR>Asigna(Info.Codigo, Nulo)<BR><BR>Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID, :nImporte, :tCodigoCambio, :nImporteCambio, :nCobro, :tLecturaTarjeta<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto, Nulo, Nulo, Nulo, 0, Nulo))<BR><BR>/*La variable Info.Observaciones indica si el sp mando algun Mensaje de error*/<BR>Asigna(Info.Observaciones, Temp.Reg[5])<BR><BR>Si ConDatos(Info.Observaciones)<BR>  Entonces Error( Info.Observaciones )<BR>Sino <T><T>                                                                                                             <BR>  Fin<BR><BR>/*La variable Info.PuedeEditar indica si Se recalculo todo el ticket (1) o solamente debe tomar la ultima linea (0)*/<BR>Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR><BR>Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR><BR>Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>Asigna(Ver.Total, Temp.Reg[8])<BR>Asigna(Info.Saldo, Temp.Reg[9])<BR>Asigna(Info.Importe, Temp.Reg[9])<BR>Asigna(Ver.Saldo, Temp.Reg[9])<BR>Asigna(Ver.Imagen,Temp.Reg[11])
[Acciones.Encabezado.Forma]
Nombre=Forma
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S








































[Acciones.POSMonedero.POSMonedero]
Nombre=POSMonedero
Boton=0
TipoAccion=Formas
ClaveAccion=POSMonedero
Activo=S
Visible=S

[Acciones.POSMonedero.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR><BR>Asigna(Info.IDTexto, Temp.Reg[1])<BR><BR>/*La variable Info.Observaciones indica si el sp mando algun Mensaje de error*/<BR>Asigna(Info.Observaciones, Temp.Reg[5])<BR><BR>/*La variable Info.PuedeEditar indica si Se recalculo todo el ticket (1) o solamente debe tomar la ultima linea (0)*/<BR>Asigna(Info.PuedeEditar, Temp.Reg[4])<BR><BR>Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>Asigna(Ver.Total, Temp.Reg[8])<BR>Asigna(Info.Saldo, Temp.Reg[9])<BR>Asigna(Info.Importe, Temp.Reg[9])<BR>Asigna(Ver.Saldo, Temp.Reg[9])<BR>/*Asigna(Ver.Saldo, TextoEnLista(Temp.Reg[10]))*/<BR><BR>Asigna(Info.Codigo, Nulo)<BR>Asigna(Ver.Imagen,Temp.Reg[11])

[POSArtJuegoComponente.Columnas]
Componente=205
ArtSubCuenta=473










































































































































































[Logo.Info.POSLogo]
Carpeta=Logo
Clave=Info.POSLogo
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
Tamano=10x10
ColorFondo=Blanco



































SinRecapitular=N













[POSOfertaTemp.Columnas]
0=135
1=96
2=103
3=84
4=66
5=78
6=105


[POSLDenominacion.Columnas]
Denominacion=138
Cantidad=70















































TotalDenominacion=97
















Nombre=304






[POSLDenominacionTemp.Columnas]
Cantidad=70
Nombre=207
Denominacion=138
TotalDenominacion=97


















[POSOfertaTempD.Columnas]
Articulo=124
Precio=64
Puntos=83
CantidadO=86
CantidadM=101
PuntosUsar=82
ImporteTotal=69





























[POSOfertaTempCancelacion.Columnas]
0=135
1=96
2=103
3=84
4=66
5=78
6=105










[Acciones.POSMonedero.ListaAccionesMultiples]
(Inicio)=POSMonedero
POSMonedero=Expresion
Expresion=(Fin)































































































































































































































































































































































































































































































































































[Detalle.Columnas]
Articulo=87
Cantidad=48
Precio=77
DescuentoLinea=36
Importe=87



CantidadNeta=47














































Codigo=97
ClaveIdioma=74
SustitutoArticulo=76
SustitutoSubCuenta=71
Espacio=42
PesoTotal=50
VolumenTotal=54
Unidad=41
CantidadInventario=54
CantidadInvNeta=53
Horas=32
DescuentoImporte=54
PrecioMoneda=48
PrecioTipoCambio=64
FechaRequerida=88
TipoImpuesto1=70
Impuesto1=35
SubImpuesto1=74
TipoImpuesto2=72
Impuesto2=42
SubImpuesto2=72
TipoImpuesto3=83
Impuesto3=64
SubImpuesto3=76
ContUso=76
ContUso2=124
ContUso3=124
ProveedorRef=57
Costo=76
CostoTotal=77
Paquete=45
AutoLocalidad=68
DescripcionExtra=245
CantidadReservada=57
CantidadOrdenada=52
CantidadPendiente=53
ServicioNumero=54
Estado=85
CantidadA=47
Establecimiento=124
VigenteA=112




































































































































































SubCuenta=99
































































































































































































































































































[POSVentaPedidoTemp.Columnas]
0=93
1=115
2=-2
3=157



































































[POSCxcAnticipoTemp.Columnas]
FechaEmision=94
Referencia=173
Concepto=210
AnticipoSaldo=71
Moneda=64
AnticipoAplicar=77































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































[Acciones.Afectar.Afectar]
Nombre=Afectar
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Asigna(Info.MovClaveAfecta, SQL(<T>SELECT mt.Clave FROM POSL p INNER JOIN MovTipo mt ON p.Mov = mt.Mov AND mt.Modulo = :tPOS WHERE p.ID = :tID<T>, <T>POS<T>, Info.IDTexto))<BR>Asigna(Info.Mensaje,Nulo)<BR>Asigna(Info.IDTextoAnterior, Info.IDTexto)<BR>Asigna(Info.POSMonedero,Nulo)<BR>EjecutarSQL(<T>spPOSOfertaPuntosImporte :tEmpresa,:nEstacion,:tID<T>,Empresa, EstacionTrabajo, Info.IDTexto)<BR>Asigna(Info.POSRedondeo, SQL(<T>EXEC spPOSVentaInsertaRedondeo :tID, :tTipo<T>, Info.IDTexto, <T>SUGERIR<T>))<BR>Asigna(Info.POSRedondeo2,0.0)  <BR>EjecutarSQL(<T>spPOSVentaInsertaRedondeo :tID,:tTipo,:nImporte<T>,Info.IDTexto,<T>ELIMINAR COBRO<T>,Nulo)<BR>Asigna(Info.Acumulativa,SQL(<T>SELECT RedondeoVenta FROM POSCfg WHERE Empresa = :tEmpresa<T>,Empresa))<BR>Asigna(Info.Codigo, SQL(<T>SELECT Codigo FROM CB WHERE Accion = :tAccion<T>, <T>CONCLUIR MOVIMIENTO<T>))<BR>Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID, :nImporte, :tFormaCambio, :nCambio, :nCobro, :nLecturaTarjeta, :tCliente, :tMonedero<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia,  Info.IDTexto, Info.Importe, Info.FormaPagoCambio, Info.Cambio, 0, Nulo, Nulo, Info.POSMonedero))<BR>Asigna(Info.Codigo, Nulo)<BR>Asigna(Info.POSImporteOferta,Nulo)<BR>Asigna(Info.IDTexto, Temp.Reg[1])<BR><BR><BR>/*La variable Info.Observaciones indica si el sp mando algun Mensaje de error*/<BR>Asigna(Info.Observaciones, Temp.Reg[5])<BR><BR>/*Si ConDatos(Info.Observaciones)<BR>  Entonces Informacion(Info.Observaciones )<BR>Sino <T><T><BR>  Fin<BR><BR>/*La variable Info.PuedeEditar indica si Se recalculo todo el ticket (1) o solamente debe tomar la ultima linea (0)*/<BR>Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>Asigna(Ver.Saldo, Temp.Reg[9])<BR>Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>Asigna(Ver.Total, Temp.Reg[8])<BR>Asigna(Info.Saldo, Temp.Reg[9])                                                            <BR>Asigna(Info.Importe, Temp.Reg[9])<BR><BR>Asigna(Ver.Imagen,Temp.Reg[11])<BR>Asigna(Ver.Expresion, TextoEnLista(Temp.Reg[7]))<BR>Asigna(Ver.Expresion2, TextoEnLista(Temp.Reg[20]))<BR>Si ConDatos(Ver.Expresion)<BR>Entonces Reexpresa( Ver.Expresion )<BR>Fin<BR>SI(ConDatos(Ver.Expresion2),Reexpresa( Ver.Expresion2 ))<BR><BR>Asigna(Ver.Expresion, Nulo)<BR>Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID, :nImporte, :tFormaCambio, :nCambio, :nCobro, :nLecturaTarjeta, :tCliente, :tMonedero,:nImporteRef<T>, EstacionTrabajo, NULO, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia,  Info.IDTexto,Nulo, Info.FormaPagoCambio, Info.Cambio, 1, Nulo, Nulo, Info.POSMonedero,NULO))<BR><BR> Si(Info.MovClaveAfecta EN(<T>POS.N<T>,<T>POS.F<T>),Si(ConDatos(Info.Mensaje),Asigna(Ver.Aviso,Ver.Aviso+NuevaLinea+Info.Mensaje)))<BR>Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>Asigna(Ver.Saldo, Temp.Reg[9])<BR>/*Cuando hay una expresion de regreso la ejecuta*/<BR>Asigna(Ver.Expresion, TextoEnLista(Temp.Reg[7]))<BR>Asigna(Ver.Expresion2, TextoEnLista(Temp.Reg[20]))<BR>Si ConDatos(Ver.Expresion)<BR>Entonces Reexpresa( Ver.Expresion )<BR>Fin<BR><BR><BR>Asigna(Ver.Expresion, Nulo)<BR>Asigna(Ver.Expresion2, Nulo)
[Acciones.Afectar.ValidarSeries]
Nombre=ValidarSeries
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

ConCondicion=S



EjecucionConError=S





































EjecucionCondicion=Asigna(Temp.Logico,SQL(<T>SELECT dbo.fnPOSValidaSerieLote(:tID)<T>,Info.IDTexto))<BR>No(Temp.Logico)
EjecucionMensaje=<T>Falta Indicar los Numeros de Serie/Lote<T>


[Acciones.Encabezado.ListaAccionesMultiples]
(Inicio)=Forma
Forma=Expresion
Expresion=(Fin)
























































































































































































































































[MovCaja.Columnas]
0=164





Accion=168












1=199
[Acciones.Expresion]
Nombre=Expresion
Boton=0
NombreDesplegar=Expresion
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S
RefrescarDespues=S




















Expresion=Asigna( Info.Codigo,POSMuestraAccionesCaja:Codigo )
[MovCaja.ListaEnCaptura]
(Inicio)=Codigo
Codigo=Accion
Accion=(Fin)












[MovPos.Accion]
Carpeta=MovPos
Clave=Accion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco



[MovPos.Columnas]
0=139
1=143




2=-2

[Saldo.Info.CodigoFormaPago]
Carpeta=Saldo
Clave=Info.CodigoFormaPago
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Saldo.Info.Importe]
Carpeta=Saldo
Clave=Info.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

AccionAlEnter=Afectar
[Saldo.Ver.Cambio]
Carpeta=Saldo
Clave=Ver.Cambio
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco













[MovPos.ListaEnCaptura]
(Inicio)=Codigo
Codigo=Accion
Accion=(Fin)







[Saldo.ListaEnCaptura]
(Inicio)=Info.CodigoFormaPago
Info.CodigoFormaPago=Info.Importe
Info.Importe=Ver.Cambio
Ver.Cambio=(Fin)



















[Saldo.Ver.Saldo]
Carpeta=Saldo
Clave=Ver.Saldo
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
Tamano=11
ColorFondo=Negro



AccionAlEnter=BuscarArticulo
ColorFuente=Lima






























AccionAlEnterBloquearAvance=N




EditarConBloqueo=S







[Total.Info.Importe]
Carpeta=Total
Clave=Info.Importe
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
AccionAlEnter=Afectar
Tamano=11
ColorFondo=Negro





AccionAlEnterBloquearAvance=N


ColorFuente=Lima































































[MovCaja.Accion]
Carpeta=MovCaja
Clave=Accion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Acciones.Expresion1]
Nombre=Expresion1
Boton=0
NombreDesplegar=Expresion
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S







RefrescarDespues=S


Expresion=Asigna( Info.Codigo,POSMuestraAccionesPos:Codigo )
























































[Codigo.Info.Importe]
Carpeta=Codigo
Clave=Info.Importe
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
AccionAlEnter=Afectar
Tamano=-1
ColorFondo=$00FFE8E8















































ColorFuente=Rojo obscuro

Pegado=S
[Acciones.Cerrar.Cerrar]
Nombre=Cerrar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Acciones.Cerrar.expresion]
Nombre=expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=EjecutarSQL( <T>spPOSUsuarioDesautoriza :tID<T>, Info.IDTexto )
[Acciones.Cerrar]
Nombre=Cerrar
Boton=21
NombreEnBoton=S
NombreDesplegar=&Cerrar
Multiple=S
TipoAccion=ventana
ClaveAccion=Cerrar
ListaAccionesMultiples=(Lista)

Activo=S
Visible=S











ConCondicion=S
EjecucionConError=S
EjecucionCondicion=SQL(<T>SELECT ISNULL(SUM(ISNULL(Importe,0)),0) FROM POSLCObro pc WHERE pc.ID =:tID<T>, Info.IDTexto) = 0
EjecucionMensaje=<T>El Movimiento Tiene Aplicaciones.. Tiene que concluirlo o Reversar el Pago Verifique.....<T>
[Acciones.Afectar.ActualizaTicket]
Nombre=ActualizaTicket
Boton=0
TipoAccion=Expresion
Expresion=Asigna(Ver.Ticket, <T><T>)
Activo=S
Visible=S



[Ticket.ListaEnCaptura]
(Inicio)=Ver.Ticket
Ver.Ticket=Ver.Aviso
Ver.Aviso=(Fin)








[MensajeMultimoneda]
Estilo=Ficha
Clave=MensajeMultimoneda
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B2
Vista=(Variables)
Fuente={Segoe UI, 10, Rojo obscuro, []}
CampoColorLetras=$008080FF
CampoColorFondo=Aqua
ListaEnCaptura=Ver.Memo
CarpetaVisible=S

FichaEspacioEntreLineas=0
FichaEspacioNombres=0
FichaColorFondo=Negro
AlinearTodaCarpeta=S

FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaMarco=S
ConFuenteEspecial=S

BarraBotones=S
ListaAccionesBB=Cierra
BarraBtnFuente={Segoe UI, 10, Blanco, []}
BarraBtnFondo=$00804000
BarraBtnPosicion=Abajo
BarraBtnSize=80
BarraBtnSeparacion=4
BarraBtnSinBisel=S
BarraBtnPaginas=1
[MensajeMultimoneda.Ver.Memo]
Carpeta=MensajeMultimoneda
Clave=Ver.Memo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Aqua

















ColorFuente=$008080FF


































[Acciones.CtaMutimoneda.expresion]
Nombre=expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, <T>CTADINERO<T>, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR><BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR> // Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Codigo, Nulo)<BR>  Asigna(Ver.Imagen,Temp.Reg[11])<BR>  Asigna(Ver.Memo, <T>En los Movimientos Mutimoneda recuerde capturar en la Apertura de Caja la Cuenta de Dinero Multimoneda y la Forma de Pago Utilizando la Tecla F2...<T>)<BR><BR>Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)
[Acciones.CtaMutimoneda.Actualizar Vista]
Nombre=Actualizar Vista
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S

[Acciones.CtaMutimoneda.Actualizar Forma]
Nombre=Actualizar Forma
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S


















[POSCBFormaPago.Columnas]
Codigo=215














[Acciones.Afectar.Cerrar]
Nombre=Cerrar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S


[Acciones.CtaMutimoneda.ListaAccionesMultiples]
(Inicio)=expresion
expresion=Actualizar Vista
Actualizar Vista=Actualizar Forma
Actualizar Forma=(Fin)









[Acciones.Afectar.ListaAccionesMultiples]
(Inicio)=ValidarSeries
ValidarSeries=Afectar
Afectar=ActualizaTicket
ActualizaTicket=Cerrar
Cerrar=(Fin)






[Codigo.ListaEnCaptura]
(Inicio)=Info.Codigo
Info.Codigo=Info.Importe
Info.Importe=(Fin)










































[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Afectar
Afectar=(Fin)








































[Acciones.Cierra]
Nombre=Cierra
Boton=0
NombreDesplegar=<T>Cerrar<T>
Multiple=S
Activo=S
Visible=S
BarraBtnFondo=$00C08000







BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
BarraBtnPagina=1
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado






ConCondicion=S
ListaAccionesMultiples=(Lista)

edBotonSrc=ESC.png
TeclaFuncion=ESC
EjecucionCondicion=SQL(<T>SELECT ISNULL(SUM(ISNULL(Importe,0)),0) FROM POSLCObro pc WHERE pc.ID =:tID<T>, Info.IDTexto) = 0
[Acciones.Cierra.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=EjecutarSQL( <T>spPOSUsuarioDesautoriza :tID<T>, Info.IDTexto )



[Acciones.Cierra.Cierra]
Nombre=Cierra
Boton=0
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S





[Acciones.Cierra.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Cierra
Cierra=(Fin)


[Acciones.Cerrar.ListaAccionesMultiples]
(Inicio)=expresion
expresion=Cerrar
Cerrar=(Fin)



























[Forma.ListaCarpetas]
(Inicio)=Ticket
Ticket=MensajeMultimoneda
MensajeMultimoneda=(Fin)
